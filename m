From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 09:25:48 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180468726AB4@EXDCVYMBSTM006.EQ1STM.local>
References: <20101011170733.GA27304@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1010111739580.16765-100000@netrider.rowland.org>
 <20101011220846.GA28611@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:35726 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754001Ab0JLH0P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 03:26:15 -0400
In-Reply-To: <20101011220846.GA28611@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

Hi,

Sorry to be jumping in late. My few comments dispersed with
individual replies

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>Sent: Tuesday, October 12, 2010 3:39 AM
>
>
>I do not believe there is a generic answer - different devices,
>different options. For example I could see buttons split into 2 groups -
>"important" ones that bring the system from sleep or "stupor" and "not
>so important" that gets to be ignored. Or user woudl need to "flick"
>the screen. Or toss the phone into a corner cussing :)
>

Yes. At least on the U8500 (and couple of OMAPs as well), it is the 
always-on power button on AB8500/TWLs that is the necessary event 
to turn off the display/keypad. The entire display/keypad themselves
cannot wakeup the system. But on the older phones, we generally had
to have the menu + star combination to unlock the phone, which falls into
the main keypad.

>The point is that there seems to be a need for kicking devices into low
>power mode and I woudl like to have generic interface for that,
>preferrably reusing (as far as kernel drivers go) existing PM
>infrastructure.

Coming in late, I would just like to summarize some of the points; please
correct if I am wrong:

- user space intervention is required to communicate specific events
  to individual devices to put them into an appropriate power state.

- auto suspend isn't the correct choice for input devices as they may
  conflict with system suspend (touch screen off/idle needs to be sync'ed
  with system suspend as with a lock switch)

- PM ATM doesn't provide a sysfs attribute for enabling/disabling or forcing
  an individual device into low power mode unlike for platform. However a new
  "suspend_ondemand" flag can enable such devices to be put into appropriate
  states via a /sys/devices/.../power/ by the user space.

If my above summarization is correct, I personally feel the on demand flag is a clean
option for the current requirement.

Cheers!
Sundar
