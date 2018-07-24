<cfquery name="qRetorno">
  SELECT COUNT(lead.lead_id) as total
  FROM ache.tb_morfeu_lead as lead
  WHERE lead.status = 'APTO'
</cfquery>

<p><cfoutput>#qRetorno.total# usuários APTOS</cfoutput></p>

<cfquery name="qRetorno">
  SELECT COUNT(lead.lead_id) as total
  FROM ache.tb_morfeu_lead as lead
  WHERE lead.status = 'NÃO APTO'
</cfquery>

<p><cfoutput>#qRetorno.total# usuários NÃO APTOS</cfoutput></p>



<cfquery name="qRetorno">
  SELECT lead.*
  FROM ache.tb_morfeu_lead as lead
  WHERE lead.data_contato IS NOT NULL
  ORDER BY data_contato DESC, lead_id
</cfquery>

<br/>

<p><cfoutput>#qRetorno.recordcount# ligações feitas</cfoutput></p>


<cfset relatorioName = "relatorioLeads" & LSDateFormat(Now(), "YYYY-MM-DD") & "_" & LSTimeFormat(Now(), "HH-MM")/>

<cfset strPath = GetDirectoryFromPath(GetCurrentTemplatePath()) />

<cfspreadsheet action="write"
  filename="#strPath##relatorioName#.xlsx"
  overwrite="true"
  query="qRetorno"
  sheetname="Leads">

<a href="<cfoutput>#relatorioName#.xlsx</cfoutput>">Baixar relatório</a>
