From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Fwd: ALPS v7 TrackStick detected wrongly
Date: Thu, 14 Jan 2016 21:07:26 +0100
Message-ID: <20160114200726.GW11560@pali>
References: <1452773083.4165.0@smtp.gmail.com>
 <20160114121118.GU11560@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36767 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246AbcANUHa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 15:07:30 -0500
Received: by mail-wm0-f42.google.com with SMTP id l65so359656073wmf.1
        for <linux-input@vger.kernel.org>; Thu, 14 Jan 2016 12:07:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160114121118.GU11560@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Martin <madstitz@gmail.com>

On Thursday 14 January 2016 13:04:43 Martin <madstitz@gmail.com> wrote:
> Is your patch intended to solve this or should I open a bug ticket?

Hi! That my patch hides Track Stick input device when ALPS touchpad
report that Track Stick is not present. Before my patch was applied
kernel created "AlpsPS/2 ALPS DualPoint Stick" input device for V7
protocol always, even if there was no Track Stick device.

But as Dmitry said, you replaced Synaptics touchpad with ALPS which is
working differently. Synaptics touchpad export PS/2 bus via its own
pass-though protocol and this bus then available on kernel which do
normal PS/2 mouse detection it. So kernel bind thinkpad TPPS2 driver to
that bus.

ALPS is working differently. There is no pass-though mode and all data
(touchpad, track stick) are exported in ALPS packets. Kernel ALPS drive=
r
has special parser which can decide if packet comes from touchpad or
trackstick (based on received data). So via ALPS touchpad kernel cannot
communicate directly with trackpoint.

So I guess... in case you have thinkpad trackpoint HW and ALPS touchpad
which cannot work with that trackpoint you just do not get trackpoint
data. Here kernel cannot do anything.

I suspect that if you apply my patch (which check presence of
trackstick) then kernel probably do not export this track stick device
"AlpsPS/2 ALPS DualPoint Stick" anymore...

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

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
