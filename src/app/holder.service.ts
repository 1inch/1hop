import { Injectable } from '@angular/core';
import { Web3Service } from './web3.service';
import { ConfigurationService } from './configuration.service';
import HolderABI from './abi/HolderABI.json';

@Injectable({
    providedIn: 'root'
})
export class HolderService {

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
            HolderABI,
            this.configurationService.HOLDER_CONTRACT_ADDRESS
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
}
