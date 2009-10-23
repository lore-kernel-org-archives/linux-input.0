From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not  work	anymore
Date: Fri, 23 Oct 2009 11:21:10 +0200
Message-ID: <4AE17586.9020009@tremplin-utc.net>
References: <928C125D-D36B-47C9-A549-3EE502C9EC73@gmail.com> <20091015215944.GA9845@core.coreip.homeip.net> <4ADF6237.9070004@tremplin-utc.net> <200910211320.16339.dmitry.torokhov@gmail.com> <4AE0840C.8070801@tremplin-utc.net> <20091022162202.GA18031@core.coreip.homeip.net> <4AE09AFF.805@tremplin-utc.net> <20091022181915.GB18031@core.coreip.homeip.net> <4AE16489.4030008@tremplin-utc.net> <20091023085824.GA7199@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:29569 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZJWJVN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2009 05:21:13 -0400
In-Reply-To: <20091023085824.GA7199@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 23-10-09 10:58, Dmitry Torokhov schreef:
> On Fri, Oct 23, 2009 at 10:08:41AM +0200, =C9ric Piel wrote:
>> Op 22-10-09 20:19, Dmitry Torokhov schreef:
>>> On Thu, Oct 22, 2009 at 07:48:47PM +0200, =C9ric Piel wrote:
>>>> I don't think so: xorg 1.6.5, with xinput-evdev 2.2.5. They are bo=
th =20
>>>> latest or second latest stable versions.
>>>>
>>>> In the log I see this:
>>>> (--) SynPS/2 Synaptics TouchPad: touchpad found
>>>> (II) PS/2 Generic Mouse: Device reopened after 1 attempts.
>>>> (EE) AT Translated Set 2 keyboard: device key_bitmask has changed
>>>> (EE) AT Translated Set 2 keyboard: Device has changed - disabling.
>>>>
>>>> Quite a few people seem to have the same problem.
>>> The bitmask should not be changing on it's own... Any chance you co=
uld
>>> save contents or /proc/bus/input/devices before suspend and after r=
esume
>>> (when X decides to ditch the keyboard) and diff them?
>>>
>> Hello,
>> I've just tried this: before and after is exactly the same (attached=
 is
>> a copy of it).
>>
>=20
> What about before X starts? Can you please boot into console, kill
> hal and udev to make sure they don't mess up with the keymap and, aft=
er
> doing
>=20
> 	echo -n rescan > /sys/bus/serio/devices/serio0/drvctl
>=20
> which should completely reinitialize keyboard and compare
> /proc/bus/input/devices again? If it is still the same then there mus=
t
> be a silly bug in X's evdev...
Ok, I'll reboot later and try. In the mean time, I've just tried this o=
n
my non-working keyboard, and it resurrected it :-) Even more
interestingly, the key bitmap has changed.

Before:
I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
N: Name=3D"AT Translated Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
S: Sysfs=3D/devices/platform/i8042/serio0/input/input4
U: Uniq=3D
H: Handlers=3Dkbd event4 evbug rfkill
B: EV=3D120013
B: KEY=3D20 0 0 30400f02100000 17803878f800d401 feffffdfffefffff
ffffffffffffffff
B: MSC=3D10
B: LED=3D7

After:
I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
N: Name=3D"AT Translated Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
S: Sysfs=3D/devices/platform/i8042/serio0/input/input15
U: Uniq=3D
H: Handlers=3Dkbd event4 evbug
B: EV=3D120013
B: KEY=3D20000 20000000020 0 0 500f02100003 3803078f900d401
feffffdfffefffff ffffffffffffffff
B: MSC=3D10
B: LED=3D7

Was this expected?

> But regardless, X policy of comparing
> keybit is stupid - they don't kill the device if I change keymap whil=
e
> in X, why do they do that on resume? Or when I change the limits on
> absolute axis... Oh well.
With respect to this bug, I have opened a bug report for xorg:
https://bugs.freedesktop.org/show_bug.cgi?id=3D24687
Indeed, evdev tend to disable for plenty of different reason the
keyboard (cf src/evdev.c: EvdevCacheCompare()). The source code is not
very clear why they do this, but somehow I was under the impression tha=
t
it was to avoid using twice the same device (with slightly different
properties).

See you,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
