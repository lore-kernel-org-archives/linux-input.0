From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not  work
	anymore
Date: Fri, 23 Oct 2009 09:31:13 -0700
Message-ID: <20091023163113.GA7707@core.coreip.homeip.net>
References: <20091015215944.GA9845@core.coreip.homeip.net> <4ADF6237.9070004@tremplin-utc.net> <200910211320.16339.dmitry.torokhov@gmail.com> <4AE0840C.8070801@tremplin-utc.net> <20091022162202.GA18031@core.coreip.homeip.net> <4AE09AFF.805@tremplin-utc.net> <20091022181915.GB18031@core.coreip.homeip.net> <4AE16489.4030008@tremplin-utc.net> <20091023085824.GA7199@core.coreip.homeip.net> <4AE17586.9020009@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:57574 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbZJWQbU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2009 12:31:20 -0400
Content-Disposition: inline
In-Reply-To: <4AE17586.9020009@tremplin-utc.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Oct 23, 2009 at 11:21:10AM +0200, =C9ric Piel wrote:
> Op 23-10-09 10:58, Dmitry Torokhov schreef:
> > On Fri, Oct 23, 2009 at 10:08:41AM +0200, =C9ric Piel wrote:
> >> Op 22-10-09 20:19, Dmitry Torokhov schreef:
> >>> On Thu, Oct 22, 2009 at 07:48:47PM +0200, =C9ric Piel wrote:
> >>>> I don't think so: xorg 1.6.5, with xinput-evdev 2.2.5. They are =
both =20
> >>>> latest or second latest stable versions.
> >>>>
> >>>> In the log I see this:
> >>>> (--) SynPS/2 Synaptics TouchPad: touchpad found
> >>>> (II) PS/2 Generic Mouse: Device reopened after 1 attempts.
> >>>> (EE) AT Translated Set 2 keyboard: device key_bitmask has change=
d
> >>>> (EE) AT Translated Set 2 keyboard: Device has changed - disablin=
g.
> >>>>
> >>>> Quite a few people seem to have the same problem.
> >>> The bitmask should not be changing on it's own... Any chance you =
could
> >>> save contents or /proc/bus/input/devices before suspend and after=
 resume
> >>> (when X decides to ditch the keyboard) and diff them?
> >>>
> >> Hello,
> >> I've just tried this: before and after is exactly the same (attach=
ed is
> >> a copy of it).
> >>
> >=20
> > What about before X starts? Can you please boot into console, kill
> > hal and udev to make sure they don't mess up with the keymap and, a=
fter
> > doing
> >=20
> > 	echo -n rescan > /sys/bus/serio/devices/serio0/drvctl
> >=20
> > which should completely reinitialize keyboard and compare
> > /proc/bus/input/devices again? If it is still the same then there m=
ust
> > be a silly bug in X's evdev...
> Ok, I'll reboot later and try. In the mean time, I've just tried this=
 on
> my non-working keyboard, and it resurrected it :-)

Yes, it would - "rescan" causes input device teardown and creationa new
one. This causes a hotplug event that is processed by X and it adds a
new device in place of the old one that it decided to disable (due to
keys change).

> Even more
> interestingly, the key bitmap has changed.
>=20

Right, your init scripts/UDEV/HAL whatever adjust keymap to match your
laptop.

> Before:
> I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
> N: Name=3D"AT Translated Set 2 keyboard"
> P: Phys=3Disa0060/serio0/input0
> S: Sysfs=3D/devices/platform/i8042/serio0/input/input4
> U: Uniq=3D
> H: Hadlers=3Dkbd event4 evbug rfkill
> B: EV=3D120013
> B: KEY=3D20 0 0 30400f02100000 17803878f800d401 feffffdfffefffff
> ffffffffffffffff
> B: MSC=3D10
> B: LED=3D7
>=20
> After:
> I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
> N: Name=3D"AT Translated Set 2 keyboard"
> P: Phys=3Disa0060/serio0/input0
> S: Sysfs=3D/devices/platform/i8042/serio0/input/input15
> U: Uniq=3D
> H: Handlers=3Dkbd event4 evbug


Yep, note that the previous instance had rfkill bound, that means the
device had KEY_WLAN or KEY_BLUETOOTH in it's keymap but this one does
not. None of these key codes are in in-kernel keymaps for atkbd; they
were added afterwards.

Now, all depends on when this adjustment happens... In your case it
looks like X server starts before the keymap is adjusted, so on first
resume the keymaps are different and it disables the device.

> B: EV=3D120013
> B: KEY=3D20000 20000000020 0 0 500f02100003 3803078f900d401
> feffffdfffefffff ffffffffffffffff
> B: MSC=3D10
> B: LED=3D7
>=20
> Was this expected?

So yes, kind of expected for laptops.

>=20
> > But regardless, X policy of comparing
> > keybit is stupid - they don't kill the device if I change keymap wh=
ile
> > in X, why do they do that on resume? Or when I change the limits on
> > absolute axis... Oh well.
> With respect to this bug, I have opened a bug report for xorg:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D24687
> Indeed, evdev tend to disable for plenty of different reason the
> keyboard (cf src/evdev.c: EvdevCacheCompare()). The source code is no=
t
> very clear why they do this, but somehow I was under the impression t=
hat
> it was to avoid using twice the same device (with slightly different
> properties).

I can see them not wanting to use the same device if it changed form
keyboard to a mouse (think USB) but differnces in keymaps should be lef=
t
alone I think. As for duplicates, they could just check sysfs path to s=
ee
if they are dealing with the same device or not. Input code does not
re-use 'inputX', X will be monotonically increasing.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
