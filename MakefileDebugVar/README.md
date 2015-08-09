<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head profile="http://gmpg.org/xfn/11">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />

	<title>如何调试makefile变量 | 酷 壳 - CoolShell.cn</title>
	<link rel="alternate" type="application/rss+xml" title="RSS 2.0 - 所有文章" href="http://coolshell.cn/feed" />
	<link rel="alternate" type="application/rss+xml" title="RSS 2.0 - 所有评论" href="http://coolshell.cn/comments/feed" />
	<link rel="pingback" href="http://coolshell.cn/xmlrpc.php" />

	<!-- style START -->
	<!-- default style -->
	<style type="text/css" media="screen">@import url( http://coolshell.cn/wp-content/themes/inove/style.css );</style>
	<link rel='stylesheet' id='open-sans-css'  href='http://coolshell.cn//wp-includes/css/google-font.css?ver=3.9.1' type='text/css' media='all' />
	<!-- for translations -->
			<link rel="stylesheet" href="http://coolshell.cn//wp-content/themes/inove/chinese.css" type="text/css" media="screen" />
		<!--[if IE]>
		<link rel="stylesheet" href="http://coolshell.cn//wp-content/themes/inove/ie.css" type="text/css" media="screen" />
	<![endif]-->
	<!-- style END -->

	<!-- script START -->
	<script type="text/javascript" src="http://coolshell.cn//wp-content/themes/inove/js/base.js"></script>
	<script type="text/javascript" src="http://coolshell.cn//wp-content/themes/inove/js/menu.js"></script>
	<!-- script END -->

	
<!-- All in One SEO Pack 2.2.7.1 by Michael Torbert of Semper Fi Web Design[326,380] -->
<meta name="keywords"  content="c++,makefile,c/c++语言,编程工具" />

<link rel="canonical" href="http://coolshell.cn/articles/3790.html" />
<meta property="og:title" content="如何调试makefile变量 | 酷 壳 - CoolShell.cn" />
<meta property="og:type" content="article" />
<meta property="og:url" content="http://coolshell.cn/articles/3790.html" />
<meta property="og:image" content="http://coolshell.cn//wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png" />
<meta property="og:site_name" content="酷 壳 - CoolShell.cn" />
<meta property="og:description" content="六、七年前写过一篇《跟我一起写Makefile》，直到今天，还有一些朋友问我一些Makefile的问题，老实说，我有一段时间没有用Makefile了，生疏了。回顾，这几年来大家问题我的问题，其实很多时候是makefile的调试问题。所以，就像我在之前的那篇关于GDB的技巧的文章中做的一样，在这里向大家介绍一个小小的调试变量的技巧。相信一定对你有用。 对于Makefile中的各种变量，可能是我们比较头痛的事了。我们要查看他们并不是很方便，需要修改makefile加入echo命令。这有时候很不方便。其实我们可以制作下面一个专门用来输出变量的makefile（假设名字叫：vars.mk）  %: @echo &#039;$*=$($*)&#039; d-%: @echo &#039;$*=$($*)&#039; @echo &#039; origin = $(origin $*)&#039; @echo &#039; value = $(value $*)&#039; @echo &#039; flavor = $(flavor $*)&#039;  这样一来，我们可以使用make命令的-f参数来查看makefile中的相关变量（包括make的内建变量，比如：COMPILE.c或MAKE_VERSION之类的）。注意：第二个以“d-”为前缀的目标可以用来打印关于这个变量更为详细的东西（后面有详细说明）  假设我们的makefile是这个样子（test.mk）  OBJDIR := objdir OBJS := $(addprefix $(OBJDIR)/,foo.o bar.o baz.o) foo = $(bar)bar = $(ugh)ugh = Huh? CFLAGS = $(include_dirs) -O include_dirs = -Ifoo -Ibar CFLAGS := $(CFLAGS) -Wall MYOBJ := a.o b.o c.o MYSRC := $(MYOBJ:.o=.c) 那么，我们可以这样进行调试：  $ make -f test.mk -f var.mk OBJS OBJS=objdir/foo.o objdir/bar.o objdir/baz.o $ make -f test.mk -f var.mk d-foo foo=Huh? origin = file value = $(bar) flavor = recursive" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="六、七年前写过一篇《跟我一起写Makefile》，直到今天，还有一些朋友问我一些Makefile的问题，老实说，我有一段时间没有用Makefile了，生疏了。回顾，这几年来大家问题我的问题，其实很多时候是makefile的调试问题。所以，就像我在之前的那篇关于GDB的技巧的文章中做的一样，在这里向大家介绍一个小小的调试变量的技巧。相信一定对你有用。 对于Makefile中的各种变量，可能是我们比较头痛的事了。我们要查看他们并不是很方便，需要修改makefile加入echo命令。这有时候很不方便。其实我们可以制作下面一个专门用来输出变量的makefile（假设名字叫：vars.mk）  %: @echo &#039;$*=$($*)&#039; d-%: @echo &#039;$*=$($*)&#039; @echo &#039; origin = $(origin $*)&#039; @echo &#039; value = $(value $*)&#039; @echo &#039; flavor = $(flavor $*)&#039;  这样一来，我们可以使用make命令的-f参数来查看makefile中的相关变量（包括make的内建变量，比如：COMPILE.c或MAKE_VERSION之类的）。注意：第二个以“d-”为前缀的目标可以用来打印关于这个变量更为详细的东西（后面有详细说明）  假设我们的makefile是这个样子（test.mk）  OBJDIR := objdir OBJS := $(addprefix $(OBJDIR)/,foo.o bar.o baz.o) foo = $(bar)bar = $(ugh)ugh = Huh? CFLAGS = $(include_dirs) -O include_dirs = -Ifoo -Ibar CFLAGS := $(CFLAGS) -Wall MYOBJ := a.o b.o c.o MYSRC := $(MYOBJ:.o=.c) 那么，我们可以这样进行调试：  $ make -f test.mk -f var.mk OBJS OBJS=objdir/foo.o objdir/bar.o objdir/baz.o $ make -f test.mk -f var.mk d-foo foo=Huh? origin = file value = $(bar) flavor = recursive" />
<meta itemprop="image" content="http://coolshell.cn//wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png" />
<!-- /all in one seo pack -->
<link rel="alternate" type="application/rss+xml" title="酷 壳 - CoolShell.cn &raquo; 如何调试makefile变量评论Feed" href="http://coolshell.cn/articles/3790.html/feed" />
<script>var killIE6ImgUrl = "http://coolshell.cn//wp-content/plugins/lets-kill-ie6/img";</script>		<script type="text/javascript">
			window._wpemojiSettings = {"baseUrl":"http:\/\/s.w.org\/images\/core\/emoji\/72x72\/","ext":".png","source":{"concatemoji":"http:\/\/coolshell.cn\/wp-includes\/js\/wp-emoji-release.min.js?ver=4.2.4"}};
			!function(a,b,c){function d(a){var c=b.createElement("canvas"),d=c.getContext&&c.getContext("2d");return d&&d.fillText?(d.textBaseline="top",d.font="600 32px Arial","flag"===a?(d.fillText(String.fromCharCode(55356,56812,55356,56807),0,0),c.toDataURL().length>3e3):(d.fillText(String.fromCharCode(55357,56835),0,0),0!==d.getImageData(16,16,1,1).data[0])):!1}function e(a){var c=b.createElement("script");c.src=a,c.type="text/javascript",b.getElementsByTagName("head")[0].appendChild(c)}var f,g;c.supports={simple:d("simple"),flag:d("flag")},c.DOMReady=!1,c.readyCallback=function(){c.DOMReady=!0},c.supports.simple&&c.supports.flag||(g=function(){c.readyCallback()},b.addEventListener?(b.addEventListener("DOMContentLoaded",g,!1),a.addEventListener("load",g,!1)):(a.attachEvent("onload",g),b.attachEvent("onreadystatechange",function(){"complete"===b.readyState&&c.readyCallback()})),f=c.source||{},f.concatemoji?e(f.concatemoji):f.wpemoji&&f.twemoji&&(e(f.twemoji),e(f.wpemoji)))}(window,document,window._wpemojiSettings);
		</script>
		<style type="text/css">
img.wp-smiley,
img.emoji {
	display: inline !important;
	border: none !important;
	box-shadow: none !important;
	height: 1em !important;
	width: 1em !important;
	margin: 0 .07em !important;
	vertical-align: -0.1em !important;
	background: none !important;
	padding: 0 !important;
}
</style>
<link rel='stylesheet' id='wp-postratings-css'  href='http://coolshell.cn//wp-content/plugins/wp-postratings/postratings-css.css?ver=1.81' type='text/css' media='all' />
<link rel='stylesheet' id='wp-pagenavi-css'  href='http://coolshell.cn//wp-content/themes/inove/pagenavi-css.css?ver=2.70' type='text/css' media='all' />
<script type='text/javascript' src='http://coolshell.cn//wp-includes/js/jquery/jquery.js?ver=1.11.2'></script>
<script type='text/javascript' src='http://coolshell.cn//wp-includes/js/jquery/jquery-migrate.min.js?ver=1.2.1'></script>
<script type='text/javascript' src='http://coolshell.cn//wp-content/plugins/lets-kill-ie6/lets-kill-ie6.js?ver=4.2.4'></script>
<link rel="EditURI" type="application/rsd+xml" title="RSD" href="http://coolshell.cn/xmlrpc.php?rsd" />
<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="http://coolshell.cn//wp-includes/wlwmanifest.xml" /> 
<link rel='prev' title='打印质数的各种算法' href='http://coolshell.cn/articles/3738.html' />
<link rel='next' title='破解你的口令' href='http://coolshell.cn/articles/3801.html' />
<meta name="generator" content="WordPress 4.2.4" />
<link rel='shortlink' href='http://coolshell.cn/?p=3790' />
	<link href="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Styles/SyntaxHighlighter.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript">
	window._wp_rp_static_base_url = 'https://wprp.zemanta.com/static/';
	window._wp_rp_wp_ajax_url = "http://coolshell.cn/wp-admin/admin-ajax.php";
	window._wp_rp_plugin_version = '3.5.4';
	window._wp_rp_post_id = '3790';
	window._wp_rp_num_rel_posts = '8';
	window._wp_rp_thumbnails = false;
	window._wp_rp_post_title = '%E5%A6%82%E4%BD%95%E8%B0%83%E8%AF%95makefile%E5%8F%98%E9%87%8F';
	window._wp_rp_post_tags = [];
	window._wp_rp_promoted_content = true;
</script>
<script type="text/javascript" src="https://wprp.zemanta.com/static/js/loader.js?version=3.5.4" async></script>
<style type="text/css">
.related_post_title {

}
ul.related_post {
}
ul.related_post li {
}
ul.related_post li a {
}
ul.related_post li img {
}</style>
<style type="text/css" id="syntaxhighlighteranchor"></style>
</head>


<body>
<!-- wrap START -->
<div id="wrap">

<!-- container START -->
<div id="container"  >

<!-- header START -->
<div id="header">

	<!-- banner START -->
			<div class="banner">
			<a title="把这个链接拖到你的Chrome收藏夹工具栏中" href='javascript:(function(){function c(){var e=document.createElement("link");e.setAttribute("type","text/css");e.setAttribute("rel","stylesheet");e.setAttribute("href",f);e.setAttribute("class",l);document.body.appendChild(e)}function h(){var e=document.getElementsByClassName(l);for(var t=0;t<e.length;t++){document.body.removeChild(e[t])}}function p(){var e=document.createElement("div");e.setAttribute("class",a);document.body.appendChild(e);setTimeout(function(){document.body.removeChild(e)},100)}function d(e){return{height:e.offsetHeight,width:e.offsetWidth}}function v(i){var s=d(i);return s.height>e&&s.height<n&&s.width>t&&s.width<r}function m(e){var t=e;var n=0;while(!!t){n+=t.offsetTop;t=t.offsetParent}return n}function g(){var e=document.documentElement;if(!!window.innerWidth){return window.innerHeight}else if(e&&!isNaN(e.clientHeight)){return e.clientHeight}return 0}function y(){if(window.pageYOffset){return window.pageYOffset}return Math.max(document.documentElement.scrollTop,document.body.scrollTop)}function E(e){var t=m(e);return t>=w&&t<=b+w}function S(){var e=document.createElement("audio");e.setAttribute("class",l);e.src=i;e.loop=false;e.addEventListener("canplay",function(){setTimeout(function(){x(k)},500);setTimeout(function(){N();p();for(var e=0;e<O.length;e++){T(O[e])}},15500)},true);e.addEventListener("ended",function(){N();h()},true);e.innerHTML=" <p>If you are reading this, it is because your browser does not support the audio element. We recommend that you get a new browser.</p> <p>";document.body.appendChild(e);e.play()}function x(e){e.className+=" "+s+" "+o}function T(e){e.className+=" "+s+" "+u[Math.floor(Math.random()*u.length)]}function N(){var e=document.getElementsByClassName(s);var t=new RegExp("\\b"+s+"\\b");for(var n=0;n<e.length;){e[n].className=e[n].className.replace(t,"")}}var e=30;var t=30;var n=350;var r=350;var i="//s3.amazonaws.com/moovweb-marketing/playground/harlem-shake.mp3";var s="mw-harlem_shake_me";var o="im_first";var u=["im_drunk","im_baked","im_trippin","im_blown"];var a="mw-strobe_light";var f="//s3.amazonaws.com/moovweb-marketing/playground/harlem-shake-style.css";var l="mw_added_css";var b=g();var w=y();var C=document.getElementsByTagName("*");var k=null;for(var L=0;L<C.length;L++){var A=C[L];if(v(A)){if(E(A)){k=A;break}}}if(A===null){console.warn("Could not find a node of the right size. Please try a different page.");return}c();S();var O=[];for(var L=0;L<C.length;L++){var A=C[L];if(v(A)){O.push(A)}}})()    '>High一下!</a>		</div>
		<!-- banner END -->

	<div id="caption">
		<h1 id="title"><a href="http://coolshell.cn/">酷 壳 &#8211; CoolShell.cn</a></h1>
		<div id="tagline">享受编程和技术所带来的快乐 &#8211; http://coolshell.cn</div>
	</div>

	<div class="fixed"></div>
</div>
<!-- header END -->

<!-- navigation START -->
<div id="navigation">
	<!-- menus START -->
	<ul id="menus">
		<li class="page_item"><a class="home" title="首页" href="http://coolshell.cn/">首页</a></li>
		<li class="page_item page-item-4194"><a href="http://coolshell.cn/featured_posts">推荐文章</a></li>
<li class="page_item page-item-3839"><a href="http://coolshell.cn/plugins">本站插件</a></li>
<li class="page_item page-item-2"><a href="http://coolshell.cn/guestbook">留言小本</a></li>
<li class="page_item page-item-368"><a href="http://coolshell.cn/about">关于酷壳</a></li>
<li class="page_item page-item-4470"><a href="http://coolshell.cn/haoel">关于陈皓</a></li>
		<li><a class="lastmenu" href="javascript:void(0);"></a></li>
	</ul>
	<!-- menus END -->

	<!-- searchbox START -->
	<div id="searchbox">
					<form action="http://coolshell.cn" method="get">
				<div class="content">
					<input type="text" class="textfield" name="s" size="24" value="" />
					<input type="submit" class="button" value="" />
				</div>
			</form>
			</div>
<script type="text/javascript">
//<![CDATA[
	var searchbox = MGJS.$("searchbox");
	var searchtxt = MGJS.getElementsByClassName("textfield", "input", searchbox)[0];
	var searchbtn = MGJS.getElementsByClassName("button", "input", searchbox)[0];
	var tiptext = "请输入关键字...";
	if(searchtxt.value == "" || searchtxt.value == tiptext) {
		searchtxt.className += " searchtip";
		searchtxt.value = tiptext;
	}
	searchtxt.onfocus = function(e) {
		if(searchtxt.value == tiptext) {
			searchtxt.value = "";
			searchtxt.className = searchtxt.className.replace(" searchtip", "");
		}
	}
	searchtxt.onblur = function(e) {
		if(searchtxt.value == "") {
			searchtxt.className += " searchtip";
			searchtxt.value = tiptext;
		}
	}
	searchbtn.onclick = function(e) {
		if(searchtxt.value == "" || searchtxt.value == tiptext) {
			return false;
		}
	}
//]]>
</script>
	<!-- searchbox END -->

	<div class="fixed"></div>
</div>
<!-- navigation END -->

<!-- content START -->
<div id="content">

	<!-- main START -->
	<div id="main">


	<div id="postpath">
		<a title="转到首页" href="http://coolshell.cn/">首页</a>
		 &gt; <a href="http://coolshell.cn/category/proglanguage/cplusplus" rel="category tag">C/C++语言</a>, <a href="http://coolshell.cn/category/tools" rel="category tag">编程工具</a>		 &gt; 如何调试makefile变量	</div>

	<div class="post" id="post-3790">
		<h2>如何调试makefile变量</h2>
		<div class="info">
			<span class="date">2011年3月1日</span>
			<span class="author"><a href="http://coolshell.cn/articles/author/haoel" title="由陈皓发布" rel="author">陈皓</a></span>										<span class="addcomment"><a href="#respond">发表评论</a></span>
				<span class="comments"><a href="#comments">阅读评论</a></span>
						<span class="comments"> 18,563 人阅读  &nbsp;  &nbsp;</span>
			<div class="fixed"></div>
		</div>
		<div class="content">
			<p>六、七年前写过一篇《<a title="跟我一起写Makefile" href="http://blog.csdn.net/haoel/archive/2004/02/24/2886.aspx" target="_blank">跟我一起写Makefile</a>》，直到今天，还有一些朋友问我一些Makefile的问题，老实说，我有一段时间没有用Makefile了，生疏了。回顾，这几年来大家问题我的问题，其实很多时候是makefile的调试问题。所以，就像我在之前的那篇<a title="GDB中应该知道的几个调试方法" href="http://coolshell.cn/articles/3643.html" target="_blank">关于GDB的技巧的文章</a>中做的一样，在这里向大家介绍一个小小的调试变量的技巧。相信一定对你有用。</p>
<p>对于Makefile中的各种变量，可能是我们比较头痛的事了。我们要查看他们并不是很方便，需要修改makefile加入echo命令。这有时候很不方便。其实我们可以制作下面一个专门用来输出变量的makefile（假设名字叫：vars.mk）</p>
<pre class="brush: bash; title: vars.mk; notranslate" title="vars.mk">
%:
        @echo '$*=$($*)'

d-%:
        @echo '$*=$($*)'
        @echo '  origin = $(origin $*)'
        @echo '   value = $(value  $*)'
        @echo '  flavor = $(flavor $*)'
</pre>
<p>这样一来，我们可以使用make命令的-f参数来查看makefile中的相关变量（包括make的内建变量，比如：COMPILE.c或MAKE_VERSION之类的）。<strong>注意：第二个以“d-”为前缀的目标可以用来打印关于这个变量更为详细的东西</strong>（后面有详细说明）<br />
<span id="more-3790"></span></p>
<p>假设我们的makefile是这个样子（test.mk）</p>
<pre class="brush: bash; title: test.mk; notranslate" title="test.mk">

OBJDIR := objdir
OBJS := $(addprefix $(OBJDIR)/,foo.o bar.o baz.o)

foo = $(bar)bar = $(ugh)ugh = Huh?

CFLAGS = $(include_dirs) -O
include_dirs = -Ifoo -Ibar
CFLAGS := $(CFLAGS) -Wall

MYOBJ := a.o b.o c.o
MYSRC := $(MYOBJ:.o=.c)</pre>
<p>那么，我们可以这样进行调试：</p>
<pre class="brush: bash; title: 演示; notranslate" title="演示">

[hchen@RHELSVR5]$ make -f test.mk -f var.mk OBJS
OBJS=objdir/foo.o objdir/bar.o objdir/baz.o

[hchen@RHELSVR5]$ make -f test.mk -f var.mk d-foo
foo=Huh?
  origin = file
  value = $(bar)
  flavor = recursive

[hchen@RHELSVR5]$ make -f test.mk -f var.mk d-CFLAGS
CFLAGS=-Ifoo -Ibar -O -O
  origin = file
  value = -Ifoo -Ibar -O -O
  flavor = simple

[hchen@RHELSVR5]$  make -f test.mk -f var.mk d-COMPILE.c
COMPILE.c=cc -Ifoo -Ibar -O -Wall   -c
  origin = default
  flavor = recursive
   value = $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
</pre>
<p>我们可以看到：</p>
<ul>
<li>make的第一个-f后是要测试的makefile，第二个是我们的debug makefile。</li>
<li>后面直接跟变量名，如果在变量名前加&#8221;d-&#8220;，则输出更为详细的东西。</li>
</ul>
<p>说一说&#8221;d-&#8221; 前缀（其意为details），其中调用了下面三个参数。</p>
<ul>
<li><span style="font-family: 'Courier New';"><a style="font-family: 'Courier New';" href="http://www.gnu.org/software/make/manual/make.html#Origin-Function">$(origin)</a><span style="font-family: 'Courier New';">：告诉你这个变量是来自哪儿，file表示文件，environment表示环境变量，还有environment override，command line，override，automatic等。</span></span></li>
<li><span style="font-family: 'Courier New';"><a href="http://www.gnu.org/software/make/manual/make.html#Value-Function">$(value)</a>：打出这个变量没有被展开的样子。比如上述示例中的 foo 变量。</span></li>
<li><span style="font-family: 'Courier New';"><a href="http://www.gnu.org/software/make/manual/make.html#Flavor-Function">$(flavor)</a>：有两个值，simple表示是一般展开的变量，recursive表示递归展开的变量。</span></li>
</ul>
<p>（全文完）
<div style="margin-top: 15px; font-size: 11px;color: #cc0000;">
<p align=center><strong>（转载本站文章请注明作者和出处 <a href="http://coolshell.cn/">酷 壳 &#8211; CoolShell.cn</a> ，请勿用于任何商业用途）</strong></div>
<div style="text-align:center;padding:0px;font-size: 14px;margin-bottom: 50px;">——=== <b>访问 <a href=http://coolshell.cn/404/ target=_blank>酷壳404页面</a> 寻找遗失儿童。</b> ===——</div>
<div style="clear:both; margin-top:5px; margin-bottom:5px;"></div><div style="float:left"><!-- JiaThis Button BEGIN -->
<div class="jiathis_style">
<a class="jiathis_button_tsina"></a>
<a class="jiathis_button_tqq"></a>
<a class="jiathis_button_tsohu"></a>
<a class="jiathis_button_t163"></a>
<a class="jiathis_button_douban"></a>
<a class="jiathis_button_renren"></a>
<a class="jiathis_button_zhuaxia"></a>
<a class="jiathis_button_fanfou"></a>
<a class="jiathis_button_twitter"></a>
<a class="jiathis_button_fb"></a>
<a class="jiathis_button_gmail"></a>
<a class="jiathis_button_linkedin"></a>
<a class="jiathis_button_friendfeed"></a>
<a class="jiathis_button_digg"></a>
<a href="http://www.jiathis.com/share?uid=1541368" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
<a class="jiathis_counter_style"></a>
</div>
<script type="text/javascript" >
var jiathis_config={
	data_track_clickback:true,
	summary:"",
	hideMore:false
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1541368" charset="utf-8"></script>
<!-- JiaThis Button END --></div><div style="clear:both; margin-top:5px; margin-bottom:5px;"></div>			<div class="fixed"></div>
		</div>
		<div class="under">
			<span class="categories">分类: </span><span><a href="http://coolshell.cn/category/proglanguage/cplusplus" rel="category tag">C/C++语言</a>, <a href="http://coolshell.cn/category/tools" rel="category tag">编程工具</a></span>			<span class="tags">标签: </span><span><a href="http://coolshell.cn/tag/c" rel="tag">C++</a>, <a href="http://coolshell.cn/tag/makefile" rel="tag">makefile</a></span>		</div>
<div id="post-ratings-3790" class="post-ratings" itemscope itemtype="http://schema.org/Article" data-nonce="07e6eeb065"><img id="rating_3790_1" src="http://coolshell.cn//wp-content/plugins/wp-postratings/images/stars_crystal/rating_on.gif" alt="好烂啊" title="好烂啊" onmouseover="current_rating(3790, 1, '好烂啊');" onmouseout="ratings_off(4.9, 5, 0);" onclick="rate_post();" onkeypress="rate_post();" style="cursor: pointer; border: 0px;" /><img id="rating_3790_2" src="http://coolshell.cn//wp-content/plugins/wp-postratings/images/stars_crystal/rating_on.gif" alt="有点差" title="有点差" onmouseover="current_rating(3790, 2, '有点差');" onmouseout="ratings_off(4.9, 5, 0);" onclick="rate_post();" onkeypress="rate_post();" style="cursor: pointer; border: 0px;" /><img id="rating_3790_3" src="http://coolshell.cn//wp-content/plugins/wp-postratings/images/stars_crystal/rating_on.gif" alt="凑合看看" title="凑合看看" onmouseover="current_rating(3790, 3, '凑合看看');" onmouseout="ratings_off(4.9, 5, 0);" onclick="rate_post();" onkeypress="rate_post();" style="cursor: pointer; border: 0px;" /><img id="rating_3790_4" src="http://coolshell.cn//wp-content/plugins/wp-postratings/images/stars_crystal/rating_on.gif" alt="还不错" title="还不错" onmouseover="current_rating(3790, 4, '还不错');" onmouseout="ratings_off(4.9, 5, 0);" onclick="rate_post();" onkeypress="rate_post();" style="cursor: pointer; border: 0px;" /><img id="rating_3790_5" src="http://coolshell.cn//wp-content/plugins/wp-postratings/images/stars_crystal/rating_half.gif" alt="很精彩" title="很精彩" onmouseover="current_rating(3790, 5, '很精彩');" onmouseout="ratings_off(4.9, 5, 0);" onclick="rate_post();" onkeypress="rate_post();" style="cursor: pointer; border: 0px;" /> (<strong>13</strong> 人打了分，平均分： <strong>4.92</strong> )<br /><span class="post-ratings-text" id="ratings_3790_text"></span><meta itemprop="name" content="如何调试makefile变量" /><meta itemprop="description" content="六、七年前写过一篇《跟我一起写Makefile》，直到今天，还有一些朋友问我一些Makefile的问题，老实说，我有一段时间没有用Makefile了，生疏了。回顾，这几年来大家问题我的问题，其实很多时候是makefile的调试问题。所以，就像我在之前的那篇关于GDB的技巧的文章中做的一样，在这里向大家介绍一个小小的调试变量的技巧。相信一定对你有用。

对于Makefile中的各种变量，可能是我..." /><meta itemprop="url" content="http://coolshell.cn/articles/3790.html" /><div style="display: none;" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"><meta itemprop="bestRating" content="5" /><meta itemprop="ratingValue" content="4.92" /><meta itemprop="ratingCount" content="13" /></div></div><div id="post-ratings-3790-loading" class="post-ratings-loading">
			<img src="http://coolshell.cn//wp-content/plugins/wp-postratings/images/loading.gif" width="16" height="16" alt="Loading..." title="Loading..." class="post-ratings-image" />Loading...</div> 
	</div>

	<!-- related posts START -->
	<div id="related_posts">
<div class="wp_rp_wrap  wp_rp_plain" id="wp_rp_first"><div class="wp_rp_content"><h3 class="related_post_title">相关文章</h3><ul class="related_post wp_rp"><li data-position="0" data-poid="in-12052" data-post-type="none" ><small class="wp_rp_publish_date">2014年10月23日</small> <a href="http://coolshell.cn/articles/12052.html" class="wp_rp_title">Leetcode 编程训练</a></li><li data-position="1" data-poid="in-12012" data-post-type="none" ><small class="wp_rp_publish_date">2014年10月12日</small> <a href="http://coolshell.cn/articles/12012.html" class="wp_rp_title">State Threads 回调终结者</a></li><li data-position="2" data-poid="in-11466" data-post-type="none" ><small class="wp_rp_publish_date">2014年04月21日</small> <a href="http://coolshell.cn/articles/11466.html" class="wp_rp_title">C语言的整型溢出问题</a></li><li data-position="3" data-poid="in-11377" data-post-type="none" ><small class="wp_rp_publish_date">2014年04月01日</small> <a href="http://coolshell.cn/articles/11377.html" class="wp_rp_title">C语言结构体里的成员数组和指针</a></li><li data-position="4" data-poid="in-11235" data-post-type="none" ><small class="wp_rp_publish_date">2014年03月15日</small> <a href="http://coolshell.cn/articles/11235.html" class="wp_rp_title">一个浮点数跨平台产生的问题</a></li><li data-position="5" data-poid="in-11112" data-post-type="none" ><small class="wp_rp_publish_date">2014年02月24日</small> <a href="http://coolshell.cn/articles/11112.html" class="wp_rp_title">由苹果的低级Bug想到的</a></li><li data-position="6" data-poid="in-10975" data-post-type="none" ><small class="wp_rp_publish_date">2014年01月28日</small> <a href="http://coolshell.cn/articles/10975.html" class="wp_rp_title">一个“蝇量级” C 语言协程库</a></li><li data-position="7" data-poid="in-10739" data-post-type="none" ><small class="wp_rp_publish_date">2013年12月03日</small> <a href="http://coolshell.cn/articles/10739.html" class="wp_rp_title">Lua简明教程</a></li></ul></div></div>
</div><div class="fixed"></div>	<!-- related posts END -->

	<script type="text/javascript" src="http://coolshell.cn//wp-content/themes/inove/js/comment.js"></script>



<div id="comments">

<div id="cmtswitcher">
			<a id="commenttab" class="curtab" href="javascript:void(0);" onclick="MGJS.switchTab('thecomments,commentnavi', 'thetrackbacks', 'commenttab', 'curtab', 'trackbacktab', 'tab');">评论 (25)</a>
		<a id="trackbacktab" class="tab" href="javascript:void(0);" onclick="MGJS.switchTab('thetrackbacks', 'thecomments,commentnavi', 'trackbacktab', 'curtab', 'commenttab', 'tab');">Trackbacks (3)</a>
				<span class="addcomment"><a href="#respond">发表评论</a></span>
				<span class="addtrackback"><a href="http://coolshell.cn/articles/3790.html/trackback">Trackback</a></span>
		<div class="fixed"></div>
</div>

<div id="commentlist">
	<!-- comments START -->
	<ol id="thecomments">
		<li class="comment regularcomment" id="comment-33144">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://2.gravatar.com/avatar/2f9a46f737f771211910560304ee0bb5?s=32&#038;d=mm&#038;r=g' srcset='http://2.gravatar.com/avatar/2f9a46f737f771211910560304ee0bb5?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-33144">
				
				maplesfive
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月1日11:04					 | <a href="#comment-33144">#1</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33144', 'comment-33144', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33144', 'comment-33144', 'commentbody-33144', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33144">
					<p>忍不住要赞美一下，太实用了</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-33181">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/c552b333e77379b252aeb1c9ac37351d?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/c552b333e77379b252aeb1c9ac37351d?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-33181">
				
				lyuehh
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月1日15:43					 | <a href="#comment-33181">#2</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33181', 'comment-33181', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33181', 'comment-33181', 'commentbody-33181', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33181">
					<p>恩，相当实用</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-33197">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/aadeddd5c381bbf0acb50fbd3153fbd6?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/aadeddd5c381bbf0acb50fbd3153fbd6?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-33197">
				
				jruv
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月1日17:17					 | <a href="#comment-33197">#3</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33197', 'comment-33197', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33197', 'comment-33197', 'commentbody-33197', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33197">
					<p>我火星了，这个网站已经关注了3年了吧， 一直觉的站长的名字很熟悉， 似乎在哪里见过， 现在终于想起来了， 过去学习Makefile就是从你那篇著名的《跟我一起写Makefile》开始的。</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment admincomment" id="comment-33198">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/af2fbb7372dd5826e44d87e6ceccea40?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/af2fbb7372dd5826e44d87e6ceccea40?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<a id="commentauthor-33198" class="url" href="http://coolshell.cn" rel="external nofollow">
				
				陈皓
									</a>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月1日17:21					 | <a href="#comment-33198">#4</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33198', 'comment-33198', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33198', 'comment-33198', 'commentbody-33198', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33198">
					<p><a href="#comment-33197" rel="nofollow">@jruv </a><br />
关注文章就行了。是谁写的并不重要。呵呵。</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-33233">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/3c8e7d37a54548d3b7f998571505d134?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/3c8e7d37a54548d3b7f998571505d134?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-33233">
				
				Noe
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月1日21:21					 | <a href="#comment-33233">#5</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33233', 'comment-33233', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33233', 'comment-33233', 'commentbody-33233', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33233">
					<p>这篇博文我必须拜一下，太有用了！谢谢博主。</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-33243">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/32cfe0bcdbd380a271f2aaf6eaa8b13d?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/32cfe0bcdbd380a271f2aaf6eaa8b13d?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<a id="commentauthor-33243" class="url" href="http://stufever.com" rel="external nofollow">
				
				stufever
									</a>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月1日22:04					 | <a href="#comment-33243">#6</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33243', 'comment-33243', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33243', 'comment-33243', 'commentbody-33243', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33243">
					<p>不错，都是好的知识</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-33252">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/d268abed55a3131c9690b3962a353325?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/d268abed55a3131c9690b3962a353325?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<a id="commentauthor-33252" class="url" href="http://www.cppfans.org" rel="external nofollow">
				
				eliteYang
									</a>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月1日23:17					 | <a href="#comment-33252">#7</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33252', 'comment-33252', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33252', 'comment-33252', 'commentbody-33252', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33252">
					<p>非常好的知识，贵站代码高亮显示的插件是什么？我也有一个技术博客，但是里面代码高显的插件都不好用，所以想问下，非常感谢！</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment admincomment" id="comment-33265">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/af2fbb7372dd5826e44d87e6ceccea40?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/af2fbb7372dd5826e44d87e6ceccea40?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<a id="commentauthor-33265" class="url" href="http://coolshell.cn" rel="external nofollow">
				
				陈皓
									</a>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月2日00:05					 | <a href="#comment-33265">#8</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33265', 'comment-33265', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33265', 'comment-33265', 'commentbody-33265', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33265">
					<p><a href="#comment-33252" rel="nofollow">@eliteYang </a><br />
代码高亮插件<br />
SyntaxHighlighter Evolved</p>
<p>插件主页：<br />
<a href="http://www.viper007bond.com/wordpress-plugins/syntaxhighlighter/" rel="nofollow">http://www.viper007bond.com/wordpress-plugins/syntaxhighlighter/</a></p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-33435">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/1fbca11f8c04d672d7e0df3fe83c3a5c?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/1fbca11f8c04d672d7e0df3fe83c3a5c?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-33435">
				
				hackage
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月2日19:12					 | <a href="#comment-33435">#9</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33435', 'comment-33435', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33435', 'comment-33435', 'commentbody-33435', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33435">
					<p>感谢大哥</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-33481">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://2.gravatar.com/avatar/84c4100c3035298381d3d7799b9d1fa6?s=32&#038;d=mm&#038;r=g' srcset='http://2.gravatar.com/avatar/84c4100c3035298381d3d7799b9d1fa6?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-33481">
				
				dbTech
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月2日22:31					 | <a href="#comment-33481">#10</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-33481', 'comment-33481', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-33481', 'comment-33481', 'commentbody-33481', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-33481">
					<p>这个很给力，或者make -n也凑合用 :)</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-34631">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/66f6f59c5a5b1e08f4514b0fae229850?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/66f6f59c5a5b1e08f4514b0fae229850?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-34631">
				
				tmy13
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月7日09:12					 | <a href="#comment-34631">#11</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-34631', 'comment-34631', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-34631', 'comment-34631', 'commentbody-34631', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-34631">
					<p>这个强大，一下子觉得可以省掉很多功夫</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-36890">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/12c0d1cfe3e1bde394f40737ccb03ddc?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/12c0d1cfe3e1bde394f40737ccb03ddc?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-36890">
				
				byte3w
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月18日11:51					 | <a href="#comment-36890">#12</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-36890', 'comment-36890', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-36890', 'comment-36890', 'commentbody-36890', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-36890">
					<p>信皓哥得永生</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-38255">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/ccff97a535fb14f4a08c1d61712f4ee2?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/ccff97a535fb14f4a08c1d61712f4ee2?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-38255">
				
				dreamer
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年3月22日10:59					 | <a href="#comment-38255">#13</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-38255', 'comment-38255', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-38255', 'comment-38255', 'commentbody-38255', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-38255">
					<p>今天又学了一招。。。</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-51762">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/aa40ffbb3e96f9e12906d1ac3bad2a1a?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/aa40ffbb3e96f9e12906d1ac3bad2a1a?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-51762">
				
				skyun
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年5月13日14:24					 | <a href="#comment-51762">#14</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-51762', 'comment-51762', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-51762', 'comment-51762', 'commentbody-51762', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-51762">
					<p>博主大牛，能不能讲一下是什么原理啊</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-64467">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://2.gravatar.com/avatar/b4a85b131f0514f4baa2bb7b0cfd226e?s=32&#038;d=mm&#038;r=g' srcset='http://2.gravatar.com/avatar/b4a85b131f0514f4baa2bb7b0cfd226e?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<a id="commentauthor-64467" class="url" href="http://pimfans.com/blog/" rel="external nofollow">
				
				pim.geek
									</a>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年7月11日16:43					 | <a href="#comment-64467">#15</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-64467', 'comment-64467', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-64467', 'comment-64467', 'commentbody-64467', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-64467">
					<p>真的太实用了！节约了我至少一个小时的时间去查阅文档！！</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-94906">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/9909d89575923919545d4258f14f9951?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/9909d89575923919545d4258f14f9951?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-94906">
				
				zyymcu
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2011年11月10日15:21					 | <a href="#comment-94906">#16</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-94906', 'comment-94906', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-94906', 'comment-94906', 'commentbody-94906', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-94906">
					<p>我out了 来晚了 不过这个确实屌爆了！</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-298803">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/c67da54be3b3a63b4a2d1d20c43ed8f7?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/c67da54be3b3a63b4a2d1d20c43ed8f7?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-298803">
				
				ludi
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2013年2月27日11:58					 | <a href="#comment-298803">#17</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-298803', 'comment-298803', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-298803', 'comment-298803', 'commentbody-298803', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-298803">
					<p>请教： 我的项目里面使用的是默认的文件名makefile, 并且是在顶层目录 make -C subdir 的形式执行。<br />
那应该怎样使用var.mk 呢？</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-329372">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/358664b6e231016840058b7337880b42?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/358664b6e231016840058b7337880b42?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-329372">
				
				tzh
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2013年4月17日23:08					 | <a href="#comment-329372">#18</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-329372', 'comment-329372', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-329372', 'comment-329372', 'commentbody-329372', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-329372">
					<p>太实用了~</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-546091">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/9a0f480829655eecafe0249c4b6b060d?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/9a0f480829655eecafe0249c4b6b060d?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<a id="commentauthor-546091" class="url" href="http://www.fakeraybans4sale.com" rel="external nofollow">
				
				replica Ray Bans sunglasses wholesale online
									</a>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2013年6月14日03:44					 | <a href="#comment-546091">#19</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-546091', 'comment-546091', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-546091', 'comment-546091', 'commentbody-546091', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-546091">
					<p>I love what you guys tend to be up too. Such clever work and reporting! Keep up the amazing works guys I&#8217;ve included you guys to my own blogroll.</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-1355381">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/c13e370b207643df5004611ddc16cf6e?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/c13e370b207643df5004611ddc16cf6e?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-1355381">
				
				成都_天空
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2014年3月10日18:05					 | <a href="#comment-1355381">#20</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-1355381', 'comment-1355381', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-1355381', 'comment-1355381', 'commentbody-1355381', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-1355381">
					<p>推荐使用 cmake更简单一些</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-1398415">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/783b8d7a58fb3bd33f9662a3f6bf832c?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/783b8d7a58fb3bd33f9662a3f6bf832c?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-1398415">
				
				fkxcole
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2014年3月20日17:13					 | <a href="#comment-1398415">#21</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-1398415', 'comment-1398415', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-1398415', 'comment-1398415', 'commentbody-1398415', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-1398415">
					<p>你好，在ubuntu13.10环境下测试失败，在home目录下建立test.mk和var.mk两个文本，内容完全复制过来，在shell中输入:<br />
  make -f test.mk -f var.mk OBJS<br />
输出显示：<br />
make: *** No rule to make target `OBJS&#8217;.  Stop.</p>
<p>我在man make 里也没有看到一行make语句使用两个-f的用法，请问怎么解决？ 初学linux,可能问题浅显，望解答。</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-1468689">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/46c8c8c1054ca4ad88b63a7a7ee1be38?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/46c8c8c1054ca4ad88b63a7a7ee1be38?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-1468689">
				
				nihao
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2014年5月25日00:17					 | <a href="#comment-1468689">#22</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-1468689', 'comment-1468689', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-1468689', 'comment-1468689', 'commentbody-1468689', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-1468689">
					<blockquote cite="#commentbody-1398415"><p>
<strong><a href="#comment-1398415" rel="nofollow">fkxcole</a> :</strong><br />
你好，在ubuntu13.10环境下测试失败，在home目录下建立test.mk和var.mk两个文本，内容完全复制过来，在shell中输入:<br />
  make -f test.mk -f var.mk OBJS<br />
输出显示：<br />
make: *** No rule to make target `OBJS’.  Stop.<br />
我在man make 里也没有看到一行make语句使用两个-f的用法，请问怎么解决？ 初学linux,可能问题浅显，望解答。
</p></blockquote>
<p>同样的问题</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-1702994">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://1.gravatar.com/avatar/7320a186d326c60aceb19d51bb4f2628?s=32&#038;d=mm&#038;r=g' srcset='http://1.gravatar.com/avatar/7320a186d326c60aceb19d51bb4f2628?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-1702994">
				
				shady
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2015年5月7日15:43					 | <a href="#comment-1702994">#23</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-1702994', 'comment-1702994', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-1702994', 'comment-1702994', 'commentbody-1702994', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-1702994">
					<p>好巧妙的一招，又学习了</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-1718963">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://2.gravatar.com/avatar/816973fc1a8df0443e8aed92199c4323?s=32&#038;d=mm&#038;r=g' srcset='http://2.gravatar.com/avatar/816973fc1a8df0443e8aed92199c4323?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-1718963">
				
				dogger
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2015年6月8日17:10					 | <a href="#comment-1718963">#24</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-1718963', 'comment-1718963', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-1718963', 'comment-1718963', 'commentbody-1718963', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-1718963">
					<p>只能得到当前显示加载的Makefile的值，无法打印Makefile递归后最终的值</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	<li class="comment regularcomment" id="comment-1724371">
		<div class="author">
			<div class="pic">
				<img alt='' src='http://0.gravatar.com/avatar/0f2764c04b25b0fd64b4f4a9e3d28658?s=32&#038;d=mm&#038;r=g' srcset='http://0.gravatar.com/avatar/0f2764c04b25b0fd64b4f4a9e3d28658?s=64&amp;d=mm&amp;r=g 2x' class='avatar avatar-32 photo' height='32' width='32' />			</div>
			<div class="name">
									<span id="commentauthor-1724371">
				
				snonez
									</span>
							</div>
		</div>

		<div class="info">
			<div class="date">
				2015年6月19日10:46					 | <a href="#comment-1724371">#25</a>
			</div>
			<div class="act">
				<a href="javascript:void(0);" onclick="MGJS_CMT.reply('commentauthor-1724371', 'comment-1724371', 'comment');">回复</a> | 
				<a href="javascript:void(0);" onclick="MGJS_CMT.quote('commentauthor-1724371', 'comment-1724371', 'commentbody-1724371', 'comment');">引用</a>
							</div>
			<div class="fixed"></div>
			<div class="content">
				
				<div id="commentbody-1724371">
					<p><a href="http://scc.qibebt.cas.cn/docs/linux/base/%B8%FA%CE%D2%D2%BB%C6%F0%D0%B4Makefile-%B3%C2%F0%A9.pdf" rel="nofollow">http://scc.qibebt.cas.cn/docs/linux/base/%B8%FA%CE%D2%D2%BB%C6%F0%D0%B4Makefile-%B3%C2%F0%A9.pdf</a>   耗子叔, google第一篇就是好心人整理的你的</p>
				</div>
			</div>
		</div>
		<div class="fixed"></div>

</li><!-- #comment-## -->
	</ol>
	<!-- comments END -->


	<!-- trackbacks START -->
			<ol id="thetrackbacks">
												<li class="trackback">
						<div class="date">
							2012年1月6日10:00							 | <a href="#comment-122078">#1</a>
						</div>
						<div class="act">
													</div>
						<div class="fixed"></div>
						<div class="title">
							<a href="http://flychen.com/article/how-to-learn-c-language-2.html">
								如何学好C++语言 | 搜索引擎技术博客							</a>
						</div>
					</li>
									<li class="trackback">
						<div class="date">
							2014年7月27日05:54							 | <a href="#comment-1501678">#2</a>
						</div>
						<div class="act">
													</div>
						<div class="fixed"></div>
						<div class="title">
							<a href="http://www.makaidong.com/cnblogs/3397.html">
								一个项目的Makefile编写及调试 &#8211; 博客园							</a>
						</div>
					</li>
									<li class="trackback">
						<div class="date">
							2015年3月8日12:49							 | <a href="#comment-1672055">#3</a>
						</div>
						<div class="act">
													</div>
						<div class="fixed"></div>
						<div class="title">
							<a href="http://www.jkeabc.com/p/564438.html">
								Linux下服务器端开发流程及相关工具介绍(C++) &#8211; 剑客|关注科技互联网							</a>
						</div>
					</li>
				
					</ol>
		<div class="fixed"></div>
	<!-- trackbacks END -->
</div>

</div>

	<form action="http://coolshell.cn/wp-comments-post.php" method="post" id="commentform">
	<div id="respond">

					
			<div id="author_info">
				<div class="row">
					<input type="text" name="author" id="author" class="textfield" value="" size="24" tabindex="1" />
					<label for="author" class="small">昵称 (必填)</label>
				</div>
				<div class="row">
					<input type="text" name="email" id="email" class="textfield" value="" size="24" tabindex="2" />
					<label for="email" class="small">电子邮箱 (我们会为您保密) (必填)</label>
				</div>
				<div class="row">
					<input type="text" name="url" id="url" class="textfield" value="" size="24" tabindex="3" />
					<label for="url" class="small">网址</label>
				</div>
			</div>

			
		
		<!-- comment input -->
		<div class="row">
			<textarea name="comment" id="comment" tabindex="4" rows="8" cols="50"></textarea>
		</div>

		<!-- comment submit and rss -->
		<div id="submitbox">
			<a class="feed" href="http://coolshell.cn/comments/feed">订阅评论</a>
			<div class="submitbutton">
				<input name="submit" type="submit" id="submit" class="button" tabindex="5" value="提交评论" />
			</div>
						<input type="hidden" name="comment_post_ID" value="3790" />
			<div class="fixed"></div>
		</div>

	</div>
	<p style="display: none;"><input type="hidden" id="akismet_comment_nonce" name="akismet_comment_nonce" value="6d06ab4666" /></p><p style="display: none;"><input type="hidden" id="ak_js" name="ak_js" value="5"/></p>	</form>

	

	<div id="postnavi">
		<span class="prev"><a href="http://coolshell.cn/articles/3801.html" rel="next">破解你的口令</a></span>
		<span class="next"><a href="http://coolshell.cn/articles/3738.html" rel="prev">打印质数的各种算法</a></span>
		<div class="fixed"></div>
	</div>


<script type='text/javascript'>
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-7486123-1']);
_gaq.push(['_trackPageview']);

	(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
</script>
	</div>
	<!-- main END -->

	
<!-- sidebar START -->
<div id="sidebar">

<!-- sidebar north START -->
<div id="northsidebar" class="sidebar">

	<!-- feeds -->
	<div class="widget widget_feeds">
		<div class="content">
			<div id="subscribe">
				<a rel="external nofollow" id="feedrss" title="订阅这个博客的文章" href="http://coolshell.cn/feed">订阅</a>
									<ul id="feed_readers">
						<li id="google_reader"><a rel="external nofollow" class="reader" title="订阅到 Google" href="http://fusion.google.com/add?feedurl=http://coolshell.cn/feed"><span> Google</span></a></li>
						<li id="youdao_reader"><a rel="external nofollow" class="reader" title="订阅到有道" href="http://reader.youdao.com/#url=http://coolshell.cn/feed"><span>有道</span></a></li>
						<li id="xianguo_reader"><a rel="external nofollow" class="reader" title="订阅到鲜果" href="http://www.xianguo.com/subscribe.php?url=http://coolshell.cn/feed"><span>鲜果</span></a></li>
						<li id="zhuaxia_reader"><a rel="external nofollow" class="reader" title="订阅到抓虾" href="http://www.zhuaxia.com/add_channel.php?url=http://coolshell.cn/feed"><span>抓虾</span></a></li>
						<li id="yahoo_reader"><a rel="external nofollow" class="reader" title="订阅到 My Yahoo!"	href="http://add.my.yahoo.com/rss?url=http://coolshell.cn/feed"><span> My Yahoo!</span></a></li>
						<li id="newsgator_reader"><a rel="external nofollow" class="reader" title="订阅到 newsgator"	href="http://www.newsgator.com/ngs/subscriber/subfext.aspx?url=http://coolshell.cn/feed"><span> newsgator</span></a></li>
						<li id="bloglines_reader"><a rel="external nofollow" class="reader" title="订阅到 Bloglines"	href="http://www.bloglines.com/sub/http://coolshell.cn/feed"><span> Bloglines</span></a></li>
						<li id="inezha_reader"><a rel="external nofollow" class="reader" title="订阅到哪吒"	href="http://inezha.com/add?url=http://coolshell.cn/feed"><span>哪吒</span></a></li>
<li id="qq_reader"><a class="reader" title="订阅到QQ Mail" onclick="window.open(this.href);return false;" rel="external nofollow" href="http://mail.qq.com/cgi-bin/feed?u=http://coolshell.cn/feed"><span>
			QQ Mail            </span></a></li>
            <li id="douban_reader"><a class="reader" title="订阅到Douban" onclick="window.open(this.href);return false;" rel="external nofollow" href="http://9.douban.com/reader/subscribe?url=http://coolshell.cn/feed"><span>
			Douban            </span></a></li>
            <li id="rojo_reader"><a class="reader" title="订阅到Rojo" onclick="window.open(this.href);return false;" rel="external nofollow" href="http://www.rojo.com/add-subscription?resource=http://coolshell.cn/feed"><span>
            Rojo            </span></a></li>
            <li id="pageflakes_reader"><a class="reader" title="订阅到Pageflakes" onclick="window.open(this.href);return false;" rel="external nofollow" href="http://www.pageflakes.com/subscribe.aspx?url=http://coolshell.cn/feed"><span>
            Pageflakes            </span></a></li>
					</ul>
							</div>
							<a id="followme" title="Follow me!" href="http://twitter.com/haoel/">Twitter</a>
						<div class="fixed"></div>
		</div>
	</div>

	<!-- showcase -->
			<div class="widget">
							<h3>本站公告</h3>
						<div class="content">
				<p align="center" style="background-color: #777;padding: 5px;color: white;font-weight: bold;border: solid 1px black;text-shadow: 0px 0px 3px black;">访问 <a href="http://coolshell.cn/404/" target=_blank style="color: #FFE249;">酷壳404页面</a> 寻找遗失儿童！</p>

<p>酷壳建议大家多使用RSS访问阅读（本站已经是全文输出，推荐使用cloud.feedly.com 或 digg.com）。有相关事宜欢迎电邮：haoel(at)hotmail.com。最后，感谢大家对酷壳的支持和体谅！</p>
			</div>
		</div>
	
		<div id="recent-posts-2" class="widget widget_recent_entries">		<h3>最新文章</h3>		<ul>
					<li>
				<a href="http://coolshell.cn/articles/17049.html">Docker基础技术：Linux CGroup</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/17010.html">Docker基础技术：Linux Namespace（上）</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/17029.html">Docker基础技术：Linux Namespace（下）</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/17066.html">关于移动端的钓鱼式攻击</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/16910.html">Linus：为何对象引用计数必须是原子的</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/12225.html">DHH 谈混合移动应用开发</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/12206.html">HTML6 展望</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/12136.html">Google Inbox如何跨平台重用代码？</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/12103.html">vfork 挂掉的一个问题</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/12052.html">Leetcode 编程训练</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/12012.html">State Threads 回调终结者</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11973.html">bash代码注入的安全漏洞</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11928.html">互联网之子 &#8211; Aaron Swartz</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11847.html">谜题的答案和活动的心得体会</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11832.html">【活动】解迷题送礼物</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11656.html">开发团队的效率</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11609.html">TCP 的那些事儿（下）</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11564.html">TCP 的那些事儿（上）</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11629.html">「我只是认真」聊聊工匠情怀</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11541.html">面向GC的Java编程</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11466.html">C语言的整型溢出问题</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11454.html">从LongAdder看更高效的无锁实现</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11432.html">从Code Review 谈如何做技术</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11377.html">C语言结构体里的成员数组和指针</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11312.html">无插件Vim编程技巧</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11265.html">Python修饰器的函数式编程</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11235.html">一个浮点数跨平台产生的问题</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11175.html">Java中的CopyOnWrite容器</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11170.html">如何用最有创造力的方式输出42</a>
						</li>
					<li>
				<a href="http://coolshell.cn/articles/11112.html">由苹果的低级Bug想到的</a>
						</li>
				</ul>
		</div><div id="views-4" class="widget widget_views"><h3>全站热门</h3><ul>
<li><a href="http://coolshell.cn/articles/4990.html"  title="程序员技术练级攻略 - 573,749 人阅读">程序员技术练级攻略</a></li><li><a href="http://coolshell.cn/articles/5426.html"  title="简明 Vim 练级攻略 - 487,735 人阅读">简明 Vim 练级攻略</a></li><li><a href="http://coolshell.cn/articles/7186.html"  title="做个环保主义的程序员 - 228,323 人阅读">做个环保主义的程序员</a></li><li><a href="http://coolshell.cn/articles/4102.html"  title="如何学好C语言 - 195,205 人阅读">如何学好C语言</a></li><li><a href="http://coolshell.cn/articles/8883.html"  title="应该知道的Linux技巧 - 156,758 人阅读">应该知道的Linux技巧</a></li><li><a href="http://coolshell.cn/articles/914.html"  title="6个变态的C语言Hello World程序 - 155,407 人阅读">6个变态的C语言Hello World程序</a></li><li><a href="http://coolshell.cn/articles/2250.html"  title="&ldquo;21天教你学会C++&rdquo; - 154,048 人阅读">&ldquo;21天教你学会C++&rdquo;</a></li><li><a href="http://coolshell.cn/articles/9070.html"  title="AWK 简明教程 - 146,709 人阅读">AWK 简明教程</a></li><li><a href="http://coolshell.cn/articles/6470.html"  title="由12306.cn谈谈网站性能技术 - 142,823 人阅读">由12306.cn谈谈网站性能技术</a></li><li><a href="http://coolshell.cn/articles/9308.html"  title="&ldquo;作环保的程序员，从不用百度开始&rdquo; - 138,364 人阅读">&ldquo;作环保的程序员，从不用百度开始&rdquo;</a></li><li><a href="http://coolshell.cn/articles/10688.html"  title="编程能力与编程年龄 - 136,450 人阅读">编程能力与编程年龄</a></li><li><a href="http://coolshell.cn/articles/7829.html"  title="28个Unix/Linux的命令行神器 - 130,384 人阅读">28个Unix/Linux的命令行神器</a></li><li><a href="http://coolshell.cn/articles/1870.html"  title="我是怎么招聘程序员的 - 129,916 人阅读">我是怎么招聘程序员的</a></li><li><a href="http://coolshell.cn/articles/11564.html"  title="TCP 的那些事儿（上） - 126,877 人阅读">TCP 的那些事儿（上）</a></li><li><a href="http://coolshell.cn/articles/6043.html"  title="Web开发中需要了解的东西 - 115,485 人阅读">Web开发中需要了解的东西</a></li><li><a href="http://coolshell.cn/articles/3549.html"  title="Android将允许纯C/C++开发应用 - 113,873 人阅读">Android将允许纯C/C++开发应用</a></li><li><a href="http://coolshell.cn/articles/2287.html"  title="C++ 程序员自信心曲线图 - 110,204 人阅读">C++ 程序员自信心曲线图</a></li><li><a href="http://coolshell.cn/articles/7490.html"  title="性能调优攻略 - 106,875 人阅读">性能调优攻略</a></li><li><a href="http://coolshell.cn/articles/4119.html"  title="如何学好C++语言 - 105,353 人阅读">如何学好C++语言</a></li><li><a href="http://coolshell.cn/articles/9104.html"  title="sed 简明教程 - 103,399 人阅读">sed 简明教程</a></li><li><a href="http://coolshell.cn/articles/4758.html"  title="如何写出无法维护的代码 - 102,531 人阅读">如何写出无法维护的代码</a></li><li><a href="http://coolshell.cn/articles/355.html"  title="20本最好的Linux免费书籍 - 99,895 人阅读">20本最好的Linux免费书籍</a></li><li><a href="http://coolshell.cn/articles/1391.html"  title="编程真难啊 - 98,056 人阅读">编程真难啊</a></li><li><a href="http://coolshell.cn/articles/3008.html"  title="Windows编程革命简史 - 95,975 人阅读">Windows编程革命简史</a></li><li><a href="http://coolshell.cn/articles/5761.html"  title="深入理解C语言 - 94,356 人阅读">深入理解C语言</a></li><li><a href="http://coolshell.cn/articles/10217.html"  title="加班与效率 - 91,245 人阅读">加班与效率</a></li><li><a href="http://coolshell.cn/articles/1846.html"  title="MySQL性能优化的最佳20+条经验 - 90,783 人阅读">MySQL性能优化的最佳20+条经验</a></li><li><a href="http://coolshell.cn/articles/5701.html"  title="SteveY对Amazon和Google平台的吐槽 - 90,309 人阅读">SteveY对Amazon和Google平台的吐槽</a></li><li><a href="http://coolshell.cn/articles/945.html"  title="C语言的谜题 - 88,780 人阅读">C语言的谜题</a></li><li><a href="http://coolshell.cn/articles/2058.html"  title="各种流行的编程风格 - 88,396 人阅读">各种流行的编程风格</a></li></ul>
</div><div id="text-400151743" class="widget widget_text"><h3>新浪微博</h3>			<div class="textwidget"><iframe width="100%" height="120" class="share_self"  frameborder="0" scrolling="no" src="http://widget.weibo.com/weiboshow/index.php?language=&width=0&height=550&fansRow=2&ptype=1&speed=0&skin=1&isTitle=1&noborder=1&isWeibo=0&isFans=0&uid=1401880315&verifier=f47cc89f&dpc=1"></iframe></div>
		</div><div id="tag_cloud-2" class="widget widget_tag_cloud"><h3>标签</h3><div class="tagcloud"><a href='http://coolshell.cn/tag/agile' class='tag-link-17' title='15个话题' style='font-size: 11.8532110092pt;'>agile</a>
<a href='http://coolshell.cn/tag/ajax' class='tag-link-34' title='11个话题' style='font-size: 10.3119266055pt;'>AJAX</a>
<a href='http://coolshell.cn/tag/algorithm' class='tag-link-76' title='25个话题' style='font-size: 14.5504587156pt;'>Algorithm</a>
<a href='http://coolshell.cn/tag/android' class='tag-link-145' title='11个话题' style='font-size: 10.3119266055pt;'>Android</a>
<a href='http://coolshell.cn/tag/bash' class='tag-link-190' title='9个话题' style='font-size: 9.28440366972pt;'>Bash</a>
<a href='http://coolshell.cn/tag/c' class='tag-link-59' title='90个话题' style='font-size: 21.6146788991pt;'>C++</a>
<a href='http://coolshell.cn/tag/coding' class='tag-link-135' title='25个话题' style='font-size: 14.5504587156pt;'>Coding</a>
<a href='http://coolshell.cn/tag/css' class='tag-link-96' title='21个话题' style='font-size: 13.6513761468pt;'>CSS</a>
<a href='http://coolshell.cn/tag/database' class='tag-link-109' title='7个话题' style='font-size: 8pt;'>Database</a>
<a href='http://coolshell.cn/tag/design' class='tag-link-71' title='18个话题' style='font-size: 12.880733945pt;'>Design</a>
<a href='http://coolshell.cn/tag/design-pattern' class='tag-link-25' title='8个话题' style='font-size: 8.64220183486pt;'>design pattern</a>
<a href='http://coolshell.cn/tag/ebook' class='tag-link-101' title='15个话题' style='font-size: 11.8532110092pt;'>ebook</a>
<a href='http://coolshell.cn/tag/flash' class='tag-link-98' title='7个话题' style='font-size: 8pt;'>Flash</a>
<a href='http://coolshell.cn/tag/game' class='tag-link-125' title='9个话题' style='font-size: 9.28440366972pt;'>Game</a>
<a href='http://coolshell.cn/tag/go' class='tag-link-238' title='9个话题' style='font-size: 9.28440366972pt;'>Go</a>
<a href='http://coolshell.cn/tag/google' class='tag-link-32' title='32个话题' style='font-size: 15.9633027523pt;'>Google</a>
<a href='http://coolshell.cn/tag/html' class='tag-link-38' title='33个话题' style='font-size: 16.0917431193pt;'>HTML</a>
<a href='http://coolshell.cn/tag/ie' class='tag-link-175' title='10个话题' style='font-size: 9.79816513761pt;'>IE</a>
<a href='http://coolshell.cn/tag/java' class='tag-link-13' title='48个话题' style='font-size: 18.1467889908pt;'>Java</a>
<a href='http://coolshell.cn/tag/javascript' class='tag-link-114' title='51个话题' style='font-size: 18.5321100917pt;'>Javascript</a>
<a href='http://coolshell.cn/tag/jquery' class='tag-link-191' title='11个话题' style='font-size: 10.3119266055pt;'>jQuery</a>
<a href='http://coolshell.cn/tag/linux' class='tag-link-37' title='63个话题' style='font-size: 19.6880733945pt;'>Linux</a>
<a href='http://coolshell.cn/tag/mysql' class='tag-link-106' title='7个话题' style='font-size: 8pt;'>MySQL</a>
<a href='http://coolshell.cn/tag/oop' class='tag-link-245' title='8个话题' style='font-size: 8.64220183486pt;'>OOP</a>
<a href='http://coolshell.cn/tag/password' class='tag-link-319' title='8个话题' style='font-size: 8.64220183486pt;'>password</a>
<a href='http://coolshell.cn/tag/performance' class='tag-link-120' title='15个话题' style='font-size: 11.8532110092pt;'>Performance</a>
<a href='http://coolshell.cn/tag/php' class='tag-link-35' title='25个话题' style='font-size: 14.5504587156pt;'>PHP</a>
<a href='http://coolshell.cn/tag/programmer' class='tag-link-70' title='94个话题' style='font-size: 21.871559633pt;'>Programmer</a>
<a href='http://coolshell.cn/tag/programming' class='tag-link-499' title='8个话题' style='font-size: 8.64220183486pt;'>Programming</a>
<a href='http://coolshell.cn/tag/programming-language' class='tag-link-115' title='12个话题' style='font-size: 10.6972477064pt;'>programming language</a>
<a href='http://coolshell.cn/tag/puzzle' class='tag-link-514' title='11个话题' style='font-size: 10.3119266055pt;'>Puzzle</a>
<a href='http://coolshell.cn/tag/pythondev' class='tag-link-33' title='29个话题' style='font-size: 15.4495412844pt;'>Python</a>
<a href='http://coolshell.cn/tag/ruby' class='tag-link-69' title='10个话题' style='font-size: 9.79816513761pt;'>Ruby</a>
<a href='http://coolshell.cn/tag/sql' class='tag-link-131' title='10个话题' style='font-size: 9.79816513761pt;'>SQL</a>
<a href='http://coolshell.cn/tag/tdd' class='tag-link-485' title='8个话题' style='font-size: 8.64220183486pt;'>TDD</a>
<a href='http://coolshell.cn/tag/ui' class='tag-link-47' title='12个话题' style='font-size: 10.6972477064pt;'>UI</a>
<a href='http://coolshell.cn/tag/unix' class='tag-link-21' title='33个话题' style='font-size: 16.0917431193pt;'>Unix</a>
<a href='http://coolshell.cn/tag/vim' class='tag-link-50' title='19个话题' style='font-size: 13.1376146789pt;'>vim</a>
<a href='http://coolshell.cn/tag/web' class='tag-link-30' title='40个话题' style='font-size: 17.119266055pt;'>Web</a>
<a href='http://coolshell.cn/tag/windows' class='tag-link-49' title='17个话题' style='font-size: 12.623853211pt;'>Windows</a>
<a href='http://coolshell.cn/tag/xml' class='tag-link-104' title='8个话题' style='font-size: 8.64220183486pt;'>XML</a>
<a href='http://coolshell.cn/tag/%e5%ae%89%e5%85%a8' class='tag-link-318' title='19个话题' style='font-size: 13.1376146789pt;'>安全</a>
<a href='http://coolshell.cn/tag/%e7%a8%8b%e5%ba%8f%e5%91%98' class='tag-link-58' title='96个话题' style='font-size: 22pt;'>程序员</a>
<a href='http://coolshell.cn/tag/%e7%ae%97%e6%b3%95' class='tag-link-77' title='10个话题' style='font-size: 9.79816513761pt;'>算法</a>
<a href='http://coolshell.cn/tag/interview' class='tag-link-164' title='16个话题' style='font-size: 12.2385321101pt;'>面试</a></div>
</div></div>
<!-- sidebar north END -->

<div id="centersidebar">

	<!-- sidebar east START -->
	<div id="eastsidebar" class="sidebar">
	<div id="categories-367921423" class="widget widget_categories"><h3>分类目录</h3>		<ul>
	<li class="cat-item cat-item-189"><a href="http://coolshell.cn/category/proglanguage/dotnet" >.NET编程</a> (3)
</li>
	<li class="cat-item cat-item-8"><a href="http://coolshell.cn/category/proglanguage/ajaxdev" >Ajax开发</a> (9)
</li>
	<li class="cat-item cat-item-5"><a href="http://coolshell.cn/category/proglanguage/cplusplus" >C/C++语言</a> (70)
</li>
	<li class="cat-item cat-item-186"><a href="http://coolshell.cn/category/proglanguage/erlang" >Erlang</a> (1)
</li>
	<li class="cat-item cat-item-4"><a href="http://coolshell.cn/category/proglanguage/javadev" >Java语言</a> (32)
</li>
	<li class="cat-item cat-item-11"><a href="http://coolshell.cn/category/proglanguage/phpdev" >PHP脚本</a> (11)
</li>
	<li class="cat-item cat-item-33"><a href="http://coolshell.cn/category/proglanguage/pythondev" >Python</a> (23)
</li>
	<li class="cat-item cat-item-100"><a href="http://coolshell.cn/category/proglanguage/rubydev" >Ruby</a> (5)
</li>
	<li class="cat-item cat-item-20"><a href="http://coolshell.cn/category/operatingsystem/unixlinux" >Unix/Linux</a> (72)
</li>
	<li class="cat-item cat-item-7"><a href="http://coolshell.cn/category/proglanguage/webdev" >Web开发</a> (103)
</li>
	<li class="cat-item cat-item-19"><a href="http://coolshell.cn/category/operatingsystem/mswindows" >Windows</a> (12)
</li>
	<li class="cat-item cat-item-195"><a href="http://coolshell.cn/category/itnews" >业界新闻</a> (26)
</li>
	<li class="cat-item cat-item-509"><a href="http://coolshell.cn/category/%e4%bc%81%e4%b8%9a%e5%ba%94%e7%94%a8" >企业应用</a> (2)
</li>
	<li class="cat-item cat-item-9"><a href="http://coolshell.cn/category/technews" >技术新闻</a> (33)
</li>
	<li class="cat-item cat-item-550"><a href="http://coolshell.cn/category/%e6%8a%80%e6%9c%af%e7%ae%a1%e7%90%86" >技术管理</a> (12)
</li>
	<li class="cat-item cat-item-12"><a href="http://coolshell.cn/category/techarticle" >技术读物</a> (117)
</li>
	<li class="cat-item cat-item-18"><a href="http://coolshell.cn/category/operatingsystem" >操作系统</a> (47)
</li>
	<li class="cat-item cat-item-105"><a href="http://coolshell.cn/category/datebase" >数据库</a> (10)
</li>
	<li class="cat-item cat-item-10"><a href="http://coolshell.cn/category/misc" >杂项资源</a> (264)
</li>
	<li class="cat-item cat-item-15"><a href="http://coolshell.cn/category/process" >流程方法</a> (46)
</li>
	<li class="cat-item cat-item-23"><a href="http://coolshell.cn/category/progdesign" >程序设计</a> (83)
</li>
	<li class="cat-item cat-item-602"><a href="http://coolshell.cn/category/%e7%b3%bb%e7%bb%9f%e6%9e%b6%e6%9e%84" >系统架构</a> (8)
</li>
	<li class="cat-item cat-item-1"><a href="http://coolshell.cn/category/tools" >编程工具</a> (65)
</li>
	<li class="cat-item cat-item-3"><a href="http://coolshell.cn/category/proglanguage" >编程语言</a> (174)
</li>
	<li class="cat-item cat-item-6"><a href="http://coolshell.cn/category/netsecurity" >网络安全</a> (27)
</li>
	<li class="cat-item cat-item-39"><a href="http://coolshell.cn/category/career" >职场生涯</a> (33)
</li>
	<li class="cat-item cat-item-271"><a href="http://coolshell.cn/category/funny" >趣味问题</a> (18)
</li>
	<li class="cat-item cat-item-52"><a href="http://coolshell.cn/category/story" >轶事趣闻</a> (147)
</li>
		</ul>
</div>	</div>
	<!-- sidebar east END -->

	<!-- sidebar west START -->
	<div id="westsidebar" class="sidebar">
	<div id="archives-2" class="widget widget_archive"><h3>归档</h3>		<ul>
	<li><a href='http://coolshell.cn/articles/date/2015/04'>2015年四月</a>&nbsp;(4)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/12'>2014年十二月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/11'>2014年十一月</a>&nbsp;(2)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/10'>2014年十月</a>&nbsp;(2)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/09'>2014年九月</a>&nbsp;(2)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/08'>2014年八月</a>&nbsp;(2)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/06'>2014年六月</a>&nbsp;(1)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/05'>2014年五月</a>&nbsp;(4)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/04'>2014年四月</a>&nbsp;(4)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/03'>2014年三月</a>&nbsp;(5)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/02'>2014年二月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2014/01'>2014年一月</a>&nbsp;(2)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/12'>2013年十二月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/11'>2013年十一月</a>&nbsp;(1)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/10'>2013年十月</a>&nbsp;(6)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/08'>2013年八月</a>&nbsp;(1)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/07'>2013年七月</a>&nbsp;(8)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/06'>2013年六月</a>&nbsp;(2)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/05'>2013年五月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/04'>2013年四月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/03'>2013年三月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/02'>2013年二月</a>&nbsp;(5)</li>
	<li><a href='http://coolshell.cn/articles/date/2013/01'>2013年一月</a>&nbsp;(1)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/12'>2012年十二月</a>&nbsp;(4)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/11'>2012年十一月</a>&nbsp;(4)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/10'>2012年十月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/09'>2012年九月</a>&nbsp;(4)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/08'>2012年八月</a>&nbsp;(8)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/07'>2012年七月</a>&nbsp;(4)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/06'>2012年六月</a>&nbsp;(7)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/05'>2012年五月</a>&nbsp;(6)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/04'>2012年四月</a>&nbsp;(6)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/03'>2012年三月</a>&nbsp;(6)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/02'>2012年二月</a>&nbsp;(3)</li>
	<li><a href='http://coolshell.cn/articles/date/2012/01'>2012年一月</a>&nbsp;(6)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/12'>2011年十二月</a>&nbsp;(5)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/11'>2011年十一月</a>&nbsp;(9)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/10'>2011年十月</a>&nbsp;(6)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/09'>2011年九月</a>&nbsp;(5)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/08'>2011年八月</a>&nbsp;(14)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/07'>2011年七月</a>&nbsp;(6)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/06'>2011年六月</a>&nbsp;(12)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/05'>2011年五月</a>&nbsp;(5)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/04'>2011年四月</a>&nbsp;(18)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/03'>2011年三月</a>&nbsp;(16)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/02'>2011年二月</a>&nbsp;(16)</li>
	<li><a href='http://coolshell.cn/articles/date/2011/01'>2011年一月</a>&nbsp;(18)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/12'>2010年十二月</a>&nbsp;(11)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/11'>2010年十一月</a>&nbsp;(11)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/10'>2010年十月</a>&nbsp;(19)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/09'>2010年九月</a>&nbsp;(15)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/08'>2010年八月</a>&nbsp;(10)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/07'>2010年七月</a>&nbsp;(20)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/06'>2010年六月</a>&nbsp;(9)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/05'>2010年五月</a>&nbsp;(13)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/04'>2010年四月</a>&nbsp;(12)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/03'>2010年三月</a>&nbsp;(11)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/02'>2010年二月</a>&nbsp;(7)</li>
	<li><a href='http://coolshell.cn/articles/date/2010/01'>2010年一月</a>&nbsp;(9)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/12'>2009年十二月</a>&nbsp;(22)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/11'>2009年十一月</a>&nbsp;(27)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/10'>2009年十月</a>&nbsp;(17)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/09'>2009年九月</a>&nbsp;(14)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/08'>2009年八月</a>&nbsp;(21)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/07'>2009年七月</a>&nbsp;(18)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/06'>2009年六月</a>&nbsp;(19)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/05'>2009年五月</a>&nbsp;(27)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/04'>2009年四月</a>&nbsp;(53)</li>
	<li><a href='http://coolshell.cn/articles/date/2009/03'>2009年三月</a>&nbsp;(43)</li>
	<li><a href='http://coolshell.cn/articles/date/2008/10'>2008年十月</a>&nbsp;(1)</li>
	<li><a href='http://coolshell.cn/articles/date/2007/12'>2007年十二月</a>&nbsp;(1)</li>
	<li><a href='http://coolshell.cn/articles/date/2006/11'>2006年十一月</a>&nbsp;(1)</li>
	<li><a href='http://coolshell.cn/articles/date/2004/06'>2004年六月</a>&nbsp;(1)</li>
		</ul>
</div>	</div>
	<!-- sidebar west END -->
	<div class="fixed"></div>
</div>

<!-- sidebar south START -->
<div id="southsidebar" class="sidebar">
<div id="get-recent-comments" class="widget widget_get_recent_comments"><h3>最新评论</h3><div id="get_recent_comments_wrap"><ul>	<li><a href="http://coolshell.cn/articles/4990.html#comment-1744509" title="程序员技术练级攻略, 2011年07月18日">TK</a>: @风云再起 这就是些基础知识……</li>
	<li><a href="http://coolshell.cn/articles/8990.html#comment-1743918" title="Linus：利用二级指针删除单向链表, 2013年02月04日">cscareer</a>: @0xFFFFFFFF 如果构造dummy head H很费呢？</li>
	<li><a href="http://coolshell.cn/guestbook#comment-1743634" title="留言小本, 2009年03月02日">usuria</a>: Pus de padamiya lu:pas. datania uluba dosa erpz uukorutu:ab, soo mula</li>
	<li><a href="http://coolshell.cn/articles/945.html#comment-1743624" title="C语言的谜题, 2009年05月31日">seamaner</a>: 10题编译不过，而且最后有个';&#8217;，一行中能接连 犯那么多错也不容易。^_^. ps. 《 C陷阱与缺陷》、《C专家》也有不少有意思的题目。</li>
	<li><a href="http://coolshell.cn/articles/9308.html#comment-1743476" title="“作环保的程序员，从不用百度开始”, 2013年03月23日">支持博主</a>: 百度确实差谷歌太多了，知乎上对百度的评价都蛮中肯的</li>
	<li><a href="http://coolshell.cn/articles/17049.html#comment-1743411" title="Docker基础技术：Linux CGroup, 2015年04月17日">sssxdfdsf</a>: </li>
	<li><a href="http://coolshell.cn/about#comment-1743380" title="关于酷壳, 2009年04月08日">iEason</a>: 给力!</li>
	<li><a href="http://coolshell.cn/articles/7186.html#comment-1743352" title="做个环保主义的程序员, 2012年04月27日">hhy</a>: 写的太好了！！</li>
	<li><a href="http://coolshell.cn/articles/17049.html#comment-1743347" title="Docker基础技术：Linux CGroup, 2015年04月17日">宁波叉车租赁</a>: 谢谢楼主分享。。。。</li>
	<li><a href="http://coolshell.cn/articles/11564.html#comment-1743331" title="TCP 的那些事儿（上）, 2014年05月28日">josehp</a>: @dd 我明白了，他的意思是，2号包没收到，6号，11号，20号也没 收到，那发送方传输完2号包剩下的就不知道还少哪个包了。</li>
	<li><a href="http://coolshell.cn/articles/11564.html#comment-1743330" title="TCP 的那些事儿（上）, 2014年05月28日">josehp</a>: @dd 我也是这么想的</li>
	<li><a href="http://coolshell.cn/articles/5265.html#comment-1743234" title=" C++11 中值得关注的几大变化（详解）, 2011年08月19日">caichai2004</a>: 好文章，可惜从今天看，C++11还是没普及，至少chromi um里面还没体现</li>
	<li><a href="http://coolshell.cn/articles/10590.html#comment-1743090" title="二维码的生成细节和原理, 2013年10月29日">xiaofei</a>: 刚看到，上面说的那个网站好像几年前有人提到了，这个网站也还不 错：http://www.swetake.com/qrcod e/qr1_en.html</li>
	<li><a href="http://coolshell.cn/articles/10590.html#comment-1743070" title="二维码的生成细节和原理, 2013年10月29日">xiaofei</a>: 本人发现了一个网站，在QR二维码生成方面讲述地很详细，对生成 完整的QR二维码很有帮助！不过是英文滴，http://www .thonky.com/qr-code-tutorial/i ntroduction</li>
	<li><a href="http://coolshell.cn/articles/5815.html#comment-1742910" title="来信， 创业 和 移动互联网, 2011年11月15日">macaw</a>: 范凯不是csdn的老总吧，csdn是西门子帮，所以只有西门子 的人能晋升到高层。记得不那么清了，应当就是西门子</li>
</ul></div></div><div id="text-2" class="widget widget_text"><h3>友情链接</h3>			<div class="textwidget"><ul class='blogroll'>
<li><a href="http://blog.csdn.net/haoel" target="_blank" onclick="pageTracker._trackPageview('/outgoing/blog.csdn.net/haoel?referer=http://coolshell.cn');">陈皓的博客</a></li>

<li><a href="http://ifeve.com/" target="_blank" title="促进并发编程的研究和推广" onclick="pageTracker._trackPageview('/outgoing/ifeve.com/?referer=http://coolshell.cn');">并发编程</a></li>


<li><a href="http://www.raychase.net/" target="_blank" title="一个啰嗦的程序员" onclick="pageTracker._trackPageview('/outgoing/www.raychase.net/?referer=http://coolshell.cn');">四火的唠叨</a></li>



<li><a href="http://www.hellogcc.org/" target=_blank title="致力于讨论和学习GNU Toolchain方面的工作组" onclick="pageTracker._trackPageview('/outgoing/www.hellogcc.org//?referer=http://coolshell.cn/');">HelloGcc Working Group</a></li>

<li><a href="http://pangee.cn/" target=_blank title="一名在路上的程序员" onclick="pageTracker._trackPageview('/outgoing/http://blog.lvscar.info/?referer=http://coolshell.cn/');">吕毅的Blog</a></li>

<li><a href="http://www.cnblogs.com/weidagang2046/" target=_blank title="Just for Fun" onclick="pageTracker._trackPageview('/outgoing/http://www.cnblogs.com/weidagang2046/?referer=http://coolshell.cn/');">Todd Wei的Blog</a></li>

<li><a href="http://www.cppfans.org/" target=_blank title="记录我们点滴学习工作生活" onclick="pageTracker._trackPageview('/outgoing/http://www.cppfans.org/?referer=http://coolshell.cn/');">C++爱好者博客</a></li>

<li><a href="http://www.mhtml5.com/" target=_blank title="致力于HTML5在中国的发展与应用" onclick="pageTracker._trackPageview('/outgoing/http://www.mhtml5.com/?referer=http://coolshell.cn/');">HTML5研究小组</a></li>


<li><a href="http://zhuwenhao.com/" target=_blank title="朱文昊的中文博客－－专注技术，向往自由" onclick="pageTracker._trackPageview('/outgoing/http://zhuwenhao.com/?referer=http://coolshell.cn/');">朱文昊Albert Zhu</a></li>


<li><a href="http://www.cguage.com/" target=_blank title="某VC++软件开发爱好者" onclick="pageTracker._trackPageview('/outgoing/http://www.cguage.com/?referer=http://coolshell.cn/');">C瓜哥的博客</a></li>


<li><a href="http://www.kaiyuanba.cn/" target=_blank title="汇聚各种开源项目的中英文混合介绍并分类排列，致力于软件项目的开源事业" onclick="pageTracker._trackPageview('/outgoing/http://www.kaiyuanba.cn/?referer=http://coolshell.cn/');">开源吧</a></li>



<li><a href="http://HelloACM.com/" target=_blank title="Smart Ideas, Smart Algorithms" onclick="pageTracker._trackPageview('/outgoing/http://HelloACM.com/?referer=http://coolshell.cn/');">ACMer</a></li>

<li><a href="http://chenpeng.info/" target=_blank title="优秀的开源软件让生活更简单" onclick="pageTracker._trackPageview('/outgoing/http://chenpeng.info/?referer=http://coolshell.cn/');">陈鹏个人博客</a></li>

<li><a href="http://www.coderli.com/" target=_blank title="一个普通的coder，coding为了生活，coding因为消遣:-) Just a coder" onclick="pageTracker._trackPageview('/outgoing/http://www.coderli.com/?referer=http://coolshell.cn/');">OneCoder</a></li>

<li><a href="http://www.vimer.me/" target=_blank title="Geek for Tech、Design、Product" onclick="pageTracker._trackPageview('/outgoing/http://www.vimer.me/?referer=http://coolshell.cn/');">More Than Vimer</a></li>

<li><a href="http://www.yunweipai.com" target=_blank title="关注IT技术 | 分享 | 交流 | 记录" onclick="pageTracker._trackPageview('/outgoing/http://www.yunweipai.com/?referer=http://coolshell.cn/');">运维派 </a></li>

<li><a href="http://www.ishuchao.com/" target=_blank title="闲置纸质书的在线漂流平台" onclick="pageTracker._trackPageview('/outgoing/http://www.ishuchao.com/?referer=http://coolshell.cn/');">书巢</a></li></div>
		</div><div id="meta-3" class="widget widget_meta"><h3>功能</h3>			<ul>
			<li><a href="http://coolshell.cn/wp-login.php?action=register">注册</a></li>			<li><a href="http://coolshell.cn/wp-login.php">登录</a></li>
			<li><a href="http://coolshell.cn/feed">文章<abbr title="Really Simple Syndication">RSS</abbr></a></li>
			<li><a href="http://coolshell.cn/comments/feed">评论<abbr title="Really Simple Syndication">RSS</abbr></a></li>
<li><a href="https://cn.wordpress.org/" title="基于WordPress，一个优美、先进的个人信息发布平台。">WordPress.org</a></li>			</ul>
</div><div id="text-400151742" class="widget widget_text">			<div class="textwidget"><script src="http://s50.cnzz.com/stat.php?id=1785679&web_id=1785679&show=pic1" language="JavaScript" charset="gb2312"></script>



</div>
		</div></div>
<!-- sidebar south END -->

</div>
<!-- sidebar END -->
	<div class="fixed"></div>
</div>
<!-- content END -->

<!-- footer START -->
<div id="footer">
	<a id="gotop" href="#" onclick="MGJS.goTop();return false;">回到顶部</a>
	<a id="powered" href="http://wordpress.org/">WordPress</a>
	<div id="copyright">
		版权所有 &copy; 2004-2015 酷 壳 &#8211; CoolShell.cn	</div>
	<div id="themeinfo">
		主题由 <a href="http://www.neoease.com/">NeoEase</a> 提供, 通过 <a href="http://validator.w3.org/check?uri=referer">XHTML 1.1</a> 和 <a href="http://jigsaw.w3.org/css-validator/check/referer?profile=css3">CSS 3</a> 验证.	</div>
</div>
<!-- footer END -->

</div>
<!-- container END -->
</div>
<!-- wrap END -->

<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shCore.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushCSharp.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushPhp.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushJScript.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushJava.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushVb.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushSql.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushXml.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushDelphi.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushPython.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushRuby.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushCss.js"></script>
<script class="javascript" src="http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/shBrushCpp.js"></script>
<script class="javascript">
dp.SyntaxHighlighter.ClipboardSwf = 'http://coolshell.cn//wp-content/plugins/google-syntax-highlighter/Scripts/clipboard.swf';
dp.SyntaxHighlighter.HighlightAll('code');
</script>
    <!-- Start of StatCounter Code -->
    <script>
    <!-- 
        var sc_project=8326668; 
        var sc_security="cccb27f2"; 
      var sc_invisible=1;
        var scJsHost = (("https:" == document.location.protocol) ?
        "https://secure." : "http://www.");
    //-->
document.write("<sc"+"ript src='" +scJsHost +"statcounter.com/counter/counter.js'></"+"script>");
</script>
<noscript><div class="statcounter"><a title="web analytics" href="http://statcounter.com/"><img class="statcounter" src="http://c.statcounter.com/8326668/0/cccb27f2/1/" alt="web analytics" /></a></div></noscript>   
    <!-- End of StatCounter Code -->
<!-- Powered by WPtouch: 3.8.3 --><script type='text/javascript' src='http://coolshell.cn//wp-content/plugins/akismet/_inc/form.js?ver=3.1.3'></script>
<script type='text/javascript' src='http://coolshell.cn//wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/scripts/shCore.js?ver=3.0.9b'></script>
<script type='text/javascript' src='http://coolshell.cn//wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/scripts/shBrushBash.js?ver=3.0.9b'></script>
<script type='text/javascript'>
	(function(){
		var corecss = document.createElement('link');
		var themecss = document.createElement('link');
		var corecssurl = "http://coolshell.cn//wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/styles/shCore.css?ver=3.0.9b";
		if ( corecss.setAttribute ) {
				corecss.setAttribute( "rel", "stylesheet" );
				corecss.setAttribute( "type", "text/css" );
				corecss.setAttribute( "href", corecssurl );
		} else {
				corecss.rel = "stylesheet";
				corecss.href = corecssurl;
		}
		document.getElementsByTagName("head")[0].insertBefore( corecss, document.getElementById("syntaxhighlighteranchor") );
		var themecssurl = "http://coolshell.cn//wp-content/plugins/syntaxhighlighter/syntaxhighlighter3/styles/shThemeDefault.css?ver=3.0.9b";
		if ( themecss.setAttribute ) {
				themecss.setAttribute( "rel", "stylesheet" );
				themecss.setAttribute( "type", "text/css" );
				themecss.setAttribute( "href", themecssurl );
		} else {
				themecss.rel = "stylesheet";
				themecss.href = themecssurl;
		}
		//document.getElementById("syntaxhighlighteranchor").appendChild(themecss);
		document.getElementsByTagName("head")[0].insertBefore( themecss, document.getElementById("syntaxhighlighteranchor") );
	})();
	SyntaxHighlighter.config.strings.expandSource = '+ expand source';
	SyntaxHighlighter.config.strings.help = '帮助';
	SyntaxHighlighter.config.strings.alert = 'SyntaxHighlighter\n\n';
	SyntaxHighlighter.config.strings.noBrush = '无法找到Brush：';
	SyntaxHighlighter.config.strings.brushNotHtmlScript = 'Brush不能设置 html-script选项';
	SyntaxHighlighter.defaults['class-name'] = 'coolshell_syntaxhighlighter';
	SyntaxHighlighter.defaults['pad-line-numbers'] = false;
	SyntaxHighlighter.defaults['toolbar'] = false;
	SyntaxHighlighter.all();
</script>
<script type='text/javascript'>
/* <![CDATA[ */
var ratingsL10n = {"plugin_url":"http:\/\/coolshell.cn\/wp-content\/plugins\/wp-postratings","ajax_url":"http:\/\/coolshell.cn\/wp-admin\/admin-ajax.php","text_wait":"Please rate only 1 post at a time.","image":"stars_crystal","image_ext":"gif","max":"5","show_loading":"1","show_fading":"1","custom":"0"};
var ratings_mouseover_image=new Image();ratings_mouseover_image.src=ratingsL10n.plugin_url+"/images/"+ratingsL10n.image+"/rating_over."+ratingsL10n.image_ext;;
/* ]]> */
</script>
<script type='text/javascript' src='http://coolshell.cn//wp-content/plugins/wp-postratings/postratings-js.js?ver=1.81'></script>
<script type='text/javascript'>
/* <![CDATA[ */
var viewsCacheL10n = {"admin_ajax_url":"http:\/\/coolshell.cn\/wp-admin\/admin-ajax.php","post_id":"3790"};
/* ]]> */
</script>
<script type='text/javascript' src='http://coolshell.cn//wp-content/plugins/wp-postviews/postviews-cache.js?ver=1.68'></script>
<script src="http://s50.cnzz.com/stat.php?id=1785679&web_id=1785679&show=pic1" language="JavaScript" charset="gb2312"></script>


</body>
</html>


<script src="http://coolshell.cn//wp-content/themes/inove/js/1.9.0/jquery.min.js"></script>
<script src="http://coolshell.cn//wp-content/themes/inove/js/jquery.bpopup-0.8.0.min.js"></script>

<script type="text/javascript">
;(function($) {
    $(function() {
        var url=document.referrer;
        if ( url && ( url.search("http://")>-1 || url.search("https://")>-1 ) ) {
            var refurl =  url.match(/:\/\/(.[^/]+)/)[1];
            if(refurl.indexOf("baidu.com")>-1){
                $('#nobaidu_dlg').bPopup();
            }
        }
    });

})(jQuery);
</script>



<div id="nobaidu_dlg" style="background-color:#fff; border-radius:15px;color:#000;display:none;padding:20px;min-width:450px;min-height:180px;">
    <!--<span class="bClose" style="cursor:pointer; position:absolute; right:10px;top:5px;">x<span/>-->
    <img src="http://coolshell.cn//wp-content/themes/inove/img/nobaidu.jpg" align="left">
     <p style="margin-left:200px;margin-top: 20px; line-height: 30px;">
     检测到你还在使用百度这个搜索引擎，<br/>
     作为一个程序员，这是一种自暴自弃！<br/>
     <br/>
     </p>
     <p align="center" style="margin-top:20px;">
     <b><a href="http://coolshell.cn/articles/7186.html">作环保的程序员，从不用百度开始！</a></b>
     </p>
</div>


<!-- Dynamic page generated in 0.488 seconds. -->
<!-- Cached page generated by WP-Super-Cache on 2015-08-08 12:39:10 -->

<!-- Compression = gzip -->
