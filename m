From: Terry Lambert <tlambert@chromium.org>
Subject: Re: Busted keyboard, fix, and Question about default HID device plumbing
Date: Fri, 7 Oct 2011 16:01:19 -0700
Message-ID: <CAA_E9NEDVynFfVBfkXPW6viAsGT3_ffBVfD309eSAeqq6QGj3w@mail.gmail.com>
References: <CAA_E9NGQC1Jy-MqRbMEj1cetuFktknBmtU91N7gPv1_rApzX6Q@mail.gmail.com>
	<20111007220745.GA30273@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:31735 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab1JGXBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 19:01:24 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p97N1MHl024932
	for <linux-input@vger.kernel.org>; Fri, 7 Oct 2011 16:01:22 -0700
Received: from gya6 (gya6.prod.google.com [10.243.49.6])
	by hpaq12.eem.corp.google.com with ESMTP id p97N0OPI018170
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 7 Oct 2011 16:01:20 -0700
Received: by gya6 with SMTP id 6so6029511gya.8
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2011 16:01:20 -0700 (PDT)
In-Reply-To: <20111007220745.GA30273@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-usb@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Thanks for replying, Dmitry...

I guess I need to clarify a point or two.

On Fri, Oct 7, 2011 at 3:07 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Terry,
>
> On Fri, Oct 07, 2011 at 01:44:29PM -0700, Terry Lambert wrote:
> > I have a USB keyboard that needs a workaround. =A0I know what the
> > workaround is, but not where to plumb it in.
> >
> > This is apparently an issue with a number of keyboards from a numbe=
r
> > of vendors, and Mac OS X and Windows both work around it. =A0It imp=
acts
> > all Linux desktops, Android, and Chrome OS for a number of popular
> > folding keyboards, as well as other keyboards.
> >
> > I'm perfectly able to write the workaround, and have done so using =
the
> > boot protocol, but now I want to fix the issue in the default stack
> > used for the console.
> >
> > I don't care about the UHCI/EHCI plumbing, or anything up to hiddev=
;
> > but from there it gets murky as to how an event in the raw driver e=
nds
> > up getting turned into a keyboard key. =A0It appears to be lost in
> > callbacks I'm having a hard time tracing through.
> >
> > I've read three books on the Linux USB system, two of them very out=
 of
> > date, and they're all written from the perspective of "So, you want=
 to
> > write a device driver", rather than the perspective of "This book
> > documents the plumbing between the driver and userspace and how to
> > figure it out".
> >
> > So the question is: how are things plumbed between hiddev and the
> > console driver,
>
>
> They aren't. Or maybe we are talking about different "hiddev"s. The
> generic HID driver binds devices to hid-input which registers them wi=
th
> input core as separate input devices. The legacy console registers a
> separate input handler (see drivers/tty/vt/keyboard.c) that binds to =
all
> keyboard-like devices, listens to input events and converts them to
> keystrokes and sends them to tty.

My question is "who processes USB report packets from a USB keyboard
into EV_KEY events?"

I understand that there's a separate evdev handler that publishes raw
events as /dev/input/eventX.  It's handling the events from somewhere,
but it's not clear to me how a hidraw1 event turns into a console
input event.

Somewhere someone is translating a USB 1.11 section 8.3 report into an
EV_KEY, and I need to do the modifier magic to alter the contents of
the reports before it gets to whoever that is.
You seem to be saying hid-input.c ... but I'm not seeing the modifier
bits being processed out of the report?


> There is also a evdev input handler (that's where evtest utility gets
> its data from) that provides input event data to userspace via
> /dev/input/eventX nodes where X picks it does its own thing with it.
>
> > so I can figure out where I need to hack on the
> > events.
> >
> > I just need to know the correct place/method to interpose the event=
s.
> >
> > Any help would be appreciated.
> >
> > Thanks,
> > -- Terry
> >
> > PS: For the curious:
> >
> > I put a USB protocol analyzer on this thing, and discovered the pro=
blem.
> >
> > The issue is that modifier keys are not reported in the bitmap on t=
he
> > keyboard, and are instead signaled as in-band key events themselves=
=2E
> > The Mac OS X and Windows drivers work around the issue by
> > pre-processing the event stream looking for in-band modifier keys, =
and
> > then converting them into bit-sets in the (0'ed) bitmap of modifier
> > keys, and then dropping them from the key event stream. =A0Without =
the
> > workaround, the report order is such that it looks like a modifier =
up
> > report followed by a keystroke. =A0Here's evtest output for the seq=
uence
> > after processing by the (unknown to me -- that's what I'm trying to
> > find out) code:
> >
> > Event: time 1318019769.922534, type 4 (Misc), code 4 (ScanCode), va=
lue 700e1
> > Event: time 1318019769.922550, type 1 (Key), code 42 (LeftShift), v=
alue 1
> > Event: time 1318019769.922554, -------------- Report Sync ---------=
---
> > Event: time 1318019770.082521, type 4 (Misc), code 4 (ScanCode), va=
lue
> > 700e1 XXXX
> > Event: time 1318019770.082534, type 1 (Key), code 42 (LeftShift),
> > value 0 =A0 =A0 =A0 =A0 =A0XXXX
>
> Hmm, so the shift is reported as released before we get the next key.=
=2E.
> Wierd...
>
> > Event: time 1318019770.082549, type 4 (Misc), code 4 (ScanCode), va=
lue 7001e
> > Event: time 1318019770.082553, type 1 (Key), code 2 (1), value 1
> > Event: time 1318019770.082555, -------------- Report Sync ---------=
---
> > 1Event: time 1318019770.242541, type 4 (Misc), code 4 (ScanCode), v=
alue 7001e
> > Event: time 1318019770.242552, type 1 (Key), code 2 (1), value 0
> > Event: time 1318019770.242555, -------------- Report Sync ---------=
---
> >
> > This is a shift-1.
> >
> > The patch for usbkbd.c looks like this:
> >
> > diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkb=
d.c
> > index 0658173..d22ecdb 100644
> > --- a/drivers/hid/usbhid/usbkbd.c
> > +++ b/drivers/hid/usbhid/usbkbd.c
> > @@ -2,6 +2,10 @@
> > =A0 * =A0Copyright (c) 1999-2001 Vojtech Pavlik
> > =A0 *
> > =A0 * =A0USB HIDBP Keyboard support
> > + *
> > + * Device Class Definition for Human Interface Devices (HID) Versi=
on 1.11
> > + * Section 8.3 describes the report formant.
> > + * http://www.usb.org/developers/devclass_docs/HID1_11.pdf
> > =A0 */
> >
> > =A0/*
> > @@ -97,6 +101,16 @@ static void usb_kbd_irq(struct urb *urb)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto resubmit;
> > =A0 =A0 =A0 =A0 }
> >
> > + =A0 =A0 =A0 /* Convert in-band modifier keys to modifier bits */
> > + =A0 =A0 =A0 for (i =3D 2; i < 8; i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kbd->new[i] >=3D 0xE0 && kbd->new=
[i] <=3D 0xE7) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kbd->new[0] |=3D (1 >=
> (kbd->new[i] - 0xE0));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kbd->new[i] =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
>
> Wait, why are you using usbkbd? Unless you have very compelling reaso=
n
> you should be using hid & hid-input.

I fixed it there because it was accessible and a way to test the fix.
I'm also going to have to do something similar for coreboot/u-boot to
allow the keyboard to be used in the boot loader, so it's not wasted
effort, and it was an OK proof of concept.  So there was a good
reason.

I'm getting the impression from the above that the file I should be
looking in is:

    drivers/hid/hid-input.c

Where are the modifier bits being decoded there?  Maybe I'm just not
seeing something in front of me...

The analyzer reports the USB over the wire report as:

<-- left shift key down -->
    00 00 E1 00 00 00 00 00  <- transaction
    69 82 18  <- input packet
    48 00 00 E1 00 00 00 00 00 A8 45 <-- breakout : <--
        Keyboard LeftControl : 0b0
        Keyboard LeftShift : 0b0  <-- ***WRONG ***
        Keyboard LeftAlt : 0b0
        Keyboard LeftGUI : 0b0
        Keyboard RightControl : 0b0
        Keyboard RightShiftl : 0b0
        Keyboard RightAlt : 0b0
        Keyboard RightGUI : 0b0
        Keyboard/Keypad Array : Keyboard LeftShift (225) <-- ***WRONG *=
**
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
    -->
<-- 1 key down -->
    00 00 E1 1E 00 00 00 00  <- transaction
    69 82 18  <- input packet
    C3 00 00 E1 1E 00 00 00 00 A8 45 <-- breakout : <--
        Keyboard LeftControl : 0b0
        Keyboard LeftShift : 0b0  <-- ***WRONG ***
        Keyboard LeftAlt : 0b0
        Keyboard LeftGUI : 0b0
        Keyboard RightControl : 0b0
        Keyboard RightShiftl : 0b0
        Keyboard RightAlt : 0b0
        Keyboard RightGUI : 0b0
        Keyboard/Keypad Array : Keyboard LeftShift (d225)  <-- *** WRON=
G ***
        Keyboard/Keypad Array : Keyboard 1 and ! (d30)
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
    -->
<-- 1 key up -- >
    00 00 E1 00 00 00 00 00  <- transaction
    69 82 18  <- input packet
    48 00 00 E1 00 00 00 00 00 A8 45 <-- breakout : <--
        Keyboard LeftControl : 0b0
        Keyboard LeftShift : 0b0
        Keyboard LeftAlt : 0b0
        Keyboard LeftGUI : 0b0
        Keyboard RightControl : 0b0
        Keyboard RightShiftl : 0b0
        Keyboard RightAlt : 0b0
        Keyboard RightGUI : 0b0
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
        Keyboard/Keypad Array : 00
    -->
<-- left shift key up -->
    00 00 00 00 00 00 00 00  <- transaction
    69 82 18  <- input packet
    48 00 00 00 00 00 00 00 00 BF F4 <-- breakout : <--
        Keyboard LeftControl : 0b0
        Keyboard LeftShift : 0b0  <-- ***WRONG ***
        Keyboard LeftAlt : 0b0
        Keyboard LeftGUI : 0b0
        Keyboard RightControl : 0b0
        Keyboard RightShiftl : 0b0
        Keyboard RightAlt : 0b0
        Keyboard RightGUI : 0b0
        Keyboard/Keypad Array : Keyboard LeftShift (225) <-- ***WRONG *=
**
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
        Keyboard/Keypad Array :
    -->

I just need to know where in the code to stomp the report into
correctness. Should make a bunch of people happy. 8-)

Thanks,
-- Terry

> Thanks.
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
