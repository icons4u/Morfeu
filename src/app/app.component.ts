import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';
  lead = {nome: 'Leonardo Sobral', telefone: '21967026543', idade: 39, imc: 21};
}
