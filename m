From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Missing axis on Gembird JPD-DUALFORCE2 since Linux 3.18
Date: Tue, 11 Aug 2015 11:35:05 -0400
Message-ID: <CAN+gG=GBavJ8cSpg3_oo4SDSjdjb2xGE-ir3dXgeyupqcF6q+A@mail.gmail.com>
References: <20150810082642.3a0880ab@orivej.orivej.org>
	<CAN+gG=EmtKjR2bw1c=LedYv24PPaPVijW-HqsyxA0mF6F4+FrQ@mail.gmail.com>
	<20150810213608.356908e5@orivej.orivej.org>
	<CAN+gG=FkyGdYQwBFYfRFGuTC5xPpieoq7gDeQwFs5B1A8ZOhqA@mail.gmail.com>
	<20150810222855.7e08c16e@orivej.orivej.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38364 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbHKPfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2015 11:35:09 -0400
Received: by wicja10 with SMTP id ja10so73349205wic.1
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2015 08:35:08 -0700 (PDT)
In-Reply-To: <20150810222855.7e08c16e@orivej.orivej.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Orivej Desh <orivej@gmx.fr>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, Aug 10, 2015 at 6:28 PM, Orivej Desh <orivej@gmx.fr> wrote:
> * Benjamin Tissoires
>> Thanks for the logs.
>>
>> So, yes, it appears that your joypad as a weird report descriptor.
>> It declares 2 Z axis, no Ry and one Rz.
>>
>> The first Z axis seems somewhat correlated to X, but does not seem t=
o
>> add any actual value but noise.
>
> That's right.
>
>> If I understand correctly your problem, I can submit a patch which
>> will mute the Z axis, and provide proper Rx,Ry so you won't have to
>> deal with that in userspace.
>> Will this be OK with you?
>
> I would appreciate it if you do this, and learn to do it myself!  Yet=
 I

OK. And sorry, I started ahead yesterday before your answer, so this
morning I already had a half-backed patch waiting for tests.

> think that Z axis is better removed than muted; it serves no purpose =
and
> would only confuse other users of this device (if any) when tools
> present them with 7 axes to configure.

OK. This step made the patch slightly more complicated, so in the end,
I believe I (or you if you want) might need to use a different
solution to fix this. Anyway, I'll send the patch in a few minutes. I
tested it on your logs, and they seem to behave properly now. However,
tests with real hardware are much appreciated. I can help you if you
need to set up the test kernel that you will have to rebuild (and I
can do that in French too - basing this on the @gmx.fr).

Cheers,
Benjamin

>
>> On Mon, Aug 10, 2015 at 5:36 PM, Orivej Desh <orivej@gmx.fr> wrote:
>> > * Benjamin Tissoires
>> >> Thanks for the bisect. Could you please run a hid-recorder from
>> >> http://bentiss.github.io/hid-replay-docs/ and record a few events=
 from
>> >> your joypad? Depending on the output, we will be able to tell you
>> >> where this should be fixed (but I strongly suspect that the kerne=
l
>> >> should be fixed).
>> >
>> > See attached idle.hid, with what appears to be noise on the Z axis=
 when
>> > the joypad is idle, and XYRxRy.hid with my approximation to the se=
quence
>> > of physical X Y Rx Ry zero-negative-positive-zero swings.
>>
>> >> On Mon, Aug 10, 2015 at 4:26 AM, Orivej Desh <orivej@gmx.fr> wrot=
e:
>> >> > I have one of those gamepads, and since Linux 3.18 the kernel h=
ides one
>> >> > of its axes.
>> >> >
>> >> > In Linux 3.17 jstest reports it as
>> >> >
>> >> >      Joystick (PC Game Controller       ) has 7 axes (X, Y, Z, =
Rx, Rz, Hat0X, Hat0Y)
>> >> >
>> >> > and in Linux 3.18 as
>> >> >
>> >> >      Joystick (PC Game Controller       ) has 6 axes (X, Y, Z, =
Rz, Hat0X, Hat0Y)
>> >> >
>> >> > It has 6 physical axes (X, Y, Rx, Ry, Hat0X, Hat0Y), but Ry is =
reported
>> >> > as Rz, and Z emits noise (which had to be silenced with jscal).
>> >> >
>> >> > I bisected disappearing axis to the following commit [1], but i=
f I
>> >> > understand correctly, it is the device that is wrong by misrepo=
rting
>> >> > some property of Rx.
>> >> >
>> >> > I can remap Rz to Ry in userspace with ioctl(fd, JSIOCSAXMAP, .=
=2E.),
>> >> > though I never had to.  Can I likewise restore Rx in userspace =
(and also
>> >> > delete Z)?  If not, or if this device justifies a quirk, how sh=
ould it
>> >> > be added?
>> >> >
>> >> > usb-devices report: [2].
>> >> >
>> >> > [1]
>> >> > commit 79346d620e9de87912de73337f6df8b7f9a46888
>> >> > Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> >> > Date:   Mon Aug 25 13:07:10 2014 -0400
>> >> >
>> >> >     HID: input: force generic axis to be mapped to their user s=
pace axis
>> >> >
>> >> >     Atmel 840B digitizer presents a stylus interface which repo=
rts twice
>> >> >     the X coordinate and then twice the Y coordinate. In its cu=
rrent
>> >> >     implementation, hid-input assign the first X to X, then the=
 second to Y,
>> >> >     then the first Y to Z, then the second one to RX.
>> >> >
>> >> >     This is wrong, and X should always be mapped to X, no matte=
r what.
>> >> >     A solution consists in forcing X, Y, Z, RX, RY, RZ to be ma=
pped to their
>> >> >     correct user space counter part.
>> >> >
>> >> >     Reported-by: =C3=89ric Brunet <Eric.Brunet@lps.ens.fr>
>> >> >     Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redha=
t.com>
>> >> >     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>> >> >
>> >> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> >> > index 2619f7f..2df7fdd 100644
>> >> > --- a/drivers/hid/hid-input.c
>> >> > +++ b/drivers/hid/hid-input.c
>> >> > @@ -599,6 +599,12 @@ static void hidinput_configure_usage(struc=
t hid_input *hidinput, struct hid_fiel
>> >> >                 /* These usage IDs map directly to the usage co=
des. */
>> >> >                 case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
>> >> >                 case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
>> >> > +                       if (field->flags & HID_MAIN_ITEM_RELATI=
VE)
>> >> > +                               map_rel(usage->hid & 0xf);
>> >> > +                       else
>> >> > +                               map_abs_clear(usage->hid & 0xf)=
;
>> >> > +                       break;
>> >> > +
>> >> >                 case HID_GD_SLIDER: case HID_GD_DIAL: case HID_=
GD_WHEEL:
>> >> >                         if (field->flags & HID_MAIN_ITEM_RELATI=
VE)
>> >> >                                 map_rel(usage->hid & 0xf);
>> >> >
>> >> > [2]
>> >> > T:  Bus=3D09 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 S=
pd=3D1.5 MxCh=3D 0
>> >> > D:  Ver=3D 1.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #C=
fgs=3D  1
>> >> > P:  Vendor=3D11ff ProdID=3D3331 Rev=3D01.07
>> >> > S:  Product=3DPC Game Controller
>> >> > C:  #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
>> >> > I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D03(HID  ) Sub=3D00 Prot=3D=
00 Driver=3Dusbhid
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
