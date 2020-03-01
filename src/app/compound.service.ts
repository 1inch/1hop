import { Injectable } from '@angular/core';
import { ethers } from 'ethers';

import CERC20ABI from './abi/CERC20.json';
import { Web3Service } from './web3.service';
import { TokenService } from './token.service';
import { ConfigurationService } from './configuration.service';

import toformat from 'toformat';

let Decimal = require('decimal.js-light');
Decimal = toformat(Decimal);

export const WadDecimal = Decimal.clone({
    rounding: 1, // round down
    precision: 78,
    toExpNeg: -18,
    toExpPos: 78
});

const secondsInYear = new WadDecimal(60 * 60 * 24 * 365);

@Injectable({
    providedIn: 'root'
})
export class CompoundService {

    tokens = {
        cBAT: {
            symbol: 'cBAT',
            name: 'Compound Basic Attention Token (cBAT)',
            icon: '',
            decimals: 8,
            address: '0x6c8c6b02e7b2be14d4fa6022dfd6d75921d90e4e'
        },
        cSAI: {
            symbol: 'cSAI',
            name: 'Compound SAI (cSAI)',
            icon: '',
            decimals: 8,
            address: '0xf5dce57282a584d2746faf1593d3121fcac444dc'
        },
        cDAI: {
            symbol: 'cDAI',
            name: 'Compound DAI (cDAI)',
            icon: '',
            decimals: 8,
            address: '0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643'
        },
        cETH: {
            symbol: 'cETH',
            name: 'Compound ETH (cETH)',
            icon: '',
            decimals: 8,
            address: '0x4ddc2d193948926d02f9b1fe9e1daa0718270ed5'
        },
        cUSDC: {
            symbol: 'cUSDC',
            name: 'Compound USD Coin (cUSDC)',
            icon: '',
            decimals: 8,
            address: '0x39AA39c021dfbaE8faC545936693aC917d5E7563'
        },
        cREP: {
            symbol: 'cREP',
            name: 'Compound Augur (cREP)',
            icon: '',
            decimals: 8,
            address: '0x158079Ee67Fce2f58472A96584A73C7Ab9AC95c1'
        },
        cWBTC: {
            symbol: 'cWBTC',
            name: 'Compound Wrapped BTC',
            icon: '',
            decimals: 8,
            address: '0xc11b1268c1a384e55c48c2391d8d480264a3a7f4'
        },
        cZRX: {
            symbol: 'cZRX',
            name: 'Compound 0x (cZRX)',
            icon: '',
            decimals: 8,
            address: '0xB3319f5D18Bc0D84dD1b4825Dcde5d5f7266d407'
        }
    };

    constructor(
        protected web3Service: Web3Service,
        protected tokenService: TokenService,
        protected configurationService: ConfigurationService
    ) {

    }

    async getBalances(walletAddress) {

        const allTokens = Object.values(this.tokens);

        const promises = allTokens
            .map(async token => {

                const contract = new (await this.web3Service.getWeb3Provider()).eth.Contract(
                    // @ts-ignore
                    CERC20ABI,
                    token.address
                );

                return contract.methods.balanceOfUnderlying(walletAddress).call();
            });

        return (await Promise.all(promises))
            .map((balance, i) => {

                const balanceBN = ethers.utils.bigNumberify(balance);

                const token = Object.assign({}, this.tokenService.tokens[allTokens[i].symbol.substr(1)]);

                if (balanceBN.gt(0)) {

                    token['balance'] = this.tokenService.toFixed(
                        this.tokenService.formatAsset(
                            token.symbol,
                            // @ts-ignore
                            balanceBN
                        ),
                        5
                    );
                } else {

                    token['balance'] = '0';
                }

                token['rawBalance'] = balance;

                return token;
            });
    }

    async getBorrowedBalances(walletAddress) {

        const allTokens = Object.values(this.tokens);

        const provider = (await this.web3Service.getWeb3Provider());

        const promises = allTokens
            .map(token => {

                const contract = new provider.eth.Contract(
                    // @ts-ignore
                    CERC20ABI,
                    token.address
                );

                return contract.methods.borrowBalanceCurrent(walletAddress).call();
            });

        return (await Promise.all(promises))
            .map((balance, i) => {

                const balanceBN = ethers.utils.bigNumberify(balance);

                const token = Object.assign({}, this.tokenService.tokens[allTokens[i].symbol.substr(1)]);

                if (balanceBN.gt(0)) {

                    token['balance'] = this.tokenService.toFixed(
                        this.tokenService.formatAsset(
                            token.symbol,
                            // @ts-ignore
                            balanceBN
                        ),
                        6);
                } else {

                    token['balance'] = 0;
                }

                token['rawBalance'] = balance;

                return token;
            });
    }

    async interest(
        tokenAddress: string
    ) {

        const cTokenContractAddress = this.tokenService
            .getTokenBySymbol(
                'c' + this.tokenService.getTokenByAddress(tokenAddress).symbol
            ).address;

        if (typeof cTokenContractAddress === 'undefined') {

            return {
                annualLendRate: 0,
                annualBorrowRate: 0
            };
        }

        const contract = new (await this.web3Service.getWeb3Provider()).eth.Contract(
            // @ts-ignore
            CERC20ABI,
            cTokenContractAddress
        );

        const [
            blockBorrowRate,
            totalBorrows,
            cash
        ] = await Promise.all([
            contract.methods.borrowRatePerBlock.call(),
            contract.methods.totalBorrows.call(),
            contract.methods.getCash.call()
        ]);

        const annualBorrowRate = (new WadDecimal(blockBorrowRate.toString())
            .div('1e18')
            .add(1)
            .pow(secondsInYear.div(15))
            .minus(1)
            .mul(100));

        const annualLendRate = annualBorrowRate
            .mul(totalBorrows.toString())
            .div(totalBorrows.add(cash).toString())
            .div(1 - 0.1);

        return {
            annualLendRate: annualLendRate,
            annualBorrowRate: annualBorrowRate
        };
    }
}
