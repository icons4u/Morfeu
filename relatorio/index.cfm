<cfquery name="qRetorno">
  SELECT lead.*
  FROM ache.tb_morfeu_lead as lead
  WHERE lead.status IS NOT NULL
  ORDER BY data_contato DESC, lead_id
</cfquery>

<cfoutput>#qRetorno.recordcount# usuários completados</cfoutput>

<cfdump var="#qRetorno#"/>


<cfquery name="qRetorno">
  SELECT lead.*
  FROM ache.tb_morfeu_lead as lead
  WHERE lead.data_contato IS NOT NULL
  ORDER BY data_contato DESC, lead_id
</cfquery>

<br/>

<cfoutput>#qRetorno.recordcount# ligações feitas</cfoutput>


<cfset relatorioName = "relatorioLeads" & LSDateFormat(Now(), "YYYY-MM-DD") & "_" & LSTimeFormat(Now(), "HH-MM")/>

<cfset strPath = GetDirectoryFromPath(GetCurrentTemplatePath()) />

<cfspreadsheet action="write"
  filename="#strPath##relatorioName#.xlsx"
  overwrite="true"
  query="qRetorno"
  sheetname="Leads">

<a href="<cfoutput>#relatorioName#.xlsx</cfoutput>">Baixar relatório</a>
