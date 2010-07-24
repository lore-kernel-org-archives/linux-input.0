From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ACRUX gamepads not happy with autosuspend?
Date: Sat, 24 Jul 2010 00:51:13 -0700
Message-ID: <20100724075112.GB3615@core.coreip.homeip.net>
References: <4C3F8A90.3020308@dv-life.ru>
 <201007201203.43573.oneukum@suse.de>
 <1279628053.6419.3.camel@desktop>
 <201007201424.20880.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53142 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0GXHvS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jul 2010 03:51:18 -0400
Content-Disposition: inline
In-Reply-To: <201007201424.20880.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: x0r <x0r@dv-life.ru>, Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>

On Tue, Jul 20, 2010 at 02:24:20PM +0200, Oliver Neukum wrote:
> Am Dienstag, 20. Juli 2010, 14:14:13 schrieb x0r:
> > =D0=92 =D0=92=D1=82=D1=80, 20/07/2010 =D0=B2 12:03 +0200, Oliver Ne=
ukum =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > Am Dienstag, 20. Juli 2010, 10:58:50 schrieb Jiri Kosina:
> > > > On Tue, 20 Jul 2010, Oliver Neukum wrote:
> > > >=20
> > > > > > It looks like ACRUX game controllers do not like autopm. Th=
ere is
> > > > > > a bug report over at Ubuntu's launchpad:
> > > > > >=20
> > > > > > 	https://bugs.launchpad.net/ubuntu/+source/joystick/+bug/44=
8446
> > > > >=20
> > > > > That report shows that the symptoms are consistent with autos=
uspend,
> > > > > but it doesn't show that autosuspend was on.
> > > >=20
> > > > That would be my first question -- who enabled autosuspend, if =
it was=20
> > > > really on? I thought it should be still off by default, shouldn=
't it?
> > >=20
> > > It is off by default, but that doesn't stop Ubuntu having a udev =
rule to
> > > switch it on or patching the kernel, so it might be on. We simply=
 need
> > > to know.
> > >=20
> > > 	Regards
> > > 		Oliver
> > >=20
> >=20
> > x0r@desktop:~$ cat /sys/bus/usb/devices/5-1/power/autosuspend
> > 2
> >=20
> > Does it mean that autosuspend is enabled?
>=20
> No, this means that if it is enabled a heuristic timeout of 2s is use=
d.
> That is if your device has been being idle for 2s, it will be autosus=
pend.
>=20
> Whether it is autosuspended at all all is controlled in the "level" a=
ttribute.
>=20
> on =3D no autosuspend
> auto =3D autosuspend activated
>=20

Hmm, Sergei says that fiddling with autosuspend values (nor disabling i=
t
altogether by recompiling without CONFIG_USB_SUSPEND) helps. If device
left unopened then attempts to open it (and thus start traffic) at a
later time fail.

Sergei, what happens if you have the device plugged and compile HID as =
a
module and then unload/reload the driver and try opening the device
right away? Does it work or is it still dead?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
