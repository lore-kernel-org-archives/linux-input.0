From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 09:11:06 +0200
Message-ID: <20101013071106.GC1610@ucw.cz>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
 <20101005174106.GA21399@core.coreip.homeip.net>
 <4CAC340B.90207@codeaurora.org>
 <33A307AF30D7BF4F811B1568FE7A9B180461062FE6@EXDCVYMBSTM006.EQ1STM.local>
 <1286358518.26914.23.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:52278 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752590Ab0JMNGL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 09:06:11 -0400
Content-Disposition: inline
In-Reply-To: <1286358518.26914.23.camel@4fid08082>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Onkalo Samu <samu.p.onkalo@nokia.com>
Cc: ext Sundar R IYER <sundar.iyer@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

Hi!
 
> For mobile devices it is not acceptable to filter events away at some
> upper SW layer depending on the system state. The HW which generates
> those events may not generate events at all to allow longer CPU sleep
> periods.

Ok.

> In ideal world it would be nice to control device states based on for
> example user count. However, there are several listeners for input
> devices and it is hard or impossible to have them all to follow overall
> state transition (screen blanked etc.). Instead, there is some
> system

So you have mobile device; why is it impossible to just close the
device when you do not want the events? I guess it is hard for generic
distros, but on your phone, you should be able to modify Xserver to
close touchscreen/keypad device when it is not needed... right?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
