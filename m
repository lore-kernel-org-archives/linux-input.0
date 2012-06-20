From: David VomLehn <vomlehn@texas.net>
Subject: Keyboard problem on HP Envy 17 3D
Date: Wed, 20 Jun 2012 15:02:27 -0700
Message-ID: <4FE24873.8010106@texas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:35585
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754835Ab2FTWIY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jun 2012 18:08:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a keyboard problem that I figure *must* be a keyboard hardware 
problem, but it doesn't really look like it. When I bring up either 
Ubuntu 12.04 (installed) or Fedora 17 (from Live CD) and use either the 
"Terminal" program or xterm, I can type some small number of characters 
(~10-20) without a problem. As I type more, though, other characters 
start getting inserted. This will typically start with a newline, but 
then I get short strings, starting with an ESC character, then I'll get 
multiple copies of things I've typed many lines before. The extraneous 
text may be inserted while I am typing, but there may be a short (~0.5 
sec) delay before it appears. The ESC strings will be things like cursor 
up or down. It quickly becomes possible to do much of anything.

I see the same problems when entering text on other programs, as well, 
such as Thunderbird or Firefox. Note that I don't see any keyboard 
problems when using PuTTY or any other program on (yech) Windows.

This probably began when I switched my installation from Fedora 16 to 
Ubuntu 12.04 or shortly thereafter (clean install of *everything*, 
including Windows).

My system is an HP Envy 17" 3D (2090nr).

I can't believe this is software because other people would see it; I 
think pretty much anyone would be ready to pitch their system off a 
cliff in frustration. Yet, the problem only happens when running Linux, 
appears to have started with a kernel upgrade (as part of the Ubuntu 
install), and there isn't any hardware buffer I know that would keep 
things I typed hundreds of characters before.

I'm a little desperate here--I bought the system for kernel development 
but I work on embedded systems without keyboards; any suggestions, or 
even just confirmation that other people see the same thing, appreciated!
--
David VL

