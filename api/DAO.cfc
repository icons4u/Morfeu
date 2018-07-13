<cfcomponent output="false">

  <!---jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23--->

  <cfsetting requestTimeout="30"/>
  <cfprocessingdirective pageencoding="utf-8"/>
  <cfset SetEncoding("url", "utf-8")/>
  <cfset SetEncoding("form", "utf-8")/>
  <cfheader name="Access-Control-Allow-Origin" value="*"/>
  <cfheader name="Content-Type" value="application/json"/>


  <!--- PACIENTE --->

  <cffunction name="addUsuario" access="remote" output="false" returnformat="plain" returntype="string">

    <cfargument name="person_name" type="string"/>
    <cfargument name="person_email" type="string"/>
    <cfargument name="token" type="string" default=""/>

    <cfset returnObject = CreateObject("component", "ReturnObject")/>

    <cfif ARGUMENTS.token NEQ "jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23">
      <cfset returnObject["status"]["mensagem"] = "Token invalido"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 99/>
      <cfreturn SerializeJSON(returnObject)/>
    </cfif>

    <cftry>
      <cfquery name="qInsertUser" result="queryResult">
        INSERT INTO projeto_caua.tb_person_user
        (person_name, person_email, password)
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.person_name#"/>,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.person_email#"/>,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1234"/>
        )
      </cfquery>
    <cfset returnObject["data"] = true/>
    <cfcatch type="any">
      <cfset returnObject["status"]["mensagem"] = "Erro ao inserir usuário"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 500/>
    </cfcatch>
    </cftry>

    <cfreturn SerializeJSON(returnObject)/>

  </cffunction>

  <cffunction name="editUsuario" access="remote" output="false" returnformat="plain" returntype="string">

    <cfargument name="person_name" type="string"/>
    <cfargument name="birth_date" type="date"/>
    <cfargument name="gender" type="string"/>
    <cfargument name="intervention_id" type="numeric"/>
    <cfargument name="user_id" type="numeric" default="5"/>
    <cfargument name="token" type="string" default=""/>

    <cfset returnObject = CreateObject("component", "ReturnObject")/>

    <cfif ARGUMENTS.token NEQ "jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23">
      <cfset returnObject["status"]["mensagem"] = "Token invalido"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 99/>
      <cfreturn SerializeJSON(returnObject)/>
    </cfif>

    <cfquery name="qPaciente">
      SELECT paciente.*, inte.intervention_id
      FROM projeto_caua.tb_intervention inte
      INNER JOIN projeto_caua.tb_person_patient paciente ON inte.person_id = paciente.person_id
      WHERE paciente.active = true
      AND inte.intervention_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.intervention_id#"/>;
    </cfquery>

    <cftry>
      <cfquery name="qUpdatePatient">
        UPDATE projeto_caua.tb_person_patient
        SET person_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.person_name#"/>,
        birth_date = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.birth_date#"/>,
        gender = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gender#"/>
        WHERE person_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qPaciente.person_id#"/>;
      </cfquery>
    <cfset returnObject["data"] = true/>
    <cfcatch type="any">
      <cfset returnObject["status"]["mensagem"] = "Erro ao editar intervenção"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 500/>
    </cfcatch>
    </cftry>

    <cfreturn SerializeJSON(returnObject)/>

  </cffunction>

  <cffunction name="getUsuarios" access="remote" output="false" returnformat="plain" returntype="string">

    <cfargument name="institution_id" type="numeric" default="1"/>
    <cfargument name="token" type="string" default=""/>

    <cfset returnObject = CreateObject("component", "ReturnObject")/>

    <cfif ARGUMENTS.token NEQ "jf8w3ynr73840rync848udq07yrc89q2h4nr08ync743c9r8h328f42fc8n23">
      <cfset returnObject["status"]["mensagem"] = "Token invalido"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 99/>
      <cfreturn SerializeJSON(returnObject)/>
    </cfif>

    <cfquery name="qRetorno" cachedwithin="#CreateTimeSpan(0, 0, 1, 0)#">
            SELECT usr.*
            FROM projeto_caua.tb_person_user as usr
            WHERE usr.active = true
            ORDER BY usr.person_name;
        </cfquery>

    <cfif qRetorno.recordCount>
      <cfset arrayVO = ArrayNew(1)/>
      <cfloop query="qRetorno">
        <cfset obj = CreateObject("component", "Objeto")/>
        <cfset obj["person_id"] = qRetorno.person_id/>
        <cfset obj["person_name"] = qRetorno.person_name/>
        <cfset obj["person_email"] = qRetorno.person_email/>
        <cfset arrayVO[CurrentRow] = obj/>
      </cfloop>
      <cfset returnObject["data"] = arrayVO/>
    <cfelse>
      <cfset returnObject["status"]["mensagem"] = "Dados Inexistentes"/>
      <cfset returnObject["status"]["erro"] = true/>
      <cfset returnObject["status"]["codErro"] = 1/>
    </cfif>

    <cfreturn SerializeJSON(returnObject)/>

  </cffunction>

</cfcomponent>
