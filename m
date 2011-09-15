From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/6] mc13783 cleanup
Date: Thu, 15 Sep 2011 17:10:33 +0200
Message-ID: <20110915151033.GD32263@sortiz-mobl>
References: <20110824132740.GA28197@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41420 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933899Ab1IOPH4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Sep 2011 11:07:56 -0400
Content-Disposition: inline
In-Reply-To: <20110824132740.GA28197@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

Hi Uwe,

On Wed, Aug 24, 2011 at 03:27:40PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> this series removes the long obsolte mc13783 API after fixing all
> remaining users.
>=20
> The patches touch many subsystems and have some interdependencies:
>=20
>  - patches 3 and 5 depend on patch 2
>  - patch 6 depends on patches 1-5
>=20
> So we have to think about how to merge them when everyone is OK that
> they are merged.
I am merging them, unless someone objects here.
I have applied all 6 patches now.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
