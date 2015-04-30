<html>
	<head>
		<title>BlackTDN :: UBTDNTBLVIEW.php</title>
	</head>
	<body>
		<?php
			$wsdl	 = "http://BlackTDN:8088/ws02/UBTDNTVIEW.apw?WSDL";
			try {
				$client  = new SoapClient($wsdl,array("cache_wsdl"=>WSDL_CACHE_NONE));
				$alias   = "SX2";
				$deleted = false;
				$recno   = false;
				$param   = array("ALIAS"=>$alias,"RDELETED"=>$deleted);
				$result  = $client->GETTRMAX($param);
				$tRMax   = $result->GETTRMAXRESULT;
				$where   = "SUBSTR(X2_CHAVE,1,2)$'SR/SP'";
				$param   = array("ALIAS"=>$alias,"RINIT"=>1,"REND"=>$tRMax,"WHERE"=>$where,"RDELETED"=>$deleted,"RRECNO"=>$recno);
				$result  = $client->GETTBYWHERE($param);
				echo "<table border='1' align='left'>";
				echo 	"<thead>";
				echo 		"<tr align='left'>";
				echo 			"<th>FLDNAME</th>";
				echo 			"<th>FLDTYPE</th>";
				echo 			"<th>FLDSIZE</th>";
				echo 			"<th>FLDDEC</th>";
				echo 			"<th>FLDTITLE</th>";
				echo 			"<th>FLDDESCRIPTION</th>";
				echo 			"<th>FLDMANDATORY</th>";
				echo 		"</tr>";
				echo 	"</thead>";	  
				echo "<tbody>";
				foreach ($result->GETTBYWHERERESULT->TABLESTRUCT->UFIELDSTRUCT as $item) {
					 echo "<tr>";
						echo "<td><pre>".print_r($item->FLDNAME,true)."</pre></td>";
						echo "<td><pre>".print_r($item->FLDTYPE,true)."</pre></td>";
						echo "<td><pre>".print_r($item->FLDSIZE,true)."</pre></td>";
						echo "<td><pre>".print_r($item->FLDDEC,true)."</pre></td>";
						echo "<td><pre>".print_r($item->FLDTITLE,true)."</pre></td>";
						echo "<td><pre>".print_r($item->FLDDESCRIPTION,true)."</pre></td>";
						echo "<td><pre>".print_r($item->FLDMANDATORY,true)."</pre></td>";
					echo "</tr>";
				}
				echo "<tbody>";
				echo "</table>";
				echo "<br />";
				echo "<table border='1' align='left'>";
				echo 	"<thead>";
				echo 		"<tr align='left'>";
					foreach ($result->GETTBYWHERERESULT->TABLESTRUCT->UFIELDSTRUCT as $item) {
							echo "<th><pre>".print_r($item->FLDNAME,true)."</pre></th>";
					}
				echo 		"</tr>";
				echo 	"</thead>";	  
				echo "<tbody>";
				if (is_array($result->GETTBYWHERERESULT->TABLEDATA->FIELDVIEW)){
					foreach ($result->GETTBYWHERERESULT->TABLEDATA->FIELDVIEW as $itens) {
						echo "<tr align='left'>";
						foreach ($itens->FLDTAG->STRING as $item) {
							echo "<td><pre>".print_r($item,true)."</pre></td>";
						}
						echo "</tr>";
					}
				} else{
					echo "<tr align='left'>";
						foreach ($result->GETTBYWHERERESULT->TABLEDATA->FIELDVIEW->FLDTAG->STRING as $item) {
							echo "<td><pre>".print_r($item,true)."</pre></td>";
						}
					echo "<tr>";
				}
				echo "</tbody>";			
				echo "</table>";
			} catch (SoapFault $fault) {
						echo "<table>";
						echo 	"<thead>";
						echo 		"<tr>";
						echo 			"<th>SOAP Fault</th>";
						echo 		"</tr>";
						echo 	"</thead>";
						echo 	"<tbody>";
						echo 		"<tr>";
						echo 			"<td>";
						echo 				"<pre>";
						echo 				"".print_r(trigger_error("SOAP Fault: (faultcode: {$fault->faultcode}, faultstring: {$fault->faultstring})", E_USER_ERROR),true)."";
						echo 				"</pre>";
						echo 			"</td>";
						echo 		"</tr>";
						echo 	"</tbody>";
						echo "</table>";
			} catch (exception $e) {
						echo "<table>";
						echo 	"<thead>";
						echo 		"<tr>";
						echo 			"<th>Caught Exception</th>";
						echo 		"</tr>";
						echo 	"</thead>";
						echo 	"<tbody>";
						echo 		"<tr>";
						echo 			"<td>";
						echo 				"<pre>";
						echo 					"Caught Exception ('{$e->getMessage()}')\n{$e}\n";
						echo 				"</pre>";
						echo 			"</td>";
						echo 		"</tr>";
						echo 	"</tbody>";
						echo "</table>";
			}				
			die();
		?>
	</body>
</html>