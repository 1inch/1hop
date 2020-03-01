import { Component, OnDestroy, OnInit, ViewEncapsulation } from '@angular/core';
import { CompoundService } from '../compound.service';
import { Web3Service } from '../web3.service';
import { OnPageHidden, OnPageVisible } from 'angular-page-visibility';
import { MakerService } from '../maker.service';
import { TokenService } from '../token.service';

@Component({
    selector: 'app-migration',
    templateUrl: './migration.component.html',
    styleUrls: ['./migration.component.scss'],
    encapsulation: ViewEncapsulation.None
})
export class MigrationComponent implements OnInit, OnDestroy {

    compound = {
        lending: [],
        borrowing: []
    };

    maker = {
        dsr: 0,
        lending: [],
        borrowing: []
    };

    destroyed = false;
    sync = true;
    timer;

    constructor(
        private web3Service: Web3Service,
        private compoundService: CompoundService,
        private tokenService: TokenService,
        private makerService: MakerService,
    ) {
    }

    async ngOnInit() {


        await this.loadPositions();

        setTimeout(() => {

            this.web3Service.connectEvent.subscribe(async () => {

                this.loadPositions();
            });

            this.web3Service.disconnectEvent.subscribe(async () => {

            });
        }, 1000);
    }

    @OnPageVisible()
    logWhenPageVisible(): void {

        // console.log('OnPageVisible => visible');
        this.sync = true;
    }

    @OnPageHidden()
    logWhenPageHidden(): void {

        // console.log('OnPageHidden => hidden');
        this.sync = false;
    }

    async runBackgroundJobs() {

        const startTime = (new Date()).getTime();

        try {

            if (this.sync) {

                const promises = [];

                if (
                    this.web3Service.walletAddress
                ) {

                    promises.push(
                        this.loadPositions()
                    );
                }

                await Promise.all(promises);
            }
        } catch (e) {

            console.error(e);
        }

        try {

            if (
                (new Date()).getTime() - startTime > 5000
            ) {

                this.runBackgroundJobs();
            } else {

                this.timer = setTimeout(() => {

                    if (!this.destroyed) {

                        this.runBackgroundJobs();
                    }
                }, 5000 - ((new Date()).getTime() - startTime));
            }
        } catch (e) {

            console.error(e);
        }
    }

    async loadPositions() {

        this.makerService.getDSR().then(value => this.maker.dsr = value);

        if (this.web3Service.walletAddress) {

            this.compound.lending = await Promise.all(
                (await this.compoundService.getBalances(this.web3Service.walletAddress))
                    .filter(position => position.balance != 0)
                    .map(async position => {

                        position['apy'] = this.tokenService.toFixed(
                            (await this.compoundService.interest(
                                position.address
                            )).annualLendRate,
                            2
                        );

                        return position;
                    })
            );

            this.compound.borrowing = await Promise.all(
                (await this.compoundService.getBorrowedBalances(this.web3Service.walletAddress))
                    .filter(position => position.rawBalance.gt(0))
                    .map(async position => {

                        position['apy'] = this.tokenService.toFixed(
                            (await this.compoundService.interest(
                                position.address
                            )).annualBorrowRate,
                            2
                        );

                        return position;
                    })
            );

            console.log('this.compound', this.compound);
        }
    }

    ngOnDestroy(): void {

        this.destroyed = true;
        clearTimeout(this.timer);
    }
}
