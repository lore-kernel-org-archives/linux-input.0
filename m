From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Tue, 1 Feb 2011 10:00:12 +0100
Message-ID: <AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
References: <1296485689.7756.9.camel@novo.hadess.net>
	<20110131212842.GB1603@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44257 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1BAJAN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Feb 2011 04:00:13 -0500
Received: by wyb28 with SMTP id 28so6443232wyb.19
        for <linux-input@vger.kernel.org>; Tue, 01 Feb 2011 01:00:12 -0800 (PST)
In-Reply-To: <20110131212842.GB1603@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

Hi Bastien, Henrik,

On Mon, Jan 31, 2011 at 22:28, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Bastien,
>
>> Built into my Lenovo A700 all-in-one is a touchscreen. lsusb says:
>> $ lsusb | grep -i touch
>> Bus 002 Device 006: ID 04e7:0022 Elo TouchSystems
>
> I take it this is a dual-touch device?
>
>> The touchscreen "works", in that tapping it will create a click even=
t,
>> though that click event is always in the top left of the screen.
>
> This is quite common for HID multitouch devices without proper driver
> support. Sometimes using the HID_MULTI_INPUT quirk helps. Check
> usbhid/hid-quirks.c for examples.
>
>> Full output of lsusb -vvv attached.
>>
>> Anybody with ideas as to what I'm missing, or whether that particula=
r
>> device is supported?
>
> You probably noted already that the 04e7:0020 device is listed in
> usbhid. Unless the device claims to be win7 compliant (implying
> patching up hid-multitouch), going with the evtouch X driver might ge=
t
> you a bit on the way. Or - god forbid - the binary blob drivers...

To know if the device is "win7 compliant" or not, we need the full
output of lsusb (with the report descriptors).
You need to tell usbhid to release the device before calling lsusb -v.

Please use the script at
http://lii-enac.fr/en/architecture/linux-input/report.py
and run, as root: python report.py > descriptors.txt

This will do the job. You can then send us the descriptors.txt, and we
will see what we can do.

>
>> Using kernel 2.6.38-rc2-git5 (from Fedora rawhide).

If your device is "win7 compliant" you will have to recompile a new ker=
nel.

Cheers,
Benjamin

>
> The serial elo driver has not been updated since 2007...
>
> Cheers,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
