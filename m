From: Douglas Christman <douglaschristman@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Mon, 20 Jul 2015 23:00:27 -0400
Message-ID: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
	<20150720065446.GA13879@dtor-ws>
	<20150720072548.GA25910@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35178 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbGUDA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 23:00:28 -0400
Received: by iecri3 with SMTP id ri3so36929906iec.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 20:00:28 -0700 (PDT)
In-Reply-To: <20150720072548.GA25910@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Jul 20, 2015 at 3:25 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> Hi! Please recompile psmouse.ko with dev_dbg() debug information and
> send new dmesg output. We need to know type of ALPS device. Thanks!

I recompiled with CONFIG_DYNAMIC_DEBUG and echoed 'module psmouse' to
/sys/kernel/debug/dynamic_debug/control as described in
Documentation/dynamic-debug-howto.txt, but I don't see any additional
output in dmesg after reloading the module.  I haven't done this
before, so I'm probably overlooking something...

In the meantime, hopefully this output from hwinfo can be of use:

52: PS/2 00.0: 10500 PS/2 Mouse
  [Created at input.249]
  Unique ID: AH6Q.5+smWHVjPI3
  Hardware Class: mouse
  Model: "AlpsPS/2 ALPS DualPoint Stick"
  Vendor: 0x0002
  Device: 0x0008 "AlpsPS/2 ALPS DualPoint Stick"
  Compatible to: int 0x0210 0x0003
  Device File: /dev/input/mice (/dev/input/mouse0)
  Device Files: /dev/input/mice, /dev/input/mouse0,
/dev/input/event11,
/dev/input/by-path/platform-i8042-serio-1-event-mouse,
/dev/input/by-path/platform-i8042-serio-1-mouse
  Device Number: char 13:63 (char 13:32)
  Driver Info #0:
    Buttons: 3
    Wheels: 0
    XFree86 Protocol: explorerps/2
    GPM Protocol: exps2
  Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown

53: PS/2 00.0: 10500 PS/2 Mouse
  [Created at input.249]
  Unique ID: AH6Q.5+smWHVjPI3
  Hardware Class: mouse
  Model: "AlpsPS/2 ALPS DualPoint TouchPad"
  Vendor: 0x0002
  Device: 0x0008 "AlpsPS/2 ALPS DualPoint TouchPad"
  Compatible to: int 0x0210 0x0003
  Device File: /dev/input/mice (/dev/input/mouse1)
  Device Files: /dev/input/mice, /dev/input/mouse1,
/dev/input/event12,
/dev/input/by-path/platform-i8042-serio-1-event-mouse,
/dev/input/by-path/platform-i8042-serio-1-mouse
  Device Number: char 13:63 (char 13:33)
  Driver Info #0:
    Buttons: 3
    Wheels: 0
    XFree86 Protocol: explorerps/2
    GPM Protocol: exps2
  Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
