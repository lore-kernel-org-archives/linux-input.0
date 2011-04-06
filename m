From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Wacom Intuos4 LED and OLED support
Date: Wed, 6 Apr 2011 11:46:48 -0700
Message-ID: <20110406184648.GA17470@core.coreip.homeip.net>
References: <1301817429-12782-1-git-send-email-eduard@hasenleithner.at>
 <BANLkTimvgdahQyu94Ep=C8JU_Cfra_kdjg@mail.gmail.com>
 <20110405182808.GB13086@core.coreip.homeip.net>
 <BANLkTikmHMg=TVpQ_e7U2yED_2ciznsuCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48310 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab1DFSqz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 14:46:55 -0400
Received: by iyb14 with SMTP id 14so1696953iyb.19
        for <linux-input@vger.kernel.org>; Wed, 06 Apr 2011 11:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikmHMg=TVpQ_e7U2yED_2ciznsuCg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduard Hasenleithner <ehasenle@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 05, 2011 at 09:28:52PM +0200, Eduard Hasenleithner wrote:
> Hi
> 
> 2011/4/5 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Tue, Apr 05, 2011 at 08:12:07PM +0200, Eduard Hasenleithner wrote:
> >> I have been encouraged by Ping Cheng to submit the OLED matrix display
> >> patch for the Intuos4 to the linux-input mailing list. In absence of
> >> any comment by you on this issue, I'm a bit lost. Could you give
> >> something like a quick ACK (e.g. you will have a look into it later,
> >> when you have time) or NACK (e.g. no way for inclusion, needs major
> >> change, ...).
> >
> > Sorry, just a bit swamped at the moment (unfortunately happens to be
> > quite often ;( ), that is why not responding...
> 
> If you like, I can come back in a month or so for discussion. Or you
> write me an email when you are less stressed (you being a maintainer,
> this is probably just wishful thinking).

No, that would not be a good idea as there will be more drivers in the
queue...

> 
> > The main issue for me is adding a new device-specific interface. Are
> > there any other suitable ways to provide access to the functionality?
> > Something like auxdisplay?
> 
> I had the impression that using the existing RAW USB-device IOCTL
> mechanism would not be considered an additional interface. There is no
> change in the event- or any other subsystem, just in the wacom driver.

This is definition of adding a new device-specific interface. You are
adding something that can only work with these 3 devices and required
specially written userspace component to make use of the interface.

> And, as a bonus, using sysfs the RAW USB Device belonging to the event
> device can be located in a straight forward way. Since the wacom
> driver "grabs" the USB device and the OLED part of the Intuos4 is not
> a separate USB device, the display control has to be performed in any
> case in the wacom (input) driver. A "auxdisplay" implementation would
> then have to be done also there.
>

Yes, of course.

> Wrt auxdisplay: a quick look at the driver reveals that it exposes a
> (generic?) framebuffer device. If you say: "This is the way to go",
> I'll try it. It is just that I fear that some X-Server might
> automatically use it as display, which is not exactly my intention ;)
> Furthermore, there are four LEDs (only one can be lit at a time) on
> the device, and three different luminace settings, which would
> probably need some IOCTL anyway. And due to the higher complexity,
> implementing a (simulated) framebuffer device provides more
> possibilities for bugs.

OK, it could be that representing these leds as a generic framebuffer
device is not the best idea (I am not ocnvinced either way yet). If this
is the case have you thought about accessing the leds via binary sysfs
attributes? At least you can simply "cat" icon data in those...

Thanks.

-- 
Dmitry
