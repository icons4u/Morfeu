<cfcomponent output="false" alias="api.Objeto">

	<cfproperty name="status" type="struct">
	<cfproperty name="data" type="struct">

	<cfscript>
		//Initialize the CFC with the default properties values.
		this["status"]["mensagem"] = "OK";
		this["status"]["erro"] = false;
		this["status"]["codErro"] = 0;
		this["data"] = {};
	</cfscript>

	<cffunction name="init" output="false" returntype="Objeto">
		<cfreturn this/>
	</cffunction>

</cfcomponent>