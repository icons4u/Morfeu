import {Component, OnInit} from '@angular/core';
import { HttpClientModule, HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent  implements OnInit {

  lead: any;

  constructor(private http: HttpClient) {
    // constructor
  }

  ngOnInit() {
    this.getLead();
  }

  calcIdade(nascimento) {
    const dateNascimento = new Date(nascimento);
    const ageDifMs = Date.now() - dateNascimento.getTime();
    const ageDate = new Date(ageDifMs);
    this.lead.idade = Math.abs(ageDate.getUTCFullYear() - 1970);
    this.calcStatus();
  }

  calcIMC() {
    if (this.lead.peso && this.lead.altura) {
      this.lead.imc = this.lead.peso / ((this.lead.altura / 100) * (this.lead.altura / 100));
      this.calcStatus();
    }
  }

  calcStatus() {
    if (this.lead.imc <= 31 && this.lead.idade >= 55 && this.lead.insonia !== 'false' && this.lead.iniciar_sono !== 'false') {
      this.lead.status = 'APTO';
    } else {
      this.lead.status = 'NÃO APTO';
    }
  }

  getLead() {
    this.http.get('http://api.icons4u.com.br/morfeu/api/DAO.cfc?method=getLead&token=jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23')
      .subscribe(data => {
        if (!data['status'].erro) {
          this.lead = data['data'];
        }
      });
  }

  saveLead() {
    const params = JSON.stringify(this.lead);
    this.http.post('http://api.icons4u.com.br/morfeu/api/DAO.cfc?method=editLead&token=jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23', params)
      .subscribe(data => {
        if (!data['status'].erro) {
          this.getLead();
        } else {

        }
      });
  }
}
