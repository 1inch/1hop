import { Injectable } from '@angular/core';
import { Web3Service } from './web3.service';
import TokenABI from './abi/TokenABI.json';
import { ConfigurationService } from './configuration.service';

@Injectable({
    providedIn: 'root'
})
export class OneHopTokenService {

    contract;

    constructor(
        private web3Service: Web3Service,
        private configurationService: ConfigurationService
    ) {

        this.init();
    }

    async init() {

        this.contract = new (await this.web3Service.getWeb3Provider()).eth.Contract(
            // @ts-ignore
            TokenABI,
            this.configurationService.TOKEN_CONTRACT_ADDRESS
        );
    }

    async getContract() {

        // @ts-ignore
        return new Promise((resolve, reject) => {

            setTimeout(reject, 300000);

            const check = () => {

                if (this.contract) {

                    resolve(this.contract);
                    return;
                }

                setTimeout(() => {

                    check();
                }, 100);
            };

            check();
        });
    }

    async newPosition() {

        // @ts-ignore
        const callData = (await this.getContract()).methods.newPosition(
            this.configurationService.HOLDER_CONTRACT_ADDRESS
        )
            .encodeABI();

        const tx = this.web3Service.txProvider.eth.sendTransaction({
            from: this.web3Service.walletAddress,
            to: this.configurationService.TOKEN_CONTRACT_ADDRESS,
            value: 0,
            gasPrice: this.configurationService.fastGasPrice,
            data: callData
        });

        return new Promise((resolve, reject) => {

            tx
                .once('transactionHash', async (hash) => {

                    resolve(hash);
                })
                .on('error', (err) => {

                    reject(err);
                });
        });
    }
}
