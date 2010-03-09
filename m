From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: alps: Add support for the touchpad of the Toshiba
 Tecra A11-11L
Date: Tue, 9 Mar 2010 11:01:36 -0800
Message-ID: <20100309190135.GB28000@core.coreip.homeip.net>
References: <1268160967-21403-1-git-send-email-thomas@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:21494 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab0CITBp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 14:01:45 -0500
Received: by fg-out-1718.google.com with SMTP id l26so1835491fgb.1
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 11:01:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1268160967-21403-1-git-send-email-thomas@archlinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: linux-input@vger.kernel.org

Hi Thomas,

On Tue, Mar 09, 2010 at 07:56:07PM +0100, Thomas B=E4chler wrote:
>=20
> Signed-off-by: Thomas B=E4chler <thomas@archlinux.org>
> ---
> This patch was made by trial-and-error, I copied the byte0 and
> mask0 value from another model, tried different flags settings
> and it seems to work. I have no idea if there might be side-
> effects due to incorrect settings. Please tell me if I can do
> anything to verify or correct these values.
>=20
>  drivers/input/mouse/alps.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index f93c2c0..f6dad83 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -63,6 +63,8 @@ static const struct alps_model_info alps_model_data=
[] =3D {
>  	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
>  	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell =
Vostro 1400 */
> +	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
> +		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },	  /* Toshiba =
Tecra A11-11L */
>  };
> =20

Looking at the picture it appears to have a touchpad only, not a
touchpad/trackpoint combo. So I am wondering if ALPS_DUALPOINT and
ALPS_PS2_INTERLEAVED flags are needed here. What happens if you remove
them? Also, does it have external PS/2 post?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
