From: Martin <madstitz@gmail.com>
Subject: Re: Fwd: ALPS v7 TrackStick detected wrongly
Date: Fri, 15 Jan 2016 12:27:16 +0100
Message-ID: <1452857236.32706.0@smtp.gmail.com>
References: <1452773083.4165.0@smtp.gmail.com>
	<20160114121118.GU11560@pali> <20160114200726.GW11560@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34131 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbcAOL1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 06:27:20 -0500
Received: by mail-wm0-f44.google.com with SMTP id u188so19190496wmu.1
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 03:27:19 -0800 (PST)
In-Reply-To: <20160114200726.GW11560@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?b?Um9o4XI=?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org

So I can't be sure if it even detects the trackstick, because it just=20
creates the device anyway?

I bought the trackpad from eBay, as Lenovo doesn't sell it separately.
Apparently its pure luck if you get a Synaptics or Alps model - I got=20
the Alps, my friend got the Synaptics model.
Don't know whether Lenovo uses Alps in its newer series too or if this=20
trackpad is a fake (feels and works very real though ;))

Maybe I'll try to get a synaptics then, as this was the manufacturer of=
=20
the original trackpad.

Greetings
Martin


Am Do, 14. Jan, 2016 um 9:07 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.=
com>:
> On Thursday 14 January 2016 13:04:43 Martin <madstitz@gmail.com>=20
> wrote:
>>  Is your patch intended to solve this or should I open a bug ticket?
>=20
> Hi! That my patch hides Track Stick input device when ALPS touchpad
> report that Track Stick is not present. Before my patch was applied
> kernel created "AlpsPS/2 ALPS DualPoint Stick" input device for V7
> protocol always, even if there was no Track Stick device.
>=20
> But as Dmitry said, you replaced Synaptics touchpad with ALPS which i=
s
> working differently. Synaptics touchpad export PS/2 bus via its own
> pass-though protocol and this bus then available on kernel which do
> normal PS/2 mouse detection it. So kernel bind thinkpad TPPS2 driver=20
> to
> that bus.
>=20
> ALPS is working differently. There is no pass-though mode and all dat=
a
> (touchpad, track stick) are exported in ALPS packets. Kernel ALPS=20
> driver
> has special parser which can decide if packet comes from touchpad or
> trackstick (based on received data). So via ALPS touchpad kernel=20
> cannot
> communicate directly with trackpoint.
>=20
> So I guess... in case you have thinkpad trackpoint HW and ALPS=20
> touchpad
> which cannot work with that trackpoint you just do not get trackpoint
> data. Here kernel cannot do anything.
>=20
> I suspect that if you apply my patch (which check presence of
> trackstick) then kernel probably do not export this track stick devic=
e
> "AlpsPS/2 ALPS DualPoint Stick" anymore...
>=20
>>  I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D0700
>>  N: Name=3D"AlpsPS/2 ALPS DualPoint Stick"
>>  P: Phys=3Disa0060/serio1/input1
>>  S: Sysfs=3D/devices/platform/i8042/serio1/input/input8
>>  U: Uniq=3D
>>  H: Handlers=3Dmouse0 event6
>>  B: PROP=3D21
>>  B: EV=3D7
>>  B: KEY=3D70000 0 0 0 0
>>  B: REL=3D3
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
