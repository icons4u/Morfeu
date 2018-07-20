<cfcomponent output="false">

  <!---jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23--->

  <cfsetting requestTimeout="30"/>
  <cfprocessingdirective pageencoding="utf-8"/>
  <cfset SetEncoding("url", "utf-8")/>
  <cfset SetEncoding("form", "utf-8")/>
  <cfheader name="Access-Control-Allow-Origin" value="*"/>
  <cfheader name="Content-Type" value="application/json"/>


  <!--- PACIENTE --->

  <cffunction name="nextLead" access="remote" output="false" returnformat="plain" returntype="string">

    <cfargument name="token" type="string" default=""/>

    <cfset returnObject = CreateObject("component", "ReturnObject")/>

    <cfif ARGUMENTS.token NEQ "jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23">
      <cfset returnObject["status"]["mensagem"] = "Token invalido"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 99/>
      <cfreturn SerializeJSON(returnObject)/>
    </cfif>

    <cftry>
      <cfset VARIABLES.POST = deserializeJSON(ToString(getHTTPRequestData().content)) />
      <cfset VARIABLES.lead_id = VARIABLES.POST.lead_id/>
      <cfset VARIABLES.observacoes = VARIABLES.POST.observacoes/>
      <cfcatch type="any">
        <cfset vo = CreateObject("component", "ReturnObject")/>
        <cfset vo["status"]["mensagem"] = "Dados incorretos, não consegui gravar."/>
        <cfset vo["status"]["erro"] = true/>
        <cfreturn SerializeJSON(vo)/>
      </cfcatch>
    </cftry>

    <!---cftry--->
      <cfquery name="qUpdate" result="queryResult">
        UPDATE ache.tb_morfeu_lead as lead
        SET
        status = <cfqueryparam cfsqltype="cf_sql_varchar" value="tentar novamente"/>,
        data_contato = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>,
        observacoes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.observacoes#"/>
        WHERE lead_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#VARIABLES.lead_id#"/>
      </cfquery>
      <cfset returnObject["data"] = true/>
      <!---cfcatch type="any">
        <cfset returnObject["status"]["mensagem"] = "Erro ao alterar lead"/>
        <cfset returnObject["status"]["erro"] = true/>
        <cfset returnObject["status"]["codErro"] = 500/>
      </cfcatch>
    </cftry--->

    <cfreturn SerializeJSON(returnObject)/>

  </cffunction>

  <cffunction name="editLead" access="remote" output="false" returnformat="plain" returntype="string">

    <cfargument name="token" type="string" default=""/>

    <cfset returnObject = CreateObject("component", "ReturnObject")/>

    <cfif ARGUMENTS.token NEQ "jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23">
      <cfset returnObject["status"]["mensagem"] = "Token invalido"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 99/>
      <cfreturn SerializeJSON(returnObject)/>
    </cfif>

    <!---cftry--->
      <cfset VARIABLES.POST = deserializeJSON(ToString(getHTTPRequestData().content)) />
      <cfset VARIABLES.lead_id = VARIABLES.POST.lead_id/>
      <cfset VARIABLES.status = VARIABLES.POST.status/>
      <cfset VARIABLES.nascimento = VARIABLES.POST.nascimento/>
      <cfset VARIABLES.peso = VARIABLES.POST.peso/>
      <cfset VARIABLES.altura = VARIABLES.POST.altura/>
      <cfset VARIABLES.imc = VARIABLES.POST.imc/>
      <cfset VARIABLES.insonia = VARIABLES.POST.insonia/>
      <cfset VARIABLES.iniciar_sono = VARIABLES.POST.iniciar_sono/>
      <cfset VARIABLES.manter_sono = VARIABLES.POST.manter_sono/>
      <cfset VARIABLES.despertar_antes = VARIABLES.POST.despertar_antes/>
      <cfset VARIABLES.horario_dormir = VARIABLES.POST.horario_dormir/>
      <cfset VARIABLES.doenca = VARIABLES.POST.doenca/>
      <cfset VARIABLES.medicamentos = VARIABLES.POST.medicamentos/>
      <cfset VARIABLES.usou_medicamento = VARIABLES.POST.usou_medicamento/>
      <cfset VARIABLES.diabetes = VARIABLES.POST.diabetes/>
      <cfset VARIABLES.apneia = VARIABLES.POST.apneia/>
      <cfset VARIABLES.trabalha_noite = VARIABLES.POST.trabalha_noite/>
      <cfset VARIABLES.imc_alto = VARIABLES.POST.imc_alto/>
      <cfset VARIABLES.alcool_drogas = VARIABLES.POST.alcool_drogas/>
      <cfset VARIABLES.interesse = VARIABLES.POST.interesse/>
      <cfset VARIABLES.observacoes = VARIABLES.POST.observacoes/>
      <!---cfcatch type="any">
        <cfset vo = CreateObject("component", "ReturnObject")/>
        <cfset vo["status"]["mensagem"] = "Dados incorretos, não consegui gravar."/>
        <cfset vo["status"]["erro"] = true/>
        <cfreturn SerializeJSON(vo)/>
      </cfcatch>
    </cftry--->

    <!---cftry--->
      <cfquery name="qUpdate" result="queryResult">
        UPDATE ache.tb_morfeu_lead as lead
        SET
        status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.status#"/>,
        data_contato = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>,
        nascimento = <cfqueryparam cfsqltype="cf_sql_date" value="#VARIABLES.nascimento#"/>,
        peso = <cfqueryparam cfsqltype="cf_sql_numeric" value="#VARIABLES.peso#"/>,
        altura = <cfqueryparam cfsqltype="cf_sql_numeric" value="#VARIABLES.altura#"/>,
        imc = <cfqueryparam cfsqltype="cf_sql_numeric" value="#VARIABLES.imc#"/>,
        <cfif Len(trim(VARIABLES.insonia)) GT 0>insonia = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.insonia)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.iniciar_sono)) GT 0>iniciar_sono = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.iniciar_sono)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.manter_sono)) GT 0>manter_sono = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.manter_sono)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.despertar_antes)) GT 0>despertar_antes = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.despertar_antes)#"/>,</cfif>
        horario_dormir = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.horario_dormir#"/>,
        doenca = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.doenca#"/>,
        medicamentos = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.medicamentos#"/>,
        <cfif Len(trim(VARIABLES.usou_medicamento)) GT 0>usou_medicamento = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.usou_medicamento)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.diabetes)) GT 0>diabetes = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.diabetes)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.apneia)) GT 0>apneia = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.apneia)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.trabalha_noite)) GT 0>trabalha_noite = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.trabalha_noite)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.imc_alto)) GT 0>imc_alto = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.imc_alto)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.alcool_drogas)) GT 0>alcool_drogas = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.alcool_drogas)#"/>,</cfif>
        <cfif Len(trim(VARIABLES.interesse)) GT 0>interesse = <cfqueryparam cfsqltype="cf_sql_bit" value="#YesNoFormat(VARIABLES.interesse)#"/>,</cfif>
        observacoes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.observacoes#"/>
        WHERE lead_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#VARIABLES.lead_id#"/>
      </cfquery>
      <cfset returnObject["data"] = true/>
      <!---cfcatch type="any">
        <cfset returnObject["status"]["mensagem"] = "Erro ao alterar lead"/>
        <cfset returnObject["status"]["erro"] = true/>
        <cfset returnObject["status"]["codErro"] = 500/>
      </cfcatch>
    </cftry--->

    <cfreturn SerializeJSON(returnObject)/>

  </cffunction>

  <cffunction name="getLead" access="remote" output="false" returnformat="plain" returntype="string">

    <cfargument name="token" type="string" default=""/>

    <cfset returnObject = CreateObject("component", "ReturnObject")/>

    <cfif ARGUMENTS.token NEQ "jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23">
      <cfset returnObject["status"]["mensagem"] = "Token invalido"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 99/>
      <cfreturn SerializeJSON(returnObject)/>
    </cfif>

    <cfquery name="qRetorno">
        SELECT lead.*
        FROM ache.tb_morfeu_lead as lead
        WHERE lead.status IS NULL
        ORDER BY data_contato DESC, lead_id
        LIMIT 1;
    </cfquery>
    <cfquery name="qUpdate" result="queryResult">
      UPDATE ache.tb_morfeu_lead
      SET status = <cfqueryparam cfsqltype="cf_sql_varchar" value="ligando"/>
      WHERE lead_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qRetorno.lead_id#"/>
    </cfquery>

    <cfif qRetorno.recordCount>
        <cfset obj = CreateObject("component", "Objeto")/>
        <cfset obj["lead_id"] = qRetorno.lead_id/>
        <cfset obj["telefone"] = qRetorno.telefone/>
        <cfset obj["status"] = qRetorno.status/>
        <cfset obj["data_contato"] = qRetorno.data_contato/>
        <cfset obj["nome"] = qRetorno.nome/>
        <cfset obj["nascimento"] = qRetorno.nascimento/>
        <cfset obj["peso"] = qRetorno.peso/>
        <cfset obj["altura"] = qRetorno.altura/>
        <cfset obj["imc"] = qRetorno.imc/>
        <cfset obj["telefone"] = qRetorno.telefone/>
        <cfset obj["telefone2"] = qRetorno.telefone2/>
        <cfset obj["celular"] = qRetorno.celular/>
        <cfset obj["insonia"] = qRetorno.insonia/>
        <cfset obj["iniciar_sono"] = qRetorno.iniciar_sono/>
        <cfset obj["manter_sono"] = qRetorno.manter_sono/>
        <cfset obj["despertar_antes"] = qRetorno.despertar_antes/>
        <cfset obj["horario_dormir"] = qRetorno.horario_dormir/>
        <cfset obj["doenca"] = qRetorno.doenca/>
        <cfset obj["medicamentos"] = qRetorno.medicamentos/>
        <cfset obj["usou_medicamento"] = qRetorno.usou_medicamento/>
        <cfset obj["diabetes"] = qRetorno.diabetes/>
        <cfset obj["apneia"] = qRetorno.apneia/>
        <cfset obj["trabalha_noite"] = qRetorno.trabalha_noite/>
        <cfset obj["imc_alto"] = qRetorno.imc_alto/>
        <cfset obj["alcool_drogas"] = qRetorno.alcool_drogas/>
        <cfset obj["interesse"] = qRetorno.interesse/>
        <cfset obj["observacoes"] = qRetorno.observacoes/>
        <cfset returnObject["data"] = obj/>
    <cfelse>
      <cfset returnObject["status"]["mensagem"] = "Dados Inexistentes"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 1/>
    </cfif>

    <cfreturn SerializeJSON(returnObject)/>

  </cffunction>

</cfcomponent>
