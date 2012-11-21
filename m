From: Jan-Matthias Braun <jan_braun@gmx.net>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Wed, 21 Nov 2012 10:33:16 +0100
Message-ID: <2539870.ZuUQxCIqZO@orthese>
References: <8159607.SRZZrRIPNF@orthese> <CAN+gG=Ho7c6B27B5Lqo2T-qKT8PQH1Xr+kLVnr1nCOStPatfqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:37148 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753127Ab2KUJdg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 04:33:36 -0500
In-Reply-To: <CAN+gG=Ho7c6B27B5Lqo2T-qKT8PQH1Xr+kLVnr1nCOStPatfqA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Benjamin,

thanks for looking into the issue.

Am Dienstag, 20. November 2012, 13:47:23 schrieben Sie:
> Hi Jan-Matthias,
> 
> On Mon, Nov 19, 2012 at 12:58 PM, Jan-Matthias Braun <jan_braun@gmx.net> wrote:
> > Dear List,
> >
> > using the current (Linux v2.6.7) hid-multitouch driver I have the problem, that the touchscreen works fine after a fresh boot, but after a suspend the touchscreen does not come back to live and I am asking for assistance to get this working. As I can reproduce this problem on a standard tty device without X (see below) I am suspecting a driver problem, but I might as well be wrong.
> 
> I assume you are talking about v3.6.7...

You are right, of course. Sorry for the distraction.

> > The device in question is the Touchscreen of a Dell Inspron Duo convertable, a USB device with id 0eef:725e (D-WAV Scientific Co., Ltd), found and registered as an input device by the kernel as
> > [    6.931638] usb 4-1: Manufacturer: eGalax Inc.
> > [   16.186272] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input10
> > [   16.187162] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer
> >                  [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0
> >
> > I have tested the behaviour with and without X11. Without X11 I was using a standard tty and using cat on the input device.
> > After boot the input device gives lot of output while touching the screen, after resume the device stays silent.
> 
> strange. I have tested the procedure with the eGalax 0x72FA I got, and
> I'm not seeing this problem on a 3.6 kernel.
> 
> Is the config symbol CONFIG_PM set to "y" in your .config file?

Yes.

> Also, can you try to rmmod / modprobe hid-multitouch when the device
> is not responding and see if this solves things.

This is not working for me. On modprobe the Kernel log says

[12537.335946] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input
/input13
[12537.336875] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0

but /dev/input/event13 is not created. To be honest, I don't even know, if it should be created.
What happens is, that /dev/input/event10 vanishes on removal of the hid-multitouch module and then reappears after modprobe. But a cat on it wont show a reaction while touching the screen's surface.

> > I have this problem since moving to hid-multitouch for handling this device.
> 
> What kind of driver did you use before?

I think, there was a separate usb touchscreen driver for egalax devices before something like kernel version 3.2. This one I used. Long story short: I have never used the vendor supplied drivers, but those coming with the kernel.

Cheers,

Jan

> > I will be happy to test and supply more information. Thanks a lot for looking into this,
> >
> > Jan-Matthias Braun
> >
> > PS: As I am not subscribed to the mailing list, please CC me.

