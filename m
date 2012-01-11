From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] input/mc13783-ts: add pdata to set conversion delay
Date: Wed, 11 Jan 2012 20:21:14 +0100
Message-ID: <20120111192114.GP14252@pengutronix.de>
References: <1326278963-22510-1-git-send-email-michael.thalmeier@hale.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50492 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933763Ab2AKTVU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 14:21:20 -0500
Content-Disposition: inline
In-Reply-To: <1326278963-22510-1-git-send-email-michael.thalmeier@hale.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, michael@thalmeier.at

On Wed, Jan 11, 2012 at 11:49:23AM +0100, Michael Thalmeier wrote:
> MC13783 can be programmed to wait some clock cycles between the touch=
 screen
> polarization and the resistance conversion. This is needed to adjust =
for
> touchscreens with high capacitance between plates.
>=20
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
Looks good for me.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
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
