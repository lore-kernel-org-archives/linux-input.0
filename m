From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: /input/mouse/elan_i2c_core.c Fix some Asus touchapod which casue TP no funciton sometimes, the patch detect some specific touchpad and run a special initialize
Date: Mon, 11 Jul 2016 20:40:58 +0800
Message-ID: <019201d1db71$7986cd80$6c946880$@emc.com.tw>
References: <1467979929-3409-1-git-send-email-kt.liao@emc.com.tw> <20160709002448.GI28589@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160709002448.GI28589@dtor-ws>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'KT Liao' <ktalex.liao@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

-----Original Message-----
=46rom: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
Sent: Saturday, July 09, 2016 8:25 AM
To: KT Liao
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org; phoenix@=
emc.com.tw; kt.liao@emc.com.tw
Subject: Re: [PATCH] Input: /input/mouse/elan_i2c_core.c Fix some Asus =
touchapod which casue TP no funciton sometimes, the patch detect some s=
pecific touchpad and run a special initialize

Hi KT,

On Fri, Jul 08, 2016 at 08:12:09PM +0800, KT Liao wrote:
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>

Please make sure you add a blan line between change subject and the res=
t of description. Then git send-email will compose your email properly =
instead of lumping everything into one long line subject.
[KT] :Sorry, I will fix it in the later upstream
> ---
>  drivers/input/mouse/elan_i2c_core.c | 81=20
> +++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c_core.c=20
> b/drivers/input/mouse/elan_i2c_core.c
> index 2f58985..1c200fb 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -3,8 +3,8 @@
>   *
>   * Copyright (c) 2013 ELAN Microelectronics Corp.
>   *
> - * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com=
=2Etw>
> - * Version: 1.6.0
> + * Author: KT Liao <kt.liao@emc.com.tw>
> + * Version: 1.6.2
>   *
>   * Based on cyapa driver:
>   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> @@ -40,7 +40,7 @@
>  #include "elan_i2c.h"
> =20
>  #define DRIVER_NAME		"elan_i2c"
> -#define ELAN_DRIVER_VERSION	"1.6.1"
> +#define ELAN_DRIVER_VERSION	"1.6.2"
>  #define ELAN_VENDOR_ID		0x04f3
>  #define ETP_MAX_PRESSURE	255
>  #define ETP_FWIDTH_REDUCE	90
> @@ -95,6 +95,8 @@ struct elan_tp_data {
>  	bool			baseline_ready;
>  };
> =20
> +static int check_ASUS_special_fw(struct elan_tp_data *data);
> +
>  static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
>  			   u16 *signature_address)
>  {
> @@ -210,21 +212,40 @@ static int __elan_initialize(struct elan_tp_dat=
a *data)
>  		return error;
>  	}
> =20
> -	data->mode |=3D ETP_ENABLE_ABS;
> -	error =3D data->ops->set_mode(client, data->mode);
> -	if (error) {
> -		dev_err(&client->dev,
> -			"failed to switch to absolute mode: %d\n", error);
> -		return error;
> -	}
> +	/* If it's the special FW, it need a different flow for mode change=
=2E*/
> +	if (check_ASUS_special_fw(data)) {
> +		error =3D data->ops->sleep_control(client, false);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to wake device up: %d\n", error);
> +			return error;
> +		}
> =20
> -	error =3D data->ops->sleep_control(client, false);
> -	if (error) {
> -		dev_err(&client->dev,
> -			"failed to wake device up: %d\n", error);
> -		return error;
> -	}
> +		msleep(200);
> =20
> +		data->mode |=3D ETP_ENABLE_ABS;
> +		error =3D data->ops->set_mode(client, data->mode);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to switch to absolute mode: %d\n", error);
> +			return error;
> +		}
> +	} else {
> +		data->mode |=3D ETP_ENABLE_ABS;
> +		error =3D data->ops->set_mode(client, data->mode);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to switch to absolute mode: %d\n", error);
> +			return error;
> +		}
> +
> +		error =3D data->ops->sleep_control(client, false);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to wake device up: %d\n", error);
> +			return error;
> +		}
> +	}
>  	return 0;
>  }
> =20
> @@ -757,6 +778,34 @@ out:
>  	return retval;
>  }
> =20
> +static int check_ASUS_special_fw(struct elan_tp_data *data) {
> +	struct i2c_client *client =3D data->client;
> +	int error;
> +
> +	error =3D data->ops->get_product_id(client, &data->product_id);
> +	if (error)
> +		return false;
> +
> +	error =3D data->ops->get_sm_version(client, &data->ic_type,
> +					  &data->sm_version);
> +	if (error)
> +		return false;

That means we'd be fetching product ID and IC type twice when initializ=
ing the device. Can we come with a way to do it once?
[KT]:Because the elan_query_device_info() is behind the elan_initialize=
(). That's why I fetching product ID and IC type in the elan_initialize=
()
    I will discuss with FW team and then execute elan_query_device_info=
() first to get product_id and ic_type.=20
> +
> +	if (data->ic_type =3D=3D 0x0E) {

Maybe

	if (dat->ic_type !=3D 0x0e)
		return false;

? Then you would not need to indent the switch statement.
[KT] : OK, fix in the next patch
> +		switch (data->product_id) {
> +		case 0x05:
> +		case 0x06:
> +		case 0x07:
> +		case 0x09:
> +		case 0x13:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +	return false;
> +}
> =20
>  static DEVICE_ATTR_WO(acquire);
>  static DEVICE_ATTR_RO(min);
> --
> 2.7.4
>=20

Thanks.

--=20
Dmitry
