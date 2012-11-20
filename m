From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Tue, 20 Nov 2012 13:47:23 +0100
Message-ID: <CAN+gG=Ho7c6B27B5Lqo2T-qKT8PQH1Xr+kLVnr1nCOStPatfqA@mail.gmail.com>
References: <8159607.SRZZrRIPNF@orthese>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54360 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab2KTMrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 07:47:24 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1794104lbb.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 04:47:23 -0800 (PST)
In-Reply-To: <8159607.SRZZrRIPNF@orthese>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Matthias Braun <jan_braun@gmx.net>
Cc: linux-input@vger.kernel.org

Hi Jan-Matthias,

On Mon, Nov 19, 2012 at 12:58 PM, Jan-Matthias Braun <jan_braun@gmx.net> wrote:
> Dear List,
>
> using the current (Linux v2.6.7) hid-multitouch driver I have the problem, that the touchscreen works fine after a fresh boot, but after a suspend the touchscreen does not come back to live and I am asking for assistance to get this working. As I can reproduce this problem on a standard tty device without X (see below) I am suspecting a driver problem, but I might as well be wrong.

I assume you are talking about v3.6.7...

>
> The device in question is the Touchscreen of a Dell Inspron Duo convertable, a USB device with id 0eef:725e (D-WAV Scientific Co., Ltd), found and registered as an input device by the kernel as
> [    6.931638] usb 4-1: Manufacturer: eGalax Inc.
> [   16.186272] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input10
> [   16.187162] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer
>                  [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0
>
> I have tested the behaviour with and without X11. Without X11 I was using a standard tty and using cat on the input device.
> After boot the input device gives lot of output while touching the screen, after resume the device stays silent.

strange. I have tested the procedure with the eGalax 0x72FA I got, and
I'm not seeing this problem on a 3.6 kernel.

Is the config symbol CONFIG_PM set to "y" in your .config file?

Also, can you try to rmmod / modprobe hid-multitouch when the device
is not responding and see if this solves things.

>
> I have this problem since moving to hid-multitouch for handling this device.

What kind of driver did you use before?

Cheers,
Benjamin

>
> I will be happy to test and supply more information. Thanks a lot for looking into this,
>
> Jan-Matthias Braun
>
> PS: As I am not subscribed to the mailing list, please CC me.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
