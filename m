From: Douglas Christman <douglaschristman@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Tue, 21 Jul 2015 19:51:48 -0400
Message-ID: <CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
	<20150720065446.GA13879@dtor-ws>
	<20150720072548.GA25910@pali>
	<CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
	<20150721071218.GA27290@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:32911 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284AbbGUXvt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 19:51:49 -0400
Received: by igbpg9 with SMTP id pg9so76480674igb.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 16:51:48 -0700 (PDT)
In-Reply-To: <20150721071218.GA27290@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Jul 21, 2015 at 3:12 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> It is not enough. If do not want to recompile full kernel, but just o=
nly
> psmouse.ko I think that the easiest way is to change this define
>
>  #define psmouse_dbg
>
> in file drivers/input/mouse/psmouse.h to call dev_warn instead dev_db=
g.
> And then just compile psmouse.ko and reload it.

Thanks, that seemed to do the trick.  This is what I get from dmesg now=
:

[    6.281814] psmouse serio1: cypress_ps2: send extension cmd 0x00, [0=
 0 0 0]
[    6.540028] psmouse serio1: cypress_ps2: Command 0x00 response data
(0x): 00 00 14
[    6.582031] psmouse serio1: alps: E6 report: 00 00 64
[    6.617471] psmouse serio1: alps: E7 report: 22 02 14
[    6.656974] psmouse serio1: alps: EC report: 10 00 64
[    7.104479] psmouse serio1: alps: E6 report: 00 00 64
[    7.139714] psmouse serio1: alps: E7 report: 22 02 14
[    7.176568] psmouse serio1: alps: EC report: 10 00 64
[    7.368849] psmouse serio1: alps: F5 report: 05 01 0a
[    7.541367] input: AlpsPS/2 ALPS DualPoint Stick as
/devices/platform/i8042/serio1/input/input11
[    7.571454] input: AlpsPS/2 ALPS DualPoint TouchPad as
/devices/platform/i8042/serio1/input/input8
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
