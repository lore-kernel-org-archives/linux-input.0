From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: tsc2005: Add MODULE_ALIAS
Date: Sat, 16 Feb 2013 22:13:43 -0800
Message-ID: <20130217061342.GA10469@core.coreip.homeip.net>
References: <1361060872-11818-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49735 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab3BQGNq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Feb 2013 01:13:46 -0500
Content-Disposition: inline
In-Reply-To: <1361060872-11818-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 17, 2013 at 01:27:52AM +0100, Pali Roh=E1r wrote:
> * This patch enable autoloading tsc2005 driver when is compiled as mo=
dule
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  drivers/input/touchscreen/tsc2005.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touc=
hscreen/tsc2005.c
> index 9c0cdc7..7213e8b 100644
> --- a/drivers/input/touchscreen/tsc2005.c
> +++ b/drivers/input/touchscreen/tsc2005.c
> @@ -753,3 +753,4 @@ module_spi_driver(tsc2005_driver);
>  MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
>  MODULE_DESCRIPTION("TSC2005 Touchscreen Driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("spi:tsc2005");

Applied, thank you Pali.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
