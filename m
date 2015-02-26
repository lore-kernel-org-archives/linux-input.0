From: Stefan Sauer <ensonic@google.com>
Subject: Re: udev timeout for mma8450 unless the accelerometer is shaken
Date: Thu, 26 Feb 2015 17:02:02 +0100
Message-ID: <CAGX7z0w0MjQR7rGpr5YMZB3ao33CN8yNZiq5vugwNbBDKAXfwA@mail.gmail.com>
References: <CAGX7z0yi5JbTUsDEZRO1EffDBi4Co6YX=NyOZ9m2uJfyPh8o_w@mail.gmail.com>
	<1424959374.2459.17.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:58271 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbBZQCE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 11:02:04 -0500
Received: by mail-qa0-f54.google.com with SMTP id x12so8363252qac.13
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2015 08:02:02 -0800 (PST)
In-Reply-To: <1424959374.2459.17.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

udev is 208-r4 - most likely not having the patch. Thanks for the
info, will see if I can bump the version.

On Thu, Feb 26, 2015 at 3:02 PM, Bastien Nocera <hadess@hadess.net> wro=
te:
> On Thu, 2015-02-26 at 14:05 +0100, Stefan Sauer wrote:
>> hi,
>>
>> on my beaglebone-black I get these lines during bootup
>>
>> [   71.745951] udevd[105]: worker [113]
>> /devices/ocp.2/4819c000.i2c/i2c-2/2-001d/input/input2/event1 timeout=
;
>> kill it
>> [   71.771991] udevd[105]: seq 1243
>> '/devices/ocp.2/4819c000.i2c/i2c-2/2-001d/input/input2/event1' kille=
d
>> [   71.799611] udevd[105]: worker [113] terminated by signal 9 (Kill=
ed)
>>
>> The device is an accelerometer connected via i2c. When I shake it
>> during bootup I don't get these warnings. Alternative repro:
>> udevadm trigger --action=3Dadd --subsystem-match=3D"input" --subsyst=
em-match=3D"misc"
>> udevadm settle
>>
>> The 'udevadm settle' will block until the device is moved. Is that e=
xpected?
>
> This is likely due to the accelerometer support in udev. Which versio=
n
> of udev/systemd is it? You might want to pick this patch if it isn't
> already in your tree:
> http://cgit.freedesktop.org/systemd/systemd/commit/src/udev/accelerom=
eter/accelerometer.c?id=3Da545c6e1aa31b4d7e80c9d3609d9fc4fc9921498
>
> Cheers
>



--=20
Stefan Sauer | Software Engineer | ensonic@google.com

Google Germany GmbH | Maximilianstrasse 11-15 | 80539 M=C3=BCnchen | Ge=
rmany
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Graham Law, Christine Elizabeth Flores
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
