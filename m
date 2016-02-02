From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/3] Input: rotary-encoder - make use of devm_* to
 simplify .probe and .remove
Date: Tue, 2 Feb 2016 14:00:22 +0100
Message-ID: <20160202130022.GX13664@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1454408678-6011-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09968.9050705@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48044 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754466AbcBBNAp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2016 08:00:45 -0500
Content-Disposition: inline
In-Reply-To: <56B09968.9050705@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Tue, Feb 02, 2016 at 12:56:24PM +0100, Daniel Mack wrote:
> On 02/02/2016 11:24 AM, Uwe Kleine-K=F6nig wrote:
> > For all operations called in .probe there are devm_* variants.
> > (input_register_device is clever enough to be devm aware on its own=
=2E)
> > This allows to get rid of the error unwind code paths in .probe and=
 the
> > complete .remove function.
>=20
> While at it, could you also convert this over to the gpiod_* API?

This is done in patch 3.

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
