From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
Date: Sun, 10 Jul 2011 10:04:50 +0200
Message-ID: <20110710080450.GW29624@pengutronix.de>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59496 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab1GJIE5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jul 2011 04:04:57 -0400
Content-Disposition: inline
In-Reply-To: <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com

Hello,

On Sun, Jul 10, 2011 at 01:06:36AM +0200, Philippe R=E9tornaz wrote:
> The leds and buttons subdevices cannot be used without additional
> platform data.
>=20
> Use the presence of the platform data to enable the device instead
> of an additional flag.
I guess you could make some people happy by splitting this patch into:

	- mfd/mc13xxx: implicitly enable leds and buttons (and
	  regulators?)
	- drop MC13XXX_USE_... in arch code

because the patches have different paths into mainline (unless it's
handled otherwise).

And I wonder why you introduce MC13XXX_USE_BUTTON in the first place.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
