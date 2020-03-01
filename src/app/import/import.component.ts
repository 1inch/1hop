import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { faArrowRight } from '@fortawesome/free-solid-svg-icons';
import { OneHopTokenService } from '../one-hop-token.service';
import { Router } from '@angular/router';
import { TokenService } from '../token.service';
import { Web3Service } from '../web3.service';
import { ConfigurationService } from '../configuration.service';
import { TransactionService } from '../transaction.service';

@Component({
    selector: 'app-import',
    templateUrl: './import.component.html',
    styleUrls: ['./import.component.scss'],
    encapsulation: ViewEncapsulation.None
})
export class ImportComponent implements OnInit {

    copyIcon = faArrowRight;
    loading = false;

    constructor(
        private oneHopTokenService: OneHopTokenService,
        private configurationService: ConfigurationService,
        private web3Service: Web3Service,
        private transactionService: TransactionService,
        private tokenService: TokenService,
        private router: Router
    ) {
    }

    ngOnInit(): void {
    }

    async createNewPosition() {

        this.loading = true;

        try {

            if (
                (await this.tokenService.getERC20TokenBalanceByAddress(
                    this.web3Service.walletAddress,
                    this.configurationService.TOKEN_CONTRACT_ADDRESS
                )).eq(0)
            ) {

                const hash = await this.oneHopTokenService.newPosition();
                console.log('hash', hash);

                await this.transactionService.waitForTransaction(hash);
            }

            this.router.navigateByUrl('/manage');
        } catch (e) {

            console.error(e);
            alert(e);
        }

        this.loading = false;
    }
}
