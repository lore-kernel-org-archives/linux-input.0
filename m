From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Tue, 21 Jul 2015 09:12:18 +0200
Message-ID: <20150721071218.GA27290@pali>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
 <20150720065446.GA13879@dtor-ws>
 <20150720072548.GA25910@pali>
 <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36312 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbGUHM0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 03:12:26 -0400
Received: by wicgb10 with SMTP id gb10so46324717wic.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 00:12:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Monday 20 July 2015 23:00:27 Douglas Christman wrote:
> On Mon, Jul 20, 2015 at 3:25 AM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > Hi! Please recompile psmouse.ko with dev_dbg() debug information an=
d
> > send new dmesg output. We need to know type of ALPS device. Thanks!
>=20
> I recompiled with CONFIG_DYNAMIC_DEBUG and echoed 'module psmouse' to
> /sys/kernel/debug/dynamic_debug/control as described in
> Documentation/dynamic-debug-howto.txt, but I don't see any additional
> output in dmesg after reloading the module.  I haven't done this
> before, so I'm probably overlooking something...
>=20
> In the meantime, hopefully this output from hwinfo can be of use:
>=20
> 52: PS/2 00.0: 10500 PS/2 Mouse
>   [Created at input.249]
>   Unique ID: AH6Q.5+smWHVjPI3
>   Hardware Class: mouse
>   Model: "AlpsPS/2 ALPS DualPoint Stick"
>   Vendor: 0x0002
>   Device: 0x0008 "AlpsPS/2 ALPS DualPoint Stick"
>   Compatible to: int 0x0210 0x0003
>   Device File: /dev/input/mice (/dev/input/mouse0)
>   Device Files: /dev/input/mice, /dev/input/mouse0,
> /dev/input/event11,
> /dev/input/by-path/platform-i8042-serio-1-event-mouse,
> /dev/input/by-path/platform-i8042-serio-1-mouse
>   Device Number: char 13:63 (char 13:32)
>   Driver Info #0:
>     Buttons: 3
>     Wheels: 0
>     XFree86 Protocol: explorerps/2
>     GPM Protocol: exps2
>   Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown
>=20
> 53: PS/2 00.0: 10500 PS/2 Mouse
>   [Created at input.249]
>   Unique ID: AH6Q.5+smWHVjPI3
>   Hardware Class: mouse
>   Model: "AlpsPS/2 ALPS DualPoint TouchPad"
>   Vendor: 0x0002
>   Device: 0x0008 "AlpsPS/2 ALPS DualPoint TouchPad"
>   Compatible to: int 0x0210 0x0003
>   Device File: /dev/input/mice (/dev/input/mouse1)
>   Device Files: /dev/input/mice, /dev/input/mouse1,
> /dev/input/event12,
> /dev/input/by-path/platform-i8042-serio-1-event-mouse,
> /dev/input/by-path/platform-i8042-serio-1-mouse
>   Device Number: char 13:63 (char 13:33)
>   Driver Info #0:
>     Buttons: 3
>     Wheels: 0
>     XFree86 Protocol: explorerps/2
>     GPM Protocol: exps2
>   Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown

It is not enough. If do not want to recompile full kernel, but just onl=
y
psmouse.ko I think that the easiest way is to change this define

 #define psmouse_dbg

in file drivers/input/mouse/psmouse.h to call dev_warn instead dev_dbg.
And then just compile psmouse.ko and reload it.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
