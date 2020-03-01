import { Component, OnInit } from '@angular/core';
import { faArrowRight } from '@fortawesome/free-solid-svg-icons';

@Component({
    selector: 'app-migrate',
    templateUrl: './migrate.component.html',
    styleUrls: ['./migrate.component.scss']
})
export class MigrateComponent implements OnInit {

    copyIcon = faArrowRight;

    constructor() {
    }

    ngOnInit(): void {
    }

}
