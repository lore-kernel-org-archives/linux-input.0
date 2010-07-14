From: Oliver Neukum <oneukum@suse.de>
Subject: Re: usbtouchscreen - runtime PM patches testing [Was: [PATCH 1/2] Input: usbtouchscreen - add support for ET&T TC4UM touchscreen controller]
Date: Wed, 14 Jul 2010 14:23:04 +0200
Message-ID: <201007141423.04634.oneukum@suse.de>
References: <20100603075720.GQ26052@ibawizard.net> <201006301504.51681.oneukum@suse.de> <20100714104327.GW15039@ibawizard.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55569 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab0GNMXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 08:23:51 -0400
In-Reply-To: <20100714104327.GW15039@ibawizard.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr =?utf-8?q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Am Mittwoch, 14. Juli 2010, 12:43:27 schrieb Petr =C5=A0tetiar:
> Oliver Neukum <oneukum@suse.de> [2010-06-30 15:04:51]:
>=20
> Hi,
>=20
> > 1. indeed a few suspend & resume cycles
>=20
> it seems to work, although I've tested it with the suspend to RAM onl=
y with=20
> 'echo devices > /sys/power/pm_test', the complete suspend doesn't wor=
k on my
> laptop. I hope it's enough. If the whole cycle is necessary I can try=
 to test
> it on=20
>=20
> I was testing it with 'cat /dev/input/touchscreen | od -x' and withou=
t your
> patches the device dissapeared after the resume cycle. With your patc=
hes it was
> still working fine after 5-6 suspend and resume cycles.

This is enough. Thank you.

> > 2. to know what happens if you switch runtime power management on w=
ith
> > echo "auto" >/sys/bus/usb/devices/$DEVICE/power/level
>=20
> Sorry my ignorance, but what should happen? I don't follow PM stuff t=
hat much.
> I've enabled auto and the touchscreen is still working and nothing ha=
s
> changed, is it ok?

This is quite good already. Ideally in the /sys/bus/usb/devices/$DEVICE=
/power
directory active_duration should grow slower than connected_duration.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
