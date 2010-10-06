From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 10:56:49 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180461062FE6@EXDCVYMBSTM006.EQ1STM.local>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
 <20101005174106.GA21399@core.coreip.homeip.net>
 <4CAC340B.90207@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:35519 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754363Ab0JFI5g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Oct 2010 04:57:36 -0400
In-Reply-To: <4CAC340B.90207@codeaurora.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>

Hi,

>-----Original Message-----
>From: Trilok Soni [mailto:tsoni@codeaurora.org]
>Sent: Wednesday, October 06, 2010 2:02 PM
>
>I agree with Dmitry. Meego people or you should explain the real end-to-end
>usecase first. Why it can't fit anywhere else?

I don't know the full details; but what I can think of (or did I read it somewhere?)
is events like phones with slider keypad; you can power save keypad controller
when the keypad is not active. And these events are probably issued from the user
space to the kernel and that's why the requirement probably. And I do remember
Samu mentioning about unwanted wakeup events which were avoided via these switches.

Adding Samu who can explain more on this.

>We should not fill in features very specific to userspace frameworks. I see lately
>lot of Android and Meego specific bits into TS and Keypad drivers from many
>folks.
>

Yeah. IMO it is because people want to mainline and push out all drivers more and more;
And as of today most of these drivers and HW are tested and delivered on such frameworks :)

Regards,
Sundar


