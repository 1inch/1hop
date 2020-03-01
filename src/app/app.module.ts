import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { MigrationComponent } from './migration/migration.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { BaseComponent } from './base/base.component';
import { NoContentComponent } from './no-content/no-content.component';
import { NgbAlertModule, NgbDropdownModule, NgbModule, NgbToastModule } from '@ng-bootstrap/ng-bootstrap';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { FormsModule } from '@angular/forms';
import { ServiceWorkerModule } from '@angular/service-worker';
import { environment } from '../environments/environment';
import { LoadingSpinnerModule } from './loading-spinner/loading-spinner.module';
import { HttpClientModule } from '@angular/common/http';
import { ModalModule } from 'ngx-bootstrap';
import { ImportComponent } from './import/import.component';

@NgModule({
    declarations: [
        AppComponent,
        MigrationComponent,
        BaseComponent,
        NoContentComponent,
        ImportComponent
    ],
    imports: [
        BrowserAnimationsModule,
        AppRoutingModule,
        NgbAlertModule,
        NgbDropdownModule,
        FontAwesomeModule,
        NgbDropdownModule,
        FormsModule,
        NgbModule,
        HttpClientModule,
        LoadingSpinnerModule,
        ModalModule.forRoot(),
        NgbToastModule,
        ServiceWorkerModule.register('ngsw-worker.js', {
            enabled: navigator.userAgent.toLowerCase().indexOf('android') === -1 &&
                'serviceWorker' in navigator && environment.production
        }),
        FontAwesomeModule
    ],
    providers: [],
    bootstrap: [AppComponent]
})
export class AppModule {
}
