import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MigrationComponent } from './migration/migration.component';
import { HowItWorksComponent } from './how-it-works/how-it-works.component';
import { NoContentComponent } from './no-content/no-content.component';
import { BaseComponent } from './base/base.component';
import { ImportComponent } from './import/import.component';
import { ManageComponent } from './manage/manage.component';
import { MigrateComponent } from './migrate/migrate.component';

const routes: Routes = [
    {
        path: '',
        component: BaseComponent,
        children: [
            {
                path: '',
                component: MigrationComponent
            },
            {
                path: 'import/:provider',
                component: ImportComponent
            },
            {
                path: 'migrate/:provider',
                component: MigrateComponent
            },
            {
                path: 'manage',
                component: ManageComponent
            },
            {
                path: 'how-it-works',
                component: HowItWorksComponent
            }
        ]
    },
    {
        path: '**',
        component: NoContentComponent
    }
];

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
