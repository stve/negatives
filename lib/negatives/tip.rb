<?
  require('libs/phpQuery/phpQuery.php');

  $url = "http://twitpic.com/4hdmzc";
  $url = "http://twitpic.com/4hf8jk";
  $url = "http://twitpic.com/1qiutb";
  $url = "http://25.media.tumblr.com/tumblr_lhs0ssF9aX1qe1u2co1_500.gif";
  $url = "http://24.media.tumblr.com/tumblr_likcz8hQkN1qfm827o1_500.jpg";
  $url = "http://tenso.blog.br/wp-content/2011/03/enhanced-buzz-25600-1301347176-39.png";
  $url = "http://t.co/MY9b42o";
  $url = "http://yfrog.com/gzvvsjij";
  $url = "http://t.co/uC8sH1c";
  $url = "http://i.imgur.com/w2aHU.jpg";
  $url = "http://bit.ly/hhj19H";
  $url = "http://plixi.com/p/89897091";
  $url = "http://fb.me/WoObXhIC";
  $url = "http://img.ly/3nww";


  if(isset($_GET['url'])) { $url = $_GET['url']; }


  // IMAGE SERVICES


  if(strstr($url,"instagr.am")) {
    phpQuery::newDocumentFile($url);
    $img = pq("img.photo")->attr("src");
    $output =  file_get_contents($img);
  }

  }

  if(strstr($url,"posterous")) {
    phpQuery::newDocumentFile($url);
    $img = pq("img[width=500]")->attr("src");
    $output =  file_get_contents($img);
  }



  // ALL DIRECT IMAGES
  if(strstr($url,".gif") || strstr($url,".jpg") || strstr($url,".png")) {
    $img = $url;
    header("Content-type: image/jpeg");
    $output =  file_get_contents($img);
  }

  header("Content-type: image");
  die($output);

?>