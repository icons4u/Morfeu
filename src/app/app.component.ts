import {Component, OnInit} from '@angular/core';
import { HttpClientModule, HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent  implements OnInit {

  lead: any = {status:''};
  arrLeads: any = [];
  arrUsers: any = [];
  statusStage: number = 0;
  atendenteID: number = 0;
  showLead: boolean = true;

  constructor(private http: HttpClient) {
    // constructor
  }

  ngOnInit() {
    this.getUsers();
  }

  getUsers() {
    this.http.get('http://api.icons4u.com.br/morfeu/api/DAO.cfc?method=getUsers&token=jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23')
      .subscribe(data => {
        console.log('users:' + JSON.stringify(data));
        if (!data['status'].erro) {
          this.arrUsers = data['data'];
          window.scrollTo(0,0);
        }
      });
  }

  iniciaAtendimento(atendente) {
    console.log('atendente:' + atendente);
    if (atendente == 0) {
      this.showLead = true;
      return;
    } else {
      this.showLead = false;
      this.atendenteID = atendente;
      this.getLead();
      this.getToReturnLeads();
    }
  }

  calcIdade(nascimento) {
    const dateNascimento = new Date(nascimento);
    const ageDifMs = Date.now() - dateNascimento.getTime();
    const ageDate = new Date(ageDifMs);
    this.lead.idade = Math.ceil(ageDate.getUTCFullYear() - 1970);
    this.calcStatus();
  }

  calcIMC() {
    if (this.lead.peso && this.lead.altura) {
      this.lead.imc = this.lead.peso / ((this.lead.altura / 100) * (this.lead.altura / 100));
      this.calcStatus();
    }
  }

  calcStatus() {
    this.lead.status = 'APTO';
    if (this.lead.interesse === 'false') {
      this.lead.status = 'NÃO APTO';
      console.log('interesse');
      return;
    }
    this.statusStage = 1;

    if (this.lead.idade) {
      if (this.lead.idade && this.lead.idade < 55) {
        this.lead.status = 'NÃO APTO';
        console.log('idade: ' + this.lead.idade);
        return;
      }
    } else {
      return;
    }
    this.statusStage = 2;

    if (this.lead.imc) {
      if (this.lead.imc && this.lead.imc > 31) {
        this.lead.status = 'NÃO APTO';
        console.log('imc: ' + this.lead.imc);
        return;
      }
    } else {
      return;
    }
    this.statusStage = 3;

    if (this.lead.insonia) {
      if (this.lead.insonia === 'false') {
        this.lead.status = 'NÃO APTO';
        console.log('insonia');
        return;
      }
    } else {
      return;
    }
    this.statusStage = 4;

    if (this.lead.iniciar_sono) {
      if (this.lead.iniciar_sono === 'false') {
        this.lead.status = 'NÃO APTO';
        console.log('iniciar_sono');
        return;
      }
    } else {
      return;
    }
    this.statusStage = 5;

    if (this.lead.usou_medicamento) {
      if (this.lead.usou_medicamento === 'true') {
        this.lead.status = 'NÃO APTO';
        console.log('usou_medicamento');
        return;
      }
    } else {
      return;
    }
    this.statusStage = 6;

    if (this.lead.diabetes) {
      if (this.lead.diabetes === 'true') {
        this.lead.status = 'NÃO APTO';
        console.log('diabetes');
        return;
      }
    } else {
      return;
    }
    this.statusStage = 7;

    if (this.lead.apneia) {
      if (this.lead.apneia === 'true') {
        this.lead.status = 'NÃO APTO';
        console.log('apneia');
        return;
      }
    } else {
      return;
    }
    this.statusStage = 8;

    if (this.lead.trabalha_noite) {
      if (this.lead.trabalha_noite === 'true') {
        this.lead.status = 'NÃO APTO';
        console.log('trabalha_noite');
        return;
      }
    } else {
      return;
    }
    this.statusStage = 9;

    if (this.lead.alcool_drogas) {
      if (this.lead.alcool_drogas === 'true') {
        this.lead.status = 'NÃO APTO';
        console.log('alcool_drogas');
        return;
      }
    } else {
      return;
    }
    this.statusStage = 10;
  }

  getLead() {
    console.log('getLead | Atendente: ' + this.atendenteID);
    this.http.get('http://api.icons4u.com.br/morfeu/api/DAO.cfc?method=getLead&token=jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23&idUser=' + this.atendenteID)
      .subscribe(data => {
        console.log(JSON.stringify(data));
        if (!data['status'].erro) {
          this.lead = data['data'];
          window.scrollTo(0,0);
        }
      });
  }

  getToReturnLeads() {
    this.http.get('http://api.icons4u.com.br/morfeu/api/DAO.cfc?method=getToReturnLeads&token=jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23')
      .subscribe(data => {
        console.log(JSON.stringify(data));
        if (!data['status'].erro) {
          this.arrLeads = data['data'];
        }
      });
  }

  saveLead() {
    const params = JSON.stringify(this.lead);
    //console.log(JSON.stringify(this.lead));
    this.http.post('http://api.icons4u.com.br/morfeu/api/DAO.cfc?method=editLead&token=jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23', params)
      .subscribe(data => {
        if (!data['status'].erro) {
          this.getLead();
          this.getToReturnLeads();
        } else {

        }
      });
  }

  nextLead(status) {

    if (status == '') {
      return;
    } else {
      this.lead.status = status;
    }

    const params = JSON.stringify(this.lead);
    console.log(JSON.stringify(this.lead));

    this.http.post('http://api.icons4u.com.br/morfeu/api/DAO.cfc?method=nextLead&token=jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23', params)
      .subscribe(data => {
        if (!data['status'].erro) {
          this.getLead();
          this.getToReturnLeads();
        } else {

        }
      });
  }

  setLead(lead) {
    this.lead = lead;
  }
}
