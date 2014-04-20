From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: wacom - unify outbound support for Cintiq and
 Intuos series
Date: Sat, 19 Apr 2014 22:34:55 -0700
Message-ID: <20140420053455.GE12454@core.coreip.homeip.net>
References: <1397244785-20052-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:62757 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaDTFe5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 01:34:57 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so2682224pdb.0
        for <linux-input@vger.kernel.org>; Sat, 19 Apr 2014 22:34:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397244785-20052-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, Apr 11, 2014 at 12:33:05PM -0700, Ping Cheng wrote:
> Signed-off-by: Ping Cheng <pingc@wacom.com>


Applied, thank you.

> ---
>  drivers/input/tablet/wacom_wac.c | 88 ++++++++++++++++++++++++++++++++--------
>  drivers/input/tablet/wacom_wac.h |  4 +-
>  2 files changed, 75 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 3d094c9..0e37cde 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -488,6 +488,8 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>  		input_report_key(input, BTN_TOUCH, 0);
>  		input_report_abs(input, ABS_PRESSURE, 0);
>  		input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
> +		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
> +			wacom->shared->stylus_in_proximity = true;
>  	}
>  
>  	/* Exit report */
> @@ -562,6 +564,55 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
>  	}
>  }
>  
> +static bool wacom_intuos_outbound(struct wacom_wac *wacom)
> +{
> +	struct wacom_features *features = &wacom->features;
> +	unsigned char *data = wacom->data;
> +	struct input_dev *input = wacom->input;
> +	unsigned int bound = 200;
> +	bool outbound = false;
> +
> +	/* Intuos and old Cintiqs use ready bit for outbound tracking */
> +	if (!(data[1] & 0x40))
> +		outbound = true;
> +
> +	/* New Cintiqs have 200 counts of outbound */
> +	if (features->type >= WACOM_21UX2 && features->type <= WACOM_13HD) {
> +		if (wacom->x_mapped < bound) {
> +			wacom->x_mapped = 0;
> +			outbound = true;
> +		} else {
> +			wacom->x_mapped -= bound;
> +			if (wacom->x_mapped > features->x_max) {
> +				wacom->x_mapped = features->x_max;
> +				outbound = true;
> +			}
> +		}
> +
> +		if (wacom->y_mapped < bound) {
> +			wacom->y_mapped = 0;
> +			outbound = true;
> +		} else {
> +			wacom->y_mapped -= bound;
> +			if (wacom->y_mapped > features->y_max) {
> +				wacom->y_mapped = features->y_max;
> +				outbound = true;
> +			}
> +		}
> +	}
> +
> +	/* Intuos supports outbound tracking */
> +	if (outbound && (features->type >= INTUOS3S && features->type <= INTUOSPL)) {
> +		input_report_abs(input, ABS_X, wacom->x_mapped);
> +		input_report_abs(input, ABS_Y, wacom->y_mapped);
> +		input_report_abs(input, ABS_MISC, wacom->id[0]);
> +		input_report_key(input, wacom->tool[0], 1);
> +		input_event(input, EV_MSC, MSC_SERIAL, wacom->serial[0]);
> +	}
> +
> +	return outbound;
> +}
> +
>  static int wacom_intuos_irq(struct wacom_wac *wacom)
>  {
>  	struct wacom_features *features = &wacom->features;
> @@ -802,17 +853,22 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
>  		return 0;
>  	}
>  
> -	/* Cintiq doesn't send data when RDY bit isn't set */
> -	if (features->type == CINTIQ && !(data[1] & 0x40))
> -                 return 0;
> +	if (features->type >= INTUOS3S) {
> +		wacom->x_mapped = (data[2] << 9) | (data[3] << 1) | ((data[9] >> 1) & 1);
> +		wacom->y_mapped = (data[4] << 9) | (data[5] << 1) | (data[9] & 1);
> +	} else {
> +		wacom->x_mapped = be16_to_cpup((__be16 *)&data[2]);
> +		wacom->y_mapped = be16_to_cpup((__be16 *)&data[4]);
> +	}
> +
> +	if (wacom_intuos_outbound(wacom))
> +		return 0;
>  
> +	input_report_abs(input, ABS_X, wacom->x_mapped);
> +	input_report_abs(input, ABS_Y, wacom->y_mapped);
>  	if (features->type >= INTUOS3S) {
> -		input_report_abs(input, ABS_X, (data[2] << 9) | (data[3] << 1) | ((data[9] >> 1) & 1));
> -		input_report_abs(input, ABS_Y, (data[4] << 9) | (data[5] << 1) | (data[9] & 1));
>  		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 2) & 0x3f));
>  	} else {
> -		input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[2]));
> -		input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[4]));
>  		input_report_abs(input, ABS_DISTANCE, ((data[9] >> 3) & 0x1f));
>  	}
>  
> @@ -2132,10 +2188,10 @@ static const struct wacom_features wacom_features_0x317 =
>  	  63, INTUOSPL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
>  	  .touch_max = 16 };
>  static const struct wacom_features wacom_features_0xF4 =
> -	{ "Wacom Cintiq 24HD",       WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
> +	{ "Wacom Cintiq 24HD",       WACOM_PKGLEN_INTUOS,   104080, 65200, 2047,
>  	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
>  static const struct wacom_features wacom_features_0xF8 =
> -	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104480, 65600, 2047, /* Pen */
> +	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104080, 65200, 2047, /* Pen */
>  	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
>  static const struct wacom_features wacom_features_0xF6 =
> @@ -2151,7 +2207,7 @@ static const struct wacom_features wacom_features_0xC6 =
>  	{ "Wacom Cintiq 12WX",    WACOM_PKGLEN_INTUOS,    53020, 33440, 1023,
>  	  63, WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
>  static const struct wacom_features wacom_features_0x304 =
> -	{ "Wacom Cintiq 13HD",    WACOM_PKGLEN_INTUOS,    59552, 33848, 1023,
> +	{ "Wacom Cintiq 13HD",    WACOM_PKGLEN_INTUOS,    59152, 33448, 1023,
>  	  63, WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
>  static const struct wacom_features wacom_features_0xC7 =
>  	{ "Wacom DTU1931",        WACOM_PKGLEN_GRAPHIRE,  37832, 30305,  511,
> @@ -2166,23 +2222,23 @@ static const struct wacom_features wacom_features_0xFB =
>  	{ "Wacom DTU1031",        WACOM_PKGLEN_DTUS,      22096, 13960,  511,
>  	  0, DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x57 =
> -	{ "Wacom DTK2241",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
> +	{ "Wacom DTK2241",        WACOM_PKGLEN_INTUOS,    95440, 53860, 2047,
>  	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES};
>  static const struct wacom_features wacom_features_0x59 = /* Pen */
> -	{ "Wacom DTH2242",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
> +	{ "Wacom DTH2242",        WACOM_PKGLEN_INTUOS,    95440, 53860, 2047,
>  	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5D };
>  static const struct wacom_features wacom_features_0x5D = /* Touch */
>  	{ "Wacom DTH2242",       .type = WACOM_24HDT,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x59, .touch_max = 10 };
>  static const struct wacom_features wacom_features_0xCC =
> -	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    87200, 65600, 2047,
> +	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    86400, 64800, 2047,
>  	  63, WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
>  static const struct wacom_features wacom_features_0xFA =
> -	{ "Wacom Cintiq 22HD",    WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
> +	{ "Wacom Cintiq 22HD",    WACOM_PKGLEN_INTUOS,    95440, 53860, 2047,
>  	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
>  static const struct wacom_features wacom_features_0x5B =
> -	{ "Wacom Cintiq 22HDT", WACOM_PKGLEN_INTUOS,      95840, 54260, 2047,
> +	{ "Wacom Cintiq 22HDT", WACOM_PKGLEN_INTUOS,      95440, 53860, 2047,
>  	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
>  static const struct wacom_features wacom_features_0x5E =
> @@ -2325,7 +2381,7 @@ static const struct wacom_features wacom_features_0x6004 =
>  	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
>  	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x0307 =
> -	{ "Wacom ISDv5 307", WACOM_PKGLEN_INTUOS,  59552,  33848, 2047,
> +	{ "Wacom ISDv5 307", WACOM_PKGLEN_INTUOS,  59152,  33448, 2047,
>  	  63, CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
>  static const struct wacom_features wacom_features_0x0309 =
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
> index f69c0eb..9f947c3 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -93,9 +93,9 @@ enum {
>  	DTK,
>  	WACOM_24HD,
>  	CINTIQ_HYBRID,
> +	WACOM_13HD,
>  	CINTIQ,
>  	WACOM_BEE,
> -	WACOM_13HD,
>  	WACOM_MO,
>  	WIRELESS,
>  	BAMBOO_PT,
> @@ -148,6 +148,8 @@ struct wacom_wac {
>  	int tool[2];
>  	int id[2];
>  	__u32 serial[2];
> +	unsigned int x_mapped;
> +	unsigned int y_mapped;
>  	struct wacom_features features;
>  	struct wacom_shared *shared;
>  	struct input_dev *input;
> -- 
> 1.8.3.2
> 

-- 
Dmitry
