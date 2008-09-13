From: Annick et Jean-Philippe <jpmeuret@free.fr>
Subject: Re: Force Feedback for Thrustmaster RGT Pro Clutch Pedal Edition
 racing wheel
Date: Sat, 13 Sep 2008 18:32:06 +0200
Message-ID: <48CBEB06.5070104@free.fr>
References: <48CBD7B3.4070104@xs4all.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:33613 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbYITSsh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Sep 2008 14:48:37 -0400
In-Reply-To: <48CBD7B3.4070104@xs4all.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Didier Moens <moensd@xs4all.be>
Cc: linux-input@vger.kernel.org

Hi, Didier, and all.

> I'm trying to get force feedback activated on this quite wonderful 
> racing wheel 
> ...
> (patches against 2.6.25, but I've already tested with 2.6.26.3)
> ...
> Unfortunately, this yields no improvement : no force feedback is sent to 
> the wheel (tested with ff-utils).
> ...

Not sure this will fix your issues, but ...

ff-utils original code has 2 flaws :
- it is NOT 64-bit compatible
- it was coded for 2.4.x kernels, and when you compile it, it does not use
   the includes of your specific kernel, but those shipped with the sources
   (see sub-folder "linux")

So I recommend you apply the patch that fixes this issues :
look on SourceForge libff patches page ...

https://sourceforge.net/tracker/?func=detail&atid=440671&aid=2098907&group_id=44724

Then, be sure to test FF with "ffcfstress" (only for Constant Force),
not only with "fftest" ;
the first one works very well with my Logitech G25,
whereas I not sure the second one does ... (the rendered Constant Force effect 
is so week, that it's not that clear ...).

Finally, you can try the FFConsoleDemo of the OIS library (get 1.2.0 sources,
and apply the recent "Linux FF 64bit port + Windows FF fixes + DemoFFTest" patch
https://sourceforge.net/tracker/?func=detail&atid=775955&aid=2087429&group_id=149835) 
; it tests constant and periodic FF (Constant Force test is OK for my G25, not 
periodic).

Hope this helps.

Jean-Philippe MEURET

