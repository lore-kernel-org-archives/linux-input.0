From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Fri, 8 Jul 2016 14:34:15 +1000
Message-ID: <20160708043415.GA3691@jelly>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
 <1467933668.25410.3.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:48163 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbcGHEgf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 00:36:35 -0400
Content-Disposition: inline
In-Reply-To: <1467933668.25410.3.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Fri, Jul 08, 2016 at 01:21:08AM +0200, Bastien Nocera wrote:
> On Wed, 2016-06-29 at 19:28 +1000, Peter Hutterer wrote:
> > If the 0x1000 Unified Battery Level Status feature exists, expose t=
he
> > battery
> > level.
> >=20
> > The main drawback is that while a device is plugged in its battery
> > level is 0.
> > To avoid exposing that as 0% charge we make up a number based on th=
e
> > charging
> > status.
>=20
> This will require changes in UPower, so that it doesn't try to access
> the Logitech unifying devices via user-space, and uses the data from
> the kernel. Did you already file a bug?

filed now: https://bugs.freedesktop.org/show_bug.cgi?id=3D96857

> Note that this would also mean losing the "lux" information, but I
> don't think that's something we're that interested in exposing.

Adding that HID++ request to the kernel would be easy enough but I don'=
t=20
see anything in the power_supply_property that would match this, do you=
?=20
Also, I don't have such a device so testing would be tricky.

Cheers,
   Peter


>=20
> For example, for a keyboard that recharges via solar panels, at night=
:
>=20
> Device: /org/freedesktop/UPower/devices/keyboard_0003o046Do4002x0004
> =A0 native-path:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/sys/devices/pci0000:00=
/0000:00:14.0/usb3/3-10/3-10:1.2/0003:046D:C52B.0003/0003:046D:4002.000=
4
> =A0 vendor:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Logitech, Inc=
=2E
> =A0 model:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0K750
> =A0 serial:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0197F3F23
> =A0 power supply:=A0=A0=A0=A0=A0=A0=A0=A0=A0no
> =A0 updated:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Fri 08 Jul 2016=
 01:17:40 CEST (95 seconds ago)
> =A0 has history:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0yes
> =A0 has statistics:=A0=A0=A0=A0=A0=A0=A0no
> =A0 keyboard
> =A0=A0=A0=A0present:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0yes
> =A0=A0=A0=A0rechargeable:=A0=A0=A0=A0=A0=A0=A0=A0yes
> =A0=A0=A0=A0state:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0discha=
rging
> =A0=A0=A0=A0warning-level:=A0=A0=A0=A0=A0=A0=A0none
> =A0=A0=A0=A0luminosity:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A016 lx
> =A0=A0=A0=A0percentage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A089%
> =A0=A0=A0=A0icon-name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'battery-full-sym=
bolic'
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
