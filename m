From: Chris Leech <christopher.leech@linux.intel.com>
Subject: Re: [PATCH 3/5] qt602240_ts: Trust factory configuration of
	touchscreen.
Date: Thu, 18 Nov 2010 11:41:12 -0800
Message-ID: <20101118194112.GF1273@cleech-lnx.jf.intel.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6> <20101116204200.28796.23013.stgit@localhost6.localdomain6> <4CE5258F.4030507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:59279 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab0KRTlN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 14:41:13 -0500
Content-Disposition: inline
In-Reply-To: <4CE5258F.4030507@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

On Thu, Nov 18, 2010 at 10:09:35PM +0900, Joonyoung Shim wrote:
> Hi, Chris.
> On 2010-11-17 =EC=98=A4=EC=A0=84 5:42, Chris Leech wrote:

>> +static void qt602240_read_config(struct qt602240_data *data)
>> +{
>> +	struct qt602240_platform_data *pdata =3D data->pdata;
>> +	u8 val;
>> +	u8 high, low;
>> +
>> +	/* touchscreen lines */
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_XS=
IZE,
>> +			&val);
>> +		pdata->x_line =3D val;
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_YS=
IZE,
>> +			&val);
>> +		pdata->x_line =3D val;
>> +
>> +	/* touchscreen orient */
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_OR=
IENT,
>> +			&val);
>> +		pdata->orient =3D val;
>> +
>> +	/* touchscreen burst length */
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_BL=
EN,
>> +			&val);
>> +		pdata->blen =3D val;
>> +
>> +	/* touchscreen threshold */
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_TC=
HTHR,
>> +			&val);
>> +		pdata->threshold =3D val;
>> +
>> +	/* touchscreen resolution */
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
>> +			QT602240_TOUCH_XRANGE_LSB,&low);
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
>> +			QT602240_TOUCH_XRANGE_MSB,&high);
>> +	pdata->x_size =3D (high<<  8) | (low + 1);
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
>> +			QT602240_TOUCH_YRANGE_LSB,&low);
>> +	qt602240_read_object(data, QT602240_TOUCH_MULTI,
>> +			QT602240_TOUCH_YRANGE_MSB,&high);
>> +	pdata->y_size =3D (high<<  8) | (low + 1);
>> +}
>> +
>
> Please don't modify pdata, the pdata means platform specific data fro=
m
> machine file. The pdata of struct qt602240_data be used only in
> qt602240_initialize function when driver is probed, so we need to
> remove pdata from struct qt602240_data.

OK. If I add the relevant fields to qt602240_data, and either copy over
from pdata or read from the hardware configuration based on trust_nvm,
does that approach seem acceptable to you?

>> +	/*
>> +	 * Bit 0 of TOUCH_ORIENT is the X/Y swap configuration.
>> +	 * If the axises are swapped the reporting will change, and in ord=
er to
>> +	 * get the scaling correct we need to swap the maximum range value=
s
>> +	 * reported to the input layer.
>> +	 */
>> +	if (data->pdata->orient&  1) {
>> +		x_size =3D data->pdata->y_size;
>> +		y_size =3D data->pdata->x_size;
>> +	} else {
>> +		x_size =3D data->pdata->x_size;
>> +		y_size =3D data->pdata->y_size;
>> +	}
>> +
>> +	/* For single touch */
>> +	input_set_abs_params(input_dev, ABS_X, 0, x_size, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_Y, 0, y_size, 0, 0);
>> +
>> +	/* For multi touch */
>> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
>> +			QT602240_MAX_AREA, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, x_size, 0, 0=
);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, y_size, 0, 0=
);
>> +
>
> I'm not sure but i know this max is maximum value to be supported by
> touch chip.

I think the maxtouch scales it's output based on the TOUCH_XRANGE and
TOUCH_YRANGE configuration, so there should be the maximum values that
will ever be reported.

I can test this again, but if these values are wrong I get messed up
scaling when they events are translated to windowing coordinates.

- Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
