<%-- 
    Document   : linear
    Created on : Sep 14, 2016, 11:16:51 AM
    Author     : java4
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
        if (request.getParameter("msgg") != null) {
    %>
    <script>alert('Please Give a Currect minimum and Maximum Value');</script>
    <%        }
    %>
    <%
        if (request.getParameter("msg") != null) {
    %>
    <script>alert('File Upload to Drive HQ');</script>
    <%            }
    %>
    <script language="Javascript">


        //*** globals
        var browserName = navigator.appName;
        var browserVersion = navigator.appVersion;
        var Win_1 = null;
        if ( (browserName == "Netscape") && (parseInt(browserVersion) >= 3)) browserName = "N";
        else if ( (browserName == "Microsoft Internet Explorer") && (parseInt(browserVersion) >= 3) ) browserName = "M";
        var maxDenom = 1000;  // for fraction approximation
        var tol = .000000001; // for 10 digit accuracy guaranteed cutoff for fractin approx not yet implemented
        var e = 2.718281828459045;
        var pi = 3.141592653589793;
        var theColor = 0; // the color of a pixel
        var x = 0;
        var A = 0;
        var tab = unescape( "%09" );	// these are now the appropriate strings;
        var cr = unescape( "%0D" );	
        var lf = unescape( "%0A" );
        var uniMinus = unescape( "%u2212"); // unicode minus &minus

        // alert( unescape( "%3C" ));
        var symb = unescape( "%C5" );
        var backSlash = unescape( "%5C" );
        var gteSymbol = unescape( "%B3" ); // made-up symbols
        var lteSymbol = unescape( "%B2" );
        var lte = unescape ("%u2264");	// actual symbol in IE
        var gte = unescape ("%u2265");
        var fractionMode = false;
        var singular = false;
        var unbounded = false;
        var msFormat = false;
        var maxRows = 15;
        var maxCols = 30;
        var numRows = 0;
        var numCols = 0;
        var numConstraints = 0;
        var graphingOnly = false; 	// for pure graphing only
        var maximization = true;		// this is a max problem
        var phase1 = false;			// are we in phase 1?
        var objectiveName = "p";
        var numVariables = 1;
        var variableString = "";
        var theTableau = new makeArray2 (1,1);
        var theStringTableau = new makeArray2 (1,1); 	// to display steps in the computation
        var starred = new makeArray(1);			// starred rows
        var TableauNumber = 1;				// the number of tableaus
        var maxSteps = 15;					//of tableaux 
        var numDecs = 6;					// default accuracy
        var fractionMode = false;
        var integerMode = false;

        var MaxNumValues = 15; //
        var numColors = 7;
        var theDot = new Array();
        theDot[0] = new Image();
        theDot[0].src = "pixelwhite.gif"
        theDot[1] = new Image();
        theDot[1].src = "pixelblack.gif"; 
        theDot[2] = new Image();
        theDot[2].src = "pixelred.gif"; 
        theDot[3] = new Image();
        theDot[3].src = "pixelgreen.gif";
        theDot[4] = new Image();
        theDot[4].src = "pixelblue.gif";
        theDot[5] = new Image();
        theDot[5].src = "pixelmagenta.gif";
        theDot[6] = new Image();
        theDot[6].src = "pixelorange.gif";
        theDot[7] = new Image();
        theDot[7].src = "pixelyellow.gif";
        var x = 0;  // wants a global x for eval...

        var numX = 200; // picure width in pixels
        var numY = 200; // picture height

        var theCanvas = new makeArray2(numX,numY);

        var okToRoll = true;
        var theString = "";
        //        sessionStorage.setAttribute("hi", "Asha");
        //        var hi = sessionStorage.getAttribute(attributeName)

        //var a = '@Request.RequestContext.HttpContext.Session["1000"]';
        //document.write(a+ "<br>");
        var a = 0;
        var b = 0; // end points
        var c = 0;
        var d = 0;
        var theFunction = ""; // the function

        var ExampleString = "maximize p = 3x + y subject to" + cr + "2x - y <= 6" + cr + "2x + 3y <= 12" + cr + "y <= 3";

        var GExampleString = "graph" + cr + "2x - y <= 4" + cr + "2x + 3y <= 12" + cr + "y <= 3";

        var theInstructionString = "Notes on formatting: " + cr + " (1) Variable names must be x and y." + cr + " (2) For fraction inputs, keep the variable on the right." + cr + tab + tab + "    (eg. (1/3)x and not x/3) " + cr + " (3) Both x and y must appear in the objective function," + cr+ "     (but not necessarily in the constraints). " + cr + tab + tab + "    (eg. p = 0x + 2y) " + cr + " (4) The words 'maximize' (or 'minimize') and 'subject to'  " + cr + "     must appear. " + cr + " (5) Each inequality should be on its own line, as shown. " + cr + " (6) No need to enter the default constraints: x >= 0, y >= 0.";


        var theGInstructionString = "Notes on formatting: " + cr + " (1) Variable names must be x and y." + cr + " (2) For fraction inputs, keep the variable on the right." + cr + tab + tab + "    (eg. (1/3)x and not x/3) " + cr + " (3) Each inequality should be on its own line, as shown. ";

        // Graphical Method Computation Globals
        var vertexX = new Array(); 
        var vertexY = new Array();
        var linesThroughVertex1 = new Array(); 
        var linesThroughVertex2 = new Array();
        var valObjective = new Array();
        var solutionLocation = 1;
        var equation = new Array();
        // Some temporary global variables for testing

        var xGridLines = new Array();
        var yGridLines = new Array();
        var lines = new Array();
        var ineq = new Array();  // 0 means y <=, 1 means y >=
        var vlines = new Array(); // vertical lines
        var vineq = new Array();  // 0 means x <=, 1 means x >=
        var lineColor = 4; // blue

        lines[0] = 0; // number of inequalities; all understood to be y <= expression;
        lines[1] = "0.5*x";
        lines[2] = "2*x";
        lines[3] = "20-x";
        ineq[1] = 1; // 0 means y lte  1 means y gte
        ineq[2] = 0;
        ineq[3] = 0;
        vlines[0] = 0; 
        vlines[1] = 10;
        vlines[2] = -13;
        vineq[1] = 0;
        vineq[2] = 1;

        var xAxisPosition = 50; 
        var yAxisPosition = 100;
        var xGridStep = 10;
        var yGridStep = 10;

        function myErrorTrap(message,url,linenumber) {
            alert("Whoops! I can't process this!" + cr +" Press 'Example' for formatting information.");
            return (true);
        }

        function makeArray2 (X,Y)
        {
            var count;
            this.length = X+1;
            for (var count = 1; count <= X+1; count++)

            this[count] = new makeArray(Y);
    } 

    function makeArray (Y)
    {
        var count;
        this.length = Y+1;
        for (var count = 1; count <= Y+1; count++)
            this[count] = 0;
    }

    function myParse(expression)
    {
        theString = stripSpaces(expression);		
        with (Math)
        {
	
            theString = putProduct(theString);
            theString = replaceSubstring(theString,"log","(1/log(10))*log");
            theString = replaceSubstring(theString,"ln","log");
            while (powCheck(theString))
            {
                theString = powFix2(theString);
                // alert (theString);
            }
            theString = replaceChar(theString,"X","x");
        } // with Math
        return(theString);
    } // myParse


    function readBasics() {

        for (var k = 1; k <= 1; k++)
        {
            var aa = document.theForm.a.value; 
            if (aa == "") { document.theForm.output.value = "You have not entered a number for xMin."; okToRoll = false; break;}
            a = eval(aa);
            if (isNaN(a) ) { document.theForm.output.value = "You have not entered a number for xMin."; okToRoll = false; break;}
            var bb = document.theForm.b.value; 
            if (bb == "") { document.theForm.output.value = "You have not entered a number for xMax."; okToRoll = false; break}
            b = eval(bb); 
            if (isNaN(b) ) { document.theForm.output.value = "You have not entered a number for xMax."; okToRoll = false; break;}
            if ( (okToRoll) && (a >= b)) { document.theForm.output.value = "xMax should be larger than xMin"; okToRoll = false; break;}
            var cc = document.theForm.c.value; 
            if (cc == "") { document.theForm.output.value = "You have not entered a number for yMin"; okToRoll = false; break}
            c = eval(cc); 
            if (isNaN(c) ) { document.theForm.output.value = "You have not entered a number for yMin."; okToRoll = false; break;}
            var dd = document.theForm.d.value; 
            if (dd == "") { document.theForm.output.value = "You have not entered a number for yMax."; okToRoll = false; break}
            d = eval(dd); 
            if (isNaN(d) ) { document.theForm.output.value = "You have not entered a number for yMax."; okToRoll = false; break;}
            if ( (okToRoll) && (c >= d)) { document.theForm.output.value = "yMax should be larger than yMin"; okToRoll = false; break;}
            var xk = document.theForm.xg.value;
            if (xk == "") xGridStep = 0;
            else xGridStep = eval(xk);
            var yk = document.theForm.yg.value;
            if (yk == "") yGridStep = 0;
            else yGridStep = eval(yk);
        } // end of single loop
    }

    function displayTheGraph()  {

        var tb="toolbar=0,directories=0,status=0,menubar=0"
        tb+=",scrollbars=1,resizable=1,"
        var tbend="width=" + (numX+100).toString() + ",height=" + (numY+120).toString();
        tb+=tbend;
        Win_1 = window.open("","win1",tb);
        Win_1.document.open();
        // ** Window is opened

        var theString  = '<html><title>Your Graph</title><body bgcolor = "FFFFFF"><p><center><table><tr>'
        theString += '<td></td><td align = center>' + roundDec(d,4) + '</td></tr><tr><td valign = center>'+ roundDec(a,4)+'</td><td>';

        theString += '<table border = 0><tr><td>';
        theString += formatGraph2();			// the actual graph
        theString += '</td></tr></table>';
        theString += '</td><td valign = center>' + roundDec(b,4) + '</td></tr><tr><td><td align = center>' + roundDec(c,4) + '</td></tr></table><p style = "font-size: 13px">The feasible region is shown in white.</center></body></html>';
        Win_1.document.write(theString);
        Win_1.document.close();
        Win_1.focus();

    } 

    function formatGraph2() {
        var theString = "";
        var repeats = new Array(); // this contains a list of different rows in theCanvas
        var theRow1 = new makeArray(numY);
        repeats[1] = 1; // first row
        var numRepeats = 1; 
        var oldVal = 0;
        var newVal = 0;
        var theLength = 0;
        var theHeight = 0;
        for (var k = 1; k <= numY; k++) theRow1[k] = theCanvas[k][1];
        for (var i = 1; i <= numY; i++)
        {
            for (var j = i+1; j <= numY; j++)
            {
                for (var k = 1; k <= numX; k++)
                {
                    if (theRow1[k] != theCanvas[k][j])
                    {
                        numRepeats++;
                        repeats[numRepeats] = j;
                        // document.theForm.output.value += cr + j + ":";
                        // for (var p = 1;p <= numY; p++) document.theForm.output.value += theRow1[p] + " ";
                        for (var p = 1; p <= numY; p++) theRow1[p] = theCanvas[p][j]; 
                        i = j-1;
                        k = numX;
                        j = numY;
                    } // if
                } // k
            } // j
        } // i
        repeats[numRepeats+1] = numY+1; // for last line height

        var theRow = 1;
        for (var i = 1; i <= numRepeats; i++)
        { 
            theLength = 1;
            theRow = repeats[i];
            theHeight = repeats[i+1] - repeats[i];
            oldVal = theCanvas[1][theRow];
            for (var j = 2; j <= numX; j++)
            {
                if ((j == numX)  && ( theCanvas[j][theRow] != oldVal) )
                {
                    var LL = theLength-1;
                    theString += '<img src = "' + theDot[oldVal].src + '" width = ' + LL + ' height = ' + theHeight + '>'
                    theString += '<img src = "' + theDot[theCanvas[j][theRow]].src + '" width = 1 height = ' + theHeight + '>'
			
                } // change on last pixel
                else if(( theCanvas[j][theRow] != oldVal) || (j == numX))
                {

                    theString += '<img src = "' + theDot[oldVal].src + '" width = ' + theLength + ' height = ' + theHeight + '>'
                    oldVal = theCanvas[j][theRow];
                    theLength = 0;
                } 
                theLength++;
            } // j
            theString += '<br>';
        } // i

        return(theString);
    } 
    function drawVLine(xval, lte) {
        var xbar = Math.round( (numX-1)*(xval-a)/(b-a) ) + 1; // screen position of line
        if ((xbar < 0) && (lte == 0))
        {
            // all red
            for (var i = 1; i <= numX; i++) for (var j = 1; j <= numY; j++) if(theCanvas[i][j] != lineColor) theCanvas[i][j] = 2; // red
        }
        else if  ((xbar > 0) && (xbar <= numX) && (lte == 0))
        {
            // alert(xbar);
            for (var j = 1; j <= numY; j++) theCanvas[xbar][j] = lineColor;
            for (var i = xbar+1; i <= numX; i++) for (var j = 1; j <= numY; j++) if(theCanvas[i][j] != lineColor) theCanvas[i][j] = 2; // red
        }
        else if ((xbar > numX) && (lte == 1))
        {
            // all red
            for (var i = 1; i <= numX; i++) for (var j = 1; j <= numY; j++) if(theCanvas[i][j] != lineColor) theCanvas[i][j] = 2; // red
        }
        else if  ((xbar > 0) && (xbar <= numX) && (lte == 1))
        {
            for (var j = 1; j <= numY; j++) theCanvas[xbar][j] = lineColor;
            for (var i = 1; i <= xbar-1; i++) for (var j = 1; j <= numY; j++) if(theCanvas[i][j] != lineColor) theCanvas[i][j] = 2; // red
        }

    }
    function drawLine(functionString, lte) {
        var deltax = (b-a)/numX;
        var deltay = (d-c)/numY;
        x = a;
        var x1 = x;
        var y1 = eval(functionString);
        x = b;
        var x2 =x; 
        var y2 = eval(functionString);
        // now decide if shading is above or below
        var shadingDown = false;
        if (lte == 0) shadingDown = false;
        else shadingDown = true;

        clippedSegment(x1,y1,x2,y2, shadingDown);


    }
    function clippedSegment(x1,y1,x2,y2, shadingDown){

        var xMin = a;
        var xMax = b;
        var yMin = c;
        var yMax = d; 


        var x1bar = Math.round( numX*(x1-xMin)/(xMax-xMin) );
        var x2bar = Math.round( numX*(x2-xMin)/(xMax-xMin) );
        var y1bar = Math.round( numY*(yMax-y1)/(yMax-yMin) );
        var y2bar = Math.round( numY*(yMax-y2)/(yMax-yMin) );

        // Now draw the actual segment in the right color
        var deltaX = x2bar - x1bar;
        var deltaY = y2bar - y1bar; 


        var shading = true; // avoid shading same vertical line twice
        var xx = 0;
        var y = 0;
        var xold = 0;
        var xint = 0;
        var yint = 0;
        var numSteps = 0;
        var theYStep = 0; 
        var theXStep = 0;
        var theColor = 0;
        // latter are actual steps on the screen 
        var xOK = false;
        var yOK = false;

        if ( Math.abs(deltaX) > Math.abs(deltaY) ) {numSteps = Math.abs(deltaX); xOK = true}
        else {numSteps = Math.abs(deltaY); yOK = true}

        theXStep = deltaX/numSteps;
        theYStep = deltaY/numSteps

        // set initial pixel
        xx = x1bar; y = y1bar; 

        if (( xx >= 1) && (y >= 1)  && (xx <= numX) && (y <= numY)) theCanvas[xx][y] = lineColor;
        if (!shadingDown)
        {
            if ((xx >= 1) && (xx <= numX))
            {
                theColor = 2; // not feasible
                if (yint >= yMax) for (var k = 1; k <= numY; k++) 
                {
                    if(theCanvas[xx][k] != lineColor) theCanvas[xx][k] = theColor;
                }
                else if  (( yint >= yMin) &&  (yint <= yMax)) for (var k = 1; k < yint; k++) 			{
                    if(theCanvas[xx][k] != lineColor) theCanvas[xx][k] = theColor;
                }
            }
        }
        else 
        // shading down
        {
            if ((xx >= 1) && (xx <= numX))
            {

                theColor = 2; // not feasible
                if (yint <= 0) for (var k = 1; k <= numY; k++) 
                {
                    if(theCanvas[xx][k] != lineColor) theCanvas[xx][k] = theColor;
                }
                else if  (( yint >= 1) &&  (yint <= numY)) for (var k = yint+1; k < numY; k++) 
                {
                    if(theCanvas[xx][k] != lineColor) theCanvas[xx][k] = theColor;
                }
            }
        }

        for (var i = 1; i <= numSteps; i++)
        {
            // alert(xx);
            // alert(y);
            xold = Math.round(xx);
            xx += theXStep;  
            y += theYStep;
            xint = Math.round(xx);
            yint = Math.round(y);
            if (xint > xold) shading = true;
            else shading = false;

            if (( xint >= 1) && (yint >= 1)  && (xint <= numX) && (yint <= numY)) 	theCanvas[xint][yint] = lineColor;

            // now do the shading
            if (shading)
            {
                if (!shadingDown) 
                {
                    if ((xint >= 1) && (xint <= numX))
                    {
                        theColor = 2; // not feasible
                        if (yint >= numY) for (var k = 1; k <= numY; k++) 
                        {
                            if(theCanvas[xint][k] != lineColor) theCanvas[xint][k] = theColor;
                        }
                        else if  (( yint >= 1) &&  (yint <= numY)) for (var k = 1; k < yint; k++)
                        {
                            if(theCanvas[xint][k] != lineColor) theCanvas[xint][k] = theColor;
                        }
                    }
                }
                else 
                // shading down
                {
                       
                    if ((xint >= 1) && (xint <= numX))
                    {
                        theColor = 2; // not feasible
                        if (yint <= 0) for (var k = 1; k <= numY; k++) 
                        {
                            if(theCanvas[xint][k] != lineColor) theCanvas[xint][k] = theColor;
                        }
                        else if  (( yint >= 1) &&  (yint <= numY)) for (var k = yint+1; k < numY; k++)
                        {
                            if(theCanvas[xint][k] != lineColor) theCanvas[xint][k] = theColor;
                        }

                    }
                }
            } 
        } // i

    } 



    function makeGraph()
    {

        // first initialize the canvas
        for (var i = 1; i <= numX; i++) for (var j = 1; j <= numY; j++) theCanvas[i][j] = 0;
        // first read and parse the function

        readBasics();

        if (okToRoll)
        {
            // draw the lines & shaded regions
            for (var k = 1; k <= lines[0]; k++) drawLine(lines[k], ineq[k]);
            for (var k = 1; k <= vlines[0]; k++) {
                drawVLine(vlines[k], vineq[k]);
                //alert(vlines[k] + " ' " + vineq[k]);
            } // k
            // now draw the axes & gridlines
            // gridlines first
            // setup position of gridlines
            if (xGridStep > 0) xGridLines[0] = Math.floor(  (b-a)/xGridStep );
            else xGridLines[0] = 0;
            if (yGridStep > 0) yGridLines[0] = Math.floor(  (d-c)/yGridStep );
            else yGridLines[0] = 0;
            for (var i = 1; i <= xGridLines[0]; i++)
            {
                xGridLines[i] = Math.round( i*xGridStep*numX/(b-a)  ) 
                // alert("i = " + i + " : " + xGridLines[i] + cr);
            } // x Grid Line Positions

            for (var i = 1; i <= yGridLines[0]; i++)
            {
                yGridLines[i] = Math.round( i*yGridStep*numY/(d-c)  )
            } // y Grid Line Positions
            for (var i = 1; i <= xGridLines[0]; i++) 
            {
                // alert("i = " + i + " : " + xGridLines[i] + "of " + xGridLines[0]);
                var p = xGridLines[i];
                for (var k = 1; k <= numY; k++) if (theCanvas[p][k] != lineColor) theCanvas[p][k] = 3;
            }
            // alert("here");
            for (var i = 1; i <= yGridLines[0]; i++) 
            {
                var p = yGridLines[i];
                for (var k = 1; k <= numX; k++) if (theCanvas[k][p] != lineColor) theCanvas[k][p] = 3;
            }
            // now the axes
            if ((a < 0) && (b > 0)) yAxisPosition = Math.round((-a)*numX/(b-a));
            else yAxisPosition = -1;
            if ((c < 0) && (d > 0)) xAxisPosition = Math.round((-c)*numY/(d-c));
            else xAxisPosition = -1;
            if (yAxisPosition > 0) for (var k = 1; k <= numY; k++) theCanvas[yAxisPosition][k] = 1;
            if (xAxisPosition > 0) for (var k = 1; k <= numX; k++) theCanvas[k][xAxisPosition] = 1;
        } // oktoRoll	

    }
    function stripChar (InString,symbol)  {
        OutString="";
        for (Count=0; Count < InString.length; Count++)  {
            TempChar=InString.substring (Count, Count+1);
            if (TempChar!=symbol)
                OutString=OutString+TempChar;
        }
        return (OutString);
    }

    function lastChar(theString) {
        if (theString == "") return(theString);
        var len = theString.length;
        return theString.charAt(len-1); 
    }


    function checkString(InString,subString,backtrack)

    {
        var found = -1;
        var theString = InString;
        var Length = theString.length;
        var symbLength = subString.length;
        for (var i = Length- symbLength; i >-1; i--)
        {	
            TempChar=theString.substring (i, i+ symbLength);
            if (TempChar == subString) 
            {
                found = i;
                if (backtrack) i = -1
            }
        } // i
        return(found);
    } // check



    function parser (InString, Sep)  {

        var NumSeps=0; var Count = 0;
        var location = new Array;
        location[0] = -1;
        var len = InString.length;
        for (Count=0; Count < len; Count++)  {
            if (InString.charAt(Count)==Sep)
            {
                NumSeps++;
                location[NumSeps] = Count;
            }
        }
	
        var parse = new makeArray (NumSeps+2);
        if (NumSeps == 0) {parse[0] = 1; parse[1] = InString; return(parse);}
        parse[0] = NumSeps + 1;  
	
        for (var i = 1; i <=NumSeps; i++)
        {
            parse[i] = InString.substring(location[i-1]+1, location[i]);
            // alert("i = " + i + "  "  + parse[i]);
        }	
        parse[NumSeps+1] = InString.substring(location[NumSeps]+1, len);
        // alert("i = " + i + "  "  + parse[i]);

	
        return (parse);
    }

    function parseLinearExpr(InString) {

        InString = stripChar(InString,"(");   // get rid of parens (not needed once x is gone...
        InString = stripChar(InString,")");
        var stringlen = InString.length

        if (!looksLikeANumber(InString.charAt(0))) InString = "1" + InString;

         
        if (InString.charAt(0) != "-") InString = "+"+ InString;
        // alert(InString);
        var variableList = "";
        InString = replaceSubstring (InString,"+","_+");
        InString = replaceSubstring (InString,"-","_-");
	
        var ch = "_";
        var Ar = parser(InString, ch);
        var parsd = new makeArray (Ar[0]+1, "");
           

        for (var i = 1; i < Ar[0]; i++)
        {
            parsd[i] = stripChar(Ar[i+1],"_"); 
               
        }
	 
        // now for the variable names
        var str = "";
        for (var i = 1; i < Ar[0]; i++)
        {
            str += rightString(parsd[i],1);
            parsd[i] = rightTrim(parsd[i],1);
            if (parsd[i] == "+") parsd[i] = "1";  // fixz up the coefficients
            else if  (parsd[i] == "-") parsd[i] = "-1";
            parsd[i] = stripChar(parsd[i],"+");
        }
        parsd[0] = str;

        // alert(parsd[0] + "," + parsd[1] + "," + parsd[2] + "," + parsd[3])
        return (parsd);

    } // parser



    function rightString (InString, num)  {
        OutString=InString.substring (InString.length-num, InString.length);
        return (OutString);
    }

    function rightTrim (InString)  {
        var length = InString.length;
        OutString=InString.substring(0,length-1);
        return (OutString);
    }

    function replaceChar (InString,oldSymbol,newSymbol)  {
        var OutString="";
        var TempChar = "";
        for (Count=0; Count < InString.length; Count++)  {
            TempChar=InString.substring (Count, Count+1);
            if (TempChar!=oldSymbol)
                OutString=OutString+TempChar
            else OutString=OutString+newSymbol;
        }
        return (OutString);
    }

    function replaceSubstring (InString,oldSubstring,newSubstring)  {
        OutString="";
        var sublength = oldSubstring.length;
        for (Count=0; Count < InString.length; Count++)  {
            TempStr=InString.substring (Count, Count+sublength);
            TempChar=InString.substring (Count, Count+1);
            if (TempStr!= oldSubstring)
                OutString=OutString+TempChar
            else 
            {
                OutString=OutString+ newSubstring;
                Count +=sublength-1
            }

        }
        return (OutString);
    }

    function solveGraphical() {
                
        var theVertexCount = 0;
        var skipThis = false; // for repeated vertices
        var a1 = 0, b1 = 0, c1 = 0, d1 = 0, det = 0, p1 = 0, q1 = 0, x1 = 0, y1 = 0, coeff = 0;
        var feasible = true;
        for (var i = 1; i <= numRows-1; i++)
        {
            for (var j = i+1; j <= numRows-1; j++)
            {
                feasible = false;
                a1 = theTableau[i][1];
                b1 = theTableau[i][2];
                p1 = theTableau[i][numCols];
                c1 = theTableau[j][1];
                d1 = theTableau[j][2];
                q1 = theTableau[j][numCols];
                det = a1*d1-b1*c1
                if (det != 0)
                {
                    x1 = (d1*p1-b1*q1)/det;
                    y1 = (-c1*p1+a1*q1)/det;
                           
                    feasible = true;
                    for (var k = 1; k <= numRows-1; k++)
                    {
                        coeff = theTableau[k][2+k];
                        if (  ( ( coeff > 0) && (roundSigDig(theTableau[k][1]*x1 + theTableau[k][2]*y1,10) - roundSigDig(theTableau[k][numCols],10) > 0 ))  ||  ((coeff < 0) && (roundSigDig(theTableau[k][1]*x1 + theTableau[k][2]*y1, 10) - roundSigDig(theTableau[k][numCols],10) < 0))  )
                        {
                            feasible = false;
                            k = numRows-1;
                        }
                    } // k
                } 
                if (feasible)
                {
                    skipThis = false;
                    for (var h = 1; h <= theVertexCount; h++)
                    {
                        if ( ( vertexX[h] == x1) && ( vertexY[h] == y1) ) skipThis = true;
                    }
                    if (!skipThis)
                    {
                        theVertexCount++;
                        vertexX[theVertexCount] = x1;
                        vertexY[theVertexCount] = y1;
                        var str = replaceChar(equation[i],lteSymbol," = ");
                        str = replaceChar(str,gteSymbol," = ");
                        linesThroughVertex1[theVertexCount]  = str;
                        str = replaceChar(equation[j],lteSymbol," = ");
                        str = replaceChar(str,gteSymbol," = ");
                        linesThroughVertex2[theVertexCount]  = str;
                        if (maximization) valObjective[theVertexCount] = -theTableau[numRows][1]*x1- theTableau[numRows][2]*y1;
                        else valObjective[theVertexCount] = theTableau[numRows][1]*x1+theTableau[numRows][2]*y1;
                    } 
                }
            } 
        } 

          
        var maxXcoord = 0;
        var maxYcoord = 0;
        for (var i = 1; i <= theVertexCount; i++)
        {
            if (vertexX[i] > maxXcoord) maxXcoord = vertexX[i];
            if (vertexY[i] > maxYcoord) maxYcoord = vertexY[i];
        } 
        maxXcoord += 100;
        maxYcoord += 100;
        unbounded = false;
        var theExtraVertexCount = 0;
        for (var i = 1; i <= numRows-1; i++)
        {
            for (var k = 1; k <= 3; k++)
            {
                if (k == 1)
                {
                    a1 = theTableau[i][1];
                    b1 = theTableau[i][2];
                    p1 = theTableau[i][numCols];
                    c1 = 1;
                    d1 = 0;
                    q1 = maxXcoord;
                }
                else if (k == 2)
                {
                    a1 = theTableau[i][1];
                    b1 = theTableau[i][2];
                    p1 = theTableau[i][numCols];
                    c1 = 0;
                    d1 = 1;
                    q1 = maxYcoord;
                }
                else if (k == 3)
                { 
                    a1 = 1;
                    b1 = 0;
                    p1 = maxXcoord
                    c1 = 0;
                    d1 = 1; 
                    q1 = maxYcoord;
                    i = numRows;
                } 
                det = a1*d1-b1*c1
                if (det != 0)
                {
                    x1 = (d1*p1-b1*q1)/det;
                    y1 = (-c1*p1+a1*q1)/det;
                    feasible = true;
                    for (var k = 1; k <= numRows-1; k++)
                    {
                        coeff = theTableau[k][2+k];
                        if (  ( ( coeff > 0) && (theTableau[k][1]*x1 + theTableau[k][2]*y1 > theTableau[k][numCols]) )  ||  ((coeff < 0) && (theTableau[k][1]*x1 + theTableau[k][2]*y1 < theTableau[k][numCols]))  )
                        {
                            feasible = false;
                                
                            k = numRows-1;
                        }
                    } 
                } 
                if (feasible)
                {
                    unbounded = true;
                    skipThis = false;
                    if (!skipThis)
                    {
                        theExtraVertexCount ++;
                        vertexX[theVertexCount + theExtraVertexCount] = x1;
                        vertexY[theVertexCount + theExtraVertexCount] = y1;
                        if (maximization) valObjective[theVertexCount + theExtraVertexCount] = -theTableau[numRows][1]*x1- theTableau[numRows][2]*y1;
                        else valObjective[theVertexCount + theExtraVertexCount] = theTableau[numRows][1]*x1+theTableau[numRows][2]*y1;
                    } 
                }
            } 
                
        } 


        var displayString = ''; 
        var maxLen = 0;
        var tempString = '';
        var rowString = new Array();
        for (var i = 1; i <= theVertexCount; i++)
        {
            if (fractionMode)
            {		
                rowString[i] = "(" + toFrac(roundSigDig(vertexX[i],15) , maxDenom, tol);
                rowString[i] += "," + toFrac(roundSigDig(vertexY[i],15) , maxDenom, tol) + ")  ";
                if (rowString[i].length > maxLen) maxLen = rowString[i].length;
            } 
            else
            {
                rowString[i] = "(" + roundDec(vertexX[i],numDecs) + "," + roundDec(vertexY[i], numDecs) + ")  ";
                if (rowString[i].length > maxLen) maxLen = rowString[i].length;
            } 
        } 
        for (var i = 1; i <= theVertexCount; i++)
        {
            var shortLen = rowString[i].length;
            for (var j = shortLen+1; j <= maxLen; j++) rowString[i] += " ";
        } 
        var maxLen2 = maxLen + 23;
        for (var i = 1; i <= theVertexCount; i++)
        {
            rowString[i]  += linesThroughVertex1[i] + "; " + linesThroughVertex2[i] + "   ";
            if (rowString[i].length > maxLen2) maxLen2 = rowString[i].length;
        }
        for (var i = 1; i <= theVertexCount; i++)
        {
            var shortLen = rowString[i].length
            for (var j = shortLen+1; j <= maxLen2; j++) rowString[i] += " ";
        }
        var optimalString = "";
        solutionLocation = 1;
        if (maximization)
        {
            optimalString = "Maximum"
            var maxVal = valObjective[1];
            for (var i = 2; i <= theVertexCount + theExtraVertexCount; i++)
            {
                if (valObjective[i] > maxVal)  
                {
                    maxVal = valObjective[i];
                    solutionLocation = i
                }
		
            } 
        }
        else
        {
            optimalString = "Minimum"
            var minVal = valObjective[1];
            for (var i = 2; i <= theVertexCount + theExtraVertexCount; i++)
            {
                if (valObjective[i] < minVal)  
                {
                    minVal = valObjective[i];
                    solutionLocation = i
                }
		
            } 
        }
          
        for (var i = 1; i <= theVertexCount; i++)
        {
            if (fractionMode)
            {
                rowString[i] += toFrac(roundSigDig(valObjective[i],15) , maxDenom, tol);
                if (valObjective[i] == valObjective[solutionLocation]) rowString[i] += " " + optimalString;
            } 
            else
            { 
                rowString[i] += roundDec(valObjective[i],numDecs);
                if (valObjective[i] == valObjective[solutionLocation]) rowString[i] += " " + optimalString;
            } 
        } 
           
        var Heading = "";
        if (theVertexCount > 0) 
        {
            Heading += "Vertex ";
            shortLen = Heading.length;
            for (var j = shortLen+1; j <= maxLen; j++) Heading += " ";
            Heading += "Lines Through Vertex";
            shortLen = Heading.length;
            for (var j = shortLen+1; j <= maxLen2; j++) Heading += " ";
            Heading += "Value of Objective";
            displayString = Heading + cr;
            for (var i = 1; i <= theVertexCount; i++) displayString += rowString[i] + cr;
            if (solutionLocation > theVertexCount) displayString += "***Unbounded Feasible Region -- No Optimal Solution ***"
        }
        else displayString = "***Empty Feasible Region -- No Optimal Solution***";
        document.theForm.output.value = displayString;

    }
    function sesame(url,hsize,vsize){ 

        var tb="toolbar=0,directories=0,status=0,menubar=0"
        tb+=",scrollbars=1,resizable=1,"
        var tbend="width="+hsize+",height="+vsize;
        if(tbend.indexOf("<undefined>")!=-1){tbend="width=550,height=400"}
        tb+=tbend
        Win_1 = window.open("","win1",tb);
        Win_1 = window.open(url,"win1",tb);
    }



    function SetupTableau() {
 
        if (!okToRoll) return (666);

        maximization = true;
        graphingOnly = false;
        singular = false;	
        lines[0] = 0;
        vlines[0] = 0;


        var theString = document.theForm.input.value; 
        theString = theString.toLowerCase();
        theString = replaceChar(theString, uniMinus,"-");	
        if (theString.indexOf("graph")==-1) theString += cr + "x >= 0" + cr + "y >= 0";	// GRAPHICAL ADDITIONS
        theString += cr;		
        theString = stripSpaces(theString);
        theString = stripChar(theString,tab);			

        theString = replaceChar(theString,lf,cr);	

        theString = replaceSubstring(theString, "to", "to"+cr);
        theString = replaceSubstring(theString, ",", cr);
        theString = replaceSubstring(theString, cr+"subject", "subject");

        var doublecr = true;
        while (doublecr) 
        {
            if (checkString(theString,cr+cr,false) == -1) doublecr = false;
            else theString = replaceSubstring(theString,cr+cr,cr);
        }
        if (lastChar(theString) == cr) theString = rightTrim(theString,1);
        theString = replaceSubstring(theString, "<=", lteSymbol);
        theString = replaceSubstring(theString, ">=", gteSymbol);
        theString = replaceSubstring(theString, lte, lteSymbol);
        theString = replaceSubstring(theString, gte, gteSymbol);


        var check = checkString(theString,"maxi",false)
        if (check == -1) 
        {check = checkString(theString,"mini",false); maximization = false; phase1 = true}
        if (check == -1) 
        {check = checkString(theString,"graph",false); graphingOnly = true }
        if (check == -1) { document.theForm.output.value = "That does not look like a linear programming problem to me!" + cr + cr + "Press Example to see how to type one in." ; okToRoll = false; return(666);}
        len = theString.length;
        theString = theString.substring(check,len);
        var tempAr = parser(theString,cr); 

        if (!graphingOnly) {
            var line1 = tempAr[1];

            check = checkString(line1,"subj",true);
            if (check > 0) line1 = line1.substring(0,check);
            check = checkString(line1,"=",false);
            if (check <=0) return(666);
            objectiveName = line1.charAt(check-1);
            len = line1.length;
            var expression = line1.substring(check+1,len);
            var OBJ = parseLinearExpr(expression);
            variableString = OBJ[0];
            if (variableString.length >= 3) {alert ("Only two unknowns: x and y, please."); okToRoll = false}
        }
        variableString = "xy";

        numConstraints = tempAr[0]-1;

        for (var i = 1; i <= numConstraints; i++) equation[i] = tempAr[i+1];   


        numVariables = variableString.length;

        numRows = numConstraints+1;
        numCols = numRows + numVariables + 1;

        theTableau = new makeArray2 (numRows,numCols);
        theStringTableau = new makeArray2 (numRows,numCols); 
        if (phase1) starred = new makeArray(numRows);		

        if (!graphingOnly) {
            for (var j = 1; j <= numCols; j++) theTableau[numRows][j] = 0; 
            for (var i = 1; i <= numVariables; i++)
            {
                if (maximization) theTableau[numRows][i] = -eval(OBJ[i]);
                else theTableau[numRows][i] = eval(OBJ[i]);
            }
            theTableau[numRows][numCols-1] = 1;
            theTableau[numRows][numCols] = 0;
        } 

        theString = tempAr[2];
        var x = checkString(theString,"to",false);
        len = theString.length;
        if (x != -1) theString = theString.substring(x+2,len);


        tempAr[2] = theString;
        var GTE = false; 
        for (var i = 1; i <= numConstraints; i++)
        {
            GTE = false; 

            twoPart = parser(tempAr[1+i], lteSymbol);
            if (twoPart[0] <2) {twoPart = parser(tempAr[1+i], gteSymbol); phase1 = true; GTE = true;}

            if (twoPart[0] <2) { i += 1; okToRoll = false; document.theForm.expr.value = "Huh? The expression in line " + i + " does not look like an inequality to me!"; return (666)}
            var leftHandSide = parseLinearExpr(twoPart[1]);
	
            for (var j = 1; j <= numCols; j++) theTableau[i][j] = 0;	
            theTableau[i][numCols] = eval(twoPart [2]); 		
            if (GTE) theTableau[i][numVariables + i] = -1;
            else theTableau[i][numVariables + i] = 1;

            var theIndex = 0;
            for (var j = 1; j <= numVariables; j++)
            {
                theVar = variableString.charAt(j-1);

                theIndex = leftHandSide[0].indexOf (theVar,0);

                if (theIndex == -1) theTableau[i][j] = 0;
                else theTableau[i][j] = eval(leftHandSide[theIndex+1]); 
            } 

            if (theTableau[i][2] != 0)
            {
                lines[0]++; 
                var theRatio1 = -theTableau[i][1] /theTableau[i][2];
                var theRatio2 = theTableau[i][numCols] /theTableau[i][2];
                if (theTableau[i][2] >= 0) lines[lines[0]] = theRatio1.toString() + "*x" + "+"+ theRatio2.toString();
                else
                {
                    lines[lines[0]] = theRatio1.toString() + "*x" + "+" +  theRatio2.toString();
                    if (GTE) GTE = false;
                    else GTE = true;
                }
                if (GTE) ineq[lines[0]] = 1;
                else ineq[lines[0]] = 0;
            }
            else
            {
                
                vlines[0]++;
                var theRatio = theTableau[i][numCols] /theTableau[i][1];
                vlines[vlines[0]] = theRatio.toString();
                if (GTE) vineq[vlines[0]] = 1;
                else vineq[vlines[0]] = 0;
            }	
        } 
        return(1);
    } 


    function displayFinalStatus() {

        if  (TableauNumber > maxSteps) document.theForm.expr.value = "No optimal solution found after 20 steps. Aborted."
        else if (singular) document.theForm.expr.value = "No optimal solution exists for this problem."
        else
        {
            document.theForm.expr.value = "Optimal Solution: " + objectiveName + " = ";
            var numx = 0; var theRowx = 0; var theColx = 0; var count = 0; var theChar = ""; 
            var theStr = ""; 
            var objectiveVal = theTableau[numRows][numCols];
	
            if (!maximization) objectiveVal = - objectiveVal;
            if ((fractionMode) || (integerMode)) document.theForm.expr.value += toFrac (roundSigDig(objectiveVal,15), maxDenom, tol) + "; ";  else
                document.theForm.expr.value  += roundDec(objectiveVal, numDecs).toString() + "; ";
	
            for (var j = 1; j <= numVariables; j++)
            { 
                count = 0;
                theRowx = 0; 
		
                theChar = variableString.charAt(j-1);		
                document.theForm.expr.value += theChar + " = ";
                for (var i = 1; i <= numRows; i++)
                {
                    numx = roundSigDig(theTableau[i][j],10);
                    if (numx != 0) 
                    {
                        count++;
                        if (numx != 0) theRowx = i
                    }
                }
                if ((count == 1) && (theRowx > 0))
                {
                      
                    if ((fractionMode) || (integerMode)) theStr = toFrac (roundSigDig(theTableau[theRowx][numCols],15), maxDenom, tol);  else
                        theStr = roundDec(theTableau[theRowx][numCols],numDecs).toString();
                    if (j < numVariables) theStr += ", "; 
                    document.theForm.expr.value += theStr
                } 
                else 
                {
                    theStr = "0";
                    if (j < numVariables) theStr += ", "; 								document.theForm.expr.value += theStr;
                }
            } 
        }
    }




    function displayMatrix(number) {
        var theString = "Tableau #" + TableauNumber + cr;

        if (singular) theString += "undefined";

        else
        {
            var RowNum = numRows;

            var ColNum = numCols;
                   
            var maxLength = 1;
            var x = "", i=0, j=0, k=0;
            var xLen = 0;

            if (integerMode) theStringTableau = makeInteger(theTableau, RowNum, ColNum,true);

            else {
                for (i = 1; i <= RowNum; i++)
                { 
                    for (j = 1; j <= ColNum; j++) 
                    { 
                        if (fractionMode) x = toFrac (roundSigDig(theTableau[i][j],15) , maxDenom, tol);  
                        else x = roundDec(theTableau[i][j], numDecs).toString();
                        xLen = x.length; 
                        if (xLen > maxLength) maxLength = xLen; 

                        theStringTableau[i][j] = x; 
	
                    } 
                } 
            } 

            if (maxLength < 6) maxLength = 6;  // more space

            var spaceString = "";
            for (i = 0; i <= RowNum; i++) // was 1
            {
                for (j = 1; j <= ColNum; j++) 
                { 
                    if (i == 0)
                    { 
                        if  (j <= numVariables)  x = variableString.charAt(j-1);
                        else if (j == numVariables + numConstraints + 1) {x = objectiveName; if (!maximization) x = "-"+x;}
                        else if (j < ColNum) { var mmm = j - numVariables ; x = "s" + mmm.toString();}
                        else if (j == ColNum) x = " ";
                    } 
			
                    else x = theStringTableau[i][j];


                    sp = maxLength - x.length
                    spaceString = "";
                    for (k = 0; k <= sp; k++) spaceString += " ";
                    theString += x + spaceString;
			
                }
                theString += cr;
            } 
        } 
        document.theForm.output.value += theString + cr;

        return(0);
    }
    function looksLikeANumber(theString) {
        var result = true;
        var length = theString.length;
        var x = ""
        var y = "1234567890-+^*./ "
        var yLength = y.length;
        for (var i = 0; i <= length; i++)
        { 
            x = theString.charAt(i);
            result = false;
            for (var j = 0; j <= yLength; j++) 
            {
                if (x == y.charAt(j)) {result = true; break}
            } 
            if (result == false) return(false);
        } 
        return(result);
    }


    function shiftRight(theNumber, k) {
        if (k == 0) return (theNumber)
        else
        {
            var k2 = 1;
            var num = k;
            if (num < 0) num = -num;
            for (var i = 1; i <= num; i++)
            {
                k2 = k2*10
            }
        }
        if (k>0) 
        {return(k2*theNumber)}
        else 
        {return(theNumber/k2)}
    }

    function roundDec(theNumber, numPlaces) {
        with (Math)
        {
            var x =shiftRight(round(shiftRight(theNumber,numPlaces)),-numPlaces);
            return x;
        } 
    } 

    function roundSigDig(theNumber, numDigits) {
        with (Math)
        {
            if (theNumber == 0) return(0);
            else if(abs(theNumber) < 0.000000000001) return(0);
            else
            {
                var k = floor(log(abs(theNumber))/log(10))-numDigits
                var k2 = shiftRight(round(shiftRight(abs(theNumber),-k)),k)
                if (theNumber > 0) return(k2);
                else return(-k2)
            } 
        }
    }

    function stripSpaces (InString)  {
        OutString="";
        for (Count=0; Count < InString.length; Count++)  {
            TempChar=InString.substring (Count, Count+1);
            if (TempChar!=" ")
                OutString=OutString+TempChar;
        }
        return (OutString);
    }

    function replaceChar (InString,oldSymbol,newSymbol)  {
        var OutString="";
        var TempChar = "";
        for (Count=0; Count < InString.length; Count++)  {
            TempChar=InString.substring (Count, Count+1);
            if (TempChar!=oldSymbol) OutString=OutString+TempChar;
            else OutString=OutString+newSymbol;
        }
        return (OutString);
    }

    function replaceSubstring (InString,oldSubstring,newSubstring)  {
        OutString="";
        var sublength = oldSubstring.length;
        for (Count=0; Count < InString.length; Count++)  {
            TempStr=InString.substring (Count, Count+sublength);
            TempChar=InString.substring (Count, Count+1);
            if (TempStr!= oldSubstring)
                OutString=OutString+TempChar
            else 
            {
                OutString=OutString+ newSubstring;
                Count +=sublength-1
            }

        }
        return (OutString);
    }

    function reverse (InString)  {
        OutString="";
        var Length = InString.length;
        for (Count=Length; Count > -1; Count--)  {
            TempChar=InString.substring (Count, Count+1);
            if (TempChar == "(") {TempChar = ")"}
            else if  (TempChar == ")") {TempChar = "("}
            OutString=OutString+TempChar;
        }
        return (OutString);
    }

    function toFrac(x, maxDenom, tol) {
        var theFrac = new Array();
        theFrac[1] = 0;
        theFrac[2] = 0;
        var p1 = 1;
        var p2 = 0;
        var q1 = 0;	
        var q2 = 1;	
        var u =0;
        var t = 0;
        var flag = true;
        var negflag = false;
        var a = 0;
        var xIn = x; 

        if (x >10000000000) return(theFrac);
        while (flag)
        {
            if (x<0) {x = -x; negflag = true; p1 = -p1}
            var intPart = Math.floor(x);
            var decimalPart = roundSigDig((x - intPart),15);

            x = decimalPart;
            a = intPart;
	
            t = a*p1 + p2;
            u = a*q1 + q2;
            if  ( (Math.abs(t) > 10000000000 ) || (u > maxDenom ) ) 
            {
                n = p1;
                d = q1;
                break;
            }

            p = t;
            q = u;
		
            if ( x == 0 )
            {
                n = p;
                d = q;
                break;
            }

            p2 = p1;
            p1 = p;
            q2 = q1;
            q1 = q;
            x = 1/x;
	
        } 
	
        theFrac[1] = n;
        theFrac[2] = d;
        if (Math.abs(xIn-(n/d)) > tol) return (roundDec(xIn, numDecs-1).toString());
        if (theFrac[2] == 1) return (theFrac[1].toString());
        return (theFrac[1] + "/" + theFrac[2]);

    } 
    function calc(){
        fractionMode = document.theForm.fracModeButton.checked;
        var num = calc.arguments[0];
        if (num == 0)
        {
            document.theForm.input.value = GExampleString;
            document.theForm.a.value = -5;
            document.theForm.b.value = 5;
            document.theForm.c.value = -5;
            document.theForm.d.value = 7;
            document.theForm.xg.value = 1;
            document.theForm.yg.value = 1;
            document.theForm.output.value = theGInstructionString;
        }
        if (num == 1)
        {
            document.theForm.input.value = ExampleString;
            document.theForm.a.value = 0;
            document.theForm.b.value = 3;
            document.theForm.c.value = 0;
            document.theForm.d.value = 5;
            document.theForm.xg.value = 1;
            document.theForm.yg.value = 1;
            document.theForm.output.value = theInstructionString;
        }
        else  if (num == 2)
        {
            okToRoll = true;
            SetupTableau();
            if((okToRoll)&&(!graphingOnly)) solveGraphical();
        }
        else  if (num == 3)
        {
        }
        else  if (num == 4)
        {
		
        } 
        else  if (num == 5)
        {
		
        }
        else  if (num == 6)
        {
		
        }
    }

    </script>
    <style>
        .inputs {
            background: #DCEFF5;
            font-size: 0.9rem;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            border: none;
            padding: 10px 10px;
            width: 200px;
            margin-bottom: 20px;
            box-shadow: inset 0 2px 3px rgba( 0, 0, 0, 0.1 );
            clear: both;
        }

        .inputs:focus {
            background: #fff;
            box-shadow: 0 0 0 3px #33A3C9, inset 0 2px 3px rgba( 0, 0, 0, 0.2 ), 0px 5px 5px rgba( 0, 0, 0, 0.15 );
            outline: none;
        }

        .button {
            background-color: #102142; /* Green */
            border: none;
            color: white;
            padding: 10px 27px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 10px;
        }
        .button1 {
            background-color:  forestgreen; /* Green */
            border: none;
            color: white;
            padding: 10px 27px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 10px;
        }
    </style>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>Secure Optimization Computation</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link href="styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <!-- header begins -->
        <div id="site_shadow">
            <div id="content">
                <div id="header">
                    <div>
                        <BR><h1><font style="color: #00060C">CypherDB: A Novel Architecture for Outsourcing Secure Database Processing</font></h1>
                    </div><br><br><br><br><br><br><br><br><br><br>
                                                            <div id="menu">
                                                                <ul>
                                                                    <li id="button1"><a href="chome.jsp">Home</a></li>
                                                                    <li id="button2"><a href="linear.jsp">File Upload</a></li>
                                                                    <li id="button3"><a href="file_de.jsp">File Details</a></li>
                                                                    <li id="button3"><a href="down.jsp">Download</a></li>
                                                                    <li id="button4"><a href="reg.jsp">Logout</a></li>
                                                                </ul>
                                                            </div>
                                                            </div>
                                                            <!-- header ends -->
                                                            <!-- content begins -->

                                                            <div id="main">
                                                                <div id="right">
                                                                    <h4>Linear Programming</h4>
                                                                    <form name = "theForm" action="home.jsp">
                                                                        <center> 
                                                                            <table border = 1 bgcolor = "CCCCCC">
                                                                                <tr><td align = center>Enter the linear programming problem here.
                                                                                        <br><textarea name = "input" value = "" rows = 8 cols = 80></textarea>
                                                                                    </td></tr>

                                                                                <tr><td align = center>
                                                                                        <table><tr><td align = center>
                                                                                                    <br><input type="button" class="button" value = "Show LP Example" onClick="calc(1)">
                                                                                                            &nbsp; <br><br>
                                                                                                                    <input type="button" class="button" value = "Solve" onClick=" calc(2);">
                                                                                                                        <br><br>
                                                                                                                                <!--                                                                                                                                <input type="button" class="button" value = "Erase Everything" onClick="document.theForm.reset()">
                                                                                                                                                                                                        <br><br>-->

                                                                                                                                </td>
                                                                                                                                <td>&nbsp; &nbsp; </td>
                                                                                                                                <td><input hidden="" type=text size=6 value="" placeholder="" name="a"> &nbsp; &nbsp;
                                                                                                                                        <input hidden="" type=text size=6 value="" placeholder="" name="b"><br><br>
                                                                                                                                                    <br> <input hidden="" type=text placeholder="" size=6 value="" name="c"> &nbsp; &nbsp;  <input hidden="" type=text size=6 value="" name="d"><input hidden="" type=text size=6 value="2" name="xg">  <input hidden="" type=text size=6 value="2" name="yg"> 
                                                                                                                                                                        </form>
                                                                                                                                                                        <!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                                                                                                                                                                        <form action="up.jsp" method="get">
                                                                                                                                                                            <input type="number" class="inputs" name="mini" placeholder="X Minimum Value" required=""><br>
                                                                                                                                                                                    <input type="number" class="inputs" name="max" placeholder=" X Maximum Value" required=""><br>
                                                                                                                                                                                            <input type="number" class="inputs" name="mini1" placeholder="Y Minimum Value" required=""><br>
                                                                                                                                                                                                    <input type="number" class="inputs" name="max1" placeholder="Y Maximum Value" required=""><br>
                                                                                                                                                                                                        &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;<input type="submit" value="Next" class="button1">
                                                                                                                                                                                                        </form>
                                                                                                                                                                                                        </tr>
                                                                                                                                                                                                        <tr>
                                                                                                                                                                                                        <td></td><td></td><td>
                                                                                                                                                                                                        <input hidden="" type=text size=2  value="4" name="acc">
                                                                                                                                                                                                        <br>
                                                                                                                                                                                                        <input hidden="" type="checkbox" name="fracModeButton" defaultChecked = "false"></td>

                                                                                                                                                                                                        </tr>
                                                                                                                                                                                                        </table>
                                                                                                                                                                                                        </td>
                                                                                                                                                                                                        <tr>

                                                                                                                                                                                                        <td align = center>
                                                                                                                                                                                                        <!*** Evaluating the function ***>

                                                                                                                                                                                                        <table>
                                                                                                                                                                                                        <tr>
                                                                                                                                                                                                        <td><textarea name = "output" value = theInstructionString rows = 15 cols = 80></textarea>
                                                                                                                                                                                                        </td>	
                                                                                                                                                                                                        </tr>
                                                                                                                                                                                                        </table>

                                                                                                                                                                                                        </td>
                                                                                                                                                                                                        </tr>
                                                                                                                                                                                                        </table>
                                                                                                                                                                                                        <p>



                                                                                                                                                                                                        <center>

                                                                                                                                                                                                        <p><font color = "008822"><b>Disclaimer: </b></font>This page was created for educational purposes only. Its author is not responsible for any inaccuracies or errors in the results.


                                                                                                                                                                                                        </center>

                                                                                                                                                                                                        </center>

                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        <div id="left">
                                                                                                                                                                                                        <h3>Categories</h3>
                                                                                                                                                                                                        <div class="ul_bg">
                                                                                                                                                                                                        <ul class="categories">
                                                                                                                                                                                                        <li><a href="chome.jsp">Customer Home</a></li>
                                                                                                                                                                                                        <li><a href="linear.jsp">File Upload</a></li>
                                                                                                                                                                                                        <li><a href="file_de.jsp">File Details</a></li>
                                                                                                                                                                                                        <li><a href="down.jsp">Download</a></li>
                                                                                                                                                                                                        <li><a href="reg.jsp">Logout</a></li>
                                                                                                                                                                                                        </ul>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        </div><div style="clear:both"></div>
                                                                                                                                                                                                        <!--content ends -->
                                                                                                                                                                                                        <!--footer begins -->
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        <div id="footer">
                                                                                                                                                                                                        <p>Copyright  2017. | <a href="#" ></a></p> 
                                                                                                                                                                                                        <p>Design by <a href="#" title="Flash Templates">Asha</a> </p>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        <!-- footer ends-->
                                                                                                                                                                                                        </body>
                                                                                                                                                                                                        </html>


