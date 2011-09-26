From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/mc13xxx_ts.c: Add support for mc13892
Date: Mon, 26 Sep 2011 10:54:19 -0700
Message-ID: <20110926175418.GA4614@core.coreip.homeip.net>
References: <1317049057-4936-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53986 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1IZRyY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 13:54:24 -0400
Received: by yxl31 with SMTP id 31so4496402yxl.19
        for <linux-input@vger.kernel.org>; Mon, 26 Sep 2011 10:54:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317049057-4936-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-input@vger.kernel.org, David Jander <david@protonic.nl>

Hi Uwe,

On Mon, Sep 26, 2011 at 04:57:37PM +0200, Uwe Kleine-K=F6nig wrote:
> The mc13892 has almost the same touchscreen controller as the mc13783=
=2E
> This patch adds support for mc13892.
>=20
> Based on an earlier patch by David Jander.
>=20
> Cc: David Jander <david@protonic.nl>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/input/touchscreen/Kconfig      |   10 +-
>  drivers/input/touchscreen/Makefile     |    2 +-
>  drivers/input/touchscreen/mc13783_ts.c |  259 ----------------------=
-------
>  drivers/input/touchscreen/mc13xxx_ts.c |  282 ++++++++++++++++++++++=
++++++++++
>  4 files changed, 288 insertions(+), 265 deletions(-)
>  delete mode 100644 drivers/input/touchscreen/mc13783_ts.c
>  create mode 100644 drivers/input/touchscreen/mc13xxx_ts.c

This rename hides completely what was done to the driver to support the
new chip. I also do not think that rename is that useful; I think if we
simply update Kconfig text an driver description to reflectthe fact tha=
t
we now support 2 chips that shoudl be enough.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
