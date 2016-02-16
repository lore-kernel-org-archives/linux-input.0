From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/3] Input: rotary_encoder - Fixups for Dmitry's
 rework and support for >2 gpios
Date: Tue, 16 Feb 2016 08:33:27 +0100
Message-ID: <20160216073327.GL12289@pengutronix.de>
References: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40765 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787AbcBPHdg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 02:33:36 -0500
Content-Disposition: inline
In-Reply-To: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-input@vger.kernel.org

Hello Dmitry,

On Fri, Feb 05, 2016 at 01:08:18PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> This bases on top of
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input rotary-enco=
der
>=20
> (currently at 557a30f2f046).
>=20
> Dmitry, I assume you will squash the two fixups accordingly, otherwis=
e
> just tell me, then I create proper patches.
>=20
> Also let me note that with threaded irqs I'm able to rotate my device
> quicker than irq handling happens. So a quick counterclockwise rotati=
on
> might be detected as single step clockwise rotation.

gentle ping!

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
