From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for SiS i2c touch driver
Date: Sat, 24 Oct 2015 20:18:26 -0700
Message-ID: <20151025031826.GA20156@dtor-pixel>
References: <1444722527-10202-1-git-send-email-yuger_yu@sis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36448 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbbJYDTi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Oct 2015 23:19:38 -0400
Received: by qgad10 with SMTP id d10so95811154qga.3
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2015 20:19:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444722527-10202-1-git-send-email-yuger_yu@sis.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Ko-Hao, Yu" <yuger_yu@sis.com>
Cc: linux-input@vger.kernel.org, yuger.yu@gmail.com, tammy_tseng@sis.com

Hi,

On Tue, Oct 13, 2015 at 03:48:47PM +0800, Ko-Hao, Yu wrote:
> Hi, This patch is to add support for SiS i2c touch panel.
> Thanks a lot.

Thank you for cleaning up the driver. The first question first: it is
not compatible with the standard HID spec, is it? It is not possible to
have the standard tandem of i2c-hid + hid-multitouch driver this device? 

> 
> Signed-off-by: Ko-Hao, Yu <yuger_yu@sis.com>
> ---
>  drivers/input/touchscreen/Kconfig   |  11 +
>  drivers/input/touchscreen/Makefile  |   1 +
>  drivers/input/touchscreen/sis_i2c.c | 525 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 537 insertions(+)
>  create mode 100644 drivers/input/touchscreen/sis_i2c.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 600dcce..5782dd5 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1064,4 +1064,15 @@ config TOUCHSCREEN_COLIBRI_VF50
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called colibri_vf50_ts.
>  
> +config TOUCHSCREEN_SIS_I2C
> +	tristate "SiS 9200 family I2C touchscreen driver"
> +	depends on I2C && CRC_ITU_T
> +	help
> +	  Say Y here to enable support for I2C connected SiS touch panels.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sis_i2c.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 1b79cc0..360b577 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_TOUCHSCREEN_SX8654)	+= sx8654.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)   += sis_i2c.o
> diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchscreen/sis_i2c.c
> new file mode 100644
> index 0000000..f7b6ac5
> --- /dev/null
> +++ b/drivers/input/touchscreen/sis_i2c.c
> @@ -0,0 +1,525 @@
> +/*
> + * Touch Screen driver for SiS 9200 family I2C Touch panels
> + *
> + * Copyright (C) 2015 SiS, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
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
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/uaccess.h>
> +#include <linux/irq.h>
> +#include <asm/unaligned.h>
> +#include <linux/input/mt.h>	/*For Type-B Slot function*/
> +#include <linux/crc-itu-t.h>	/*For CRC Check*/
> +
> +#define SIS_I2C_NAME						"sis_i2c_ts"
> +#define SIS_SLAVE_ADDR					0x5c
> +#define MAX_FINGERS						10
> +
> +/*Resolution mode*/
> +/*Constant value*/
> +#define SIS_MAX_X						4095
> +#define SIS_MAX_Y						4095
> +
> +#define PACKET_BUFFER_SIZE				128
> +
> +#define SIS_CMD_NORMAL					0x0
> +
> +/* for new i2c format */
> +#define TOUCHDOWN						0x3
> +#define TOUCHUP						0x0
> +#define MAX_BYTE						64
> +#define PRESSURE_MAX					255
> +
> +/*Resolution diagonal */
> +#define AREA_LENGTH_LONGER				5792
> +/*((SIS_MAX_X^2) + (SIS_MAX_Y^2))^0.5*/
> +#define AREA_LENGTH_SHORT				5792
> +#define AREA_UNIT						(5792/32)
> +
> +#define P_BYTECOUNT						0
> +#define ALL_IN_ONE_PACKAGE				0x10
> +#define IS_TOUCH(x)						(x & 0x1)
> +#define IS_HIDI2C(x)					((x & 0xF) == 0x06)
> +#define IS_AREA(x)						((x >> 4) & 0x1)
> +#define IS_PRESSURE(x)				    ((x >> 5) & 0x1)
> +#define IS_SCANTIME(x)			        ((x >> 6) & 0x1)
> +#define NORMAL_LEN_PER_POINT			6
> +#define AREA_LEN_PER_POINT				2
> +#define PRESSURE_LEN_PER_POINT			1
> +
> +#define TOUCH_FORMAT					0x1
> +#define HIDI2C_FORMAT					0x6
> +#define P_REPORT_ID						2
> +#define BYTE_BYTECOUNT					2
> +#define BYTE_ReportID					1
> +#define BYTE_CRC_HIDI2C					0
> +#define BYTE_CRC_I2C						2
> +#define BYTE_SCANTIME					2
> +
> +#define MAX_SLOTS						15

Why MAX_SLOTS is different from MAX_FINGERS?

> +
> +struct sis_slot {
> +	int check_id;
> +	int id;
> +	unsigned short x, y;
> +	u16 pressure;
> +	u16 width;
> +	u16 height;
> +};
> +
> +struct point {
> +	int id;
> +	unsigned short x, y;
> +	u16 pressure;
> +	u16 width;
> +	u16 height;
> +};
> +
> +struct sistp_driver_data {
> +	int id;
> +	int fingers;
> +	struct point pt[MAX_FINGERS];
> +};
> +
> +struct sis_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct sistp_driver_data *tp_info;
> +};
> +
> +/* Addresses to scan */
> +static void sis_tpinfo_clear(struct sistp_driver_data *tp_info, int max);
> +
> +static int sis_cul_unit(u8 report_id)
> +{
> +	int ret = NORMAL_LEN_PER_POINT;
> +
> +	if (report_id != ALL_IN_ONE_PACKAGE) {
> +		if (IS_AREA(report_id))
> +			ret += AREA_LEN_PER_POINT;
> +		if (IS_PRESSURE(report_id))
> +			ret += PRESSURE_LEN_PER_POINT;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sis_readpacket(struct i2c_client *client, u8 cmd, u8 *buf)
> +{
> +	u8 tmpbuf[MAX_BYTE] = {0};	/*MAX_BYTE = 64;*/
> +	int ret;
> +	int touchnum = 0;
> +	int p_count = 0;
> +	int touch_format_id = 0;
> +	int locate = 0;
> +	bool read_first = true;
> +	/*
> +	 * New i2c format
> +	 * buf[0] = Low 8 bits of byte count value
> +	 * buf[1] = High 8 bits of byte count value
> +	 * buf[2] = Report ID
> +	 * buf[touch num * 6 + 2 ] = Touch information;
> +	 * 1 touch point has 6 bytes, it could be none if no touch
> +	 * buf[touch num * 6 + 3] = Touch numbers
> +	 *
> +	 * One touch point information include 6 bytes, the order is
> +	 *
> +	 * 1. status = touch down or touch up
> +	 * 2. id = finger id
> +	 * 3. x axis low 8 bits
> +	 * 4. x axis high 8 bits
> +	 * 5. y axis low 8 bits
> +	 * 6. y axis high 8 bits
> +	 */

Thank you for writing down the packet format, however it appears that
there is some more data pertaining to pressure and area in certain
packets, could you document them as well?

> +	do {
> +		if (locate >= PACKET_BUFFER_SIZE) {
> +			dev_err(&client->dev, "sis_readpacket: Buf Overflow\n");
> +			return -EPERM;
> +		}
> +		ret = i2c_master_recv(client, tmpbuf, MAX_BYTE);
> +
> +		if (ret < 0) {
> +			dev_err(&client->dev, "sis_readpacket: i2c transfer error\n");
> +			return ret;
> +		}
> +		/*error package length of receiving data*/
> +		else if (tmpbuf[P_BYTECOUNT] > MAX_BYTE) {
> +			dev_err(&client->dev, "sis_readpacket: Error Bytecount\n");
> +			return -EPERM;
> +		}
> +		if (read_first) {
> +			/*access NO TOUCH event unless BUTTON NO TOUCH event*/
> +			if (tmpbuf[P_BYTECOUNT] == 0)
> +				return 0;	/*touchnum is 0*/
> +		}
> +		/*
> +		 * skip parsing data when two devices are registered
> +		 * at the same slave address

Can you elaborate on this condition please?

> +		 * parsing data when P_REPORT_ID && 0xf is TOUCH_FORMAT
> +		 * or P_REPORT_ID is ALL_IN_ONE_PACKAGE
> +		 */
> +		touch_format_id = tmpbuf[P_REPORT_ID] & 0xf;
> +		if ((touch_format_id != TOUCH_FORMAT) &&
> +			(touch_format_id != HIDI2C_FORMAT) &&
> +			(tmpbuf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE)) {
> +			dev_err(&client->dev, "sis_readpacket: Error Report_ID\n");
> +			return -EPERM;
> +		}
> +		p_count = (int) tmpbuf[P_BYTECOUNT] - 1;	/*start from 0*/
> +		if (tmpbuf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE) {
> +			if (IS_TOUCH(tmpbuf[P_REPORT_ID])) {
> +				/*delete 2 byte crc*/
> +				p_count -= BYTE_CRC_I2C;
> +			} else if (IS_HIDI2C(tmpbuf[P_REPORT_ID])) {
> +				p_count -= BYTE_CRC_HIDI2C;
> +			} else {	/*should not be happen*/
> +				dev_err(&client->dev, "sis_readpacket: delete crc error\n");
> +				return -EPERM;
> +			}
> +			if (IS_SCANTIME(tmpbuf[P_REPORT_ID]))
> +				p_count -= BYTE_SCANTIME;
> +		}
> +		/*For ALL_IN_ONE_PACKAGE*/
> +		if (read_first) {
> +			touchnum = tmpbuf[p_count];
> +		} else {
> +			if (tmpbuf[p_count] != 0) {
> +				dev_err(&client->dev, "sis_readpacket: get error package\n");
> +				return -EPERM;
> +			}
> +		}
> +
> +		if ((touch_format_id != HIDI2C_FORMAT) &&
> +			(tmpbuf[P_BYTECOUNT] > 3)) {
> +			int crc_end = p_count + (IS_SCANTIME(
> +				tmpbuf[P_REPORT_ID]) * 2);
> +			u16 buf_crc = crc_itu_t(
> +				0, tmpbuf + 2, crc_end - 1);
> +			int l_package_crc = (IS_SCANTIME(
> +				tmpbuf[P_REPORT_ID]) * 2) + p_count + 1;
> +			u16 package_crc = get_unaligned_le16(
> +				&tmpbuf[l_package_crc]);
> +
> +			if (buf_crc != package_crc) {
> +				dev_err(&client->dev, "sis_readpacket: CRC Error\n");
> +				return -EPERM;
> +			}
> +		}
> +
> +		memcpy(&buf[locate], &tmpbuf[0], MAX_BYTE);
> +		/*Buf_Data [0~63] [64~128]*/
> +		locate += MAX_BYTE;
> +		read_first = false;
> +	} while (tmpbuf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE &&
> +			tmpbuf[p_count] > 5);
> +	return touchnum;
> +}
> +
> +static int sis_parse_i2c_event(u8 *buf, u8 fingers,
> +			       struct sistp_driver_data *tp_info,
> +			       int *check_id, struct sis_slot *sisdata)
> +{
> +	int point_unit;
> +	u8 i = 0, pstatus = 0;
> +	u8 px = 0, py = 0;
> +	u8 p_area = 0;
> +	u8 p_preasure = 0;
> +	/*Parser and Get the sis data*/
> +	point_unit = sis_cul_unit(buf[P_REPORT_ID]);
> +	tp_info->fingers = fingers = (fingers > MAX_FINGERS ? 0 : fingers);
> +
> +	/*fingers 10 =  0 ~ 9*/
> +	for (i = 0; i < fingers; i++) {
> +		if ((buf[P_REPORT_ID] != ALL_IN_ONE_PACKAGE) && (i >= 5)) {
> +			/*Calc point status*/
> +			pstatus = BYTE_BYTECOUNT + BYTE_ReportID
> +					+ ((i - 5) * point_unit);
> +			pstatus += 64;
> +		} else {
> +			pstatus = BYTE_BYTECOUNT + BYTE_ReportID
> +					+ (i * point_unit);
> +					/*Calc point status*/
> +		}
> +		px = pstatus + 2;	/*Calc point x_coord*/
> +		py = px + 2;	/*Calc point y_coord*/
> +		if ((buf[pstatus]) == TOUCHUP) {
> +			tp_info->pt[i].width = 0;
> +			tp_info->pt[i].height = 0;
> +			tp_info->pt[i].pressure = 0;
> +		} else if (buf[P_REPORT_ID] == ALL_IN_ONE_PACKAGE
> +					&& (buf[pstatus]) == TOUCHDOWN) {
> +			tp_info->pt[i].width = 1;
> +			tp_info->pt[i].height = 1;
> +			tp_info->pt[i].pressure = 1;
> +		} else if ((buf[pstatus]) == TOUCHDOWN) {
> +			p_area = py + 2;
> +			p_preasure = py + 2 + (IS_AREA(buf[P_REPORT_ID]) * 2);
> +			/*area*/
> +			if (IS_AREA(buf[P_REPORT_ID])) {
> +				tp_info->pt[i].width = buf[p_area];
> +				tp_info->pt[i].height = buf[p_area + 1];
> +			} else {
> +				tp_info->pt[i].width = 1;
> +				tp_info->pt[i].height = 1;
> +			}
> +			/*pressure*/
> +			if (IS_PRESSURE(buf[P_REPORT_ID]))
> +				tp_info->pt[i].pressure = (buf[p_preasure]);
> +			else
> +				tp_info->pt[i].pressure = 1;
> +		} else
> +			return -EPERM;
> +
> +		tp_info->pt[i].id = (buf[pstatus + 1]);
> +		tp_info->pt[i].x = get_unaligned_le16(&buf[px]);
> +		tp_info->pt[i].y = get_unaligned_le16(&buf[py]);
> +
> +		check_id[tp_info->pt[i].id] = 1;
> +		sisdata[tp_info->pt[i].id].id = tp_info->pt[i].id;
> +		sisdata[tp_info->pt[i].id].pressure = tp_info->pt[i].pressure;
> +		sisdata[tp_info->pt[i].id].x = tp_info->pt[i].x;
> +		sisdata[tp_info->pt[i].id].y = tp_info->pt[i].y;
> +		sisdata[tp_info->pt[i].id].width = tp_info->pt[i].width
> +						* AREA_UNIT;
> +		sisdata[tp_info->pt[i].id].height = tp_info->pt[i].height
> +						* AREA_UNIT;
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct sis_ts_data *ts = dev_id;
> +	struct sistp_driver_data *tp_info = ts->tp_info;
> +	int ret;
> +	u8 buf[PACKET_BUFFER_SIZE] = {0};
> +	u8 i = 0, fingers = 0;
> +	int check_id[MAX_FINGERS];
> +	static int pre_check_id[MAX_FINGERS];
> +	struct sis_slot sisdata[MAX_FINGERS];
> +
> +	memset(check_id, 0, sizeof(int)*MAX_FINGERS);
> +
> +	/*I2C or SMBUS block data read*/
> +	ret = sis_readpacket(ts->client, SIS_CMD_NORMAL, buf);
> +	/*Error Number*/
> +	if (ret < 0)
> +		goto out;
> +	/*access NO TOUCH event unless BUTTON NO TOUCH event*/
> +	else if (ret == 0) {
> +		fingers = 0;
> +		sis_tpinfo_clear(tp_info, MAX_FINGERS);
> +		goto type_b_report;
> +	}
> +
> +	sis_tpinfo_clear(tp_info, MAX_FINGERS);
> +	fingers = ret;
> +
> +	ret = sis_parse_i2c_event(buf, fingers, tp_info, check_id, sisdata);
> +	if (ret < 0)
> +		goto out;
> +
> +type_b_report:
> +	for (i = 0; i < MAX_FINGERS; i++) {
> +		if ((check_id[i] != pre_check_id[i]) && (check_id[i] != 1))
> +			check_id[i] = -1;
> +	}
> +
> +	for (i = 0; i < MAX_FINGERS; i++) {
> +		if (check_id[i] == 1) {
> +			input_mt_slot(ts->input_dev, i+1);
> +			if (sisdata[i].pressure > 0) {
> +				input_mt_report_slot_state(ts->input_dev,
> +					MT_TOOL_FINGER, true);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_PRESSURE, sisdata[i].pressure);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_TOUCH_MAJOR, sisdata[i].width);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_TOUCH_MINOR, sisdata[i].height);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_POSITION_X, sisdata[i].x);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_POSITION_Y, sisdata[i].y);
> +			} else {
> +				input_mt_report_slot_state(ts->input_dev,
> +					MT_TOOL_FINGER, false);
> +				check_id[i] = 0;
> +			}
> +		} else if (check_id[i] == -1) {
> +			input_mt_slot(ts->input_dev, i+1);
> +			input_mt_report_slot_state(ts->input_dev,
> +					MT_TOOL_FINGER, false);
> +			check_id[i] = 0;
> +		}
> +		pre_check_id[i] = check_id[i];
> +	}
> +
> +	input_sync(ts->input_dev);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static void sis_tpinfo_clear(struct sistp_driver_data *tp_info, int max)
> +{
> +	int i = 0;

No need to initialize this variable, you do that in the loop.

You also do not need to supply max:

	for (i = 0; i < ARRAY_SIZE(tp_info->pt); i++) {
		...
	}

> +
> +	for (i = 0; i < max; i++) {
> +		tp_info->pt[i].id = -1;
> +		tp_info->pt[i].x = 0;
> +		tp_info->pt[i].y = 0;
> +		tp_info->pt[i].pressure = 0;
> +		tp_info->pt[i].width = 0;
> +	}
> +	tp_info->id = 0x0;
> +	tp_info->fingers = 0;
> +}
> +
> +static int sis_ts_probe(
> +	struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	int err = 0;
> +	struct sis_ts_data *ts;
> +
> +	dev_dbg(&client->dev, "sis_ts_probe\n");
> +	ts = devm_kzalloc(&client->dev, sizeof(struct sis_ts_data),
> +			  GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +	ts->tp_info = devm_kzalloc(&client->dev,
> +				   sizeof(struct sistp_driver_data),
> +				   GFP_KERNEL);
> +	if (!ts->tp_info) {
> +		dev_err(&client->dev, "Failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	/*1. Init necessary buffers*/
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +
> +	/*2. Allocate input device*/
> +	ts->input_dev = devm_input_allocate_device(&client->dev);
> +	if (!ts->input_dev) {
> +		err = -ENOMEM;
> +		dev_err(&client->dev, "sis_ts_probe: Failed to allocate input device\n");
> +		goto err_input_dev_alloc_failed;

Return directly since you are using devm.

> +	}
> +	ts->input_dev->name = "sis_touch";

Maybe something prettier? "SiS Touch Panel"?

> +
> +	set_bit(EV_ABS, ts->input_dev->evbit);
> +	set_bit(EV_KEY, ts->input_dev->evbit);
> +	input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE,
> +						0, PRESSURE_MAX, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +						0, AREA_LENGTH_LONGER, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MINOR,
> +						0, AREA_LENGTH_SHORT, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +						0, SIS_MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +						0, SIS_MAX_Y, 0, 0);
> +	input_mt_init_slots(ts->input_dev, MAX_SLOTS, INPUT_MT_DIRECT);
> +
> +	/* add for touch keys */
> +	set_bit(KEY_COMPOSE, ts->input_dev->keybit);
> +	set_bit(KEY_BACK, ts->input_dev->keybit);
> +	set_bit(KEY_MENU, ts->input_dev->keybit);
> +	set_bit(KEY_HOME, ts->input_dev->keybit);

You never emit these events, why do you set them up?

> +
> +	/*3. Register input device to core*/
> +	err = input_register_device(ts->input_dev);
> +	if (err) {
> +		dev_err(&client->dev,
> +			"sis_ts_probe: Unable to register %s input device\n",
> +			ts->input_dev->name);
> +		goto err_input_register_device_failed;
> +	}
> +
> +	/*4. irq setup*/
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					sis_ts_irq_handler,
> +					IRQF_TRIGGER_FALLING, client->name,
> +					ts);
> +	if (err < 0) {

	if (err)

- devm_request_threaded_irq always returns 0 on success.

> +		dev_err(&client->dev, "Failed to request touchscreen IRQ\n");
> +		goto err_request_threaded_irq;
> +	}
> +
> +	dev_dbg(&client->dev, "sis SIS_SLAVE_ADDR: %d\n", SIS_SLAVE_ADDR);

It is always the same, not even worth dev_dbg().

> +	return 0;
> +err_request_threaded_irq:
> +err_input_register_device_failed:
> +	input_free_device(ts->input_dev);
> +err_input_dev_alloc_failed:
> +	kfree(ts->tp_info);
> +	kfree(ts);

Remove cleanup path.

> +	return err;
> +}
> +
> +static int sis_ts_remove(struct i2c_client *client)
> +{
> +	struct sis_ts_data *ts = i2c_get_clientdata(client);
> +
> +	input_unregister_device(ts->input_dev);
> +	input_free_device(ts->input_dev);

Never call input_free_device() after input_untregister_device() - it
will lead to double-free. Moreover, you are using devm API to allocate
your resources and they will be freed automatically, you do not need to
free them manually (and non-devm APIs can not be used to free such
resources).

Simply remove sis_ts_remove function altogether.

> +	kfree(ts->tp_info);
> +	kfree(ts);
> +	return 0;
> +}
> +
> +static int __maybe_unused sis_ts_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	disable_irq(client->irq);

Do you have to disable IRQ? What happens if it is left on?

> +	return 0;
> +}
> +
> +static int __maybe_unused sis_ts_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	enable_irq(client->irq);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(sis_ts_pm, sis_ts_suspend, sis_ts_resume);
> +
> +static const struct i2c_device_id sis_ts_id[] = {
> +	{ SIS_I2C_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sis_ts_id);
> +
> +static struct i2c_driver sis_ts_driver = {
> +	.driver = {
> +		.name = SIS_I2C_NAME,
> +		.owner = THIS_MODULE,
> +		.pm = &sis_ts_pm,
> +	},
> +	.probe		= sis_ts_probe,
> +	.remove		= sis_ts_remove,
> +	.id_table		= sis_ts_id,
> +};
> +module_i2c_driver(sis_ts_driver);
> +
> +MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");
> +MODULE_LICENSE("GPL v2");

Thank you.

-- 
Dmitry
