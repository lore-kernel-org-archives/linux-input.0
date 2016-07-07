From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Fri, 08 Jul 2016 01:21:08 +0200
Message-ID: <1467933668.25410.3.camel@hadess.net>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:32823 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbcGGXVP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2016 19:21:15 -0400
In-Reply-To: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Wed, 2016-06-29 at 19:28 +1000, Peter Hutterer wrote:
> If the 0x1000 Unified Battery Level Status feature exists, expose the
> battery
> level.
>=20
> The main drawback is that while a device is plugged in its battery
> level is 0.
> To avoid exposing that as 0% charge we make up a number based on the
> charging
> status.

This will require changes in UPower, so that it doesn't try to access
the Logitech unifying devices via user-space, and uses the data from
the kernel. Did you already file a bug?

Note that this would also mean losing the "lux" information, but I
don't think that's something we're that interested in exposing.

=46or example, for a keyboard that recharges via solar panels, at night=
:

Device: /org/freedesktop/UPower/devices/keyboard_0003o046Do4002x0004
=C2=A0 native-path:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0/sys/devices/pci0000:00/0000:00:14.0/usb3/3-10/3-10:1.2/0003:046D=
:C52B.0003/0003:046D:4002.0004
=C2=A0 vendor:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Logitech, Inc.
=C2=A0 model:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0K750
=C2=A0 serial:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0197F3F23
=C2=A0 power supply:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0no
=C2=A0 updated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Fri 08 Jul 2016 01:17:40 CEST (95 seconds ag=
o)
=C2=A0 has history:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0yes
=C2=A0 has statistics:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0no
=C2=A0 keyboard
=C2=A0=C2=A0=C2=A0=C2=A0present:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0yes
=C2=A0=C2=A0=C2=A0=C2=A0rechargeable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0yes
=C2=A0=C2=A0=C2=A0=C2=A0state:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0discharging
=C2=A0=C2=A0=C2=A0=C2=A0warning-level:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0none
=C2=A0=C2=A0=C2=A0=C2=A0luminosity:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A016 lx
=C2=A0=C2=A0=C2=A0=C2=A0percentage:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A089%
=C2=A0=C2=A0=C2=A0=C2=A0icon-name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0'battery-full-symbolic'
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
