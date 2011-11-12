From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Annoying touchpad behavior
Date: Sat, 12 Nov 2011 15:35:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1111121529400.11486-100000@netrider.rowland.org>
References: <CAGS+omA3XM9HOsPZ-UbQ8RX3bQWe9SDKYtZadfLtkdMj00E+6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:57985 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751712Ab1KLUfZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 15:35:25 -0500
In-Reply-To: <CAGS+omA3XM9HOsPZ-UbQ8RX3bQWe9SDKYtZadfLtkdMj00E+6Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sun, 13 Nov 2011, Daniel Kurtz wrote:

> Hi Alan,
>=20
> On Sun, Nov 13, 2011 at 1:15 AM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
> > On Fri, 11 Nov 2011, Dmitry Torokhov wrote:
> >
> >> Hi Alan,
> >>
> >> On Fri, Nov 11, 2011 at 11:10:46PM -0500, Alan Stern wrote:
> >> > Dmitry:
> >> >
> >> > My laptop has a Synaptics touchpad:
> >> >
> >> > [ =A0 =A02.528474] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x=
1c0b1, caps: 0xd04731/0xa40000/0xa0000
> >> > [ =A0 =A02.566383] input: SynPS/2 Synaptics TouchPad as /devices=
/platform/i8042/serio4/input/input4
> >> >
> >> > Under circumstances which I can't pin down (they generally invol=
ve my
> >> > thumb brushing over the trackpad, which happens fairly often as =
I
> >> > type), the touchpad reports a right-click. =A0This causes gnome-=
terminal
> >> > to pop up its menu, which is very annoying.
> >> >
> >> > Why does the trackpad report a right-click instead of a normal
> >> > left-click? =A0How can I fix this?
> >>
> >> You probably have corner taps or multi-finger taps enabled on your=
 box.
> >> What does "synclient' has to say about your setup?
> >
> > Here's the output from "synclient -l":
=2E..

> The synaptics X input driver is probably interpreting large contacts
> as 2-fingers, which is in turn being translated into a 2-finger tap.

That's right!  2-finger taps are reliably interpreted as right-clicks.

> To completely disable "2-finger Tap as Right Click", try setting TapB=
utton2 =3D 0.
> To temporarily change the setting, you can use the synclient program.
> To make it permanent, change the value in the Synaptics section of
> your xorg.conf file, and restart X.

The synclient program does the job.  However there is no Synaptics=20
section in xorg.conf.  In fact, there isn't any xorg.conf file at all;=20
the /etc/X11/xorg.conf.d directory contains only=20
00-system-setup-keyboard.conf, which talks about the keyboard but not=20
the touchpad.

Presumably I can add a similar file with config information for the=20
touchpad driver, but I'm not sure what it should say.  Any suggestions?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
