From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: HID-Multitouch: eGalax Touchscreen Pressure
Date: Sun, 20 Nov 2011 12:30:09 +0100
Message-ID: <CAN+gG=FNzkXUbh8V5563JR-j5CDuotmK-G+FTWoC67-xH7yiWg@mail.gmail.com>
References: <20111119070059.GA2167@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56523 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1KTLaK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Nov 2011 06:30:10 -0500
Received: by wwe5 with SMTP id 5so8497390wwe.1
        for <linux-input@vger.kernel.org>; Sun, 20 Nov 2011 03:30:09 -0800 (PST)
In-Reply-To: <20111119070059.GA2167@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: linux-input@vger.kernel.org

Hi Cedric,

On Sat, Nov 19, 2011 at 08:00, Cedric Sodhi <manday@gmx.net> wrote:
> Hello everybody
>
> After I finally got the touchscreen to work thanks to Benjamin, there
> remains one little issue for the eGalax 0eef:a001
>
> I'm pretty sure one could measure the pressure by which the finger(s)
> touches the screeen. Currently, even coming close to the surface is
> taken as a touch land. Here is the rdesc. If it is does not report such
> a capability, then something is wrong, I think. I cannot recall having
> had such overly responsive behaviour under windows.

Well, the reports don't show pressure, so you won't be able to handle
it in a generic way.
Maybe under windows you have a vendor-specific driver that talks to
the proprietary input interface on your device:

With little luck:
You may change the value of the input mode in mt_set_input_mode to
switch the device mode (0x01 means mouse/touchscreen emulation, 0x02
means win7 generic multitouch), try 0x03 for instance...

Then, try to see if the event node is active (do not forget to have
someone reading /dev/input/eventX).

Then, once you decoded the reports, you may write a specific driver
for this eGalax product ;-)

Cheers,
Benjamin

>
> How to add support for finger-pressure?
>
> Cedric
>
