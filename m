From: <Steve.Grahovac@microchip.com>
Subject: RE: Microchip Touchscreen Driver Submissions
Date: Thu, 2 Dec 2010 10:16:29 -0700
Message-ID: <E773D38DD616EA4A9B9DBDA8009918200B029AD8@CHN-CL-MAIL01.mchp-main.com>
References: <E773D38DD616EA4A9B9DBDA8009918200B0298FA@CHN-CL-MAIL01.mchp-main.com> <20101202001439.GA31397@core.coreip.homeip.net> <4CF76CFA.5010709@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.microchip.com ([198.175.253.47]:14873 "EHLO
	smtp01.microchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab0LBRMX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Dec 2010 12:12:23 -0500
Content-class: urn:content-classes:message
In-Reply-To: <4CF76CFA.5010709@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Thanks Hendrik for your help.  I will use this application as a testbed
for verifying events for multi-touch kernel modules.

Would you happen to know the appropriate way to download the source for
this?  I tried both cloning it's git repository and also tried clicking
on the URL but unfortunately I was unable to gain access.

>If you do find an error higher up the stack, providing a test case
using the
utouch-evemu project is very valuable, since it allows the hardware and
the
exact situation to be emulated and explicitly tested on any machine.

That sounds like a nice tool.  If I can reproduce using this issue using
emulated events, I'll submit a case.

Best regards,

Steve Grahovac
Sr. Software Engineer
Microchip Technology, Inc.
9055 N. 51st Street Suite H
Brown Deer, WI 53223 USA
Steve.Grahovac@microchip.com
Ph: 414.355.4675
FX: 414.355.4775




-----Original Message-----
From: Henrik Rydberg [mailto:rydberg@euromail.se] 
Sent: Thursday, December 02, 2010 3:55 AM
To: Dmitry Torokhov
Cc: Steve Grahovac - C13916; Linux Input
Subject: Re: Microchip Touchscreen Driver Submissions

>

>> I verified the multi-touch was being reported
>> correctly by use of the pymt python multi-touch draw application.
For
>> touchscreen emulation,  I did notice an issue where touch events
seemed
>> to be properly sent as evdev packets by the mchppcapmt kernel module,
>> however Xorg 7.5 did not process these touch events correctly since
the
>> cursor moved but there were no click events (I'm guessing this is an
>> Xorg issue, but not 100 percent sure).  Are you familiar with any
>> multi-touch touchscreen emulation issues with Xorg?
> 
> Multitouch support is work in progress on all levels of our stack, I
> think Henrik is in a better position to answer this question.


There are a number of things that can go wrong, anywhere from the kernel
driver,
whether mtdev is used or not (latest pymt has mtdev support), which X
driver is
in use, and what distro is being used.

For driver tests, the mtview program (http://bitmath.org/code/mtview/)
has been
used successfully during development of some drivers, since it does not
depend
on the higher levels of the stack. Combined with evtest, it is usually
possible
to find the point-and-click problems.

If you do find an error higher up the stack, providing a test case using
the
utouch-evemu project is very valuable, since it allows the hardware and
the
exact situation to be emulated and explicitly tested on any machine.

Thanks,
Henrik
