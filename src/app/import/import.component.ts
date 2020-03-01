import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { faArrowRight } from '@fortawesome/free-solid-svg-icons';

@Component({
    selector: 'app-import',
    templateUrl: './import.component.html',
    styleUrls: ['./import.component.scss'],
    encapsulation: ViewEncapsulation.None
})
export class ImportComponent implements OnInit {

    copyIcon = faArrowRight;

    constructor() {
    }

    ngOnInit(): void {
    }

}
