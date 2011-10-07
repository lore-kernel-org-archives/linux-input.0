From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Busted keyboard, fix, and Question about default HID device
 plumbing
Date: Fri, 7 Oct 2011 15:07:45 -0700
Message-ID: <20111007220745.GA30273@core.coreip.homeip.net>
References: <CAA_E9NGQC1Jy-MqRbMEj1cetuFktknBmtU91N7gPv1_rApzX6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59249 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab1JGWHy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 18:07:54 -0400
Content-Disposition: inline
In-Reply-To: <CAA_E9NGQC1Jy-MqRbMEj1cetuFktknBmtU91N7gPv1_rApzX6Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Lambert <tlambert@chromium.org>
Cc: linux-usb@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Terry,

On Fri, Oct 07, 2011 at 01:44:29PM -0700, Terry Lambert wrote:
> I have a USB keyboard that needs a workaround.  I know what the
> workaround is, but not where to plumb it in.
>=20
> This is apparently an issue with a number of keyboards from a number
> of vendors, and Mac OS X and Windows both work around it.  It impacts
> all Linux desktops, Android, and Chrome OS for a number of popular
> folding keyboards, as well as other keyboards.
>=20
> I'm perfectly able to write the workaround, and have done so using th=
e
> boot protocol, but now I want to fix the issue in the default stack
> used for the console.
>=20
> I don't care about the UHCI/EHCI plumbing, or anything up to hiddev;
> but from there it gets murky as to how an event in the raw driver end=
s
> up getting turned into a keyboard key. =A0It appears to be lost in
> callbacks I'm having a hard time tracing through.
>=20
> I've read three books on the Linux USB system, two of them very out o=
f
> date, and they're all written from the perspective of "So, you want t=
o
> write a device driver", rather than the perspective of "This book
> documents the plumbing between the driver and userspace and how to
> figure it out".
>=20
> So the question is: how are things plumbed between hiddev and the
> console driver,


They aren't. Or maybe we are talking about different "hiddev"s. The
generic HID driver binds devices to hid-input which registers them with
input core as separate input devices. The legacy console registers a
separate input handler (see drivers/tty/vt/keyboard.c) that binds to al=
l
keyboard-like devices, listens to input events and converts them to
keystrokes and sends them to tty.

There is also a evdev input handler (that's where evtest utility gets
its data from) that provides input event data to userspace via
/dev/input/eventX nodes where X picks it does its own thing with it.

> so I can figure out where I need to hack on the
> events.
>=20
> I just need to know the correct place/method to interpose the events.
>=20
> Any help would be appreciated.
>=20
> Thanks,
> -- Terry
>=20
> PS: For the curious:
>=20
> I put a USB protocol analyzer on this thing, and discovered the probl=
em.
>=20
> The issue is that modifier keys are not reported in the bitmap on the
> keyboard, and are instead signaled as in-band key events themselves.
> The Mac OS X and Windows drivers work around the issue by
> pre-processing the event stream looking for in-band modifier keys, an=
d
> then converting them into bit-sets in the (0'ed) bitmap of modifier
> keys, and then dropping them from the key event stream.  Without the
> workaround, the report order is such that it looks like a modifier up
> report followed by a keystroke.  Here's evtest output for the sequenc=
e
> after processing by the (unknown to me -- that's what I'm trying to
> find out) code:
>=20
> Event: time 1318019769.922534, type 4 (Misc), code 4 (ScanCode), valu=
e 700e1
> Event: time 1318019769.922550, type 1 (Key), code 42 (LeftShift), val=
ue 1
> Event: time 1318019769.922554, -------------- Report Sync -----------=
-
> Event: time 1318019770.082521, type 4 (Misc), code 4 (ScanCode), valu=
e
> 700e1 XXXX
> Event: time 1318019770.082534, type 1 (Key), code 42 (LeftShift),
> value 0          XXXX

Hmm, so the shift is reported as released before we get the next key...
Wierd...

> Event: time 1318019770.082549, type 4 (Misc), code 4 (ScanCode), valu=
e 7001e
> Event: time 1318019770.082553, type 1 (Key), code 2 (1), value 1
> Event: time 1318019770.082555, -------------- Report Sync -----------=
-
> 1Event: time 1318019770.242541, type 4 (Misc), code 4 (ScanCode), val=
ue 7001e
> Event: time 1318019770.242552, type 1 (Key), code 2 (1), value 0
> Event: time 1318019770.242555, -------------- Report Sync -----------=
-
>=20
> This is a shift-1.
>=20
> The patch for usbkbd.c looks like this:
>=20
> diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.=
c
> index 0658173..d22ecdb 100644
> --- a/drivers/hid/usbhid/usbkbd.c
> +++ b/drivers/hid/usbhid/usbkbd.c
> @@ -2,6 +2,10 @@
>   *  Copyright (c) 1999-2001 Vojtech Pavlik
>   *
>   *  USB HIDBP Keyboard support
> + *
> + * Device Class Definition for Human Interface Devices (HID) Version=
 1.11
> + * Section 8.3 describes the report formant.
> + * http://www.usb.org/developers/devclass_docs/HID1_11.pdf
>   */
>=20
>  /*
> @@ -97,6 +101,16 @@ static void usb_kbd_irq(struct urb *urb)
>                 goto resubmit;
>         }
>=20
> +       /* Convert in-band modifier keys to modifier bits */
> +       for (i =3D 2; i < 8; i++) {
> +               if (kbd->new[i] >=3D 0xE0 && kbd->new[i] <=3D 0xE7) {
> +                       kbd->new[0] |=3D (1 >> (kbd->new[i] - 0xE0));
> +                       kbd->new[i] =3D 0;
> +               }
> +       }

Wait, why are you using usbkbd? Unless you have very compelling reason
you should be using hid & hid-input.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
