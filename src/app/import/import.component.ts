import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { faArrowRight } from '@fortawesome/free-solid-svg-icons';
import { OneHopTokenService } from '../one-hop-token.service';
import { Router } from '@angular/router';
import { TokenService } from '../token.service';
import { Web3Service } from '../web3.service';
import { ConfigurationService } from '../configuration.service';
import { TransactionService } from '../transaction.service';
import { ethers } from 'ethers';

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

            const nftTokenBalance = await this.tokenService.getERC20TokenBalanceByAddress(
                this.web3Service.walletAddress,
                this.configurationService.TOKEN_CONTRACT_ADDRESS
            );

            if (
                nftTokenBalance.eq(0)
            ) {

                const hash = await this.oneHopTokenService.newPosition();
                console.log('hash', hash);

                await this.transactionService.waitForTransaction(hash);
            }

            const tokenBalance = await this.tokenService.getTokenBalance(
                'cDAI',
                this.web3Service.walletAddress
            );

            if (
                !(await this.tokenService.isApproved(
                    'cDAI',
                    this.configurationService.TOKEN_CONTRACT_ADDRESS,
                    tokenBalance
                ))
            ) {

                await this.tokenService.approve(
                    'cDAI',
                    this.configurationService.TOKEN_CONTRACT_ADDRESS,
                    tokenBalance
                );
            }

            const hash = await this.oneHopTokenService.moveIn(
                this.tokenService.getTokenBySymbol('DAI').address,
                this.tokenService.getTokenBySymbol('WBTC').address,
                await this.oneHopTokenService.tokenOfOwnerByIndex(
                    this.web3Service.walletAddress,
                    nftTokenBalance.sub(1)
                )
            );

            console.log('hash', hash);

            await this.transactionService.waitForTransaction(hash);

            this.router.navigateByUrl('/manage');
        } catch (e) {

            console.error(e);
            alert(e);
        }

        this.loading = false;
    }
}
