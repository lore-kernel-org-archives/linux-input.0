From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not  work
	anymore
Date: Thu, 22 Oct 2009 11:32:50 -0700
Message-ID: <20091022183249.GC18031@core.coreip.homeip.net>
References: <928C125D-D36B-47C9-A549-3EE502C9EC73@gmail.com> <20091015215944.GA9845@core.coreip.homeip.net> <4ADF6237.9070004@tremplin-utc.net> <200910211320.16339.dmitry.torokhov@gmail.com> <4AE0840C.8070801@tremplin-utc.net> <20091022162202.GA18031@core.coreip.homeip.net> <4AE09AFF.805@tremplin-utc.net> <20091022181915.GB18031@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:33330 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbZJVScw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Oct 2009 14:32:52 -0400
Content-Disposition: inline
In-Reply-To: <20091022181915.GB18031@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Oct 22, 2009 at 11:19:15AM -0700, Dmitry Torokhov wrote:
> On Thu, Oct 22, 2009 at 07:48:47PM +0200, =C9ric Piel wrote:
> > Op 22-10-09 18:22, Dmitry Torokhov schreef:
> >> On Thu, Oct 22, 2009 at 06:10:52PM +0200, =C9ric Piel wrote:
> >>> Op 21-10-09 22:20, Dmitry Torokhov schreef:
> >>>>
> >>>> Nothing, as far as I can tell... I see you typing "qwerty"... Do=
es the
> >>>> keyboard work in console (let's say if you boot in run level 3 t=
o take X out
> >>>> of the picture)? Could you please try compiling evbug module - i=
t will show if
> >>>> keyboard events are propagated through input core. Also, whta dr=
iver are you
> >>>> using in X? Legacy keyboard or evdev?
> >>> In the console (in init 3), I haven't managed to reproduce it. In=
 xorg,
> >>> the keyboard input uses evdev. Now I've just tried "evtest
> >>> /dev/input/event4", when the keyboard doesn't work... and I see t=
he key
> >>> presses!
> >>>
> >>> So I guess it rules out a bug in the kernel, and I have to talk w=
ith the
> >>> people from Xorg, right?
> >>>
> >>
> >> Yep... but it is still wierd since evdev driver works fine for me.=
=2E.
> >> Could it be you are using either too old or too new version of X?
> >>
> > I don't think so: xorg 1.6.5, with xinput-evdev 2.2.5. They are bot=
h =20
> > latest or second latest stable versions.
> >

Same here...

> > In the log I see this:
> > (--) SynPS/2 Synaptics TouchPad: touchpad found
> > (II) PS/2 Generic Mouse: Device reopened after 1 attempts.
> > (EE) AT Translated Set 2 keyboard: device key_bitmask has changed
> > (EE) AT Translated Set 2 keyboard: Device has changed - disabling.
> >
> > Quite a few people seem to have the same problem.
>=20
> The bitmask should not be changing on it's own... Any chance you coul=
d
> save contents or /proc/bus/input/devices before suspend and after res=
ume
> (when X decides to ditch the keyboard) and diff them?
>=20

Also, are you using 64 bit userspace?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
