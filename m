From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: elan_i2c - Add pressure normalization
Date: Sun, 12 Apr 2015 16:15:11 -0700
Message-ID: <20150412231511.GA35775@dtor-ws>
References: <37C3176B-C1AD-4417-AF27-A9CBEAA468AC@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34142 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbDLXPQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Apr 2015 19:15:16 -0400
Content-Disposition: inline
In-Reply-To: <37C3176B-C1AD-4417-AF27-A9CBEAA468AC@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: duson <dusonlin@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>

Hi Duson,

On Sat, Apr 11, 2015 at 07:01:00PM +0800, duson wrote:
> Get pressure format flag form firmware to check need to send normaliz=
ed
> pressure data to upper OS or not. The normalized data will approximat=
e
> the measure of area of the ideal metal weight. For example, using the
> 8 mm metal weight touch the touchpad surface, the ideal value is 4*4=3D=
16
> (ignore the constent pi) and the pressure get from firmware will near=
 16.
>=20
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c.h       |    7 +++++--
>  drivers/input/mouse/elan_i2c_core.c  |   25 +++++++++++++++---------=
-
>  drivers/input/mouse/elan_i2c_i2c.c   |   26 ++++++++++++++++++++++++=
--
>  drivers/input/mouse/elan_i2c_smbus.c |   12 ++++++++++--
>  4 files changed, 54 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/ela=
n_i2c.h
> index e100c1b..5ca846e 100644
> --- a/drivers/input/mouse/elan_i2c.h
> +++ b/drivers/input/mouse/elan_i2c.h
> @@ -1,4 +1,4 @@
> -/*
> +=EF=BB=BF/*
>   * Elan I2C/SMBus Touchpad driver
>   *
>   * Copyright (c) 2013 ELAN Microelectronics Corp.
> @@ -17,7 +17,7 @@
>   */
> =20
>  #ifndef _ELAN_I2C_H
> -#define _ELAN_i2C_H
> +#define _ELAN_I2C_H
> =20

This has already been fixed in my tree.

>  #include <linux/types.h>
> =20
> @@ -25,6 +25,7 @@
>  #define ETP_ENABLE_CALIBRATE	0x0002
>  #define ETP_DISABLE_CALIBRATE	0x0000
>  #define ETP_DISABLE_POWER	0x0001
> +#define ETP_PRESSURE_OFFSET	25
> =20
>  /* IAP Firmware handling */
>  #define ETP_FW_NAME		"elan_i2c.bin"
> @@ -79,6 +80,8 @@ struct elan_transport_ops {
>  				struct completion *reset_done);
> =20
>  	int (*get_report)(struct i2c_client *client, u8 *report);
> +	int (*get_pressure_adjustment)(struct i2c_client *client,
> +				       int *adjustment);
>  };
> =20
>  extern const struct elan_transport_ops elan_smbus_ops, elan_i2c_ops;
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mous=
e/elan_i2c_core.c
> index 4b970e2..6333ba6 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2013 ELAN Microelectronics Corp.
>   *
>   * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com=
=2Etw>
> - * Version: 1.5.6
> + * Version: 1.5.7
>   *
>   * Based on cyapa driver:
>   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> @@ -40,8 +40,7 @@
>  #include "elan_i2c.h"
> =20
>  #define DRIVER_NAME		"elan_i2c"
> -#define ELAN_DRIVER_VERSION	"1.5.6"
> -#define ETP_PRESSURE_OFFSET	25
> +#define ELAN_DRIVER_VERSION	"1.5.7"
>  #define ETP_MAX_PRESSURE	255
>  #define ETP_FWIDTH_REDUCE	90
>  #define ETP_FINGER_WIDTH	15
> @@ -81,7 +80,7 @@ struct elan_tp_data {
>  	u8			sm_version;
>  	u8			iap_version;
>  	u16			fw_checksum;
> -
> +	int			pressure_adjustment;
>  	u8			mode;
> =20
>  	bool			irq_wake;
> @@ -229,6 +228,11 @@ static int elan_query_device_info(struct elan_tp=
_data *data)
>  	if (error)
>  		return error;
> =20
> +	error =3D data->ops->get_pressure_adjustment(data->client,
> +						   &data->pressure_adjustment);
> +	if (error)
> +		return error;
> +
>  	return 0;
>  }
> =20
> @@ -726,8 +730,8 @@ static void elan_report_contact(struct elan_tp_da=
ta *data,
>  	struct input_dev *input =3D data->input;
>  	unsigned int pos_x, pos_y;
>  	unsigned int pressure, mk_x, mk_y;
> -	unsigned int area_x, area_y, major, minor, new_pressure;
> -
> +	unsigned int area_x, area_y, major, minor;
> +	unsigned int scaled_pressure;
> =20
>  	if (contact_valid) {
>  		pos_x =3D ((finger_data[0] & 0xf0) << 4) |
> @@ -756,15 +760,16 @@ static void elan_report_contact(struct elan_tp_=
data *data,
>  		major =3D max(area_x, area_y);
>  		minor =3D min(area_x, area_y);
> =20
> -		new_pressure =3D pressure + ETP_PRESSURE_OFFSET;
> -		if (new_pressure > ETP_MAX_PRESSURE)
> -			new_pressure =3D ETP_MAX_PRESSURE;
> +		scaled_pressure =3D pressure + data->pressure_adjustment;
> +
> +		if (scaled_pressure > ETP_MAX_PRESSURE)
> +			scaled_pressure =3D ETP_MAX_PRESSURE;
> =20
>  		input_mt_slot(input, contact_num);
>  		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
>  		input_report_abs(input, ABS_MT_POSITION_X, pos_x);
>  		input_report_abs(input, ABS_MT_POSITION_Y, data->max_y - pos_y);
> -		input_report_abs(input, ABS_MT_PRESSURE, new_pressure);
> +		input_report_abs(input, ABS_MT_PRESSURE, scaled_pressure);
>  		input_report_abs(input, ABS_TOOL_WIDTH, mk_x);
>  		input_report_abs(input, ABS_MT_TOUCH_MAJOR, major);
>  		input_report_abs(input, ABS_MT_TOUCH_MINOR, minor);
> diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse=
/elan_i2c_i2c.c
> index e29b28c..f5031b5 100644
> --- a/drivers/input/mouse/elan_i2c_i2c.c
> +++ b/drivers/input/mouse/elan_i2c_i2c.c
> @@ -41,6 +41,7 @@
>  #define ETP_I2C_MAX_X_AXIS_CMD		0x0106
>  #define ETP_I2C_MAX_Y_AXIS_CMD		0x0107
>  #define ETP_I2C_RESOLUTION_CMD		0x0108
> +#define ETP_I2C_PRESSURE_CMD		0x010A
>  #define ETP_I2C_IAP_VERSION_CMD		0x0110
>  #define ETP_I2C_SET_CMD			0x0300
>  #define ETP_I2C_POWER_CMD		0x0307
> @@ -361,8 +362,28 @@ static int elan_i2c_get_num_traces(struct i2c_cl=
ient *client,
>  		return error;
>  	}
> =20
> -	*x_traces =3D val[0] - 1;
> -	*y_traces =3D val[1] - 1;
> +	*x_traces =3D val[0];
> +	*y_traces =3D val[1];

This change seems unrelated to the patch, please send separately if
needed.

> +
> +	return 0;
> +}
> +
> +static int elan_i2c_get_pressure_adjustment(struct i2c_client *clien=
t,
> +					    int *adjustment)
> +{
> +	int error;
> +	u8 val[3];
> +
> +	error =3D elan_i2c_read_cmd(client, ETP_I2C_PRESSURE_CMD, val);
> +	if (error) {
> +		dev_err(&client->dev, "failed to get pressure format: %d\n",
> +			error);
> +		return error;
> +	}
> +	if ((val[0] >> 4) & 0x1)
> +		*adjustment =3D 0;
> +	else
> +		*adjustment =3D ETP_PRESSURE_OFFSET;
> =20
>  	return 0;
>  }
> @@ -599,6 +620,7 @@ const struct elan_transport_ops elan_i2c_ops =3D =
{
>  	.get_sm_version		=3D elan_i2c_get_sm_version,
>  	.get_product_id		=3D elan_i2c_get_product_id,
>  	.get_checksum		=3D elan_i2c_get_checksum,
> +	.get_pressure_adjustment =3D elan_i2c_get_pressure_adjustment,
> =20
>  	.get_max		=3D elan_i2c_get_max,
>  	.get_resolution		=3D elan_i2c_get_resolution,
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mou=
se/elan_i2c_smbus.c
> index 5cd4a05..2b6516f 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -268,12 +268,19 @@ static int elan_smbus_get_num_traces(struct i2c=
_client *client,
>  		return error;
>  	}
> =20
> -	*x_traces =3D val[1] - 1;
> -	*y_traces =3D val[2] - 1;
> +	*x_traces =3D val[1];
> +	*y_traces =3D val[2];

This change seems unrelated to the patch, please send separately if
needed.

> =20
>  	return 0;
>  }
> =20
> +static int elan_smbus_get_pressure_adjustment(struct i2c_client *cli=
ent,
> +					      int *adjustment)
> +{
> +	*adjustment =3D ETP_PRESSURE_OFFSET;
> +	return 0;
> +}
> +
>  static int elan_smbus_iap_get_mode(struct i2c_client *client,
>  				   enum tp_mode *mode)
>  {
> @@ -497,6 +504,7 @@ const struct elan_transport_ops elan_smbus_ops =3D=
 {
>  	.get_sm_version		=3D elan_smbus_get_sm_version,
>  	.get_product_id		=3D elan_smbus_get_product_id,
>  	.get_checksum		=3D elan_smbus_get_checksum,
> +	.get_pressure_adjustment =3D elan_smbus_get_pressure_adjustment,
> =20
>  	.get_max		=3D elan_smbus_get_max,
>  	.get_resolution		=3D elan_smbus_get_resolution,
> --=20

Applied (but dropped changes to the number of traces calculations).

Thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
