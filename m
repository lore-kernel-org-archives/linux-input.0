From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH v6 1/2] input: add support for Nomadik SKE keypad
 controller
Date: Thu, 23 Sep 2010 07:17:26 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B1804379C9881@EXDCVYMBSTM006.EQ1STM.local>
References: <1285156355-24555-1-git-send-email-sundar.iyer@stericsson.com>
 <20100922152938.GA32097@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:49146 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752702Ab0IWFRg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Sep 2010 01:17:36 -0400
In-Reply-To: <20100922152938.GA32097@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>

Hi Dmitry,

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>
>Out of curiosity, did you try the patch that did not do polling? What
>was the breakage?

Yes. I did test the non-polling patch which you inlined in the mail.
And the issue was same: I missed the actual press/release report
events to the user space. With the threaded_irq one, I got this working
back. 

As I mentioned, I have a couple of other keypad drivers with the
same key layouts passed from platform data. I always compare the
event reports from the SKE keypad to those ones like STMPE/TC35893
keypad controllers. And hence my observation that if I miss some
events which is not captured by getevents, then this driver is doing
something wrong.

>I was also hoping you'd use it as a base for applying the threaded patch
>- I did a few fixups and changed the probe routine a bit.

Ohh. I overlooked the changes in the probe function then. Surely I will incorporate it
and send it out if you are okay with the v6 IRQ handling.

Regards,
Sundar
P.S: Again a tremendous thanx to you for being so persistent and helpful.
