From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Wed, 29 Nov 2017 13:43:52 -0800
Message-ID: <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:32833 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdK2Vnx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 16:43:53 -0500
Received: by mail-ua0-f174.google.com with SMTP id v20so4427944uaj.0
        for <linux-input@vger.kernel.org>; Wed, 29 Nov 2017 13:43:53 -0800 (PST)
In-Reply-To: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: Linux Input <linux-input@vger.kernel.org>

Hi Kevin,

The Bluetooth and tablet issues are likely to be unrelated. The
Bluetooth button is completely independent from the rest of the
tablet, with neither the tablet sensor nor the Wacom driver being
aware of it.

>From what I understand, in normal operation the Bluetooth button is
disconnected most of the time. When you press it, it briefly wakes up,
connects to the paired PC, appears as a keyboard, sends a key combo,
and then disconnects until you press it again. If you run something
like `sudo libinput-debug-events` and then press the button, you
should be able to see the key combo being sent (as well as the
connect/disconnect). I'm not sure what's up with the deadlock warning
that appears in dmesg, however...

As for the tablet, the "last error =3D -121" indicates that we got an
EREMOTEIO error. I've not come across that particular error in this
function before. I'll need some time to track down why we might be
getting this from the lower layers.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Mon, Nov 27, 2017 at 12:23 PM, Kevin Fenzi <kevin@scrye.com> wrote:
> Greetings.
>
> I'm running into some problems with Lenovo active pen 2 and wacom tablet
> on a new yoga 920.
>
> Filed:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1514837
>
> but I thought I would ask here if anyone had any ideas...
>
> Basically when pairing the pen it shows for a second, then drops:
>
> [Sat Nov 18 12:22:42 2017] input: Lenovo Active Pen2 as
> /devices/virtual/misc/uhid/0005:17EF:60A8.0006/input/input23
> [Sat Nov 18 12:22:42 2017] hid-generic 0005:17EF:60A8.0006:
> input,hidraw4: BLUETOOTH HID v0.02 Keyboard [Lenovo Active Pen2] on
> 64:6E:69:D1:A0:48
> [Sat Nov 18 12:22:47 2017] Bluetooth: hci0: last event is not cmd
> complete (0x0f)
> [Sat Nov 18 12:23:03 2017] Bluetooth: hci0: last event is not cmd
> complete (0x0f)
> [Sat Nov 18 12:23:19 2017] Bluetooth: hci0: last event is not cmd
> complete (0x0f)
>
> The wacom tablet is never connecting:
>
> [Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Pen as
> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0=
018:056A:5110.0003/input/input26
> [Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Finger as
> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00/0=
018:056A:5110.0003/input/input27
> [Fri Nov 24 21:47:01 2017] wacom 0018:056A:5110.0003: hidraw3: I2C HID
> v1.00 Mouse [WCOM5110:00 056A:5110] on i2c-WCOM5110:00
> [Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
> report to device.
> [Fri Nov 24 21:47:02 2017] wacom 0018:056A:5110.0003: wacom_set_report:
> ran out of retries (last error =3D -121)
> [Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
> report to device.
>
> Happy to gather more info and/or try patches.
>
> Thanks.
>
> kevin
>
