import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MigrationComponent } from './migration/migration.component';


const routes: Routes = [
    {
        path: '',
        component: MigrationComponent
    }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
