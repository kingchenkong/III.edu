<!DOCTYPE html>
<html>
  <head>
     <meta charset='utf-8'>
     <title>練習ex04_03</title>
     <style>
     tbody tr:nth-child(2n) {background-color:#CAFFFF;}
			tbody tr:nth-child(2n+1) {background-color:#DEFFAC;}
     </style>
  </head>
  <body>
    <?php
    	echo "<h1> 九 九 乘 法 表 </h1>";
       echo "<table border='1'><tr>";
       for ($y = 1 ; $y <= 9 ; $y++  ) {
       	for ($x = 1 ; $x <= 9 ; $x++  ) {
       		echo "<td>  $x x $y =&nbsp". $y*$x . "</td>";
       	}
       	echo "</tr>";
       }
       echo "</table>";
    ?>
   </body> 
</html>
