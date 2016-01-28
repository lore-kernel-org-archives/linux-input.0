From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [V2] Input: Add MELFAS MIP4 Touchscreen driver
Date: Thu, 28 Jan 2016 01:11:46 -0800
Message-ID: <20160128091146.GA35257@dtor-ws>
References: <1452761754-9601-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35105 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbcA1JLu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 04:11:50 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so20560456pfd.2
        for <linux-input@vger.kernel.org>; Thu, 28 Jan 2016 01:11:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452761754-9601-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

Hi Jee,

On Thu, Jan 14, 2016 at 05:55:54PM +0900, Sangwon Jee wrote:
> This is an input driver for MELFAS MIP4 Touchscreen devices,
> made by the original vendor, MELFAS.
> 
> MIP4 means MELFAS Interface Protocol Version 4.
> MELFAS MMS400, MMS500, MCS8000, MIT200, MIT300, MIT400, MFS10 and other
> recent touchscreen devices are using MIP4 and supported by this driver.
> 
> There are two MELFAS touchscreen drivers(mcs5000_ts, mms114) in the kernel.
> But those drivers are for discontinued models and not supported by MELFAS.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>
> ---

Thank you for making changes, please see some more comments below. I
have not looked closely at the firmware update so I may have more
comments.


>  drivers/input/touchscreen/Kconfig       |   11 +
>  drivers/input/touchscreen/Makefile      |    1 +
>  drivers/input/touchscreen/melfas_mip4.c | 1970 +++++++++++++++++++++++++++++++
>  include/linux/input/melfas_mip4.h       |   31 +
>  4 files changed, 2013 insertions(+)
>  create mode 100644 drivers/input/touchscreen/melfas_mip4.c
>  create mode 100644 include/linux/input/melfas_mip4.h
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 53a97b3..f193049 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -491,6 +491,17 @@ config TOUCHSCREEN_MMS114
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mms114.
>  
> +config TOUCHSCREEN_MELFAS_MIP4
> +	tristate "MELFAS MIP4 Touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here if you have a MELFAS MIP4 Touchscreen device.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called melfas_mip4.
> +
>  config TOUCHSCREEN_MTOUCH
>  	tristate "MicroTouch serial touchscreens"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 968ff12..4b518c7 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+= lpc32xx_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+= max11801_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MC13783)	+= mc13783_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+= mcs5000_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_MELFAS_MIP4)	+= melfas_mip4.o
>  obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MMS114)	+= mms114.o
>  obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> new file mode 100644
> index 0000000..afb64aa
> --- /dev/null
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -0,0 +1,1970 @@
> +/*
> + * MELFAS MIP4 Touchscreen
> + *
> + * Copyright (C) 2016 MELFAS Inc.
> + *
> + * Author : Sangwon Jee <jeesw@melfas.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +/*****************************************************************
> + * Include
> + *****************************************************************/
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>
> +#include <linux/input/mt.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/acpi.h>
> +#include <asm/unaligned.h>
> +
> +#include <linux/input/melfas_mip4.h>
> +
> +/*****************************************************************
> + * Platform
> + *****************************************************************/
> +
> +#define MIP_DEVICE_NAME	"mip4_ts"
> +#define ACPI_ID			"MLFS0000"
> +
> +/*****************************************************************
> + * Protocol
> + * Version : MIP 4.0 Rev 4.4
> + *****************************************************************/
> +
> +/* Address */
> +#define MIP_R0_BOOT						0x00
> +#define MIP_R1_BOOT_MODE					0x01
> +#define MIP_R1_BOOT_BUF_ADDR				0x10
> +#define MIP_R1_BOOT_STATUS				0x20
> +#define MIP_R1_BOOT_CMD					0x30
> +#define MIP_R1_BOOT_TARGET_ADDR			0x40
> +#define MIP_R1_BOOT_SIZE					0x44
> +
> +#define MIP_R0_INFO						0x01
> +#define MIP_R1_INFO_PRODUCT_NAME			0x00
> +#define MIP_R1_INFO_RESOLUTION_X			0x10
> +#define MIP_R1_INFO_RESOLUTION_Y			0x12
> +#define MIP_R1_INFO_NODE_NUM_X			0x14
> +#define MIP_R1_INFO_NODE_NUM_Y			0x15
> +#define MIP_R1_INFO_KEY_NUM				0x16
> +#define MIP_R1_INFO_VERSION_BOOT			0x20
> +#define MIP_R1_INFO_VERSION_CORE			0x22
> +#define MIP_R1_INFO_VERSION_APP			0x24
> +#define MIP_R1_INFO_VERSION_PARAM		0x26
> +#define MIP_R1_INFO_SECT_BOOT_START		0x30
> +#define MIP_R1_INFO_SECT_BOOT_END		0x31
> +#define MIP_R1_INFO_SECT_CORE_START		0x32
> +#define MIP_R1_INFO_SECT_CORE_END		0x33
> +#define MIP_R1_INFO_SECT_APP_START		0x34
> +#define MIP_R1_INFO_SECT_APP_END			0x35
> +#define MIP_R1_INFO_SECT_PARAM_START	0x36
> +#define MIP_R1_INFO_SECT_PARAM_END		0x37
> +#define MIP_R1_INFO_BUILD_DATE			0x40
> +#define MIP_R1_INFO_BUILD_TIME			0x44
> +#define MIP_R1_INFO_CHECKSUM_PRECALC	0x48
> +#define MIP_R1_INFO_CHECKSUM_REALTIME	0x4A
> +#define MIP_R1_INFO_PROTOCOL_NAME		0x50
> +#define MIP_R1_INFO_PROTOCOL_VERSION	0x58
> +#define MIP_R1_INFO_IC_ID					0x70
> +#define MIP_R1_INFO_IC_NAME				0x71
> +#define MIP_R1_INFO_IC_VENDOR_ID			0x75
> +#define MIP_R1_INFO_IC_HW_CATEGORY		0x77
> +#define MIP_R1_INFO_CONTACT_THD_SCR		0x78
> +#define MIP_R1_INFO_CONTACT_THD_KEY		0x7A
> +
> +#define MIP_R0_EVENT						0x02
> +#define MIP_R1_EVENT_SUPPORTED_FUNC		0x00
> +#define MIP_R1_EVENT_FORMAT				0x04
> +#define MIP_R1_EVENT_SIZE					0x06
> +#define MIP_R1_EVENT_PACKET_INFO			0x10
> +#define MIP_R1_EVENT_PACKET_DATA			0x11
> +
> +#define MIP_R0_CTRL						0x06
> +#define MIP_R1_CTRL_READY_STATUS			0x00
> +#define MIP_R1_CTRL_EVENT_READY			0x01
> +#define MIP_R1_CTRL_MODE					0x10
> +#define MIP_R1_CTRL_EVENT_TRIGGER_TYPE	0x11
> +#define MIP_R1_CTRL_RECALIBRATE			0x12
> +#define MIP_R1_CTRL_POWER_STATE			0x13
> +#define MIP_R1_CTRL_GESTURE_TYPE			0x14
> +#define MIP_R1_CTRL_DISABLE_ESD_ALERT	0x18
> +#define MIP_R1_CTRL_CHARGER_MODE			0x19
> +#define MIP_R1_CTRL_HIGH_SENS_MODE		0x1A
> +#define MIP_R1_CTRL_WINDOW_MODE			0x1B
> +#define MIP_R1_CTRL_PALM_REJECTION		0x1C
> +#define MIP_R1_CTRL_EDGE_CORRECTION		0x1D
> +#define MIP_R1_CTRL_ENTER_GLOVE_MODE	0x1E
> +#define MIP_R1_CTRL_I2C_ON_LPM			0x1F
> +#define MIP_R1_CTRL_GESTURE_DEBUG		0x20
> +#define MIP_R1_CTRL_PALM_EVENT			0x22
> +#define MIP_R1_CTRL_PROXIMITY_SENSING	0x23
> +
> +/* Value */
> +#define MIP_BOOT_MODE_BOOT				0x01
> +#define MIP_BOOT_MODE_APP					0x02
> +
> +#define MIP_BOOT_STATUS_BUSY				0x05
> +#define MIP_BOOT_STATUS_ERROR			0x0E
> +#define MIP_BOOT_STATUS_DONE				0xA0
> +
> +#define MIP_BOOT_CMD_MASS_ERASE			0x15
> +#define MIP_BOOT_CMD_PROGRAM				0x54
> +#define MIP_BOOT_CMD_ERASE				0x8F
> +#define MIP_BOOT_CMD_WRITE				0xA5
> +#define MIP_BOOT_CMD_READ					0xC2
> +
> +#define MIP_EVENT_INPUT_TYPE_KEY			0
> +#define MIP_EVENT_INPUT_TYPE_SCREEN		1
> +#define MIP_EVENT_INPUT_TYPE_PROXIMITY	2
> +
> +/*****************************************************************
> + * Header
> + *****************************************************************/
> +
> +/* Supported chip models */
> +#define CHIP_NONE		000000
> +#define CHIP_MMS427	104270
> +#define CHIP_MMS438	104380
> +#define CHIP_MMS449	104490
> +#define CHIP_MMS458	104580
> +#define CHIP_MMS500	105000
> +#define CHIP_MCS8040L	280401
> +#define CHIP_MIT200	302000
> +#define CHIP_MIT300	303000
> +#define CHIP_MIT400	304000
> +#define CHIP_MFS10		400100

I do not see these being used anywhere.

> +
> +/* Config driver */
> +#define I2C_RETRY_COUNT				3	/* 2~ */
> +#define RESET_ON_I2C_ERROR			1	/* 0 or 1 (default) */

Who is supposed to select this behavior and why would we want to do
that? Dowe observe a lot of I2C errors? Why?

> +#define RESET_ON_EVENT_ERROR			0	/* 0 (default) or 1 */

Do not see it used anywhere.

> +
> +/* Input value */
> +#define MAX_FINGER_NUM			10
> +#define MAX_KEY_NUM				4
> +#define INPUT_TOUCH_MAJOR_MIN	0
> +#define INPUT_TOUCH_MAJOR_MAX	255
> +#define INPUT_TOUCH_MINOR_MIN	0
> +#define INPUT_TOUCH_MINOR_MAX	255
> +#define INPUT_PRESSURE_MIN		0
> +#define INPUT_PRESSURE_MAX		255
> +
> +/* Firmware update */
> +#define FW_PATH_INTERNAL			"melfas_mip4.fw"
> +
> +#define MIP_FW_MAX_SECT_NUM		4
> +#define MIP_FW_UPDATE_DEBUG		0	/* 0 (default) or 1 */
> +
> +/*
> +* Firmware update error code
> +*/
> +enum fw_update_errno {
> +	fw_err_file_read = -4,
> +	fw_err_file_open = -3,
> +	fw_err_file_type = -2,
> +	fw_err_download = -1,
> +	fw_err_none = 0,
> +	fw_err_uptodate = 1,
> +};

Can we return appropriate Linux error values (-EINVAL,  -EIO, etc) directly
instead?

> +
> +/*
> +* Firmware file location
> +*/
> +enum fw_bin_source {
> +	fw_bin_source_kernel = 1,
> +	fw_bin_source_external = 2,
> +};
> +

I do not see it being used.

> +/*
> +* Device info structure
> +*/
> +struct mip_ts_info {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct melfas_mip4_platform_data *pdata;
> +	char phys[32];
> +	dev_t mip_dev;
> +	struct class *class;
> +	struct mutex lock;
> +	int irq;
> +	struct gpio_desc *gpio_ce;
> +	struct regulator *regulator_vd33;

Not used?

> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_enable;
> +	struct pinctrl_state *pins_disable;

I do not see these pinctrls being used anywhere.

> +	bool init;
> +	bool enabled;
> +	bool irq_enabled;
> +	int power;
> +	char *fw_name;
> +	u8 product_name[16];
> +	int max_x;
> +	int max_y;
> +	u8 node_x;
> +	u8 node_y;
> +	u8 node_key;
> +	u8 fw_version[8];
> +	u8 event_size;
> +	int event_format;
> +	u8 touch_state[MAX_FINGER_NUM];
> +	bool key_enable;
> +	int key_num;
> +	int key_code[MAX_KEY_NUM];
> +	u8 gesture_wakeup_mode;
> +	u8 glove_mode;
> +	u8 charger_mode;
> +	u8 cover_mode;
> +	u8 esd_cnt;
> +	bool disable_esd;
> +};
> +
> +/*
> +* Function declarations
> +*/
> +static int mip_get_fw_version(struct mip_ts_info *info, u8 *ver_buf);
> +static int mip_get_fw_version_u16(struct mip_ts_info *info, u16 *ver_buf_u16);
> +static int mip_power_on(struct mip_ts_info *info);
> +static int mip_power_off(struct mip_ts_info *info);
> +
> +/*****************************************************************
> + * Main
> + *****************************************************************/
> +
> +/*
> +* Reboot chip
> +*/
> +static void mip_reboot(struct mip_ts_info *info)
> +{
> +	mip_power_off(info);
> +	mip_power_on(info);
> +}
> +
> +/*
> +* I2C Read
> +*/
> +static int mip_i2c_read(struct mip_ts_info *info, char *write_buf,
> +	unsigned int write_len, char *read_buf, unsigned int read_len)
> +{
> +	int retry = I2C_RETRY_COUNT;
> +	int res;
> +
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr = info->client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = write_len,
> +		}, {
> +			.addr = info->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = read_buf,
> +			.len = read_len,
> +		},
> +	};
> +
> +	while (retry--) {
> +		res = i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg));
> +
> +		if (res == ARRAY_SIZE(msg))
> +			goto done;
> +		else if (res < 0)
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_transfer - errno[%d]\n",
> +				__func__, res);
> +		else
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_transfer - size[%lu] result[%d]\n",
> +				__func__, ARRAY_SIZE(msg), res);

No need for "[ERROR]" prefixes, we already encode severity in error
messages.

> +	}
> +
> +	goto error;
> +
> +error:
> +#if RESET_ON_I2C_ERROR
> +	mip_reboot(info);
> +#endif
> +	return 1;
> +
> +done:
> +	return 0;
> +}
> +
> +/*
> +* I2C Write
> +*/
> +static int __maybe_unused mip_i2c_write(struct mip_ts_info *info,
> +	char *write_buf, unsigned int write_len)
> +{
> +	int retry = I2C_RETRY_COUNT;
> +	int res;
> +
> +	while (retry--) {
> +		res = i2c_master_send(info->client, write_buf, write_len);
> +
> +		if (res == write_len)
> +			goto done;
> +		else if (res < 0)
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_master_send - errno [%d]\n",
> +				__func__, res);
> +		else
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] length mismatch - write[%d] result[%d]\n",
> +				__func__, write_len, res);
> +	}
> +
> +	goto error;
> +
> +error:
> +#if RESET_ON_I2C_ERROR
> +	mip_reboot(info);
> +#endif
> +	return 1;
> +
> +done:
> +	return 0;
> +}
> +
> +/*
> +* Power off
> +*/
> +static int mip_power_off(struct mip_ts_info *info)
> +{
> +	if (!IS_ERR_OR_NULL(info->gpio_ce))
> +		gpiod_set_value_cansleep(info->gpio_ce, 0);
> +
> +	return 0;
> +}
> +
> +/*
> +* Power on
> +*/
> +static int mip_power_on(struct mip_ts_info *info)
> +{
> +	if (!IS_ERR_OR_NULL(info->gpio_ce))
> +		gpiod_set_value_cansleep(info->gpio_ce, 1);
> +
> +	/* Booting delay : 200~300ms */
> +	usleep_range(200 * 1000, 300 * 1000);
> +
> +	return 0;
> +}
> +
> +/*
> +* Clear touch input event status
> +*/
> +static void mip_clear_input(struct mip_ts_info *info)
> +{
> +	int i;
> +
> +	/* Screen */
> +	for (i = 0; i < MAX_FINGER_NUM; i++) {
> +		input_mt_slot(info->input_dev, i);
> +		input_mt_report_slot_state(info->input_dev,
> +			MT_TOOL_FINGER, 0);
> +	}
> +
> +	/* Key */
> +	if (info->key_enable == true) {
> +		for (i = 0; i < info->key_num; i++)
> +			input_report_key(info->input_dev, info->key_code[i], 0);
> +	}
> +
> +	input_sync(info->input_dev);
> +}
> +
> +/*
> +* Input event handler - Report input event
> +*/
> +static void mip_input_event_handler(struct mip_ts_info *info, u8 sz, u8 *buf)
> +{
> +	int i;
> +	int type;
> +	int id;
> +	int hover = 0;
> +	int palm = 0;
> +	int state = 0;
> +	int x, y, z;
> +	int size = 0;
> +	int pressure_stage = 0;
> +	int pressure = 0;
> +	int touch_major = 0;
> +	int touch_minor = 0;
> +
> +	for (i = 0; i < sz; i += info->event_size) {
> +		u8 *packet = &buf[i];
> +
> +		/* Event format & type */
> +		switch (info->event_format) {
> +		case 0:
> +		case 1:
> +			type = (packet[0] & 0x40) >> 6;
> +			break;
> +		case 3:
> +			type = (packet[0] & 0xF0) >> 4;
> +			break;
> +		default:
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] Unknown event format[%d]\n",
> +				__func__, info->event_format);
> +			goto error;
> +		}
> +
> +		dev_dbg(&info->client->dev, "%s - Type[%d]\n",
> +			__func__, type);
> +
> +		/* Report input event */
> +		switch (type) {
> +		case MIP_EVENT_INPUT_TYPE_KEY:
> +			/* Key event */
> +			switch (info->event_format) {
> +			case 0:
> +			case 1:
> +				id = packet[0] & 0x0F;
> +				state = (packet[0] & 0x80) >> 7;
> +				break;
> +			case 3:
> +				id = packet[0] & 0x0F;
> +				state = (packet[1] & 0x01);
> +				break;
> +			default:
> +				dev_err(&info->client->dev,
> +					"%s [ERROR] Unknown event format[%d]\n",
> +					__func__, info->event_format);
> +				goto error;
> +			}
> +
> +			/* Report key event */
> +			if ((id >= 1) && (id <= info->key_num)) {
> +				int keycode = info->key_code[id - 1];
> +
> +				input_report_key(info->input_dev,
> +					keycode, state);
> +
> +				dev_dbg(&info->client->dev,
> +					"%s - Key : ID[%d] Code[%d] Event[%d]\n",
> +					__func__, id, keycode, state);
> +			} else {
> +				dev_err(&info->client->dev,
> +					"%s [ERROR] Unknown Key ID[%d]\n",
> +					__func__, id);
> +				continue;
> +			}
> +			break;
> +
> +		case MIP_EVENT_INPUT_TYPE_SCREEN:
> +			/* Screen event */
> +			switch (info->event_format) {
> +			case 0:
> +				/* Touch only */
> +				state = (packet[0] & 0x80) >> 7;
> +				hover = (packet[0] & 0x20) >> 5;
> +				palm = (packet[0] & 0x10) >> 4;
> +				id = (packet[0] & 0x0F) - 1;
> +				x = ((packet[1] & 0x0F) << 8) | packet[2];
> +				y = (((packet[1] >> 4) & 0x0F) << 8) |
> +					packet[3];
> +				pressure = packet[4];
> +				size = packet[5];
> +				touch_major = packet[5];
> +				touch_minor = packet[5];
> +				break;
> +
> +			case 1:
> +				/* Touch only */
> +				state = (packet[0] & 0x80) >> 7;
> +				hover = (packet[0] & 0x20) >> 5;
> +				palm = (packet[0] & 0x10) >> 4;
> +				id = (packet[0] & 0x0F) - 1;
> +				x = ((packet[1] & 0x0F) << 8) | packet[2];
> +				y = (((packet[1] >> 4) & 0x0F) << 8) |
> +					packet[3];
> +				pressure = packet[4];
> +				size = packet[5];
> +				touch_major = packet[6];
> +				touch_minor = packet[7];
> +				break;
> +
> +			case 3:
> +				/* Touch + Force(Pressure) */
> +				id = (packet[0] & 0x0F) - 1;
> +				hover = (packet[1] & 0x04) >> 2;
> +				palm = (packet[1] & 0x02) >> 1;
> +				state = (packet[1] & 0x01);
> +				x = ((packet[2] & 0x0F) << 8) | packet[3];
> +				y = (((packet[2] >> 4) & 0x0F) << 8) |
> +					packet[4];
> +				z = packet[5];
> +				size = packet[6];
> +				pressure_stage = (packet[7] & 0xF0) >> 4;
> +				pressure = ((packet[7] & 0x0F) << 8) |
> +					packet[8];
> +				touch_major = packet[9];
> +				touch_minor = packet[10];
> +				break;
> +
> +			default:
> +				dev_err(&info->client->dev,
> +					"%s [ERROR] Unknown event format[%d]\n",
> +					__func__, info->event_format);
> +				goto error;
> +			}
> +
> +			/* Report screen event */
> +			switch (state) {
> +			case 0:
> +				/* Release event */
> +				input_mt_slot(info->input_dev, id);
> +				input_mt_report_slot_state(info->input_dev,
> +					MT_TOOL_FINGER, 0);
> +
> +				dev_dbg(&info->client->dev,
> +					"%s - Screen : ID[%d] Release\n",
> +					__func__, id);
> +				break;
> +			case 1:
> +				/* Press or Move event */
> +				input_mt_slot(info->input_dev, id);
> +				input_mt_report_slot_state(info->input_dev,
> +					MT_TOOL_FINGER, true);
> +				input_report_abs(info->input_dev,
> +					ABS_MT_POSITION_X, x);
> +				input_report_abs(info->input_dev,
> +					ABS_MT_POSITION_Y, y);
> +				input_report_abs(info->input_dev,
> +					ABS_MT_PRESSURE, pressure);
> +				input_report_abs(info->input_dev,
> +					ABS_MT_TOUCH_MAJOR, touch_major);
> +				input_report_abs(info->input_dev,
> +					ABS_MT_TOUCH_MINOR, touch_minor);
> +
> +				input_report_abs(info->input_dev, ABS_X, x);
> +				input_report_abs(info->input_dev, ABS_Y, y);
> +
> +				dev_dbg(&info->client->dev,
> +					"%s - Screen : ID[%d] X[%d] Y[%d] Z[%d]\n",
> +					__func__, id, x, y, pressure);
> +				break;
> +			default:
> +				dev_err(&info->client->dev,
> +					"%s [ERROR] Unknown event state[%d]\n",
> +					__func__, state);
> +				goto error;
> +			}
> +			break;
> +
> +		default:
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] Unknown event type[%d]\n",
> +				__func__, type);
> +			goto error;
> +		}
> +	}
> +
> +	goto exit;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +exit:
> +	input_sync(info->input_dev);
> +}
> +
> +/*
> +* Config input device
> +*/
> +static void mip_config_input(struct mip_ts_info *info)
> +{
> +	struct input_dev *input_dev = info->input_dev;
> +
> +	/* Screen */
> +	input_mt_init_slots(input_dev, MAX_FINGER_NUM, INPUT_MT_DIRECT);
> +
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> +		info->max_x, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> +		info->max_y, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0,
> +		INPUT_PRESSURE_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> +		INPUT_TOUCH_MAJOR_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0,
> +		INPUT_TOUCH_MINOR_MAX, 0, 0);
> +
> +	input_set_abs_params(input_dev, ABS_X, 0,
> +		info->max_x, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0,
> +		info->max_y, 0, 0);
> +}
> +
> +/*****************************************************************
> + * Firmware update
> + *****************************************************************/
> +
> +/* Firmware Info */
> +#define BL_PAGE_SIZE		512	/* 512 */
> +#define BL_PACKET_SIZE	512	/* 512, 256, 128, 64, 32, 16, ... */
> +
> +/*
> +* Firmware binary tail info
> +*/
> +struct mip_bin_tail {
> +	u8 tail_mark[4];
> +	char chip_name[4];
> +	u32 bin_start_addr;
> +	u32 bin_length;
> +
> +	u16 ver_boot;
> +	u16 ver_core;
> +	u16 ver_app;
> +	u16 ver_param;
> +	u8 boot_start;
> +	u8 boot_end;
> +	u8 core_start;
> +	u8 core_end;
> +	u8 app_start;
> +	u8 app_end;
> +	u8 param_start;
> +	u8 param_end;
> +
> +	u8 checksum_type;
> +	u8 hw_category;
> +	u16 param_id;
> +	u32 param_length;
> +	u32 build_date;
> +	u32 build_time;
> +
> +	u32 reserved1;
> +	u32 reserved2;
> +	u16 reserved3;
> +	u16 tail_size;
> +	u32 crc;
> +} __packed;
> +
> +#define MIP_BIN_TAIL_MARK {0x4D, 0x42, 0x54, 0x01} /* M B T 0x01 */
> +#define MIP_BIN_TAIL_SIZE 64
> +
> +/*
> +* Bootloader - Read status
> +*/
> +static int mip_bl_read_status(struct mip_ts_info *info)
> +{
> +	u8 write_buf[2];
> +	u8 result = 0;
> +	int cnt = 1000;
> +	int ret = 0;
> +
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = info->client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = 2,
> +		}, {
> +			.addr = info->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = &result,
> +			.len = 1,
> +		},
> +	};
> +
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_STATUS;
> +
> +	do {
> +		if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> +			!= ARRAY_SIZE(msg)) {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_transfer\n", __func__);
> +			ret = -1;
> +			goto error;
> +		}
> +
> +		if (result == MIP_BOOT_STATUS_DONE) {
> +			dev_dbg(&info->client->dev, "%s - Done\n", __func__);
> +			ret = 0;
> +			break;
> +		} else if (result == MIP_BOOT_STATUS_BUSY) {
> +			dev_dbg(&info->client->dev, "%s - Busy\n", __func__);
> +			ret = -EBUSY;
> +			usleep_range(1000, 2000);
> +		} else if (result == MIP_BOOT_STATUS_ERROR) {
> +			dev_dbg(&info->client->dev, "%s - Error\n", __func__);
> +			ret = -EIO;
> +			goto error;
> +		} else {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] wrong value [0x%02X]\n",
> +				__func__, result);
> +			ret = -EINVAL;
> +			usleep_range(1000, 2000);
> +		}
> +	} while (--cnt);
> +
> +	if (!cnt) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] count overflow - cnt[%d] status[0x%02X]\n",
> +			__func__, cnt, result);
> +		goto error;
> +	}
> +
> +	return ret;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return ret;
> +}
> +
> +/*
> +* Bootloader - Change mode
> +*/
> +static int mip_bl_change_mode(struct mip_ts_info *info, u8 mode)
> +{
> +	u8 write_buf[8];
> +	u8 read_buf[8];
> +	int cnt = 10;
> +	int ret = 0;
> +
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = info->client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = 2,
> +		}, {
> +			.addr = info->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = read_buf,
> +			.len = 1,
> +		},
> +	};
> +
> +	do {
> +		/* Write */
> +		write_buf[0] = MIP_R0_BOOT;
> +		write_buf[1] = MIP_R1_BOOT_MODE;
> +		write_buf[2] = mode;
> +		if (i2c_master_send(info->client, write_buf, 3) != 3) {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_master_send\n", __func__);
> +			goto error;
> +		}
> +		dev_dbg(&info->client->dev,
> +			"%s - Write : Mode [%d]\n", __func__, mode);
> +
> +		/* Wait */
> +		msleep(1000);
> +
> +		/* Read */
> +		write_buf[0] = MIP_R0_BOOT;
> +		write_buf[1] = MIP_R1_BOOT_MODE;
> +		if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> +			!= ARRAY_SIZE(msg)) {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_transfer\n", __func__);
> +			ret = -1;
> +			goto error;
> +		}
> +		dev_dbg(&info->client->dev, "%s - Read : Mode [%d]\n",
> +			__func__, read_buf[0]);
> +
> +		if (read_buf[0] == mode)
> +			break;
> +
> +	} while (--cnt);
> +
> +	if (!cnt) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] count overflow - cnt [%d]\n",
> +			__func__, cnt);
> +		goto error;
> +	}
> +
> +	return ret;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return ret;
> +}
> +
> +/*
> +* Bootloader - Read info
> +*/
> +static int mip_bl_read_info(struct mip_ts_info *info, u16 *buf_addr)
> +{
> +	u8 write_buf[8];
> +	u8 read_buf[8];
> +	int ret = 0;
> +
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = info->client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = 2,
> +		}, {
> +			.addr = info->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = read_buf,
> +			.len = 2,
> +		},
> +	};
> +
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_BUF_ADDR;
> +	if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> +		!= ARRAY_SIZE(msg)) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_transfer\n", __func__);
> +		ret = -1;
> +		goto error;
> +	}
> +
> +	*buf_addr = (u16)((read_buf[1] << 8) | read_buf[0]);
> +	dev_dbg(&info->client->dev,
> +		"%s - Buf Addr [0x%04X]\n", __func__, *buf_addr);
> +
> +	return ret;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return ret;
> +}
> +
> +/*
> +* Bootloader - Program Page
> +*/
> +static int mip_bl_program_page(struct mip_ts_info *info, int offset,
> +	const u8 *data, int length, int buf_addr)
> +{
> +	u8 write_buf[2 + BL_PAGE_SIZE];
> +	int buf_offset = 0;
> +
> +	if (length > BL_PAGE_SIZE) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] page length overflow\n", __func__);
> +		goto error;
> +	}
> +
> +	/* Addr */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_TARGET_ADDR;
> +	put_unaligned_le32(offset, &write_buf[2]);
> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto error;
> +	}
> +	dev_dbg(&info->client->dev,
> +		"%s - Addr [0x%06X]\n", __func__, offset);
> +
> +	/* Size */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_SIZE;
> +	put_unaligned_le32(length, &write_buf[2]);
> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto error;
> +	}
> +	dev_dbg(&info->client->dev,
> +		"%s - Size [%d]\n", __func__, length);
> +
> +	/* Data */
> +	for (buf_offset = 0; buf_offset < length;
> +		buf_offset += BL_PACKET_SIZE) {
> +		write_buf[0] = (u8)(((buf_addr + buf_offset) >> 8) & 0xFF);
> +		write_buf[1] = (u8)((buf_addr + buf_offset) & 0xFF);
> +		memcpy(&write_buf[2], &data[buf_offset], BL_PACKET_SIZE);
> +		if (i2c_master_send(info->client, write_buf,
> +			(2 + BL_PACKET_SIZE))
> +			!= (2 + BL_PACKET_SIZE)) {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_master_send\n", __func__);
> +			goto error;
> +		}
> +		dev_dbg(&info->client->dev,
> +			"%s - PacketSize[%d] BufOffset[0x%04X]\n",
> +			__func__, BL_PACKET_SIZE, buf_offset);
> +	}
> +
> +	/* Command */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_CMD;
> +	write_buf[2] = MIP_BOOT_CMD_PROGRAM;
> +	if (i2c_master_send(info->client, write_buf, 3) != 3) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto error;
> +	}
> +
> +	/* Status */
> +	if (mip_bl_read_status(info) != 0)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return -1;
> +}
> +
> +/*
> +* Bootloader - Read Page
> +*/
> +static int mip_bl_read_page(struct mip_ts_info *info, int offset,
> +	u8 *data, int length, int buf_addr)
> +{
> +	u8 write_buf[8];
> +	u8 read_buf[BL_PACKET_SIZE];
> +	int buf_offset = 0;
> +
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = info->client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = 2,
> +		}, {
> +			.addr = info->client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = read_buf,
> +			.len = BL_PACKET_SIZE,
> +		},
> +	};
> +
> +	/* Addr */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_TARGET_ADDR;
> +	put_unaligned_le32(offset, &write_buf[2]);
> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto error;
> +	}
> +	dev_dbg(&info->client->dev, "%s - Addr [0x%06X]\n",
> +		__func__, offset);
> +
> +	/* Size */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_SIZE;
> +	put_unaligned_le32(length, &write_buf[2]);
> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto error;
> +	}
> +	dev_dbg(&info->client->dev,
> +		"%s - Size [%d]\n", __func__, length);
> +
> +	/* Command */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_CMD;
> +	write_buf[2] = MIP_BOOT_CMD_READ;
> +	if (i2c_master_send(info->client, write_buf, 3) != 3) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto error;
> +	}
> +
> +	/* Status */
> +	if (mip_bl_read_status(info) != 0)
> +		goto error;
> +
> +	/* Read */
> +	for (buf_offset = 0; buf_offset < length;
> +		buf_offset += BL_PACKET_SIZE) {
> +		write_buf[0] = (u8)(((buf_addr + buf_offset) >> 8) & 0xFF);
> +		write_buf[1] = (u8)((buf_addr + buf_offset) & 0xFF);
> +		if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> +			!= ARRAY_SIZE(msg)) {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_transfer\n", __func__);
> +			goto error;
> +		}
> +		memcpy(&data[buf_offset], read_buf, BL_PACKET_SIZE);
> +		dev_dbg(&info->client->dev,
> +			"%s - PacketSize[%d] BufOffset [0x%04X]\n",
> +			__func__, BL_PACKET_SIZE, buf_offset);
> +	}
> +
> +	return 0;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return -1;
> +}
> +
> +/*
> +* Bootloader - Start bootloader mode
> +*/
> +static int mip_bl_enter(struct mip_ts_info *info)
> +{
> +	if (mip_bl_change_mode(info, MIP_BOOT_MODE_BOOT) != 0)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return -1;
> +}
> +
> +/*
> +* Bootloader - Exit bootloader mode
> +*/
> +static int mip_bl_exit(struct mip_ts_info *info)
> +{
> +	if (mip_bl_change_mode(info, MIP_BOOT_MODE_APP) != 0)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return -1;
> +}
> +
> +/*
> +* Flash chip firmware
> +*/
> +static int mip_flash_fw(struct mip_ts_info *info, const u8 *fw_data,
> +	size_t fw_size, bool force, bool section)
> +{
> +	struct i2c_client *client = info->client;
> +	struct mip_bin_tail *bin_info;
> +	int ret = 0;
> +	int retry = 3;
> +	u8 rbuf[BL_PAGE_SIZE];
> +	int offset = 0;
> +	u32 offset_start = 0;
> +	u32 offset_end = 0;
> +	int bin_size = 0;
> +	u8 *bin_data;
> +	u16 tail_size = 0;
> +	u8 tail_mark[4] = MIP_BIN_TAIL_MARK;
> +	u16 ver_chip[MIP_FW_MAX_SECT_NUM];
> +	u16 buf_addr = 0;
> +
> +	/* Check tail size */
> +	tail_size = (fw_data[fw_size - 5] << 8) | fw_data[fw_size - 6];
> +	if (tail_size != MIP_BIN_TAIL_SIZE) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] wrong tail size [%d]\n",
> +			__func__, tail_size);
> +		ret = fw_err_file_type;
> +		goto error_file;
> +	}
> +
> +	/* Check bin format */
> +	if (memcmp(&fw_data[fw_size - tail_size], tail_mark, 4)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] wrong tail mark\n", __func__);
> +		ret = fw_err_file_type;
> +		goto error_file;
> +	}
> +
> +	/* Read bin info */
> +	bin_info = (struct mip_bin_tail *)&fw_data[fw_size - tail_size];
> +
> +#if MIP_FW_UPDATE_DEBUG
> +	print_hex_dump(KERN_ERR, MIP_DEVICE_NAME " Bin Info : ",
> +		DUMP_PREFIX_OFFSET, 16, 1, bin_info, tail_size, false);
> +#endif
> +
> +	/* Check F/W version */
> +	dev_info(&client->dev,
> +		"F/W file version [0x%04X 0x%04X 0x%04X 0x%04X]\n",
> +		bin_info->ver_boot, bin_info->ver_core,
> +		bin_info->ver_app, bin_info->ver_param);
> +
> +	if (force == true) {
> +		/* Force update */
> +		dev_info(&client->dev,
> +			"Skip chip firmware version check\n");
> +	} else {
> +		/* Read firmware version from chip */
> +		while (retry--) {
> +			if (mip_get_fw_version_u16(info, ver_chip))
> +				mip_reboot(info);
> +			else
> +				break;
> +		}
> +		if (retry < 0) {
> +			dev_err(&client->dev,
> +				"%s [ERROR] Unknown chip firmware version\n",
> +				__func__);
> +			offset_start = 0;
> +		} else {
> +			dev_info(&client->dev,
> +				"Chip firmware version [0x%04X 0x%04X 0x%04X 0x%04X]\n",
> +				ver_chip[0], ver_chip[1],
> +				ver_chip[2], ver_chip[3]);
> +
> +			/* Compare version */
> +			if ((ver_chip[0] == bin_info->ver_boot) &&
> +				(ver_chip[1] == bin_info->ver_core) &&
> +				(ver_chip[2] == bin_info->ver_app) &&
> +				(ver_chip[3] == bin_info->ver_param)) {
> +				dev_info(&client->dev,
> +					"Chip firmware is already up-to-date\n");
> +				ret = fw_err_uptodate;
> +				goto uptodate;
> +			}
> +		}
> +	}
> +
> +	/* Read bin data */
> +	bin_size = bin_info->bin_length;
> +	bin_data = kzalloc(sizeof(u8) * (bin_size), GFP_KERNEL);
> +	memcpy(bin_data, fw_data, bin_size);
> +
> +	/* Enter bootloader mode */
> +	dev_dbg(&client->dev,
> +		"%s - Enter bootloader mode\n", __func__);
> +
> +	if (mip_bl_enter(info) != 0) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_bl_enter\n", __func__);
> +		ret = fw_err_download;
> +		goto error_update;
> +	}
> +
> +	/* Read info */
> +	if (mip_bl_read_info(info, &buf_addr)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_bl_read_info\n", __func__);
> +		ret = fw_err_download;
> +		goto error_update;
> +	}
> +	dev_dbg(&client->dev,
> +		"%s - Buffer Addr [0x%04X]\n", __func__, buf_addr);
> +
> +	/* Program & Verify */
> +	dev_dbg(&client->dev,
> +		"%s - Program & Verify\n", __func__);
> +
> +	dev_dbg(&client->dev,
> +		"%s - Size : Page[%d] Packet[%d]\n",
> +		__func__, BL_PAGE_SIZE, BL_PACKET_SIZE);
> +
> +	offset_start = bin_info->bin_start_addr;
> +	offset_end = bin_size - BL_PAGE_SIZE;
> +	dev_dbg(&client->dev,
> +		"%s - Offset : Start[0x%08X] End[0x%08X]\n",
> +		__func__, offset_start, offset_end);
> +
> +	for (offset = offset_start; offset < bin_size;
> +		offset += BL_PAGE_SIZE) {
> +		/* Program */
> +		if (mip_bl_program_page(info, offset, &bin_data[offset],
> +			BL_PAGE_SIZE, buf_addr)) {
> +			dev_err(&client->dev,
> +				"%s [ERROR] mip_bl_program_page : offset[0x%08X]\n",
> +				__func__, offset);
> +			ret = fw_err_download;
> +			goto error_update;
> +		}
> +		dev_dbg(&client->dev,
> +			"%s - mip_bl_program_page : offset[0x%08X]\n",
> +			__func__, offset);
> +
> +		/* Verify */
> +		if (mip_bl_read_page
> +			(info, offset, rbuf, BL_PAGE_SIZE, buf_addr)) {
> +			dev_err(&client->dev,
> +				"%s [ERROR] mip_bl_read_page : offset[0x%08X]\n",
> +				__func__, offset);
> +			ret = fw_err_download;
> +			goto error_update;
> +		}
> +		dev_dbg(&client->dev,
> +			"%s - mip_bl_read_page : offset[0x%08X]\n",
> +			__func__, offset);
> +
> +#if MIP_FW_UPDATE_DEBUG
> +		print_hex_dump(KERN_ERR, MIP_DEVICE_NAME " F/W File : ",
> +			DUMP_PREFIX_OFFSET, 16, 1, &bin_data[offset],
> +			BL_PAGE_SIZE, false);
> +		print_hex_dump(KERN_ERR, MIP_DEVICE_NAME " F/W Chip : ",
> +			DUMP_PREFIX_OFFSET, 16, 1, rbuf,
> +			BL_PAGE_SIZE, false);
> +#endif
> +
> +		if (memcmp(rbuf, &bin_data[offset], BL_PAGE_SIZE)) {
> +			dev_err(&client->dev,
> +				"%s [ERROR] Verify failed : offset[0x%08X]\n",
> +				__func__, offset);
> +			ret = fw_err_download;
> +			goto error_update;
> +		}
> +	}
> +
> +	/* Exit bootloader mode */
> +	dev_dbg(&client->dev,
> +		"%s - Exit bootloader mode\n", __func__);
> +
> +	if (mip_bl_exit(info) != 0) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_bl_exit\n", __func__);
> +		ret = fw_err_download;
> +		goto error_update;
> +	}
> +
> +	/* Reset chip */
> +	mip_reboot(info);
> +
> +	/* Check chip firmware version */
> +	if (mip_get_fw_version_u16(info, ver_chip)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] Unknown chip firmware version\n",
> +			__func__);
> +		ret = fw_err_download;
> +		goto error_update;
> +	} else {
> +		if ((ver_chip[1] == bin_info->ver_core) &&
> +			(ver_chip[2] == bin_info->ver_app) &&
> +			(ver_chip[3] == bin_info->ver_param)) {
> +			dev_dbg(&client->dev,
> +				"%s - Version check OK\n", __func__);
> +		} else {
> +			dev_err(&client->dev,
> +				"Version mismatch after flash.\n");
> +			dev_err(&client->dev,
> +				"Chip[0x%04X 0x%04X 0x%04X 0x%04X]\n",
> +				ver_chip[0], ver_chip[1],
> +				ver_chip[2], ver_chip[3]);
> +			dev_err(&client->dev,
> +				"File[0x%04X 0x%04X 0x%04X 0x%04X]\n",
> +				bin_info->ver_boot, bin_info->ver_core,
> +				bin_info->ver_app, bin_info->ver_param);
> +			ret = fw_err_download;
> +			goto error_update;
> +		}
> +	}
> +
> +	kfree(bin_data);
> +
> +uptodate:
> +	goto exit;
> +
> +error_update:
> +	kfree(bin_data);
> +
> +	/* Reset chip */
> +	mip_reboot(info);
> +
> +error_file:
> +	dev_err(&client->dev, "%s [ERROR]\n", __func__);
> +
> +exit:
> +	return ret;
> +}
> +
> +/*****************************************************************
> + * Main
> + *****************************************************************/
> +
> +/*
> +* Enable device
> +*/
> +static int mip_enable(struct mip_ts_info *info)
> +{
> +	if (info->enabled) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] device already enabled\n", __func__);
> +		goto error;
> +	}
> +
> +	mip_power_on(info);
> +
> +	mutex_lock(&info->lock);
> +
> +	if (info->irq_enabled == false) {
> +		enable_irq(info->client->irq);
> +		info->irq_enabled = true;
> +	}
> +
> +	info->enabled = true;
> +
> +	mutex_unlock(&info->lock);
> +
> +error:
> +	dev_info(&info->client->dev, MIP_DEVICE_NAME" - Enabled\n");
> +
> +	return 0;
> +}
> +
> +/*
> +* Disable device
> +*/
> +static int mip_disable(struct mip_ts_info *info)
> +{
> +	if (!info->enabled) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] device already disabled\n", __func__);
> +		goto error;
> +	}
> +
> +	mutex_lock(&info->lock);
> +
> +	disable_irq(info->client->irq);
> +	info->irq_enabled = false;
> +
> +	mutex_unlock(&info->lock);
> +
> +	mip_power_off(info);
> +
> +	mip_clear_input(info);
> +
> +	info->enabled = false;
> +
> +error:
> +	dev_info(&info->client->dev, MIP_DEVICE_NAME" - Disabled\n");
> +
> +	return 0;
> +}
> +
> +/*
> +* Open input device
> +*/
> +static int mip_input_open(struct input_dev *dev)
> +{
> +	struct mip_ts_info *info = input_get_drvdata(dev);
> +
> +	mip_enable(info);
> +
> +	return 0;
> +}
> +
> +/*
> +* Close input device
> +*/
> +static void mip_input_close(struct input_dev *dev)
> +{
> +	struct mip_ts_info *info = input_get_drvdata(dev);
> +
> +	mip_disable(info);
> +}
> +
> +/*
> +* Read chip firmware version
> +*/
> +static int mip_get_fw_version(struct mip_ts_info *info, u8 *ver_buf)
> +{
> +	u8 rbuf[8];
> +	u8 wbuf[2];
> +	int i;
> +
> +	wbuf[0] = MIP_R0_INFO;
> +	wbuf[1] = MIP_R1_INFO_VERSION_BOOT;
> +	if (mip_i2c_read(info, wbuf, 2, rbuf, 8)) {
> +		goto error;
> +	};
> +
> +	for (i = 0; i < MIP_FW_MAX_SECT_NUM; i++) {
> +		ver_buf[0 + i * 2] = rbuf[1 + i * 2];
> +		ver_buf[1 + i * 2] = rbuf[0 + i * 2];
> +	}
> +
> +	return 0;
> +
> +error:
> +	memset(ver_buf, 0xFF, 8);
> +
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return 1;
> +}
> +
> +/*
> +* Read chip firmware version for u16
> +*/
> +static int mip_get_fw_version_u16(struct mip_ts_info *info, u16 *ver_buf_u16)
> +{
> +	u8 rbuf[8];
> +	int i;
> +
> +	if (mip_get_fw_version(info, rbuf))
> +		goto error;
> +
> +	for (i = 0; i < MIP_FW_MAX_SECT_NUM; i++)
> +		ver_buf_u16[i] = (rbuf[0 + i * 2] << 8) | rbuf[1 + i * 2];
> +
> +	return 0;
> +
> +error:
> +	memset(ver_buf_u16, 0xFFFF, 4);
> +
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return 1;
> +}
> +
> +/*
> +* Interrupt handler
> +*/
> +static irqreturn_t mip_interrupt(int irq, void *dev_id)
> +{
> +	struct mip_ts_info *info = dev_id;
> +	struct i2c_client *client = info->client;
> +	u8 wbuf[8];
> +	u8 rbuf[256];
> +	unsigned int size = 0;
> +	u8 category = 0;
> +	u8 alert_type = 0;
> +
> +	/* Read packet info */
> +	wbuf[0] = MIP_R0_EVENT;
> +	wbuf[1] = MIP_R1_EVENT_PACKET_INFO;
> +	if (mip_i2c_read(info, wbuf, 2, rbuf, 1)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] Read packet info\n", __func__);
> +		goto error;
> +	}
> +
> +	size = (rbuf[0] & 0x7F);
> +	category = ((rbuf[0] >> 7) & 0x1);
> +	dev_dbg(&client->dev,
> +		"%s - packet info : size[%d] category[%d]\n",
> +		__func__, size, category);
> +
> +	/* Check size */
> +	if (size <= 0) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] Packet size [%d]\n",
> +			__func__, size);
> +		goto exit;
> +	}
> +
> +	/* Read packet data */
> +	wbuf[0] = MIP_R0_EVENT;
> +	wbuf[1] = MIP_R1_EVENT_PACKET_DATA;
> +	if (mip_i2c_read(info, wbuf, 2, rbuf, size)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] Read packet data\n",
> +			__func__);
> +		goto error;
> +	}
> +
> +	/* Event handler */
> +	if (category == 0) {
> +		/* Touch event */
> +		info->esd_cnt = 0;
> +
> +		mip_input_event_handler(info, size, rbuf);
> +	} else {
> +		/* Alert event */
> +		alert_type = rbuf[0];
> +
> +		dev_dbg(&client->dev,
> +			"%s - alert type [%d]\n",
> +			__func__, alert_type);
> +	}
> +
> +exit:
> +	return IRQ_HANDLED;
> +
> +error:
> +	dev_err(&client->dev, "%s [ERROR]\n", __func__);
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> +* Initial config
> +*/
> +static int mip_init_config(struct mip_ts_info *info)
> +{
> +	u8 wbuf[8];
> +	u8 rbuf[64];
> +
> +	/* Product name */
> +	wbuf[0] = MIP_R0_INFO;
> +	wbuf[1] = MIP_R1_INFO_PRODUCT_NAME;
> +	mip_i2c_read(info, wbuf, 2, rbuf, 16);
> +	memcpy(info->product_name, rbuf, 16);
> +	dev_dbg(&info->client->dev,
> +		"%s - product_name[%s]\n",
> +		__func__, info->product_name);
> +
> +	/* Firmware version */
> +	mip_get_fw_version(info, rbuf);
> +	memcpy(info->fw_version, rbuf, 8);
> +	dev_info(&info->client->dev,
> +		"%s - F/W Version : %02X.%02X %02X.%02X %02X.%02X %02X.%02X\n",
> +		__func__, info->fw_version[0], info->fw_version[1],
> +		info->fw_version[2], info->fw_version[3], info->fw_version[4],
> +		info->fw_version[5], info->fw_version[6], info->fw_version[7]);
> +
> +	/* Resolution */
> +	wbuf[0] = MIP_R0_INFO;
> +	wbuf[1] = MIP_R1_INFO_RESOLUTION_X;
> +	mip_i2c_read(info, wbuf, 2, rbuf, 7);
> +
> +	/* Set resolution by firmware info */
> +	info->max_x = get_unaligned_le16(&rbuf[0]);
> +	info->max_y = get_unaligned_le16(&rbuf[2]);
> +	dev_dbg(&info->client->dev, "%s - max_x[%d] max_y[%d]\n",
> +		__func__, info->max_x, info->max_y);
> +
> +	/* Node info */
> +	info->node_x = rbuf[4];
> +	info->node_y = rbuf[5];
> +	info->node_key = rbuf[6];
> +	dev_dbg(&info->client->dev,
> +		"%s - node_x[%d] node_y[%d] node_key[%d]\n",
> +		__func__, info->node_x, info->node_y, info->node_key);
> +
> +	/* Key info */
> +	if (info->node_key > 0) {
> +		/* Enable touchkey */
> +		info->key_enable = true;
> +		info->key_num = info->node_key;
> +	}
> +
> +	/* Protocol */
> +	wbuf[0] = MIP_R0_EVENT;
> +	wbuf[1] = MIP_R1_EVENT_SUPPORTED_FUNC;
> +	mip_i2c_read(info, wbuf, 2, rbuf, 7);
> +	info->event_format = (rbuf[4]) | (rbuf[5] << 8);
> +	info->event_size = rbuf[6];
> +	dev_dbg(&info->client->dev,
> +		"%s - event_format[%d] event_size[%d]\n",
> +		__func__, info->event_format, info->event_size);
> +
> +	return 0;
> +}
> +
> +/*
> +* Update firmware
> +*/
> +static int mip_fw_update(struct mip_ts_info *info)
> +{
> +	const char *fw_name = FW_PATH_INTERNAL;
> +	const struct firmware *fw;
> +	int retires = 3;
> +	int ret = fw_err_none;
> +
> +	/* Disable IRQ */
> +	mutex_lock(&info->lock);
> +	disable_irq(info->client->irq);
> +
> +	/* Get firmware */
> +	request_firmware(&fw, fw_name, &info->client->dev);
> +
> +	if (!fw) {

Better check the return value if request_firmware() call.

> +		dev_err(&info->client->dev,
> +			"%s [ERROR] request_firmware\n", __func__);
> +		goto error;
> +	}
> +
> +	/* Update firmware */
> +	do {
> +		ret = mip_flash_fw(info, fw->data, fw->size, false, true);
> +		if (ret >= fw_err_none)
> +			break;
> +	} while (--retires);
> +
> +	if (!retires) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] mip_flash_fw failed\n", __func__);
> +		ret = fw_err_download;
> +	}
> +
> +	release_firmware(fw);
> +
> +	/* Enable IRQ */
> +	enable_irq(info->client->irq);
> +	mutex_unlock(&info->lock);
> +
> +	if (ret < fw_err_none)
> +		goto error;
> +
> +	return ret;
> +
> +error:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return ret;
> +}
> +
> +static ssize_t mip_sys_fw_update(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip_ts_info *info = i2c_get_clientdata(client);
> +	int result = 0;
> +	u8 data[255];
> +	int ret = 0;
> +
> +	/* Update firmware */
> +	ret = mip_fw_update(info);
> +
> +	switch (ret) {
> +	case fw_err_none:
> +		sprintf(data, "F/W update success.\n");
> +		break;
> +	case fw_err_uptodate:
> +		sprintf(data, "F/W is already up-to-date.\n");
> +		break;
> +	case fw_err_download:
> +		sprintf(data, "F/W update failed : Download error\n");
> +		break;
> +	case fw_err_file_type:
> +		sprintf(data, "F/W update failed : File type error\n");
> +		break;
> +	case fw_err_file_open:
> +		sprintf(data, "F/W update failed : File open error\n");
> +		break;
> +	case fw_err_file_read:
> +		sprintf(data, "F/W update failed : File read error\n");
> +		break;
> +	default:
> +		sprintf(data, "F/W update failed.\n");
> +		break;
> +	}
> +
> +	/* Re-initialize driver */
> +	mip_init_config(info);
> +	mip_config_input(info);
> +
> +	result = snprintf(buf, PAGE_SIZE, "%s\n", data);
> +	return result;

Instead of returning string encoding error why not return error value
directly?

> +}
> +static DEVICE_ATTR(fw_update, 0660, mip_sys_fw_update, NULL);
> +
> +/*
> +* Print chip firmware version
> +*/
> +static ssize_t mip_sys_fw_version(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct mip_ts_info *info = dev_get_drvdata(dev);
> +	u8 data[255];
> +	int ret;
> +	u8 rbuf[16];
> +
> +	if (mip_get_fw_version(info, rbuf)) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] mip_get_fw_version\n", __func__);
> +
> +		sprintf(data, "F/W Version : ERROR\n");
> +		goto error;
> +	}
> +
> +	sprintf(data,
> +		"F/W Version : %02X.%02X/%02X.%02X/%02X.%02X/%02X.%02X\n",
> +		rbuf[0], rbuf[1], rbuf[2], rbuf[3],
> +		rbuf[4], rbuf[5], rbuf[6], rbuf[7]);
> +
> +error:
> +	ret = snprintf(buf, PAGE_SIZE, "%s\n", data);
> +	return ret;
> +}
> +static DEVICE_ATTR(fw_version, 0660, mip_sys_fw_version, NULL);
> +
> +/*
> +* Sysfs attr info
> +*/
> +static struct attribute *mip_attrs[] = {
> +	&dev_attr_fw_update.attr,
> +	&dev_attr_fw_version.attr,
> +	NULL,
> +};
> +
> +/*
> +* Sysfs attr group info
> +*/
> +static const struct attribute_group mip_attr_group = {
> +	.attrs = mip_attrs,
> +};
> +
> +/*
> +* Create sysfs
> +*/
> +static int mip_sysfs_create(struct mip_ts_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +
> +	if (sysfs_create_group(&client->dev.kobj, &mip_attr_group)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] sysfs_create_group\n", __func__);
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> +* Remove sysfs
> +*/
> +static void mip_sysfs_remove(void *_info)
> +{
> +	struct mip_ts_info *info = _info;
> +
> +	sysfs_remove_group(&info->client->dev.kobj, &mip_attr_group);
> +}
> +
> +/*
> +* Get platform data
> +*/
> +static int mip_platform_data(struct mip_ts_info *info)
> +{
> +	int ret = 0;
> +
> +	/* Get platform data */
> +#ifndef CONFIG_ACPI
> +	if (!info->client->dev.of_node) {
> +		info->pdata = dev_get_platdata(&info->client->dev);
> +		if (info->pdata == NULL) {
> +			ret = -EINVAL;
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] dev_get_platdata\n", __func__);
> +			return ret;
> +		}
> +	}
> +#endif
> +
> +	/* Get GPIO */
> +	info->gpio_ce = devm_gpiod_get_optional(&info->client->dev,
> +						"ce", GPIOD_OUT_LOW);
> +	if (IS_ERR(info->gpio_ce)) {
> +		ret = PTR_ERR(info->gpio_ce);
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] gpio_ce\n", __func__);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> +* Initialize driver
> +*/
> +static int mip_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct mip_ts_info *info;
> +	struct input_dev *input_dev;
> +	unsigned long irqflags;
> +	int ret = 0;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] i2c_check_functionality\n",
> +			__func__);
> +		ret = -EIO;
> +		goto error;

I'd rather we returned directly here and in other places in probe(). We
already printed one error message, no need for yet another.

> +	}
> +
> +	/* Init info data */
> +	info = devm_kzalloc(&client->dev,
> +			sizeof(struct mip_ts_info), GFP_KERNEL);
> +	input_dev = devm_input_allocate_device(&client->dev);
> +	if (!info || !input_dev) {
> +		dev_err(&client->dev,
> +			"%s [ERROR]\n", __func__);
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	info->client = client;
> +	info->input_dev = input_dev;
> +	info->irq = -1;

Why do we initialize it to -1 here if we set it to client->irq a few
lines later?

> +	info->init = true;

Except this assignment I do not see it being used.

> +	info->power = -1;

Except this assignment I do not see it being used.

> +	info->irq_enabled = false;
> +	mutex_init(&info->lock);
> +
> +	/* Get platform data */
> +	ret = mip_platform_data(info);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_platform_data\n",
> +			__func__);
> +		goto error;
> +	}
> +
> +	/* Set input dev */
> +	info->input_dev->name = "MELFAS MIP4 Touchscreen";
> +	info->input_dev->phys = info->phys;
> +	info->input_dev->id.bustype = BUS_I2C;

Does Melfas have VID assigned to it?

> +	info->input_dev->dev.parent = &client->dev;

Already done by devm_input_allocate_device().

> +	info->input_dev->open = mip_input_open;
> +	info->input_dev->close = mip_input_close;
> +
> +	/* Set driver data */
> +	input_set_drvdata(input_dev, info);
> +	i2c_set_clientdata(client, info);
> +
> +	/* Power on */
> +	mip_power_on(info);
> +
> +	/* Firmware update */
> +	ret = mip_fw_update(info);
> +	if (ret)
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_fw_update\n",
> +			__func__);

Hmm, this will not work if driver is built into the kernel but firmware
is on disk. Does the firmware have to be loaded every time we restore
power to the device or is it stored in NVRAM?

> +
> +	/* Initial config */
> +	mip_init_config(info);
> +
> +	/* Config input interface */
> +	mip_config_input(info);
> +
> +	/* Register input device */
> +	ret = input_register_device(input_dev);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] input_register_device\n",
> +			__func__);
> +		ret = -EIO;
> +		goto error;
> +	}
> +
> +	/* Set interrupt handler */
> +	irqflags = info->pdata ? info->pdata->irqflags : IRQF_TRIGGER_LOW;
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +		mip_interrupt, irqflags | IRQF_ONESHOT, MIP_DEVICE_NAME, info);

The platform should set up the IRQ trigger type, so please just use
IRQF_ONESHOT here.

> +
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] request_threaded_irq\n", __func__);
> +		goto error;
> +	}
> +
> +	disable_irq(client->irq);
> +	info->irq = client->irq;
> +
> +	/* Enable device */
> +	mip_enable(info);

Why do we enable it here instead of waiting for open()?

> +
> +	/* Create sysfs */
> +	if (mip_sysfs_create(info))
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_sysfs_create\n", __func__);
> +
> +	ret = devm_add_action(&client->dev, mip_sysfs_remove, info);
> +	if (ret) {
> +		mip_sysfs_remove(info);
> +		dev_err(&client->dev,
> +			"%s [ERROR] devm_add_action\n", __func__);
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	dev_dbg(&client->dev, "%s [ERROR]\n", __func__);
> +	return ret;
> +}
> +
> +/*
> +* Device suspend event handler
> +*/
> +static int __maybe_unused mip_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip_ts_info *info = i2c_get_clientdata(client);
> +	struct input_dev *input_dev = info->input_dev;
> +
> +	mutex_lock(&input_dev->mutex);
> +
> +	if (input_dev->users)
> +		mip_disable(info);
> +
> +	mutex_unlock(&input_dev->mutex);
> +
> +	return 0;
> +}
> +
> +/*
> +* Device resume event handler
> +*/
> +static int __maybe_unused mip_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip_ts_info *info = i2c_get_clientdata(client);
> +	struct input_dev *input_dev = info->input_dev;
> +
> +	mutex_lock(&input_dev->mutex);
> +
> +	if (input_dev->users)
> +		mip_enable(info);
> +
> +	mutex_unlock(&input_dev->mutex);
> +
> +	return 0;
> +}
> +
> +/*
> +* PM info
> +*/
> +static SIMPLE_DEV_PM_OPS(mip_pm_ops, mip_suspend, mip_resume);
> +
> +/*
> +* Device tree match table
> +*/
> +static const struct of_device_id mip_match_table[] = {
> +	{.compatible = "melfas,"MIP_DEVICE_NAME,},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mip_match_table);
> +
> +/*
> +* ACPI match table
> +*/
> +static const struct acpi_device_id mip_acpi_match_table[] = {
> +	{ACPI_ID, 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, mip_acpi_match_table);
> +
> +/*
> +* I2C Device ID
> +*/
> +static const struct i2c_device_id mip_id[] = {
> +	{MIP_DEVICE_NAME, 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, mip_id);
> +
> +/*
> +* I2C driver info
> +*/
> +static struct i2c_driver mip_driver = {
> +	.id_table = mip_id,
> +	.probe = mip_probe,
> +	.driver = {
> +		.name = MIP_DEVICE_NAME,
> +		.owner = THIS_MODULE,

No need to specify owner explicitly, i2c core will set it for us.

> +		.of_match_table = of_match_ptr(mip_match_table),
> +		.acpi_match_table = ACPI_PTR(mip_acpi_match_table),
> +		.pm = &mip_pm_ops,
> +	},
> +};
> +
> +module_i2c_driver(mip_driver);
> +
> +MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
> +MODULE_VERSION("2016.01.13");
> +MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/include/linux/input/melfas_mip4.h b/include/linux/input/melfas_mip4.h
> new file mode 100644
> index 0000000..2836542
> --- /dev/null
> +++ b/include/linux/input/melfas_mip4.h
> @@ -0,0 +1,31 @@
> +/*
> + * MELFAS MIP4 Touchscreen
> + *
> + * Copyright (C) 2016 MELFAS Inc.
> + *
> + * Author : Sangwon Jee <jeesw@melfas.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef _LINUX_MELFAS_MIP4_TOUCHSCREEN_H
> +#define _LINUX_MELFAS_MIP4_TOUCHSCREEN_H
> +
> +/*
> +* Platform Data
> +*/
> +struct melfas_mip4_platform_data {
> +	unsigned long irqflags;
> +};

This should be set up by the platform (ACPI/OF/board code) and not by
the driver; since that would leave platform data empty please remove the
file.

> +#endif
> +
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
