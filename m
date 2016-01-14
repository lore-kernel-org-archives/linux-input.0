From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS v7 TrackStick detected wrongly
Date: Thu, 14 Jan 2016 11:34:30 -0800
Message-ID: <CAKdAkRS4YjXouY5GAmm+N-w4+CAYPc+WLWb9=rnLodPP3Af_SQ@mail.gmail.com>
References: <1452773083.4165.0@smtp.gmail.com>
	<20160114121118.GU11560@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34251 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbcANTeb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 14:34:31 -0500
Received: by mail-oi0-f49.google.com with SMTP id k206so122388484oia.1
        for <linux-input@vger.kernel.org>; Thu, 14 Jan 2016 11:34:31 -0800 (PST)
In-Reply-To: <20160114121118.GU11560@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Martin <madstitz@gmail.com>

On Thu, Jan 14, 2016 at 4:11 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> Hi!
>
> I'm Forwarding to linux-input. Looks like there can be problem with
> TPPS2 protocol detection on ThinkPad laptop. Any idea?

Replacing Synaptics for ALPS touchpad and expect trackpoint to
continue to work as it was is not realistic. The only way we properly
identify trackpoint if it is connected directly to the AUX port or if
it is connected to Synaptics pass-though port. In case of ALPS it
"merges" into touchpad (and we spend considerate effort untangling the
trackpoint data from touchpad data), so we handle trackpoint data, bit
never show it as TPPS/2.

That said I am confused how you ended up with ALPS as I believe
ThinkPads use only Synaptics.

Thanks.

>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
>
> ---------- Forwarded message ----------
> From: Martin <madstitz@gmail.com>
> To: pali.rohar@gmail.com
> Cc:
> Date: Thu, 14 Jan 2016 13:04:43 +0100
> Subject: ALPS v7 TrackStick detected wrongly
> Hi Mr. Rohar,
>
> I just read about your commit for kernel 4.5 ("Input: ALPS - detect t=
rackstick presence for v7 protocol"),
> and was wondering if this is addressing a problem I have:
>
> I recently replaced the touchpad of my ThinkPad S440 with the one fro=
m the T450 (because of the dedicated trackstick buttons).
> The touchpad is working fine (including the dedicated buttons), but t=
he trackstick doesn't work anymore.
>
> I suspect this is because it is detected incorrectly as an "AlpsPS/2 =
ALPS DualPoint Stick" when it should be (and previously was detected as=
) an "TPPS/2 IBM TrackPoint" (checked with other S440 owner).
> A friend replaced his T440 touchpad with a T450 touchpad from synapti=
cs, and his trackpoint is working fine.
>
> Relevant output of
> cat /proc/bus/input/devices
>
> I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D0700
> N: Name=3D"AlpsPS/2 ALPS DualPoint Stick"
> P: Phys=3Disa0060/serio1/input1
> S: Sysfs=3D/devices/platform/i8042/serio1/input/input8
> U: Uniq=3D
> H: Handlers=3Dmouse0 event6
> B: PROP=3D21
> B: EV=3D7
> B: KEY=3D70000 0 0 0 0
> B: REL=3D3
>
> I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D0700
> N: Name=3D"AlpsPS/2 ALPS DualPoint TouchPad"
> P: Phys=3Disa0060/serio1/input0
> S: Sysfs=3D/devices/platform/i8042/serio1/input/input5
> U: Uniq=3D
> H: Handlers=3Dmouse1 event7
> B: PROP=3D5
> B: EV=3Db
> B: KEY=3De520 10000 0 0 0 0
> B: ABS=3D260800000000003
>
> I: Bus=3D0019 Vendor=3D17aa Product=3D5054 Version=3D4101
> N: Name=3D"ThinkPad Extra Buttons"
> P: Phys=3Dthinkpad_acpi/input0
> S: Sysfs=3D/devices/platform/thinkpad_acpi/input/input9
> U: Uniq=3D
> H: Handlers=3Dkbd event8 rfkill
> B: PROP=3D0
> B: EV=3D13
> B: KEY=3D10040 0 18040000 0 10000000000000 0 1501b02102004 c000280041=
114000 10e000000000000 0
> B: MSC=3D10
>
>
> Is your patch intended to solve this or should I open a bug ticket?
>
> Thank you very much for your time!
>
> Greetings
> Martin Stitz
>
>

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
