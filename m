From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] Input: Driver for SiS 9200 family I2C touchscreen
 controller.
Date: Fri, 1 Jul 2016 17:17:19 -0700
Message-ID: <20160702001719.GA36469@dtor-ws>
References: <1462512137-28807-1-git-send-email-mika.penttila@nextfour.com>
 <1462512137-28807-2-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36470 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbcGBARb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2016 20:17:31 -0400
Content-Disposition: inline
In-Reply-To: <1462512137-28807-2-git-send-email-mika.penttila@nextfour.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mika.penttila@nextfour.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, tammy_tseng@sis.com, yuger_yu@sis.com

Hi Mika,

On Fri, May 06, 2016 at 08:22:16AM +0300, mika.penttila@nextfour.com wr=
ote:
> From: Mika Penttil=E4 <mika.penttila@nextfour.com>
>=20
> Multitouch protocol B support.
>=20
> v5:
>   - rebased to 4.6.0-rc6
>=20
> v4:
>   - cleanups and fixes according to review feedback
>   - irq and reset gpios are now optional,
>     if not spesified it is expected the firmware / hw
>     takes care of reset states and irq flow
>   - irq and reset gpio polarities come from dts/firmware
>   - report parsing and reporting are done at once
>   - error handling improvements
>   - misc cleanups
>   - added comments
>    =20
> v3:
>   - cleanup unused defines
>   - added acked-bys from SiS
>=20
> v2:
>   - use gpio descriptor api
>   - probe cleanups
>   - error handling cleanups
>=20
> Signed-off-by: Mika Penttil=E4 <mika.penttila@nextfour.com>
> Acked-by: Tammy Tseng <tammy_tseng@sis.com>
> Acked-by: Yuger Yu <yuger_yu@sis.com>
> ---
>  drivers/input/touchscreen/Kconfig   |  12 +
>  drivers/input/touchscreen/Makefile  |   1 +
>  drivers/input/touchscreen/sis_i2c.c | 461 ++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 474 insertions(+)
>  create mode 100644 drivers/input/touchscreen/sis_i2c.c
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 8ecdc38..8f06ae7 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1155,4 +1155,16 @@ config TOUCHSCREEN_ROHM_BU21023
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bu21023_ts.
> =20
> +config TOUCHSCREEN_SIS_I2C
> +	tristate "SiS 9200 family I2C touchscreen driver"
> +	depends on I2C
> +	depends on GPIOLIB
> +	help
> +	  This enables support for SiS 9200 family over I2C based touchscre=
ens.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sis_i2c.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index f42975e..0839e99 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_TOUCHSCREEN_PCAP)		+=3D pcap_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+=3D penmount.o
>  obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+=3D pixcir_i2c_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+=3D s3c2410_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)       +=3D sis_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ST1232)	+=3D st1232.o
>  obj-$(CONFIG_TOUCHSCREEN_STMPE)		+=3D stmpe-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+=3D sun4i-ts.o
> diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touc=
hscreen/sis_i2c.c
> new file mode 100644
> index 0000000..f1b66fa
> --- /dev/null
> +++ b/drivers/input/touchscreen/sis_i2c.c
> @@ -0,0 +1,461 @@
> +/* drivers/input/touchscreen/sis_i2c.c
> + *  - I2C Touch panel driver for SiS 9200 family
> + *
> + * Copyright (C) 2011 SiS, Inc.
> + * Copyright (C) 2015 Nextfour Group
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>

Not needed I think.

> +#include <linux/platform_device.h>

Not needed.

> +#include <linux/linkage.h>

Not needed.

> +#include <linux/slab.h>
> +#include <linux/of_gpio.h>

Not needed (but gpio/consumer.h is)

> +#include <linux/uaccess.h>
> +#include <linux/irq.h>

Not needed I think.

> +#include <asm/unaligned.h>
> +#include <linux/crc-itu-t.h>
> +
> +#define SIS_I2C_NAME "sis_i2c_ts"
> +#define MAX_FINGERS					10
> +
> +#define SIS_MAX_X					4095
> +#define SIS_MAX_Y					4095
> +
> +#define PACKET_BUFFER_SIZE				128
> +
> +#define SIS_CMD_NORMAL					0x0
> +
> +#define TOUCHDOWN                                       0x3
> +#define TOUCHUP                                         0x0
> +#define MAX_BYTE					 64
> +#define PRESSURE_MAX                                    255
> +
> +/* Resolution diagonal */
> +#define AREA_LENGTH_LONGER				5792
> +/*((SIS_MAX_X^2) + (SIS_MAX_Y^2))^0.5*/
> +#define AREA_LENGTH_SHORT				5792
> +#define AREA_UNIT					(5792/32)
> +
> +#define P_BYTECOUNT					0
> +#define ALL_IN_ONE_PACKAGE				0x10
> +#define IS_TOUCH(x)					((x) & 0x1)
> +#define IS_HIDI2C(x)					(((x) & 0xF) =3D=3D 0x06)
> +#define IS_AREA(x)					(((x) >> 4) & 0x1)
> +#define IS_PRESSURE(x)				        (((x) >> 5) & 0x1)
> +#define IS_SCANTIME(x)			                (((x) >> 6) & 0x1)
> +
> +#define NORMAL_LEN_PER_POINT			        6
> +#define AREA_LEN_PER_POINT				2
> +#define PRESSURE_LEN_PER_POINT			        1
> +
> +#define TOUCH_FORMAT					0x1
> +#define HIDI2C_FORMAT					0x6
> +#define P_REPORT_ID					2
> +#define BYTE_BYTECOUNT					2
> +#define BYTE_REPORTID					1
> +#define BYTE_CRC_HIDI2C                                 0
> +#define BYTE_CRC_I2C					2
> +#define BYTE_SCANTIME					2
> +
> +struct _touchpoint {
> +	u8 id;
> +	u16 x, y;
> +	u16 pressure;
> +	u16 width;
> +	u16 height;
> +};
> +
> +struct sistp_driver_data {
> +	int fingers;
> +	struct _touchpoint pt[MAX_FINGERS];
> +};
> +
> +struct sis_ts_data {
> +	struct gpio_desc *irq_gpiod;
> +	struct gpio_desc *reset_gpiod;
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +struct sistp_driver_data tpinfo;


There is actually no need to have storage for contact info in the drive=
r
object, you can report them as you parse them.

> +};
> +
> +static int sis_cul_unit(u8 report_id)
> +{
> +	int ret =3D NORMAL_LEN_PER_POINT;
> +
> +	if (report_id !=3D ALL_IN_ONE_PACKAGE) {
> +
> +		if (IS_AREA(report_id) /*&& IS_TOUCH(report_id)*/)
> +			ret +=3D AREA_LEN_PER_POINT;
> +
> +		if (IS_PRESSURE(report_id))
> +			ret +=3D PRESSURE_LEN_PER_POINT;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sis_readpacket(struct i2c_client *client, u8 cmd, u8 *buf=
)
> +{
> +	u8 tmpbuf[MAX_BYTE] =3D {0};
> +	int ret =3D -1;
> +	int touchnum =3D 0;
> +	int p_count =3D 0;
> +	int touch_format_id =3D 0;
> +	int location =3D 0;
> +	bool read_first =3D true;
> +
> +/*
> + * I2C touch report format
> + *
> + * The controller sends one or two
> + * 64 byte reports (depending on how many
> + * contacts down etc). We read first 64 bytes
> + * and then the second chunk if needed.
> + * The packets are individually CRC
> + * checksummed.
> + *
> + * buf[0] =3D Low 8 bits of byte count value
> + * buf[1] =3D High 8 bits of byte counte value
> + * buf[2] =3D Report ID
> + * buf[touch num * 6 + 2 ] =3D Touch information
> + * 1 touch point has 6 bytes, it could be none if no touch
> + * buf[touch num * 6 + 3] =3D Touch numbers
> + *
> + * One touch point information include 6 bytes, the order is
> + *
> + * 1. status =3D touch down or touch up
> + * 2. id =3D finger id
> + * 3. x axis low 8 bits
> + * 4. x axis high 8 bits
> + * 5. y axis low 8 bits
> + * 6. y axis high 8 bits
> + */
> +	do {
> +		if (location >=3D PACKET_BUFFER_SIZE) {
> +			dev_err(&client->dev, "sis_readpacket: buffer overflow\n");
> +			return -1;
> +		}
> +
> +		ret =3D i2c_master_recv(client, tmpbuf, MAX_BYTE);
> +
> +		if (ret <=3D 0) {
> +			return touchnum;
> +		} else if (tmpbuf[P_BYTECOUNT] > MAX_BYTE) {
> +			dev_err(&client->dev, "sis_readpacket: invalid bytecout\n");
> +			return -1;
> +		}
> +
> +		if (tmpbuf[P_BYTECOUNT] < 10)
> +			return touchnum;
> +
> +		if (read_first)
> +			if (tmpbuf[P_BYTECOUNT] =3D=3D 0)
> +				return 0;	/* touchnum is 0 */
> +
> +		touch_format_id =3D tmpbuf[P_REPORT_ID] & 0xf;
> +
> +		if ((touch_format_id !=3D TOUCH_FORMAT)
> +			&& (touch_format_id !=3D HIDI2C_FORMAT)
> +			&& (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE)) {
> +			dev_err(&client->dev, "sis_readpacket: invalid reportid\n");
> +			return -1;
> +		}
> +
> +		p_count =3D (int) tmpbuf[P_BYTECOUNT] - 1; /* start from 0 */
> +		if (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) {
> +			if (IS_TOUCH(tmpbuf[P_REPORT_ID])) {
> +				p_count -=3D BYTE_CRC_I2C; /* delete 2 byte crc */
> +			} else if (IS_HIDI2C(tmpbuf[P_REPORT_ID])) {
> +				p_count -=3D BYTE_CRC_HIDI2C;
> +			} else {
> +				dev_err(&client->dev, "sis_readpacket: delete crc error\n");
> +				return -1;
> +			}
> +			if (IS_SCANTIME(tmpbuf[P_REPORT_ID]))
> +				p_count -=3D BYTE_SCANTIME;
> +		}
> +
> +		if (read_first)
> +			touchnum =3D tmpbuf[p_count];
> +		else {
> +			if (tmpbuf[p_count] !=3D 0) {
> +				dev_err(&client->dev, "sis_readpacket: nonzero point count in ta=
il packet\n");
> +				return -1;
> +			}
> +		}
> +
> +		if ((touch_format_id !=3D HIDI2C_FORMAT) &&
> +			(tmpbuf[P_BYTECOUNT] > 3)) {
> +			int crc_end =3D p_count +
> +				(IS_SCANTIME(tmpbuf[P_REPORT_ID]) * 2);
> +			u16 buf_crc =3D
> +				crc_itu_t(0, tmpbuf + 2, crc_end - 1);
> +			int l_package_crc =3D
> +				(IS_SCANTIME(tmpbuf[P_REPORT_ID]) * 2) +
> +				p_count + 1;
> +			u16 package_crc =3D
> +				get_unaligned_le16(&tmpbuf[l_package_crc]);
> +			if (buf_crc !=3D package_crc) {
> +				dev_err(&client->dev, "sis_readpacket: CRC Error\n");
> +				return -1;
> +			}
> +		}
> +
> +		memcpy(&buf[location], &tmpbuf[0], 64);
> +		/* Buf_Data [0~63] [64~128] */
> +		location +=3D MAX_BYTE;
> +		read_first =3D false;
> +	} while (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE &&
> +		tmpbuf[p_count] > 5);
> +
> +	return touchnum;

I must say that I find this logic of combining 2 packets into one large=
r
confusing. I tried to rework it so that we fetch, parse and report
contacts as we go. Please see below.

> +}
> +
> +static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct sis_ts_data *ts =3D dev_id;
> +	struct sistp_driver_data *tpinfo =3D &ts->tpinfo;
> +
> +	int ret =3D -1;
> +	int point_unit;
> +	u8 buf[PACKET_BUFFER_SIZE] =3D {0};
> +	u8 i =3D 0, fingers =3D 0;
> +	u8 px =3D 0, py =3D 0, pstatus =3D 0;
> +	u8 p_area =3D 0;
> +	u8 p_preasure =3D 0;
> +	int slot;
> +
> +redo:
> +	/* I2C or SMBUS block data read */
> +	ret =3D sis_readpacket(ts->client, SIS_CMD_NORMAL, buf);
> +
> +	if (ret < 0)
> +		goto recheck_irq;
> +
> +	else if (ret =3D=3D 0) {
> +		fingers =3D 0;
> +		goto label_sync_input;
> +	}
> +
> +	point_unit =3D sis_cul_unit(buf[P_REPORT_ID]);
> +	fingers =3D ret;
> +
> +	tpinfo->fingers =3D fingers =3D (fingers > MAX_FINGERS ? 0 : finger=
s);
> +
> +	for (i =3D 0; i < fingers; i++) {
> +		if ((buf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) && (i >=3D 5)) {
> +			pstatus =3D BYTE_BYTECOUNT + BYTE_REPORTID
> +				+ ((i - 5) * point_unit);
> +			pstatus +=3D 64;
> +		} else {
> +			pstatus =3D BYTE_BYTECOUNT + BYTE_REPORTID
> +				+ (i * point_unit);
> +		}
> +		/* X and Y coordinate locations */
> +		px =3D pstatus + 2;
> +		py =3D px + 2;
> +
> +		if ((buf[pstatus]) =3D=3D TOUCHUP) {
> +			tpinfo->pt[i].width    =3D 0;
> +			tpinfo->pt[i].height   =3D 0;
> +			tpinfo->pt[i].pressure =3D 0;
> +		} else if (buf[P_REPORT_ID] =3D=3D ALL_IN_ONE_PACKAGE
> +			&& (buf[pstatus]) =3D=3D TOUCHDOWN) {
> +			tpinfo->pt[i].width    =3D 1;
> +			tpinfo->pt[i].height   =3D 1;
> +			tpinfo->pt[i].pressure =3D 1;
> +		} else if ((buf[pstatus]) =3D=3D TOUCHDOWN) {
> +			p_area =3D py + 2;
> +			p_preasure =3D py + 2 + (IS_AREA(buf[P_REPORT_ID]) * 2);
> +
> +			if (IS_AREA(buf[P_REPORT_ID])) {
> +				tpinfo->pt[i].width =3D buf[p_area];
> +				tpinfo->pt[i].height =3D buf[p_area + 1];
> +			} else {
> +				tpinfo->pt[i].width =3D 1;
> +				tpinfo->pt[i].height =3D 1;
> +			}
> +
> +			if (IS_PRESSURE(buf[P_REPORT_ID]))
> +				tpinfo->pt[i].pressure =3D (buf[p_preasure]);
> +			else
> +				tpinfo->pt[i].pressure =3D 1;
> +		} else {
> +			dev_err(&ts->client->dev, "Touch status error\n");
> +			goto recheck_irq;
> +		}
> +		tpinfo->pt[i].id =3D (buf[pstatus + 1]);
> +		tpinfo->pt[i].x =3D le16_to_cpu(get_unaligned_le16(&buf[px]));
> +		tpinfo->pt[i].y =3D le16_to_cpu(get_unaligned_le16(&buf[py]));

get_unaligned_le16() already converts to native CPU endianness, calling
le16_to_cpu on it is a mistake.

> +
> +		slot =3D input_mt_get_slot_by_key(
> +			ts->input_dev, tpinfo->pt[i].id);
> +
> +		if (slot < 0)
> +			continue;
> +
> +		input_mt_slot(ts->input_dev, slot);
> +		input_mt_report_slot_state(ts->input_dev,
> +					MT_TOOL_FINGER, tpinfo->pt[i].pressure);
> +
> +		if (tpinfo->pt[i].pressure) {
> +
> +			tpinfo->pt[i].width *=3D AREA_UNIT;
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +					tpinfo->pt[i].width);
> +			tpinfo->pt[i].height *=3D AREA_UNIT;
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MINOR,
> +					tpinfo->pt[i].height);
> +			input_report_abs(ts->input_dev, ABS_MT_PRESSURE,
> +					tpinfo->pt[i].pressure);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +					tpinfo->pt[i].x);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +					tpinfo->pt[i].y);
> +		}
> +	}
> +
> +label_sync_input:
> +	input_mt_sync_frame(ts->input_dev);
> +	input_sync(ts->input_dev);
> +
> +recheck_irq:
> +	if (ts->irq_gpiod) {
> +		/*
> +		 * If provided and interrupt gpio and
> +		 * irq is still asserted,
> +		 * read data until interrupt is deasserted.
> +		 */
> +		ret =3D gpiod_get_value_cansleep(ts->irq_gpiod);
> +		if (ret =3D=3D 1)
> +			goto redo;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sis_ts_reset(struct i2c_client *client, struct sis_ts_da=
ta *ts)
> +{
> +
> +	ts->irq_gpiod   =3D devm_gpiod_get_optional(&client->dev,
> +						"irq", GPIOD_IN);
> +	ts->reset_gpiod =3D devm_gpiod_get_optional(&client->dev,
> +						"reset", GPIOD_OUT_LOW);
> +
> +	if (ts->reset_gpiod) {
> +		/* Get out of reset */
> +		msleep(1);

msleep(1) will not work well with low HZ values, you want to use
usleep_range().

> +		gpiod_set_value(ts->reset_gpiod, 1);
> +		msleep(1);
> +		gpiod_set_value(ts->reset_gpiod, 0);
> +		msleep(100);
> +	}
> +}
> +
> +static int sis_ts_probe(
> +	struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	int error =3D 0;
> +	struct sis_ts_data *ts =3D NULL;

No need to initialize to NULL.

> +
> +	ts =3D devm_kzalloc(&client->dev, sizeof(struct sis_ts_data), GFP_K=
ERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	sis_ts_reset(client, ts);
> +
> +	ts->client =3D client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ts->input_dev =3D devm_input_allocate_device(&client->dev);
> +	if (!ts->input_dev) {
> +		dev_err(&client->dev, "sis_ts_probe: Failed to allocate input devi=
ce\n");
> +		return -ENOMEM;
> +	}
> +
> +	ts->input_dev->name =3D "sis_touch";
> +	ts->input_dev->id.bustype =3D BUS_I2C;
> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE,
> +			0, PRESSURE_MAX, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +			0, AREA_LENGTH_LONGER, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MINOR,
> +			0, AREA_LENGTH_SHORT, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +			0, SIS_MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +			0, SIS_MAX_Y, 0, 0);
> +
> +	error =3D input_mt_init_slots(ts->input_dev, MAX_FINGERS,
> +			INPUT_MT_DROP_UNUSED | INPUT_MT_DIRECT);

It seems that the hardware keeps track of the contact identity and
reports the release events, so I do not think we need
INPUT_MT_DROP_UNUSED.

> +
> +	if (error) {
> +		dev_err(&client->dev,
> +			"failed to initialize MT slots: %d\n", error);
> +		return error;
> +	}
> +
> +	error =3D input_register_device(ts->input_dev);
> +	if (error) {
> +		dev_err(&client->dev,
> +			"unable to register input device: %d\n", error);
> +		return error;
> +	}
> +
> +	error =3D devm_request_threaded_irq(&client->dev, client->irq, NULL=
,
> +					sis_ts_irq_handler,
> +					IRQF_ONESHOT,
> +					client->name, ts);
> +
> +	if (error) {
> +		dev_err(&client->dev, "request irq failed\n");
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id sis_ts_id[] =3D {
> +	{ SIS_I2C_NAME, 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, sis_ts_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id sis_ts_dt_ids[] =3D {
> +	{ .compatible =3D "sis,9200_ts" },

DT folks object to using underscores in properties, this should be
"sis,9200-ts".

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sis_ts_dt_ids);
> +#endif
> +
> +static struct i2c_driver sis_ts_driver =3D {
> +	.probe		=3D sis_ts_probe,
> +	.id_table	=3D sis_ts_id,
> +	.driver =3D {
> +		.name	=3D SIS_I2C_NAME,
> +		.of_match_table =3D of_match_ptr(sis_ts_dt_ids),
> +	},
> +};
> +
> +module_i2c_driver(sis_ts_driver);
> +MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.9.1
>=20

Below is the version of the patch with reworked parsing and reporting
code. Please let me know if it is messed up or if it works for you.

Thanks.

--=20
Dmitry


Input: add driver for SiS 9200 family I2C touchscreen controllers

=46rom: Mika Penttil=E4 <mika.penttila@nextfour.com>

This is a driver for SiS 9200 family touchscreen controllers using I2C =
bus.

Signed-off-by: Mika Penttil=E4 <mika.penttila@nextfour.com>
Acked-by: Tammy Tseng <tammy_tseng@sis.com>
Acked-by: Yuger Yu <yuger_yu@sis.com>
Patchwork-Id: 9029121
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/touchscreen/sis_i2c.txt         |   33 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    1=20
 drivers/input/touchscreen/Kconfig                  |   12 +
 drivers/input/touchscreen/Makefile                 |    1=20
 drivers/input/touchscreen/sis_i2c.c                |  409 ++++++++++++=
++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/sis_i2c.txt
 create mode 100644 drivers/input/touchscreen/sis_i2c.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis_i2=
c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
new file mode 100644
index 0000000..6b06b20
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
@@ -0,0 +1,33 @@
+* SiS I2C Multiple Touch Controller
+
+Required properties:
+- compatible: must be "sis,9200-ts"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+  (see interrupt binding [0])
+- interrupts: touch controller interrupt (see interrupt
+  binding [0])
+
+Optional properties:
+- pinctrl-names: should be "default" (see pinctrl binding [1]).
+- pinctrl-0: a phandle pointing to the pin settings for the
+  device (see pinctrl binding [1]).
+- attn-gpio: the gpio pin used as attention line
+- reset-gpio: the gpio pin used to reset the controller
+- wakeup-source: touchscreen can be used as a wakeup source
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts=
=2Etxt
+[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+
+	sis9255@5c  {
+		compatible =3D "sis,9200-ts";
+		reg =3D <0x5c>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_sis>;
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <19 IRQ_TYPE_EDGE_FALLING>;
+		attn-gpio =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
+		reset-gpio =3D <&gpio2 30 GPIO_ACTIVE_LOW>;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Do=
cumentation/devicetree/bindings/vendor-prefixes.txt
index 80fdbe2..99029cf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -221,6 +221,7 @@ simtek
 sii	Seiko Instruments, Inc.
 silergy	Silergy Corp.
 sirf	SiRF Technology, Inc.
+sis	Silicon Integrated Systems Corp.
 sitronix	Sitronix Technology Corporation
 skyworks	Skyworks Solutions, Inc.
 smsc	Standard Microsystems Corporation
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index ee02dc7..9a29ad1 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1181,4 +1181,16 @@ config TOUCHSCREEN_ROHM_BU21023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21023_ts.
=20
+config TOUCHSCREEN_SIS_I2C
+	tristate "SiS 9200 family I2C touchscreen driver"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  This enables support for SiS 9200 family over I2C based touchscreen=
s.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sis_i2c.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index 3315882..e547399 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+=3D penmount.o
 obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+=3D pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_RM_TS)		+=3D raydium_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+=3D s3c2410_ts.o
+obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)       +=3D sis_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+=3D st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+=3D stmpe-ts.o
 obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+=3D sun4i-ts.o
diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchs=
creen/sis_i2c.c
new file mode 100644
index 0000000..bc96c9d
--- /dev/null
+++ b/drivers/input/touchscreen/sis_i2c.c
@@ -0,0 +1,409 @@
+/*
+ * Touch Screen driver for SiS 9200 family I2C Touch panels
+ *
+ * Copyright (C) 2015 SiS, Inc.
+ * Copyright (C) 2015 Nextfour Group
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/crc-itu-t.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/interrupt.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#define SIS_I2C_NAME		"sis_i2c_ts"
+
+/*
+ * The I2C packet format:
+ * le16		byte count
+ * u8		Report ID
+ * <contact data - variable length>
+ * u8		Number of contacts
+ * le16		Scan Time (optional?)
+ * le16		CRC
+ *
+ * One touch point information consists of 6+ bytes, the order is:
+ * u8		contact state
+ * u8		finger id
+ * le16		x axis
+ * le16		y axis
+ * u8		contact width (optional)
+ * u8		contact height (optional)
+ * u8		pressure (optional)
+ *
+ * Maximum amount of data transmitted in one shot is 64 bytes, if cont=
roller
+ * needs to report more contacts than fit in one packet it will send t=
rue number
+ * of contacts in first packet and 0 as number of contacts in second p=
acket.
+ */
+
+#define SIS_MAX_PACKET_SIZE		64
+
+#define SIS_PKT_LEN_OFFSET		0
+#define SIS_PKT_REPORT_OFFSET		2 /* Report ID/type */
+#define SIS_PKT_CONTACT_OFFSET		3 /* First contact */
+
+#define SIS_SCAN_TIME_LEN		2
+
+/* Supported report types */
+#define SIS_ALL_IN_ONE_PACKAGE		0x10
+#define SIS_PKT_IS_TOUCH(x)		(((x) & 0x0f) =3D=3D 0x01)
+#define SIS_PKT_IS_HIDI2C(x)		(((x) & 0x0f) =3D=3D 0x06)
+
+/* Contact properties within report */
+#define SIS_PKT_HAS_AREA(x)		((x) & BIT(4))
+#define SIS_PKT_HAS_PRESSURE(x)		((x) & BIT(5))
+#define SIS_PKT_HAS_SCANTIME(x)		((x) & BIT(6))
+
+/* Contact size */
+#define SIS_BASE_LEN_PER_CONTACT	6
+#define SIS_AREA_LEN_PER_CONTACT	2
+#define SIS_PRESSURE_LEN_PER_CONTACT	1
+
+/* Offsets within contact data */
+#define SIS_PKT_STATUS_OFFSET		0
+#define SIS_PKT_ID_OFFSET		1 /* Contact ID */
+#define SIS_PKT_X_OFFSET		2
+#define SIS_PKT_Y_OFFSET		4
+#define SIS_PKT_WIDTH_OFFSET		6
+#define SIS_PKT_HEIGHT_OFFSET		7
+#define SIS_PKT_PRESSURE_OFFSET(id)	(SIS_PKT_HAS_AREA(id) ? 8 : 6)
+
+/* Individual contact state */
+#define SIS_STATUS_UP			0x3
+#define SIS_STATUS_DOWN			0x0
+
+/* Touchscreen parameters */
+#define SIS_MAX_FINGERS			10
+#define SIS_MAX_X			4095
+#define SIS_MAX_Y			4095
+#define SIS_MAX_PRESSURE		255
+
+/* Resolution diagonal */
+#define SIS_AREA_LENGTH_LONGER		5792
+/*((SIS_MAX_X^2) + (SIS_MAX_Y^2))^0.5*/
+#define SIS_AREA_LENGTH_SHORT		5792
+#define SIS_AREA_UNIT			(5792/32)
+
+struct sis_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+
+	struct gpio_desc *attn_gpio;
+	struct gpio_desc *reset_gpio;
+
+	u8 packet[SIS_MAX_PACKET_SIZE];
+};
+
+static int sis_read_packet(struct i2c_client *client, u8 *buf,
+			   unsigned int *num_contacts,
+			   unsigned int *contact_size)
+{
+	int count_idx;
+	int ret;
+	u16 len;
+	u16 crc, pkg_crc;
+	u8 report_id;
+
+	ret =3D i2c_master_recv(client, buf, SIS_MAX_PACKET_SIZE);
+	if (ret <=3D 0)
+		return -EIO;
+
+	len =3D get_unaligned_le16(&buf[SIS_PKT_LEN_OFFSET]);
+	if (len > SIS_MAX_PACKET_SIZE) {
+		dev_err(&client->dev,
+			"%s: invalid packet length (%d vs %d)\n",
+			__func__, len, SIS_MAX_PACKET_SIZE);
+		return -E2BIG;
+	}
+
+	if (len < 10)
+		return -EINVAL;
+
+	report_id =3D buf[SIS_PKT_ID_OFFSET];
+	count_idx  =3D len - 1;
+	*contact_size =3D SIS_BASE_LEN_PER_CONTACT;
+
+	if (report_id !=3D SIS_ALL_IN_ONE_PACKAGE) {
+		if (SIS_PKT_IS_TOUCH(report_id)) {
+			/*
+			 * Calculate CRC ignoring packet length
+			 * in the beginning and CRC transmitted
+			 * at the end of the packet.
+			 */
+			crc =3D crc_itu_t(0, buf + SIS_PKT_LEN_OFFSET,
+					len - SIS_PKT_LEN_OFFSET - 2);
+			pkg_crc =3D get_unaligned_le16(&buf[len - 2]);
+
+			if (crc !=3D pkg_crc) {
+				dev_err(&client->dev,
+					"%s: CRC Error (%d vs %d)\n",
+					__func__, crc, pkg_crc);
+				return -EINVAL;
+			}
+
+			count_idx -=3D 2;
+
+		} else if (!SIS_PKT_IS_HIDI2C(report_id)) {
+			dev_err(&client->dev,
+				"%s: invalid packet ID %#02x\n",
+				__func__, report_id);
+			return -EINVAL;
+		}
+
+		if (SIS_PKT_HAS_SCANTIME(report_id))
+			count_idx -=3D SIS_SCAN_TIME_LEN;
+
+		if (SIS_PKT_HAS_AREA(report_id))
+			*contact_size +=3D SIS_AREA_LEN_PER_CONTACT;
+		if (SIS_PKT_HAS_PRESSURE(report_id))
+			*contact_size +=3D SIS_PRESSURE_LEN_PER_CONTACT;
+	}
+
+	*num_contacts =3D buf[count_idx];
+	return 0;
+}
+
+static int sis_ts_report_contact(struct sis_ts_data *ts, const u8 *dat=
a, u8 id)
+{
+	struct input_dev *input =3D ts->input;
+	int slot;
+	u8 status =3D data[SIS_PKT_STATUS_OFFSET];
+	u8 pressure;
+	u8 height, width;
+
+	if (status !=3D SIS_STATUS_DOWN && status !=3D SIS_STATUS_UP) {
+		dev_err(&ts->client->dev, "Unexpected touch status: %#02x\n",
+			data[SIS_PKT_STATUS_OFFSET]);
+		return -EINVAL;
+	}
+
+	slot =3D input_mt_get_slot_by_key(input, data[SIS_PKT_ID_OFFSET]);
+	if (slot < 0)
+		return -ENOENT;
+
+	input_mt_slot(input, slot);
+	input_mt_report_slot_state(input, MT_TOOL_FINGER,
+				   status =3D=3D SIS_STATUS_DOWN);
+
+	if (status =3D=3D SIS_STATUS_DOWN) {
+		pressure =3D height =3D width =3D 1;
+		if (id !=3D SIS_ALL_IN_ONE_PACKAGE) {
+			if (SIS_PKT_HAS_AREA(id)) {
+				width =3D data[SIS_PKT_WIDTH_OFFSET];
+				height =3D data[SIS_PKT_HEIGHT_OFFSET];
+			}
+
+			if (SIS_PKT_HAS_PRESSURE(id))
+				pressure =3D data[SIS_PKT_PRESSURE_OFFSET(id)];
+		}
+
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR,
+				 width * SIS_AREA_UNIT);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR,
+				 height * SIS_AREA_UNIT);
+		input_report_abs(input, ABS_MT_PRESSURE, pressure);
+		input_report_abs(input, ABS_MT_POSITION_X,
+				 get_unaligned_le16(&data[SIS_PKT_X_OFFSET]));
+		input_report_abs(input, ABS_MT_POSITION_Y,
+				 get_unaligned_le16(&data[SIS_PKT_Y_OFFSET]));
+	}
+
+	return 0;
+}
+
+static void sis_ts_handle_packet(struct sis_ts_data *ts)
+{
+	const u8 *contact;
+	unsigned int num_to_report =3D 0;
+	unsigned int num_contacts;
+	unsigned int num_reported;
+	unsigned int contact_size;
+	int error;
+	u8 report_id;
+
+	do {
+		error =3D sis_read_packet(ts->client, ts->packet,
+					&num_contacts, &contact_size);
+		if (error)
+			break;
+
+		if (num_to_report =3D=3D 0) {
+			num_to_report =3D num_contacts;
+		} else if (num_contacts !=3D 0) {
+			dev_err(&ts->client->dev,
+				"%s: nonzero (%d) point count in tail packet\n",
+				__func__, num_contacts);
+			break;
+		}
+
+		report_id =3D ts->packet[SIS_PKT_REPORT_OFFSET];
+		contact =3D &ts->packet[SIS_PKT_CONTACT_OFFSET];
+		num_reported =3D 0;
+
+		while (num_to_report > 0) {
+			error =3D sis_ts_report_contact(ts, contact, report_id);
+			if (error)
+				break;
+
+			contact +=3D contact_size;
+			num_to_report--;
+			num_reported++;
+
+			if (report_id !=3D SIS_ALL_IN_ONE_PACKAGE &&
+			    num_reported >=3D 5) {
+				/*
+				 * The remainder of contacts is sent
+				 * in the 2nd packet.
+				 */
+				break;
+			}
+		}
+	} while (num_to_report > 0);
+
+	input_mt_sync_frame(ts->input);
+	input_sync(ts->input);
+}
+
+static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id)
+{
+	struct sis_ts_data *ts =3D dev_id;
+
+	do {
+		sis_ts_handle_packet(ts);
+	} while (ts->attn_gpio && gpiod_get_value_cansleep(ts->attn_gpio));
+
+	return IRQ_HANDLED;
+}
+
+static void sis_ts_reset(struct sis_ts_data *ts)
+{
+	if (ts->reset_gpio) {
+		/* Get out of reset */
+		usleep_range(1000, 2000);
+		gpiod_set_value(ts->reset_gpio, 1);
+		usleep_range(1000, 2000);
+		gpiod_set_value(ts->reset_gpio, 0);
+		msleep(100);
+	}
+}
+
+static int sis_ts_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct sis_ts_data *ts;
+	struct input_dev *input;
+	int error;
+
+	ts =3D devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->client =3D client;
+	i2c_set_clientdata(client, ts);
+
+	ts->attn_gpio =3D devm_gpiod_get_optional(&client->dev,
+						"attn", GPIOD_IN);
+	if (IS_ERR(ts->attn_gpio)) {
+		error =3D PTR_ERR(ts->attn_gpio);
+		if (error !=3D -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get attention GPIO: %d\n", error);
+		return error;
+	}
+
+	ts->reset_gpio =3D devm_gpiod_get_optional(&client->dev,
+						 "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->reset_gpio)) {
+		error =3D PTR_ERR(ts->reset_gpio);
+		if (error !=3D -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get reset GPIO: %d\n", error);
+		return error;
+	}
+
+	sis_ts_reset(ts);
+
+	ts->input =3D input =3D devm_input_allocate_device(&client->dev);
+	if (!input) {
+		dev_err(&client->dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	input->name =3D "SiS Touchscreen";
+	input->id.bustype =3D BUS_I2C;
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, SIS_MAX_X, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, SIS_MAX_Y, 0, 0);
+	input_set_abs_params(input, ABS_MT_PRESSURE, 0, SIS_MAX_PRESSURE, 0, =
0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,
+			     0, SIS_AREA_LENGTH_LONGER, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR,
+			     0, SIS_AREA_LENGTH_SHORT, 0, 0);
+
+	error =3D input_mt_init_slots(input, SIS_MAX_FINGERS, INPUT_MT_DIRECT=
);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to initialize MT slots: %d\n", error);
+		return error;
+	}
+
+	error =3D devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, sis_ts_irq_handler,
+					  IRQF_ONESHOT,
+					  client->name, ts);
+	if (error) {
+		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
+		return error;
+	}
+
+	error =3D input_register_device(ts->input);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to register input device: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id sis_ts_dt_ids[] =3D {
+	{ .compatible =3D "sis,9200-ts" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sis_ts_dt_ids);
+#endif
+
+static const struct i2c_device_id sis_ts_id[] =3D {
+	{ SIS_I2C_NAME,	0 },
+	{ "9200-ts",	0 },
+	{ /* sentinel */  }
+};
+MODULE_DEVICE_TABLE(i2c, sis_ts_id);
+
+static struct i2c_driver sis_ts_driver =3D {
+	.driver =3D {
+		.name	=3D SIS_I2C_NAME,
+		.of_match_table =3D of_match_ptr(sis_ts_dt_ids),
+	},
+	.probe		=3D sis_ts_probe,
+	.id_table	=3D sis_ts_id,
+};
+module_i2c_driver(sis_ts_driver);
+
+MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");
+MODULE_LICENSE("GPL v2");

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
