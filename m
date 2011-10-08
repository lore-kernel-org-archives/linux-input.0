From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Busted keyboard, fix, and Question about default HID device
 plumbing
Date: Fri, 7 Oct 2011 17:25:24 -0700
Message-ID: <20111008002524.GB30273@core.coreip.homeip.net>
References: <CAA_E9NGQC1Jy-MqRbMEj1cetuFktknBmtU91N7gPv1_rApzX6Q@mail.gmail.com>
 <20111007220745.GA30273@core.coreip.homeip.net>
 <CAA_E9NEDVynFfVBfkXPW6viAsGT3_ffBVfD309eSAeqq6QGj3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54087 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab1JHAZc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 20:25:32 -0400
Content-Disposition: inline
In-Reply-To: <CAA_E9NEDVynFfVBfkXPW6viAsGT3_ffBVfD309eSAeqq6QGj3w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Lambert <tlambert@chromium.org>
Cc: linux-usb@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Fri, Oct 07, 2011 at 04:01:19PM -0700, Terry Lambert wrote:
> Thanks for replying, Dmitry...
>=20
> I guess I need to clarify a point or two.
>=20
> On Fri, Oct 7, 2011 at 3:07 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Terry,
> >
> > On Fri, Oct 07, 2011 at 01:44:29PM -0700, Terry Lambert wrote:
> > > I have a USB keyboard that needs a workaround. =A0I know what the
> > > workaround is, but not where to plumb it in.
> > >
> > > This is apparently an issue with a number of keyboards from a num=
ber
> > > of vendors, and Mac OS X and Windows both work around it. =A0It i=
mpacts
> > > all Linux desktops, Android, and Chrome OS for a number of popula=
r
> > > folding keyboards, as well as other keyboards.
> > >
> > > I'm perfectly able to write the workaround, and have done so usin=
g the
> > > boot protocol, but now I want to fix the issue in the default sta=
ck
> > > used for the console.
> > >
> > > I don't care about the UHCI/EHCI plumbing, or anything up to hidd=
ev;
> > > but from there it gets murky as to how an event in the raw driver=
 ends
> > > up getting turned into a keyboard key. =A0It appears to be lost i=
n
> > > callbacks I'm having a hard time tracing through.
> > >
> > > I've read three books on the Linux USB system, two of them very o=
ut of
> > > date, and they're all written from the perspective of "So, you wa=
nt to
> > > write a device driver", rather than the perspective of "This book
> > > documents the plumbing between the driver and userspace and how t=
o
> > > figure it out".
> > >
> > > So the question is: how are things plumbed between hiddev and the
> > > console driver,
> >
> >
> > They aren't. Or maybe we are talking about different "hiddev"s. The
> > generic HID driver binds devices to hid-input which registers them =
with
> > input core as separate input devices. The legacy console registers =
a
> > separate input handler (see drivers/tty/vt/keyboard.c) that binds t=
o all
> > keyboard-like devices, listens to input events and converts them to
> > keystrokes and sends them to tty.
>=20
> My question is "who processes USB report packets from a USB keyboard
> into EV_KEY events?"

drivers/hid/hid-input.c

>=20
> I understand that there's a separate evdev handler that publishes raw
> events as /dev/input/eventX.  It's handling the events from somewhere=
,
> but it's not clear to me how a hidraw1 event turns into a console
> input event.
>=20
> Somewhere someone is translating a USB 1.11 section 8.3 report into a=
n
> EV_KEY, and I need to do the modifier magic to alter the contents of
> the reports before it gets to whoever that is.
> You seem to be saying hid-input.c ... but I'm not seeing the modifier
> bits being processed out of the report?

I do not believe we pay attention to these modifier bits as we keep
track of keys pressed ourselves (and keys could be remapped anyway).

Anyway, it looks like the devicde should not be reportign LeftShift
together with 1 in the 2nd report as it makes hhid-input think that
(accounding to the rules of 8.3) it is being released.

I wonder if the fix is to not replrt released when we get newly pressed
keys in the report.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
