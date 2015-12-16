From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH] input/touchscreen: New EETI eGalaxTouch serial
 touchscreen driver
Date: Wed, 16 Dec 2015 13:43:03 +0100
Message-ID: <56715C57.9080507@pr.hu>
References: <1450178527-26745-1-git-send-email-zboszormenyi@sicom.com>
 <20151215212123.GA18844@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:54102 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbbLPMnR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 07:43:17 -0500
In-Reply-To: <20151215212123.GA18844@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszormenyi@sicom.com>
Cc: linux-input@vger.kernel.org

2015-12-15 22:21 keltez=E9ssel, Dmitry Torokhov =EDrta:
> Hi Zolt=E1n,
>
> On Tue, Dec 15, 2015 at 12:22:07PM +0100, B=F6sz=F6rm=E9nyi Zolt=E1n =
wrote:
>> From: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>
>>
>> There are two EETI touchscreen drivers in the kernel (eeti_ts and eg=
alax_ts)
>> but both are for I2C-connected panels. This is for a different, seri=
al
>> and not multi-touch touchscreen panel. The protocol documentation is=
 at
>> http://www.eeti.com.tw/pdf/Software%20Programming%20Guide_v2.0.pdf
>>
>> Signed-off-by: B=F6sz=F6rm=E9nyi Zolt=E1n <zboszor@pr.hu>
>>
> Thank you for your patch, it looks pretty good, just a few comments
> below.
>
>> +config TOUCHSCREEN_EGALAX_SERIO
> I'd rather called it TOUCHSCREEN_EGALAX_SERIAL

It doesn't matter, I am not attached to names.

>> +obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIO)	+=3D egalax.o
> I think better name is egalax_ts_serial.

Sure, I was thinking about it myself.

>>  obj-$(CONFIG_TOUCHSCREEN_FT6236)	+=3D ft6236.o
>>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+=3D fujitsu_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+=3D goodix.o
>>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+=3D ili210x.o
>>  obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+=3D imx6ul_tsc.o
>>  obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+=3D inexio.o
>>  obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+=3D intel-mid-touch.o
>>  obj-$(CONFIG_TOUCHSCREEN_IPROC)		+=3D bcm_iproc_tsc.o
>>  obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+=3D lpc32xx_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+=3D max11801_ts.o
>> diff --git a/drivers/input/touchscreen/egalax.c b/drivers/input/touc=
hscreen/egalax.c
>> new file mode 100644
>> index 0000000..94ac9bd
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/egalax.c
>> @@ -0,0 +1,210 @@
>> +/*
>> + * EETI Egalax serial touchscreen driver
>> + *
>> + * Copyright (c) 2015 Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>
>> + *
>> + * based on the
>> + *
>> + * Hampshire serial touchscreen driver (Copyright (c) 2010 Adam Ben=
nett)
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/input.h>
>> +#include <linux/serio.h>
>> +
>> +#define DRIVER_DESC	"EETI Egalax serial touchscreen driver"
>> +
>> +MODULE_AUTHOR("Zolt=E1n B=F6sz=F6rm=E9nyi <zboszor@pr.hu>");
>> +MODULE_DESCRIPTION(DRIVER_DESC);
>> +MODULE_LICENSE("GPL");
>> +
>> +/*
>> + * Definitions & global arrays.
>> + */
>> +
>> +#define EGALAX_FORMAT_MAX_LENGTH 6
>> +#define EGALAX_RESPONSE_BEGIN_BYTE 0x80
>> +#define EGALAX_FORMAT_PRESSURE_BIT 0x40
>> +#define EGALAX_FORMAT_TOUCH_BIT 0x01
> We have BIT() macro that would be very useful here.
>
>> +#define EGALAX_FORMAT_RESOLUTION 0x06
>> +
>> +#define EGALAX_MIN_XC 0
>> +#define EGALAX_MAX_XC 0x4000
>> +#define EGALAX_MIN_YC 0
>> +#define EGALAX_MAX_YC 0x4000
>> +
>> +#define EGALAX_GET_XC(data, resbits, shift) ((((data[1] & (resbits)=
) << 7) | (data[2] & 0x7f)) << shift)
>> +#define EGALAX_GET_YC(data, resbits, shift) ((((data[3] & (resbits)=
) << 7) | (data[4] & 0x7f)) << shift)
>> +#define EGALAX_GET_TOUCHED(data) (EGALAX_FORMAT_TOUCH_BIT & data[0]=
)
>> +
>> +/*
>> + * Per-touchscreen data.
>> + */
>> +
>> +struct egalax {
>> +	struct input_dev *dev;
>> +	struct serio *serio;
>> +	int idx;
>> +	int bytes;
>> +	int resbits;
>> +	int shift;
>> +	unsigned char data[EGALAX_FORMAT_MAX_LENGTH];
>> +	char phys[32];
>> +};
>> +
>> +static void egalax_process_data(struct egalax *pegalax)
>> +{
>> +	struct input_dev *dev =3D pegalax->dev;
>> +
>> +	if (++pegalax->idx =3D=3D pegalax->bytes) {
>> +		input_report_abs(dev, ABS_X, EGALAX_GET_XC(pegalax->data, pegalax=
->resbits, pegalax->shift));
>> +		input_report_abs(dev, ABS_Y, EGALAX_GET_YC(pegalax->data, pegalax=
->resbits, pegalax->shift));
>> +		input_report_key(dev, BTN_TOUCH, EGALAX_GET_TOUCHED(pegalax->data=
));
>> +		input_sync(dev);
>> +
>> +		pegalax->idx =3D 0;
>> +	}
>> +}
>> +
>> +static irqreturn_t egalax_interrupt(struct serio *serio,
>> +		unsigned char data, unsigned int flags)
>> +{
>> +	struct egalax *pegalax =3D serio_get_drvdata(serio);
>> +
>> +	pegalax->data[pegalax->idx] =3D data;
>> +
>> +	if (EGALAX_RESPONSE_BEGIN_BYTE & pegalax->data[0]) {
>> +		pegalax->bytes =3D (EGALAX_FORMAT_PRESSURE_BIT & pegalax->data[0]=
 ? 6 : 5);
>> +		switch ((EGALAX_FORMAT_RESOLUTION & pegalax->data[0]) >> 1) {
>> +		case 0:
>> +			pegalax->resbits =3D 0x0f;
>> +			pegalax->shift =3D 3;
>> +			break;
>> +		case 1:
>> +			pegalax->resbits =3D 0x1f;
>> +			pegalax->shift =3D 2;
>> +			break;
>> +		case 2:
>> +			pegalax->resbits =3D 0x3f;
>> +			pegalax->shift =3D 1;
>> +			break;
>> +		default:
>> +			pegalax->resbits =3D 0x7f;
>> +			pegalax->shift =3D 0;
>> +			break;
>> +		}
>> +		egalax_process_data(pegalax);
> There is no reason to recalculate shift and mask on every byte and ca=
ll
> egalax_process_data(), better is to wait till you get full packet and
> then do the claculations. Also I think you can avoid conditional
> computation (switch) here.

See my comment below.

>> +static void egalax_disconnect(struct serio *serio)
>> +{
>> +	struct egalax *pegalax =3D serio_get_drvdata(serio);
>> +
>> +	input_get_device(pegalax->dev);
>> +	input_unregister_device(pegalax->dev);
>> +	serio_close(serio);
>> +	serio_set_drvdata(serio, NULL);
>> +	input_put_device(pegalax->dev);
>> +	kfree(pegalax);
> This is needlessly complicated (although I do know we have this code =
in
> other drivers). Since we do not send any data *to* the touch controll=
er
> we can close the port first and then unregister the device.

OK, whatever you think is better. I am not familiar with the input
subsystem internals.

>
> Could you please try the version of the patch below and let me know i=
f
> it works for you?
>
> Thanks!

While the code itself didn't look suspicious at first, testing showed
that it doesn't work when compiled in with 4.4-rc5, while my original
code did. You got the mask and expanding my macros wrong.
I will submit a v3 patch, as yours was v2.

Thanks,
Zolt=E1n B=F6sz=F6rm=E9nyi

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
