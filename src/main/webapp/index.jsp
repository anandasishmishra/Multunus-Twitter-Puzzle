<%-- 
    Document   : newjsp
    Created on : 16 Mar, 2014, 1:13:59 AM
    Author     : anand
--%>

<%@page import="twitter4j.conf.ConfigurationBuilder"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Collections"%>
<%@page import="twitter4j.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Multunus Twitter Puzzle</title>
        
        <link href='http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:700' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" type="text/css" href="multunus.css">
        
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="mult.js">
        	
        	$(document).ready(function(){
            	$(".around").hover(function(){
                   	 $(".blackCoat",this).fadeToggle(200);
         	   });
   			 });

		    function showExplanation(){
		        document.getElementById("explanation").style.visibility="visible";
		    }
		
		
		    function hideExplanation(){
		        document.getElementById("explanation").style.visibility="hidden";
		    }
        </script>
        <style>
        #centre{
		    width:300px;
		    height:300px;
		    position: absolute;
		    top:0;
		    bottom: 0;
		    left: 0;
		    right: 0;
		    margin: auto;
		    border-radius:500px;
		}
		.around{
		    float:left;
		    border-radius:500px;
		    width:90px;
		    height:90px;
		    margin-left: 3%;
		    box-shadow: black 0px 0px 10px 1px;
		    margin-top: 38%;
		}
		.blackCoat{
		    width:100%;
		    height:100%;
		    background-color:black;
		    opacity:.5;
		    border-radius: 500px;
		}
		
		a {
		    position: absolute;
		    color: rgba(255,255,255,1);
		    text-decoration: none;
		    background-color: rgba(219,87,5,1);
		    font-family: 'Yanone Kaffeesatz';
		    font-weight: 700;
		    font-size: 30px;
		    display: block;
		    padding: 4px;
		    -webkit-border-radius: 8px;
		    -moz-border-radius: 8px;
		    border-radius: 8px;
		    -webkit-box-shadow: 0px 9px 0px rgba(219,31,5,1), 0px 9px 25px rgba(0,0,0,.7);
		    -moz-box-shadow: 0px 9px 0px rgba(219,31,5,1), 0px 9px 25px rgba(0,0,0,.7);
		    box-shadow: 0px 9px 0px rgba(219,31,5,1), 0px 9px 25px rgba(0,0,0,.7);
		    margin: 00px auto;
		    width: 160px;
		    text-align: center;
		
		    -webkit-transition: all .1s ease;
		    -moz-transition: all .1s ease;
		    -ms-transition: all .1s ease;
		    -o-transition: all .1s ease;
		    transition: all .1s ease;
		}
		
		a:active {
		    -webkit-box-shadow: 0px 3px 0px rgba(219,31,5,1), 0px 3px 6px rgba(0,0,0,.9);
		    -moz-box-shadow: 0px 3px 0px rgba(219,31,5,1), 0px 3px 6px rgba(0,0,0,.9);
		    box-shadow: 0px 3px 0px rgba(219,31,5,1), 0px 3px 6px rgba(0,0,0,.9);
		    position: absolute;
		    top: 6px;
		}
		
		#explanation{
		    position:absolute;
		    width:100%;
		    height:100%;
		    background-color: black;
		    opacity: .5;
		    visibility: hidden;
		}
		#explainCentreText{
		    position: absolute;
		    margin-left:930px;
		    margin-top: 285px;
		    color: white; 
		    font-size: 20px;
		}
		#explainRetweetersText{
		    position: absolute;
		    margin-left:20px;
		    margin-top: 380px;
		    color: white; 
		    font-size: 20px;
		}
		#explainRanksText{
		    position: absolute;
		    margin-left:920px;
		    margin-top: 350px;
		    color: white; 
		    font-size: 20px;
		}
		
		#arrowCentre{
		    position: absolute;
		    margin-left:830px;
		    margin-top: 250px;
		}
		#arrowRetweeters{
		    position: absolute;
		    margin-left: 40px;
		    margin-top: 400px;
		}
		#arrowRanks{
		    position: absolute;
		    margin-left: 945px;
		    margin-top: 440px;
		}
        </style>
    </head>
    <body style="background-image:url('http://puzzle.multunus.com/assets/watch_minimized-8f2f2b01514d433754b4f2c47d4cee58.png'); background-size: 100%">
        
        <div id="explanation" onclick="hideExplanation()" >
            <img id="arrowCentre" border="0" src="whitearrow.png" width="100" height="100"/>
            <img id="arrowRetweeters" border="0" src="whitearrow2.png" width="100" height="100"/>
            <img id="arrowRanks" border="0" src="whitearrow2.png" width="100" height="100"/>
            
            <div id="explainCentre">
                <span id="explainCentreText" >This is the owner of the tweet.</span>
            </div>
            <div id="explainRetweeters">
                <span id="explainRetweetersText" style="color: white;">These are the users who retweeted the tweet.</span>
            </div>
            <div id="explainRanks">
                <span id="explainRanksText" style="color: white;">
                    The numbers indicate the rank of the retweeters according to their number of followers.<br/>
                    The retweeter with the highest number of followers has rank 1 and likewise.
                </span>
            </div>
        </div>
        
        <%
            ConfigurationBuilder cb = new ConfigurationBuilder();
            cb.setDebugEnabled(true)
                    .setOAuthConsumerKey("In5YecDqK6b8qci45oRnbQ")
                    .setOAuthConsumerSecret("quJblw8Nc3R55gDssaOqBTOdiqmoyJbku0mB9Sc0")
                    .setOAuthAccessToken("2162301348-PcjKzbmcM2q0ImoA6eTJw2CCvL9SUoqTiMKQuoi")
                    .setOAuthAccessTokenSecret("9WBvozULFTwZircPDDMWNbaR3UoDRqytrkCxq5kurWqZ5");
            TwitterFactory tf = new TwitterFactory(cb.build());
            Twitter twitter = tf.getInstance();

            IDs ids=twitter.getRetweeterIds(445394248100487168l, 200);

            TreeMap<Integer, Long> retweeterIdAndFollowerCount= new TreeMap<Integer, Long>();
            List<Integer> followersCount=new ArrayList<Integer>();

            for(long id:ids.getIDs()){
                User user=twitter.showUser(id);
                int followerCount=user.getFollowersCount();
                retweeterIdAndFollowerCount.put(followerCount,id);
                followersCount.add(followerCount);
            }

            Collections.sort(followersCount);
            Collections.reverse(followersCount);

            for(int i=0;i<10;i++){
                Long retweetersId=retweeterIdAndFollowerCount.get(followersCount.get(i));
                User user=twitter.showUser(retweetersId);
                String profilePicURL = user.getProfileImageURL();
        %>
        <div class="around" style="background-image: url(<%=profilePicURL%>);background-size:100%;">
            <div id="abc" class="blackCoat">
                <span style="color: white;font-size: 70px;margin-left: 30%"><%=i+1%></span>
            </div>
        </div>
        <%
            }
        %>
        <a href="javascript:void(0);" onclick="showExplanation()">Show Explanation</a>
        <img id="centre" border="0" src="http://pbs.twimg.com/profile_images/426158315781881856/sBsvBbjY.png" >
    </body>
</html>
