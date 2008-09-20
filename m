From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Force Feedback for Thrustmaster RGT Pro Clutch Pedal Edition
 racing wheel
Date: Sat, 20 Sep 2008 23:49:46 +0300
Message-ID: <48D561EA.5060402@gmail.com>
References: <48CBD7B3.4070104@xs4all.be> <48CBEB06.5070104@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:45447 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbYITUtt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Sep 2008 16:49:49 -0400
In-Reply-To: <48CBEB06.5070104@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Annick et Jean-Philippe <jpmeuret@free.fr>
Cc: Didier Moens <moensd@xs4all.be>, linux-input@vger.kernel.org

Annick et Jean-Philippe wrote:
> Hi, Didier, and all.

Hi!

>> I'm trying to get force feedback activated on this quite wonderful
>> racing wheel ...
>> (patches against 2.6.25, but I've already tested with 2.6.26.3)
>> ...
>> Unfortunately, this yields no improvement : no force feedback is sent
>> to the wheel (tested with ff-utils).
>> ...
> 
> Not sure this will fix your issues, but ...
> 
> ff-utils original code has 2 flaws :
> - it is NOT 64-bit compatible
> - it was coded for 2.4.x kernels, and when you compile it, it does not use
>   the includes of your specific kernel, but those shipped with the sources
>   (see sub-folder "linux")

Works fine for me here on 64-bit, and uses standard headers. Maybe you
are using an old version?

The latest version is in linuxconsole SVN:
http://linuxconsole.svn.sourceforge.net/viewvc/linuxconsole/trunk/utils/
Downloadable with SVN command (on one line):
svn co
https://linuxconsole.svn.sourceforge.net/svnroot/linuxconsole/trunk/utils
input-utils


> So I recommend you apply the patch that fixes this issues :
> look on SourceForge libff patches page ...
> 
> https://sourceforge.net/tracker/?func=detail&atid=440671&aid=2098907&group_id=44724

libff is stale project, I suspect this should be filed to linuxconsole
instead (after checking the problems still exist, of course). Hopefully
its maintainers are active. If not, post here.

> 
> Then, be sure to test FF with "ffcfstress" (only for Constant Force),
> not only with "fftest" ;
> the first one works very well with my Logitech G25,
> whereas I not sure the second one does ... (the rendered Constant Force
> effect is so week, that it's not that clear ...).
> 
> Finally, you can try the FFConsoleDemo of the OIS library (get 1.2.0
> sources,
> and apply the recent "Linux FF 64bit port + Windows FF fixes +
> DemoFFTest" patch
> https://sourceforge.net/tracker/?func=detail&atid=775955&aid=2087429&group_id=149835)
> ; it tests constant and periodic FF (Constant Force test is OK for my
> G25, not periodic).
> 
> Hope this helps.
> 
> Jean-Philippe MEURET


-- 
Anssi Hannula
