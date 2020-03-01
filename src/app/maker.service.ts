import { Injectable } from '@angular/core';
import { ConfigurationService } from './configuration.service';
import { Web3Service } from './web3.service';

import MCDPotABI from './abi/MCDPotABI.json';
import { TokenService } from './token.service';

import toformat from 'toformat';

let Decimal = require('decimal.js-light');
Decimal = toformat(Decimal);

export const WadDecimal = Decimal.clone({
    rounding: 1, // round down
    precision: 78,
    toExpNeg: -18,
    toExpPos: 78
});

const secondsInYear = WadDecimal(60 * 60 * 24 * 365);

@Injectable({
    providedIn: 'root'
})
export class MakerService {

    potContract;

    constructor(
        private configurationService: ConfigurationService,
        private web3Service: Web3Service,
        private tokenService: TokenService
    ) {

        this.init();
    }

    async init() {

        this.potContract = new (await this.web3Service.getWeb3Provider()).eth.Contract(
            // @ts-ignore
            MCDPotABI,
            this.configurationService.MCD_POT_CONTRACT_ADDRESS
        );
    }

    async getPotContract() {

        // @ts-ignore
        return new Promise((resolve, reject) => {

            setTimeout(reject, 300000);

            const check = () => {

                if (this.potContract) {

                    resolve(this.potContract);
                    return;
                }

                setTimeout(() => {

                    check();
                }, 100);
            };

            check();
        });
    }

    async getDSR() {

        const potContract = await this.getPotContract();
        // @ts-ignore
        const dsrRaw = await potContract.methods.dsr().call();

        return (new WadDecimal(dsrRaw.toString()).div('1e27')
            .pow(secondsInYear)
            .minus(1)
            .mul(100)).toNumber()
            .toPrecision(2);
    }
}
