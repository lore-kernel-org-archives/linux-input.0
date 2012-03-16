From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH] Input: navpoint: add clk_prepare/clk_unprepare calls
Date: Fri, 16 Mar 2012 15:57:11 +0000 (GMT)
Message-ID: <1331913431.1816.YahooMailClassic@web29020.mail.ird.yahoo.com>
References: <1331834978.14662.1.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm1.bullet.mail.ird.yahoo.com ([77.238.189.58]:47691 "HELO
	nm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754441Ab2CPQDG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 12:03:06 -0400
In-Reply-To: <1331834978.14662.1.camel@flow>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Philipp Zabel <pzabel@gmx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

--- On Thu, 15/3/12, Philipp Zabel <pzabel@gmx.de> wrote:
> This patch adds
> clk_prepare/clk_unprepare calls to the navpoint
> driver by using the helper functions clk_prepare_enable and
> clk_disable_unprepare.
>=20
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Paul Parsons <lost.distance@yahoo.com>
> ---
>  drivers/input/mouse/navpoint.c |=A0 =A0 4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/mouse/navpoint.c
> b/drivers/input/mouse/navpoint.c
> index 253ec18..cb0d3b1 100644
> --- a/drivers/input/mouse/navpoint.c
> +++ b/drivers/input/mouse/navpoint.c
> @@ -225,7 +225,7 @@ static int navpoint_suspend(struct
> device *dev)
> =20
>  =A0=A0=A0 pxa_ssp_write_reg(ssp, SSCR0, 0);
> =20
> -=A0=A0=A0 clk_disable(ssp->clk);
> +=A0=A0=A0 clk_disable_unprepare(ssp->clk);
> =20
>  =A0=A0=A0 return 0;
>  }
> @@ -236,7 +236,7 @@ static int navpoint_resume(struct device
> *dev)
>  =A0=A0=A0 struct ssp_device *ssp =3D
> drv_data->ssp;
>  =A0=A0=A0 int timeout;
> =20
> -=A0=A0=A0 clk_enable(ssp->clk);
> +=A0=A0=A0 clk_prepare_enable(ssp->clk);
> =20
>  =A0=A0=A0 pxa_ssp_write_reg(ssp, SSCR1, sscr1);
>  =A0=A0=A0 pxa_ssp_write_reg(ssp, SSSR, sssr);
> --=20
> 1.7.9.1

AFAIK the navpoint driver itself has yet to be accepted.

Acked-by: Paul Parsons <lost.distance@yahoo.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
