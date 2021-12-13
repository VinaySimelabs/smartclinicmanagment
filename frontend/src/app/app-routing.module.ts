

import { AuthGuard } from './shared/auth.guard';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdminComponent } from './admin/admin.component';
import { LoginComponent } from './login/login.component';
import { HomeComponent } from './home/home.component';
import { AboutusComponent } from './aboutus/aboutus.component';
import { ContactsComponent } from './contacts/contacts.component';
import { AnnouncementComponent } from './announcement/announcement.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'home', component: HomeComponent },
  { path: 'contacts', component: ContactsComponent },
  { path: 'prescriptionhistory/:patientId', },
  { path: 'aboutus', component: AboutusComponent },
  // { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },

  {
    path: 'labresults/:patientId/:empId/:appointmentId',
  },
  { path: 'prescription/:patientId/:empId',},
  {
    path: 'prescription/:patientId/:empId/:aId',

  },
  {
    path: 'prescription/:patientId/:empId/:atId/:id',

  },
  { path: 'doctor', },
  {
    path: 'receptionist',
    canActivate: [AuthGuard],
    data: { role: '4' },
  },
  {
    path: 'admin',
    component: AdminComponent,
    canActivate: [AuthGuard],
    data: { role: '3' },
  },
  {
    path: 'doctor/:empId',
    canActivate: [AuthGuard],
    data: { role: '1' },
  },
  {
    path: 'labtechnician/:empId',
    canActivate: [AuthGuard],
    data: { role: '2' },
  },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
