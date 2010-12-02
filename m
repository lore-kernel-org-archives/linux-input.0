From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Microchip Touchscreen Driver Submissions
Date: Thu, 02 Dec 2010 10:55:06 +0100
Message-ID: <4CF76CFA.5010709@euromail.se>
References: <E773D38DD616EA4A9B9DBDA8009918200B0298FA@CHN-CL-MAIL01.mchp-main.com> <20101202001439.GA31397@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:58467 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751748Ab0LBJzR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Dec 2010 04:55:17 -0500
In-Reply-To: <20101202001439.GA31397@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Steve.Grahovac@microchip.com, Linux Input <linux-input@vger.kernel.org>

>

>> I verified the multi-touch was being reported
>> correctly by use of the pymt python multi-touch draw application.  For
>> touchscreen emulation,  I did notice an issue where touch events seemed
>> to be properly sent as evdev packets by the mchppcapmt kernel module,
>> however Xorg 7.5 did not process these touch events correctly since the
>> cursor moved but there were no click events (I'm guessing this is an
>> Xorg issue, but not 100 percent sure).  Are you familiar with any
>> multi-touch touchscreen emulation issues with Xorg?
> 
> Multitouch support is work in progress on all levels of our stack, I
> think Henrik is in a better position to answer this question.


There are a number of things that can go wrong, anywhere from the kernel driver,
whether mtdev is used or not (latest pymt has mtdev support), which X driver is
in use, and what distro is being used.

For driver tests, the mtview program (http://bitmath.org/code/mtview/) has been
used successfully during development of some drivers, since it does not depend
on the higher levels of the stack. Combined with evtest, it is usually possible
to find the point-and-click problems.

If you do find an error higher up the stack, providing a test case using the
utouch-evemu project is very valuable, since it allows the hardware and the
exact situation to be emulated and explicitly tested on any machine.

Thanks,
Henrik
