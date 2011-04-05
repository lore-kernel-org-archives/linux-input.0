From: Eduard Hasenleithner <ehasenle@gmail.com>
Subject: Re: [PATCH v2] Wacom Intuos4 LED and OLED support
Date: Tue, 5 Apr 2011 21:28:52 +0200
Message-ID: <BANLkTikmHMg=TVpQ_e7U2yED_2ciznsuCg@mail.gmail.com>
References: <1301817429-12782-1-git-send-email-eduard@hasenleithner.at>
	<BANLkTimvgdahQyu94Ep=C8JU_Cfra_kdjg@mail.gmail.com>
	<20110405182808.GB13086@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60315 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab1DET2w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 15:28:52 -0400
Received: by iyb14 with SMTP id 14so688733iyb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 12:28:52 -0700 (PDT)
In-Reply-To: <20110405182808.GB13086@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi

2011/4/5 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Tue, Apr 05, 2011 at 08:12:07PM +0200, Eduard Hasenleithner wrote:
>> I have been encouraged by Ping Cheng to submit the OLED matrix display
>> patch for the Intuos4 to the linux-input mailing list. In absence of
>> any comment by you on this issue, I'm a bit lost. Could you give
>> something like a quick ACK (e.g. you will have a look into it later,
>> when you have time) or NACK (e.g. no way for inclusion, needs major
>> change, ...).
>
> Sorry, just a bit swamped at the moment (unfortunately happens to be
> quite often ;( ), that is why not responding...

If you like, I can come back in a month or so for discussion. Or you
write me an email when you are less stressed (you being a maintainer,
this is probably just wishful thinking).

> The main issue for me is adding a new device-specific interface. Are
> there any other suitable ways to provide access to the functionality?
> Something like auxdisplay?

I had the impression that using the existing RAW USB-device IOCTL
mechanism would not be considered an additional interface. There is no
change in the event- or any other subsystem, just in the wacom driver.
And, as a bonus, using sysfs the RAW USB Device belonging to the event
device can be located in a straight forward way. Since the wacom
driver "grabs" the USB device and the OLED part of the Intuos4 is not
a separate USB device, the display control has to be performed in any
case in the wacom (input) driver. A "auxdisplay" implementation would
then have to be done also there.

Wrt auxdisplay: a quick look at the driver reveals that it exposes a
(generic?) framebuffer device. If you say: "This is the way to go",
I'll try it. It is just that I fear that some X-Server might
automatically use it as display, which is not exactly my intention ;)
Furthermore, there are four LEDs (only one can be lit at a time) on
the device, and three different luminace settings, which would
probably need some IOCTL anyway. And due to the higher complexity,
implementing a (simulated) framebuffer device provides more
possibilities for bugs.

Thanks,
Eduard
