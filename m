From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Use iap_version to get firmware
 information
Date: Thu, 3 Sep 2015 09:57:19 -0700
Message-ID: <20150903165719.GA17498@dtor-ws>
References: <E043392A-A8F9-40C7-A273-3B20AA3F00D8@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36121 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbbICQ5X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 12:57:23 -0400
Content-Disposition: inline
In-Reply-To: <E043392A-A8F9-40C7-A273-3B20AA3F00D8@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: duson <dusonlin@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 02, 2015 at 09:03:46AM +0800, duson wrote:
> When driver get exception ic type (0xFF), maybe occurred from wrong
> I2C protocol communication, system crash or other unknown situation,
> instead of ic_type we use iap_version to get firmware information.
>=20
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_core.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mous=
e/elan_i2c_core.c
> index 5b5f403..d99d40c 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2013 ELAN Microelectronics Corp.
>   *
>   * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com=
=2Etw>
> - * Version: 1.5.9
> + * Version: 1.6.0
>   *
>   * Based on cyapa driver:
>   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> @@ -40,7 +40,7 @@
>  #include "elan_i2c.h"
> =20
>  #define DRIVER_NAME		"elan_i2c"
> -#define ELAN_DRIVER_VERSION	"1.5.9"
> +#define ELAN_DRIVER_VERSION	"1.6.0"
>  #define ETP_MAX_PRESSURE	255
>  #define ETP_FWIDTH_REDUCE	90
>  #define ETP_FINGER_WIDTH	15
> @@ -261,11 +261,11 @@ static int elan_query_device_info(struct elan_t=
p_data *data)
>  	if (error)
>  		return error;
> =20
> -	error =3D elan_get_fwinfo(data->ic_type, &data->fw_vaildpage_count,
> +	error =3D elan_get_fwinfo(data->iap_version, &data->fw_vaildpage_co=
unt,
>  				&data->fw_signature_address);
>  	if (error) {
>  		dev_err(&data->client->dev,
> -			"unknown ic type %d\n", data->ic_type);
> +			"unknown ic type %d\n", data->iap_version);

Applied but changed the working here to "unknown iap version" and also
changed argument name in elan_get_fwinfo.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
