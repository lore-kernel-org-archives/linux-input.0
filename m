From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: wacom - process outbound for newer Cintiqs
Date: Thu, 29 May 2014 00:09:29 -0700
Message-ID: <20140529070929.GC11817@core.coreip.homeip.net>
References: <1401232783-9816-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62271 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbaE2HJc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 03:09:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so12531103pbb.19
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 00:09:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401232783-9816-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, May 27, 2014 at 04:19:43PM -0700, Ping Cheng wrote:
> New Cintiq tablets have a 200 tablet counts outside of screen area.
> Add x/y_min for ABS_X/Y to pass this information to userland.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>
> Tested-by: Jason Gerecke <killertofu@gmail.com>

Applied, thank you.

> ---
>  drivers/input/tablet/wacom_wac.c | 44 ++++++++++++++++++++--------------------
>  drivers/input/tablet/wacom_wac.h |  2 ++
>  2 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 0eb9960..9c0f22b 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1576,10 +1576,10 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
>  	struct wacom_features *features = &wacom_wac->features;
>  
>  	if (features->device_type == BTN_TOOL_PEN) {
> -		input_set_abs_params(input_dev, ABS_X, 0, features->x_max,
> -				     features->x_fuzz, 0);
> -		input_set_abs_params(input_dev, ABS_Y, 0, features->y_max,
> -				     features->y_fuzz, 0);
> +		input_set_abs_params(input_dev, ABS_X, features->x_min,
> +				     features->x_max, features->x_fuzz, 0);
> +		input_set_abs_params(input_dev, ABS_Y, features->y_min,
> +				     features->y_max, features->y_fuzz, 0);
>  		input_set_abs_params(input_dev, ABS_PRESSURE, 0,
>  			features->pressure_max, features->pressure_fuzz, 0);
>  
> @@ -2135,11 +2135,11 @@ static const struct wacom_features wacom_features_0x317 =
>  	  63, INTUOSPL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
>  	  .touch_max = 16 };
>  static const struct wacom_features wacom_features_0xF4 =
> -	{ "Wacom Cintiq 24HD",       WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
> -	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
> +	{ "Wacom Cintiq 24HD",       WACOM_PKGLEN_INTUOS,   104280, 65400, 2047,
> +	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
>  static const struct wacom_features wacom_features_0xF8 =
> -	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104480, 65600, 2047, /* Pen */
> -	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
> +	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104280, 65400, 2047, /* Pen */
> +	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
>  static const struct wacom_features wacom_features_0xF6 =
>  	{ "Wacom Cintiq 24HD touch", .type = WACOM_24HDT, /* Touch */
> @@ -2154,8 +2154,8 @@ static const struct wacom_features wacom_features_0xC6 =
>  	{ "Wacom Cintiq 12WX",    WACOM_PKGLEN_INTUOS,    53020, 33440, 1023,
>  	  63, WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
>  static const struct wacom_features wacom_features_0x304 =
> -	{ "Wacom Cintiq 13HD",    WACOM_PKGLEN_INTUOS,    59552, 33848, 1023,
> -	  63, WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
> +	{ "Wacom Cintiq 13HD",    WACOM_PKGLEN_INTUOS,    59352, 33648, 1023,
> +	  63, WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
>  static const struct wacom_features wacom_features_0xC7 =
>  	{ "Wacom DTU1931",        WACOM_PKGLEN_GRAPHIRE,  37832, 30305,  511,
>  	  0, PL, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> @@ -2169,24 +2169,24 @@ static const struct wacom_features wacom_features_0xFB =
>  	{ "Wacom DTU1031",        WACOM_PKGLEN_DTUS,      22096, 13960,  511,
>  	  0, DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x57 =
> -	{ "Wacom DTK2241",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
> -	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES};
> +	{ "Wacom DTK2241",        WACOM_PKGLEN_INTUOS,    95640, 54060, 2047,
> +	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
>  static const struct wacom_features wacom_features_0x59 = /* Pen */
> -	{ "Wacom DTH2242",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
> -	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
> +	{ "Wacom DTH2242",        WACOM_PKGLEN_INTUOS,    95640, 54060, 2047,
> +	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5D };
>  static const struct wacom_features wacom_features_0x5D = /* Touch */
>  	{ "Wacom DTH2242",       .type = WACOM_24HDT,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x59, .touch_max = 10 };
>  static const struct wacom_features wacom_features_0xCC =
> -	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    87200, 65600, 2047,
> -	  63, WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
> +	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    87000, 65400, 2047,
> +	  63, WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
>  static const struct wacom_features wacom_features_0xFA =
> -	{ "Wacom Cintiq 22HD",    WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
> -	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
> +	{ "Wacom Cintiq 22HD",    WACOM_PKGLEN_INTUOS,    95640, 54060, 2047,
> +	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200 };
>  static const struct wacom_features wacom_features_0x5B =
> -	{ "Wacom Cintiq 22HDT", WACOM_PKGLEN_INTUOS,      95840, 54260, 2047,
> -	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
> +	{ "Wacom Cintiq 22HDT", WACOM_PKGLEN_INTUOS,      95640, 54060, 2047,
> +	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
>  static const struct wacom_features wacom_features_0x5E =
>  	{ "Wacom Cintiq 22HDT", .type = WACOM_24HDT,
> @@ -2340,8 +2340,8 @@ static const struct wacom_features wacom_features_0x6004 =
>  	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
>  	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x0307 =
> -	{ "Wacom ISDv5 307", WACOM_PKGLEN_INTUOS,  59552,  33848, 2047,
> -	  63, CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
> +	{ "Wacom ISDv5 307", WACOM_PKGLEN_INTUOS,  59352,  33648, 2047,
> +	  63, CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 200, 200,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
>  static const struct wacom_features wacom_features_0x0309 =
>  	{ "Wacom ISDv5 309", .type = WACOM_24HDT, /* Touch */
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
> index 29774ca..b2c9a9c 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -122,6 +122,8 @@ struct wacom_features {
>  	int type;
>  	int x_resolution;
>  	int y_resolution;
> +	int x_min;
> +	int y_min;
>  	int device_type;
>  	int x_phy;
>  	int y_phy;
> -- 
> 1.9.1
> 

-- 
Dmitry
