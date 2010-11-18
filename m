From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 3/5] qt602240_ts: Trust factory configuration of
 touchscreen.
Date: Thu, 18 Nov 2010 22:09:35 +0900
Message-ID: <4CE5258F.4030507@samsung.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
 <20101116204200.28796.23013.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53674 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab0KRNJh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 08:09:37 -0500
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC3007300JZ3A80@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 22:09:35 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC300AY10JZ66@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 22:09:35 +0900 (KST)
In-reply-to: <20101116204200.28796.23013.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: linux-input@vger.kernel.org

Hi, Chris.

On 2010-11-17 =EC=98=A4=EC=A0=84 5:42, Chris Leech wrote:
> The maXTouch 224 touchscreen controller has non-volatile storage for =
system
> configuration and calibration settings.  Make it a platform option to=
 trust
> those values, instead of reconfiguring everything.  The configuration=
 settings
> currently being applied are determined from the firmware version, but=
 are not
> appropriate for all systems.  This should be a compatible change with=
 existing
> users of this driver.
>
> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>
> ---
>   drivers/input/touchscreen/qt602240_ts.c |  121 ++++++++++++++++++++=
+++--------
>   include/linux/i2c/qt602240_ts.h         |    8 ++
>   2 files changed, 98 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/=
touchscreen/qt602240_ts.c
> index 95496ec..11055ec 100644
> --- a/drivers/input/touchscreen/qt602240_ts.c
> +++ b/drivers/input/touchscreen/qt602240_ts.c
> @@ -353,7 +353,7 @@ struct qt602240_finger {
>   struct qt602240_data {
>   	struct i2c_client *client;
>   	struct input_dev *input_dev;
> -	const struct qt602240_platform_data *pdata;
> +	struct qt602240_platform_data *pdata;
>   	struct qt602240_object *object_table;
>   	struct qt602240_info info;
>   	struct qt602240_finger finger[QT602240_MAX_FINGER];
> @@ -754,7 +754,7 @@ static int qt602240_check_reg_init(struct qt60224=
0_data *data)
>
>   static int qt602240_check_matrix_size(struct qt602240_data *data)
>   {
> -	const struct qt602240_platform_data *pdata =3D data->pdata;
> +	struct qt602240_platform_data *pdata =3D data->pdata;
>   	struct device *dev =3D&data->client->dev;
>   	int mode =3D -1;
>   	int error;
> @@ -844,7 +844,7 @@ static int qt602240_make_highchg(struct qt602240_=
data *data)
>
>   static void qt602240_handle_pdata(struct qt602240_data *data)
>   {
> -	const struct qt602240_platform_data *pdata =3D data->pdata;
> +	struct qt602240_platform_data *pdata =3D data->pdata;
>   	u8 voltage;
>
>   	/* Set touchscreen lines */
> @@ -890,6 +890,48 @@ static void qt602240_handle_pdata(struct qt60224=
0_data *data)
>   	}
>   }
>
> +static void qt602240_read_config(struct qt602240_data *data)
> +{
> +	struct qt602240_platform_data *pdata =3D data->pdata;
> +	u8 val;
> +	u8 high, low;
> +
> +	/* touchscreen lines */
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_XSI=
ZE,
> +			&val);
> +		pdata->x_line =3D val;
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_YSI=
ZE,
> +			&val);
> +		pdata->x_line =3D val;
> +
> +	/* touchscreen orient */
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_ORI=
ENT,
> +			&val);
> +		pdata->orient =3D val;
> +
> +	/* touchscreen burst length */
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_BLE=
N,
> +			&val);
> +		pdata->blen =3D val;
> +
> +	/* touchscreen threshold */
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_TCH=
THR,
> +			&val);
> +		pdata->threshold =3D val;
> +
> +	/* touchscreen resolution */
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
> +			QT602240_TOUCH_XRANGE_LSB,&low);
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
> +			QT602240_TOUCH_XRANGE_MSB,&high);
> +	pdata->x_size =3D (high<<  8) | (low + 1);
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
> +			QT602240_TOUCH_YRANGE_LSB,&low);
> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
> +			QT602240_TOUCH_YRANGE_MSB,&high);
> +	pdata->y_size =3D (high<<  8) | (low + 1);
> +}
> +

Please don't modify pdata, the pdata means platform specific data from
machine file. The pdata of struct qt602240_data be used only in
qt602240_initialize function when driver is probed, so we need to
remove pdata from struct qt602240_data.

>   static int qt602240_get_info(struct qt602240_data *data)
>   {
>   	struct i2c_client *client =3D data->client;
> @@ -981,23 +1023,28 @@ static int qt602240_initialize(struct qt602240=
_data *data)
>   	if (error)
>   		return error;
>
> -	/* Check register init values */
> -	error =3D qt602240_check_reg_init(data);
> -	if (error)
> -		return error;
> +	if (data->pdata->trust_nvm) {
> +		/* read configuration from device */
> +		qt602240_read_config(data);
> +	} else {
> +		/* Check register init values */
> +		error =3D qt602240_check_reg_init(data);
> +		if (error)
> +			return error;
>
> -	/* Check X/Y matrix size */
> -	error =3D qt602240_check_matrix_size(data);
> -	if (error)
> -		return error;
> +		/* Check X/Y matrix size */
> +		error =3D qt602240_check_matrix_size(data);
> +		if (error)
> +			return error;
>
> -	qt602240_handle_pdata(data);
> +		qt602240_handle_pdata(data);
>
> -	/* Backup to memory */
> -	qt602240_write_object(data, QT602240_GEN_COMMAND,
> -			QT602240_COMMAND_BACKUPNV,
> -			QT602240_BACKUP_VALUE);
> -	msleep(QT602240_BACKUP_TIME);
> +		/* Backup to memory */
> +		qt602240_write_object(data, QT602240_GEN_COMMAND,
> +				QT602240_COMMAND_BACKUPNV,
> +				QT602240_BACKUP_VALUE);
> +		msleep(QT602240_BACKUP_TIME);
> +	}
>
>   	/* Soft reset */
>   	qt602240_write_object(data, QT602240_GEN_COMMAND,
> @@ -1227,6 +1274,8 @@ static int __devinit qt602240_probe(struct i2c_=
client *client,
>   	struct qt602240_data *data;
>   	struct input_dev *input_dev;
>   	int error;
> +	u16 x_size;
> +	u16 y_size;
>
>   	if (!client->dev.platform_data)
>   		return -EINVAL;
> @@ -1249,20 +1298,6 @@ static int __devinit qt602240_probe(struct i2c=
_client *client,
>   	__set_bit(EV_KEY, input_dev->evbit);
>   	__set_bit(BTN_TOUCH, input_dev->keybit);
>
> -	/* For single touch */
> -	input_set_abs_params(input_dev, ABS_X,
> -			     0, QT602240_MAX_XC, 0, 0);
> -	input_set_abs_params(input_dev, ABS_Y,
> -			     0, QT602240_MAX_YC, 0, 0);
> -
> -	/* For multi touch */
> -	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
> -			     0, QT602240_MAX_AREA, 0, 0);
> -	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -			     0, QT602240_MAX_XC, 0, 0);
> -	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> -			     0, QT602240_MAX_YC, 0, 0);
> -
>   	input_set_drvdata(input_dev, data);
>
>   	data->client =3D client;
> @@ -1276,6 +1311,30 @@ static int __devinit qt602240_probe(struct i2c=
_client *client,
>   	if (error)
>   		goto err_free_object;
>
> +	/*
> +	 * Bit 0 of TOUCH_ORIENT is the X/Y swap configuration.
> +	 * If the axises are swapped the reporting will change, and in orde=
r to
> +	 * get the scaling correct we need to swap the maximum range values
> +	 * reported to the input layer.
> +	 */
> +	if (data->pdata->orient&  1) {
> +		x_size =3D data->pdata->y_size;
> +		y_size =3D data->pdata->x_size;
> +	} else {
> +		x_size =3D data->pdata->x_size;
> +		y_size =3D data->pdata->y_size;
> +	}
> +
> +	/* For single touch */
> +	input_set_abs_params(input_dev, ABS_X, 0, x_size, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, y_size, 0, 0);
> +
> +	/* For multi touch */
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> +			QT602240_MAX_AREA, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, x_size, 0, 0)=
;
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, y_size, 0, 0)=
;
> +

I'm not sure but i know this max is maximum value to be supported by
touch chip.

>   	error =3D qt602240_make_highchg(data);
>   	if (error)
>   		goto err_free_object;
> diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt60=
2240_ts.h
> index c5033e1..d2aa1b6 100644
> --- a/include/linux/i2c/qt602240_ts.h
> +++ b/include/linux/i2c/qt602240_ts.h
> @@ -33,6 +33,14 @@ struct qt602240_platform_data {
>   	unsigned int threshold;
>   	unsigned int voltage;
>   	unsigned char orient;
> +	/*
> +	 * trust_nvm: 1 to trust HW config, 0 for software reconfiguration
> +	 * If trust_nvm is set, all of the above values will be read from t=
he
> +	 * device (presumably loaded from non-volatile memory at reset),
> +	 * instead of the other way around (configuring the device based on
> +	 * platform_data).
> +	 */
> +	unsigned char trust_nvm;
>   };
>
>   #endif /* __LINUX_QT602240_TS_H */
>
>

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
