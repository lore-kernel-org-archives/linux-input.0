From: Oliver Neukum <oneukum@suse.de>
Subject: Re: usbtouchscreen - runtime PM patches testing [Was: [PATCH 1/2] Input: usbtouchscreen - add support for ET&T TC4UM touchscreen controller]
Date: Wed, 30 Jun 2010 15:04:51 +0200
Message-ID: <201006301504.51681.oneukum@suse.de>
References: <20100603075720.GQ26052@ibawizard.net> <20100628164603.GC11670@core.coreip.homeip.net> <20100630071635.GJ15039@ibawizard.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60960 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab0F3NFv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 09:05:51 -0400
In-Reply-To: <20100630071635.GJ15039@ibawizard.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr =?utf-8?q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Am Mittwoch, 30. Juni 2010, 09:16:35 schrieb Petr =C5=A0tetiar:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> [2010-06-28 09:46:03]:
>=20
> > Applied to 'next' branch (for .36). But I was wondering - could you
> > please try the runtime PM patches to usebtouchscreen posted by Oliv=
er
> > Neukum on the linux-input list? I'd really like to apply them but
> > I'd like to have them tested first.
>=20
> Thank you for applying my patches. Well, I've now only broken touchsc=
reen,
> which have only 4-wires or so working, but I think, that it should be=
 enough
> for PM testing. What kind of testing do you need, just few suspend & =
resume
> cycles? CC-ing Oliver also.

I need

1. indeed a few suspend & resume cycles
2. to know what happens if you switch runtime power management on with
echo "auto" >/sys/bus/usb/devices/$DEVICE/power/level

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
