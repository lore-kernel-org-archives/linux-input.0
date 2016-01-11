From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: Add MELFAS MIP4 Touchscreen driver
Date: Mon, 11 Jan 2016 00:37:20 -0800
Message-ID: <20160111083720.GB27512@dtor-ws>
References: <1452405140-29827-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34533 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbcAKIhY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2016 03:37:24 -0500
Received: by mail-pa0-f66.google.com with SMTP id yy13so24315392pab.1
        for <linux-input@vger.kernel.org>; Mon, 11 Jan 2016 00:37:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452405140-29827-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

Hi,

On Sun, Jan 10, 2016 at 02:52:20PM +0900, Sangwon Jee wrote:
> This is an input driver for MELFAS MIP4 Touchscreen devices,
> made by the original vendor, MELFAS.
> 
> MIP4 means MELFAS Interface Protocol Version 4.
> MELFAS MMS400, MMS500, MCS8000, MIT200, MIT300, MIT400, MFS10 and other
> recent touchscreen devices are using MIP4 and supported by this driver.
> 
> There are two MELFAS touchscreen drivers(mcs5000_ts, mms114) in the kernel.
> But those drivers are for discontinued models and not supported by MELFAS.

Thank you for you submission. Please find my comments from the 1st pass
at the code below. Please fix the issues that I pointed out and resubmit
for the next round of reviews.

> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>
> ---
>  drivers/input/touchscreen/Kconfig       |   11 +
>  drivers/input/touchscreen/Makefile      |    1 +
>  drivers/input/touchscreen/melfas_mip4.c | 2516 +++++++++++++++++++++++++++++++
>  include/linux/input/melfas_mip4.h       |   33 +
>  4 files changed, 2561 insertions(+)
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
> index 0000000..5e42105
> --- /dev/null
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -0,0 +1,2516 @@
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
> +#include <linux/cdev.h>
> +#include <linux/uaccess.h>
> +#ifdef CONFIG_OF
> +#include <linux/of_gpio.h>
> +#endif
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +#endif
> +
> +/*****************************************************************
> + * Platform
> + *****************************************************************/
> +
> +#ifdef CONFIG_OF
> +#define MIP_USE_DEVICETREE 1
> +#else
> +#define MIP_USE_DEVICETREE 0
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +#define MIP_USE_ACPI 1
> +#else
> +#define MIP_USE_ACPI 0
> +#endif

Why do we need these defines? Simply use #ifdef CONFIG_* in your code.

> +
> +#define MIP_DEVICE_NAME	"mip4_ts"
> +#define ACPI_ID			"MLFS0000"
> +
> +/*****************************************************************
> + * Protocol
> + * Version : MIP 4.0 Rev 4.2
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
> +#define MIP_R0_PARAM						0x08
> +#define MIP_R1_PARAM_BUFFER_ADDR			0x00
> +#define MIP_R1_PARAM_PROTOCOL			0x04
> +#define MIP_R1_PARAM_MODE					0x10
> +
> +#define MIP_R0_TEST						0x0A
> +#define MIP_R1_TEST_BUF_ADDR				0x00
> +#define MIP_R1_TEST_PROTOCOL				0x02
> +#define MIP_R1_TEST_TYPE					0x10
> +#define MIP_R1_TEST_DATA_FORMAT			0x20
> +#define MIP_R1_TEST_ROW_NUM				0x20
> +#define MIP_R1_TEST_COL_NUM				0x21
> +#define MIP_R1_TEST_BUFFER_COL_NUM		0x22
> +#define MIP_R1_TEST_COL_AXIS				0x23
> +#define MIP_R1_TEST_KEY_NUM				0x24
> +#define MIP_R1_TEST_DATA_TYPE			0x25
> +
> +#define MIP_R0_IMAGE						0x0C
> +#define MIP_R1_IMAGE_BUF_ADDR			0x00
> +#define MIP_R1_IMAGE_PROTOCOL_ID			0x04
> +#define MIP_R1_IMAGE_TYPE					0x10
> +#define MIP_R1_IMAGE_DATA_FORMAT			0x20
> +#define MIP_R1_IMAGE_ROW_NUM				0x20
> +#define MIP_R1_IMAGE_COL_NUM				0x21
> +#define MIP_R1_IMAGE_BUFFER_COL_NUM		0x22
> +#define MIP_R1_IMAGE_COL_AXIS			0x23
> +#define MIP_R1_IMAGE_KEY_NUM				0x24
> +#define MIP_R1_IMAGE_DATA_TYPE			0x25
> +#define MIP_R1_IMAGE_FINGER_NUM			0x30
> +#define MIP_R1_IMAGE_FINGER_AREA			0x31
> +
> +#define MIP_R0_VENDOR						0x0E
> +#define MIP_R1_VENDOR_INFO				0x00
> +
> +#define MIP_R0_LOG							0x10
> +#define MIP_R1_LOG_TRIGGER				0x14
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
> +#define MIP_EVENT_GESTURE_C				1
> +#define MIP_EVENT_GESTURE_W				2
> +#define MIP_EVENT_GESTURE_V				3
> +#define MIP_EVENT_GESTURE_M				4
> +#define MIP_EVENT_GESTURE_S				5
> +#define MIP_EVENT_GESTURE_Z				6
> +#define MIP_EVENT_GESTURE_O				7
> +#define MIP_EVENT_GESTURE_E				8
> +#define MIP_EVENT_GESTURE_V_90			9
> +#define MIP_EVENT_GESTURE_V_180			10
> +#define MIP_EVENT_GESTURE_FLICK_RIGHT	20
> +#define MIP_EVENT_GESTURE_FLICK_DOWN	21
> +#define MIP_EVENT_GESTURE_FLICK_LEFT	22
> +#define MIP_EVENT_GESTURE_FLICK_UP		23
> +#define MIP_EVENT_GESTURE_DOUBLE_TAP	24
> +#define MIP_EVENT_GESTURE_ALL			0xFFFFFFFF

Do we need these gestures defines? We generally do not use firmware
gestures in Linux.

> +
> +#define MIP_ALERT_ESD					1
> +#define MIP_ALERT_WAKEUP				2
> +#define MIP_ALERT_INPUT_TYPE			3
> +#define MIP_ALERT_IMAGE				4
> +#define MIP_ALERT_F1					0xF1
> +
> +#define MIP_CTRL_STATUS_NONE			0x05
> +#define MIP_CTRL_STATUS_READY		0xA0
> +#define MIP_CTRL_STATUS_LOG			0x77
> +
> +#define MIP_CTRL_MODE_NORMAL			0
> +#define MIP_CTRL_MODE_PARAM			1
> +#define MIP_CTRL_MODE_TEST			2
> +
> +#define MIP_CTRL_TRIGGER_NONE		0
> +#define MIP_CTRL_TRIGGER_INTR		1
> +#define MIP_CTRL_TRIGGER_REG			2
> +
> +#define MIP_CTRL_POWER_ACTIVE		0
> +#define MIP_CTRL_POWER_LOW			1
> +
> +#define MIP_TEST_TYPE_NONE			0
> +#define MIP_TEST_TYPE_CM_DELTA		1
> +#define MIP_TEST_TYPE_CM_ABS			2
> +#define MIP_TEST_TYPE_CM_JITTER		3
> +#define MIP_TEST_TYPE_SHORT			4
> +#define MIP_TEST_TYPE_GPIO_LOW		5
> +#define MIP_TEST_TYPE_GPIO_HIGH		6
> +#define MIP_TEST_TYPE_SHORT2			7
> +#define MIP_TEST_TYPE_OPEN			8
> +#define MIP_TEST_TYPE_SELF_CP			20
> +#define MIP_TEST_TYPE_SELF_DIFF_HOR		21
> +#define MIP_TEST_TYPE_SELF_DIFF_VER		22
> +#define MIP_TEST_TYPE_SELF_JITTER		23
> +#define MIP_TEST_TYPE_HSELF_CP			24
> +#define MIP_TEST_TYPE_HSELF_JITTER		25
> +#define MIP_TEST_TYPE_HSELF_DIFF_HOR	26
> +#define MIP_TEST_TYPE_HSELF_DIFF_VER	27
> +
> +#define MIP_IMG_TYPE_NONE					0
> +#define MIP_IMG_TYPE_INTENSITY			1
> +#define MIP_IMG_TYPE_RAWDATA				2
> +#define MIP_IMG_TYPE_GESTURE				5
> +#define MIP_IMG_TYPE_HSELF_RAWDATA		6
> +#define MIP_IMG_TYPE_HSELF_INTENSITY	7
> +
> +#define MIP_LOG_MODE_NONE				0
> +#define MIP_LOG_MODE_TRIG				1
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
> +
> +/* Select a chip model */
> +#define CHIP_MODEL CHIP_NONE
> +
> +/* Chip model info */
> +#if CHIP_MODEL == CHIP_NONE
> +#define CHIP_NAME		"MIP4"
> +#define FW_CHIP_CODE	""
> +#endif
> +#if CHIP_MODEL == CHIP_MMS427
> +#define CHIP_NAME		"MMS427"
> +#define FW_CHIP_CODE	"M4H2"
> +#endif
> +#if CHIP_MODEL == CHIP_MMS438
> +#define CHIP_NAME		"MMS438"
> +#define FW_CHIP_CODE	"M4H0"
> +#endif
> +#if CHIP_MODEL == CHIP_MMS449
> +#define CHIP_NAME		"MMS449"
> +#define FW_CHIP_CODE	"M4HP"
> +#endif
> +#if CHIP_MODEL == CHIP_MMS458
> +#define CHIP_NAME		"MMS458"
> +#define FW_CHIP_CODE	"M4HP"
> +#endif
> +#if CHIP_MODEL == CHIP_MMS500
> +#define CHIP_NAME		"MMS500"
> +#define FW_CHIP_CODE	"M5H0"
> +#endif
> +#if CHIP_MODEL == CHIP_MCS8040L
> +#define CHIP_NAME		"MCS8040L"
> +#define FW_CHIP_CODE	"M8TL"
> +#endif
> +#if CHIP_MODEL == CHIP_MIT200
> +#define CHIP_NAME		"MIT200"
> +#define FW_CHIP_CODE	"T2H0"
> +#endif
> +#if CHIP_MODEL == CHIP_MIT300
> +#define CHIP_NAME		"MIT300"
> +#define FW_CHIP_CODE	"T3H0"
> +#endif
> +#if CHIP_MODEL == CHIP_MIT400
> +#define CHIP_NAME		"MIT400"
> +#define FW_CHIP_CODE	"T4H0"
> +#endif
> +#if CHIP_MODEL == CHIP_MFS10
> +#define CHIP_NAME		"MFS10"
> +#define FW_CHIP_CODE	"MF10"
> +#endif

This should be runtime configurable, not compile time.

> +
> +/* Config driver */
> +#define MIP_USE_INPUT_OPEN_CLOSE		0	/* 0 (default) or 1 */

Why would we not use open/close?

> +#define MIP_INPUT_REPORT_TYPE		1	/* 0 or 1 (default) */
> +#define MIP_AUTOSET_RESOLUTION		1	/* 0 or 1 (default) */
> +#define MIP_AUTOSET_EVENT_FORMAT		1	/* 0 or 1 (default) */
> +#define I2C_RETRY_COUNT				3	/* 2~ */
> +#define RESET_ON_I2C_ERROR			1	/* 0 or 1 (default) */
> +#define RESET_ON_EVENT_ERROR			0	/* 0 (default) or 1 */
> +#define ESD_COUNT_FOR_DISABLE		7	/* 7~ */
> +
> +/* Driver features */
> +
> +/* Module features */
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
> +#define MIP_USE_AUTO_FW_UPDATE	0	/* 0 (default) or 1 */

Why would we want this configurable?

> +#define MIP_FW_MAX_SECT_NUM		4
> +#define MIP_FW_UPDATE_DEBUG		0	/* 0 (default) or 1 */
> +#define MIP_FW_UPDATE_SECTION	0	/* 0 (default) or 1 */
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
> +
> +/*
> +* Firmware file location
> +*/
> +enum fw_bin_source {
> +	fw_bin_source_kernel = 1,
> +	fw_bin_source_external = 2,
> +};
> +
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
> +	int gpio_intr;
> +	int gpio_ce;
> +	int gpio_vd33_en;
> +	struct regulator *regulator_vd33;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state	*pins_enable;
> +	struct pinctrl_state	*pins_disable;
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
> +	u8 *print_buf;
> +	u8 *debug_buf;
> +	int *image_buf;
> +	bool test_busy;

Not used?

> +	bool cmd_busy;


Not used?

> +	bool dev_busy;

Same here?

> +	struct cdev cdev;
> +	u8 *dev_fs_buf;
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
> +	struct i2c_adapter *adapter = to_i2c_adapter(info->client->dev.parent);
> +
> +	i2c_lock_adapter(adapter);

Why do we need to lock entire bus segment for this?

> +
> +	mip_power_off(info);
> +	mip_power_on(info);
> +
> +	i2c_unlock_adapter(adapter);
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
> +			goto DONE;

Please do not use all CAPS for labels.

> +		else if (res < 0)
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_transfer - errno[%d]\n",
> +				__func__, res);
> +		else if (res != ARRAY_SIZE(msg))

Given condition above (res == ARRAY_SIZE(msg)) if we get here this
condition will always evaluate as true.

> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_transfer - size[%lu] result[%d]\n",
> +				__func__, ARRAY_SIZE(msg), res);
> +		else

and this branch will never be taken.

> +			dev_err(&info->client->dev,
> +				"%s [ERROR] unknown error [%d]\n",
> +				__func__, res);
> +	}
> +
> +	goto ERROR_REBOOT;
> +
> +ERROR_REBOOT:
> +#if RESET_ON_I2C_ERROR
> +	mip_reboot(info);
> +#endif
> +	return 1;
> +
> +DONE:
> +	return 0;
> +}
> +
> +/*
> +* I2C Write
> +*/
> +static int mip_i2c_write(struct mip_ts_info *info, char *write_buf,
> +	unsigned int write_len)
> +{
> +	int retry = I2C_RETRY_COUNT;
> +	int res;
> +
> +	while (retry--) {
> +		res = i2c_master_send(info->client, write_buf, write_len);
> +
> +		if (res == write_len)
> +			goto DONE;
> +		else if (res < 0)
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] i2c_master_send - errno [%d]\n",
> +				__func__, res);
> +		else if (res != write_len)

Same comment as in read.

> +			dev_err(&info->client->dev,
> +				"%s [ERROR] length mismatch - write[%d] result[%d]\n",
> +				__func__, write_len, res);
> +		else
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] unknown error [%d]\n",
> +				__func__, res);
> +	}
> +
> +	goto ERROR_REBOOT;
> +
> +ERROR_REBOOT:
> +#if RESET_ON_I2C_ERROR
> +	mip_reboot(info);
> +#endif
> +	return 1;
> +
> +DONE:
> +	return 0;
> +}
> +
> +/*****************************************************************
> + * Platform dependent
> + *****************************************************************/
> +
> +/*
> +* Turn off power supply
> +*/
> +static int mip_power_off(struct mip_ts_info *info)
> +{
> +	/* Control CE pin */
> +	/* gpio_direction_output(info->gpio_ce, 0); */
> +
> +	/* Control VD33_EN */
> +	/* gpio_direction_output(info->gpio_vd33_en, 0); */

Why is this all commented out?

> +
> +	return 0;
> +}
> +
> +/*
> +* Turn on power supply
> +*/
> +static int mip_power_on(struct mip_ts_info *info)
> +{
> +	/* Control VD33_EN */
> +	/* gpio_direction_output(info->gpio_vd33_en, 1); */
> +
> +	/* Control CE pin */
> +	/* gpio_direction_output(info->gpio_ce, 1); */
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
> +
> +		input_report_key(info->input_dev, BTN_TOUCH, 0);
> +
> +		info->touch_state[i] = 0;
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
> +	int finger_id = 0;
> +	int finger_cnt = 0;
> +
> +	for (i = 0; i < sz; i += info->event_size) {
> +		u8 *packet = &buf[i];
> +
> +		/* Event format & type */
> +		if ((info->event_format == 0) || (info->event_format == 1)) {
> +			type = (packet[0] & 0x40) >> 6;
> +		} else if (info->event_format == 3) {
> +			type = (packet[0] & 0xF0) >> 4;
> +		} else {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] Unknown event format[%d]\n",
> +				__func__, info->event_format);
> +			goto ERROR;
> +		}
> +		dev_dbg(&info->client->dev, "%s - Type[%d]\n",
> +			__func__, type);
> +
> +		/* Report input event */
> +		if (type == MIP_EVENT_INPUT_TYPE_KEY) {

This whole function could benefit from using "switch" statement.

> +			/* Key event */
> +			if ((info->event_format == 0) ||
> +				(info->event_format == 1)) {
> +				id = packet[0] & 0x0F;
> +				state = (packet[0] & 0x80) >> 7;
> +			} else if (info->event_format == 3) {
> +				id = packet[0] & 0x0F;
> +				state = (packet[1] & 0x01);
> +			} else {
> +				dev_err(&info->client->dev,
> +					"%s [ERROR] Unknown event format[%d]\n",
> +					__func__, info->event_format);
> +				goto ERROR;
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
> +		} else if (type == MIP_EVENT_INPUT_TYPE_SCREEN) {
> +			/* Screen event */
> +			if (info->event_format == 0) {
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
> +			} else if (info->event_format == 1) {
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

It looks like you can collapse these 2 branches with touch
major/minor additionally filled when event format is 1.

> +			} else if (info->event_format == 3) {
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
> +			} else {
> +				dev_err(&info->client->dev,
> +					"%s [ERROR] Unknown event format[%d]\n",
> +					__func__, info->event_format);
> +				goto ERROR;
> +			}
> +
> +			/* Report screen event */
> +			if (state == 1) {
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
> +				info->touch_state[id] = 1;
> +
> +				/* First press event */
> +				finger_cnt = 0;
> +				for (finger_id = 0; finger_id < MAX_FINGER_NUM;
> +					finger_id++) {
> +					if (info->touch_state[finger_id] != 0) {
> +						finger_cnt++;
> +						break;
> +					}
> +				}
> +				if (finger_cnt == 1) {
> +					input_report_key(info->input_dev,
> +						BTN_TOUCH, 1);
> +					dev_dbg(&info->client->dev,
> +						"%s - Screen : Press\n",
> +						__func__);
> +				}
> +
> +				dev_dbg(&info->client->dev,
> +					"%s - Screen : ID[%d] X[%d] Y[%d] Z[%d]\n",
> +					__func__, id, x, y, pressure);
> +			} else if (state == 0) {
> +				/* Release event */
> +				input_mt_slot(info->input_dev, id);
> +				input_mt_report_slot_state(info->input_dev,
> +					MT_TOOL_FINGER, 0);
> +
> +				info->touch_state[id] = 0;
> +
> +				dev_dbg(&info->client->dev,
> +					"%s - Screen : ID[%d] Release\n",
> +					__func__, id);
> +
> +				/* Final release event */
> +				finger_cnt = 0;
> +				for (finger_id = 0; finger_id < MAX_FINGER_NUM;
> +					finger_id++) {
> +					if (info->touch_state[finger_id] != 0) {
> +						finger_cnt++;
> +						break;
> +					}
> +				}
> +				if (finger_cnt == 0) {
> +					input_report_key(info->input_dev,
> +						BTN_TOUCH, 0);
> +					dev_dbg(&info->client->dev,
> +						"%s - Screen : Release\n",
> +						__func__);
> +				}
> +			} else {
> +				dev_err(&info->client->dev,
> +					"%s [ERROR] Unknown event state[%d]\n",
> +					__func__, state);
> +				goto ERROR;
> +			}
> +		} else if (type == MIP_EVENT_INPUT_TYPE_PROXIMITY) {
> +			/* Proximity event */
> +			state = (packet[1] & 0x01);
> +			z = packet[5];
> +			dev_dbg(&info->client->dev,
> +				"%s - Proximity : State[%d] Value[%d]\n",
> +				__func__, state, z);

Why not reporting it as ABS_DISTANCE?

> +		} else {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] Unknown event type[%d]\n",
> +				__func__, type);
> +			goto ERROR;
> +		}
> +	}
> +
> +	goto EXIT;
> +
> +ERROR:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +EXIT:
> +	input_sync(info->input_dev);
> +}
> +
> +#if MIP_USE_DEVICETREE
> +/*
> +* Parse device tree
> +*/
> +static int mip_parse_devicetree(struct device *dev, struct mip_ts_info *info)
> +{
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	/* Get GPIO */
> +	ret = of_get_named_gpio(np, MIP_DEVICE_NAME",irq-gpio", 0);
> +	if (!gpio_is_valid(ret)) {
> +		dev_err(dev,
> +			"%s [ERROR] of_get_named_gpio : irq-gpio\n",
> +			__func__);
> +		goto ERROR;
> +	} else{
> +		info->gpio_intr = ret;
> +	}
> +
> +	/* Request GPIO */
> +	ret = gpio_request(info->gpio_intr, "irq-gpio");
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"%s [ERROR] gpio_request : irq-gpio\n",
> +			__func__);
> +		goto ERROR;
> +	}
> +	gpio_direction_input(info->gpio_intr);
> +
> +	/* Set IRQ */
> +	info->client->irq = gpio_to_irq(info->gpio_intr);
> +	dev_dbg(dev, "%s - gpio_to_irq : irq[%d]\n",
> +		__func__, info->client->irq);


Why do you have it all here? I2C core will take care of setting up
interrupt in client structure and the rest of platform code is
responsible for setting up gpio as interrupt.

> +
> +	return 0;
> +
> +ERROR:
> +	dev_err(dev, "%s [ERROR]\n", __func__);
> +	return 1;
> +}
> +#endif
> +
> +/*
> +* Config input device
> +*/
> +static void mip_config_input(struct mip_ts_info *info)
> +{
> +	struct input_dev *input_dev = info->input_dev;
> +
> +	set_bit(EV_SYN, input_dev->evbit);
> +	set_bit(EV_ABS, input_dev->evbit);
> +	set_bit(EV_KEY, input_dev->evbit);
> +	set_bit(BTN_TOUCH, input_dev->keybit);
> +
> +	/* Screen */
> +	set_bit(INPUT_PROP_DIRECT, input_dev->propbit);

The 5 set_bit()s above are not needed since you are calling
input_mt_init_slots() with appropriate flag.

> +
> +	input_mt_init_slots(input_dev, MAX_FINGER_NUM, INPUT_MT_DIRECT);

But you want to call it after you set up your axes.

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
> +	/* Key */
> +	set_bit(KEY_BACK, input_dev->keybit);
> +	set_bit(KEY_MENU, input_dev->keybit);
> +
> +	info->key_code[0] = KEY_BACK;
> +	info->key_code[1] = KEY_MENU;

Isn't this platform-specific?

> +}
> +
> +/*****************************************************************
> + * Firmware update
> + *****************************************************************/
> +
> +/* Firmware Info */
> +#define BL_PAGE_SIZE		512		/* 512 */
> +#define BL_PACKET_SIZE	512		/* 512, 256, 128, 64, 32, 16, ... */
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
> +			goto ERROR;
> +		}
> +
> +		if (result == MIP_BOOT_STATUS_DONE) {

"switch"

> +			dev_dbg(&info->client->dev, "%s - Done\n", __func__);
> +			ret = 0;
> +			break;
> +		} else if (result == MIP_BOOT_STATUS_BUSY) {
> +			dev_dbg(&info->client->dev, "%s - Busy\n", __func__);
> +			ret = -1;

-EBUSY

> +			usleep_range(1000, 2000);
> +		} else if (result == MIP_BOOT_STATUS_ERROR) {
> +			dev_dbg(&info->client->dev, "%s - Error\n", __func__);
> +			ret = -1;

-EIO

> +			goto ERROR;
> +		} else {
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] wrong value [0x%02X]\n",
> +				__func__, result);
> +			ret = -1;

-EINVAL

> +			usleep_range(1000, 2000);
> +		}
> +	} while (--cnt);
> +
> +	if (!cnt) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] count overflow - cnt[%d] status[0x%02X]\n",
> +			__func__, cnt, result);
> +		goto ERROR;
> +	}
> +
> +	return ret;
> +
> +ERROR:
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
> +			goto ERROR;
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
> +			goto ERROR;
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
> +		goto ERROR;
> +	}
> +
> +	return ret;
> +
> +ERROR:
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
> +		goto ERROR;
> +	}
> +
> +	*buf_addr = (u16)((read_buf[1] << 8) | read_buf[0]);
> +	dev_dbg(&info->client->dev,
> +		"%s - Buf Addr [0x%04X]\n", __func__, *buf_addr);
> +
> +	return ret;
> +
> +ERROR:
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
> +		goto ERROR;
> +	}
> +
> +	/* Addr */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_TARGET_ADDR;
> +	write_buf[2] = (u8)(offset & 0xFF);
> +	write_buf[3] = (u8)((offset >> 8) & 0xFF);
> +	write_buf[4] = (u8)((offset >> 16) & 0xFF);
> +	write_buf[5] = (u8)((offset >> 24) & 0xFF);

put_unaligned_le32()

> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto ERROR;
> +	}
> +	dev_dbg(&info->client->dev,
> +		"%s - Addr [0x%06X]\n", __func__, offset);
> +
> +	/* Size */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_SIZE;
> +	write_buf[2] = (u8)(length & 0xFF);
> +	write_buf[3] = (u8)((length >> 8) & 0xFF);
> +	write_buf[4] = (u8)((length >> 16) & 0xFF);
> +	write_buf[5] = (u8)((length >> 24) & 0xFF);
> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto ERROR;
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
> +			goto ERROR;
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
> +		goto ERROR;
> +	}
> +
> +	/* Status */
> +	if (mip_bl_read_status(info) != 0)
> +		goto ERROR;
> +
> +	return 0;
> +
> +ERROR:
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
> +	write_buf[2] = (u8)(offset & 0xFF);
> +	write_buf[3] = (u8)((offset >> 8) & 0xFF);
> +	write_buf[4] = (u8)((offset >> 16) & 0xFF);
> +	write_buf[5] = (u8)((offset >> 24) & 0xFF);
> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto ERROR;
> +	}
> +	dev_dbg(&info->client->dev, "%s - Addr [0x%06X]\n",
> +		__func__, offset);
> +
> +	/* Size */
> +	write_buf[0] = MIP_R0_BOOT;
> +	write_buf[1] = MIP_R1_BOOT_SIZE;
> +	write_buf[2] = (u8)(length & 0xFF);
> +	write_buf[3] = (u8)((length >> 8) & 0xFF);
> +	write_buf[4] = (u8)((length >> 16) & 0xFF);
> +	write_buf[5] = (u8)((length >> 24) & 0xFF);
> +	if (i2c_master_send(info->client, write_buf, 6) != 6) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] i2c_master_send\n", __func__);
> +		goto ERROR;
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
> +		goto ERROR;
> +	}
> +
> +	/* Status */
> +	if (mip_bl_read_status(info) != 0)
> +		goto ERROR;
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
> +			goto ERROR;
> +		}
> +		memcpy(&data[buf_offset], read_buf, BL_PACKET_SIZE);
> +		dev_dbg(&info->client->dev,
> +			"%s - PacketSize[%d] BufOffset [0x%04X]\n",
> +			__func__, BL_PACKET_SIZE, buf_offset);
> +	}
> +
> +	return 0;
> +
> +ERROR:
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
> +		goto ERROR;
> +
> +	return 0;
> +
> +ERROR:
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
> +		goto ERROR;
> +
> +	return 0;
> +
> +ERROR:
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
> +		goto ERROR_FILE;
> +	}
> +
> +	/* Check bin format */
> +	if (memcmp(&fw_data[fw_size - tail_size], tail_mark, 4)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] wrong tail mark\n", __func__);
> +		ret = fw_err_file_type;
> +		goto ERROR_FILE;
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
> +	/* Check chip code */
> +	if (memcmp(bin_info->chip_name, FW_CHIP_CODE, 4)) {
> +		dev_info(&client->dev,
> +			"F/W file is not for %s\n", CHIP_NAME);
> +		ret = fw_err_file_type;
> +		goto ERROR_FILE;
> +	}
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
> +				goto UPTODATE;
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
> +		goto ERROR_UPDATE;
> +	}
> +
> +	/* Read info */
> +	if (mip_bl_read_info(info, &buf_addr)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_bl_read_info\n", __func__);
> +		ret = fw_err_download;
> +		goto ERROR_UPDATE;
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
> +			goto ERROR_UPDATE;
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
> +			goto ERROR_UPDATE;
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
> +			goto ERROR_UPDATE;
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
> +		goto ERROR_UPDATE;
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
> +		goto ERROR_UPDATE;
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
> +			goto ERROR_UPDATE;
> +		}
> +	}
> +
> +	kfree(bin_data);
> +
> +UPTODATE:
> +	goto EXIT;
> +
> +ERROR_UPDATE:
> +	kfree(bin_data);
> +
> +	/* Reset chip */
> +	mip_reboot(info);
> +
> +ERROR_FILE:
> +	dev_err(&client->dev, "%s [ERROR]\n", __func__);
> +
> +EXIT:
> +	return ret;
> +}
> +
> +/*****************************************************************
> + * Development
> + *****************************************************************/
> +
> +/*
> +* Dev node output to user
> +*/
> +static ssize_t mip_dev_fs_read(struct file *fp, char *rbuf,
> +	size_t cnt, loff_t *fpos)
> +{
> +	struct mip_ts_info *info = fp->private_data;
> +	int ret = 0;
> +
> +	ret = copy_to_user(rbuf, info->dev_fs_buf, cnt);
> +
> +	return ret;
> +}
> +
> +/*
> +* Dev node input from user
> +*/
> +static ssize_t mip_dev_fs_write(struct file *fp, const char *wbuf,
> +	size_t cnt, loff_t *fpos)
> +{
> +	struct mip_ts_info *info = fp->private_data;
> +	u8 *buf;
> +	int ret = 0;
> +	int cmd = 0;
> +
> +	buf = kzalloc(cnt + 1, GFP_KERNEL);
> +
> +	if ((buf == NULL) || copy_from_user(buf, wbuf, cnt)) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] copy_from_user\n", __func__);
> +		ret = -EIO;
> +		goto EXIT;
> +	}
> +
> +	cmd = buf[cnt - 1];
> +
> +	if (cmd == 1) {
> +		if (mip_i2c_read
> +			(info, buf, (cnt - 2), info->dev_fs_buf, buf[cnt - 2]))
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] mip_i2c_read\n", __func__);
> +	} else if (cmd == 2) {
> +		if (mip_i2c_write(info, buf, (cnt - 1)))
> +			dev_err(&info->client->dev,
> +				"%s [ERROR] mip_i2c_write\n", __func__);
> +	} else {
> +		goto EXIT;
> +	}
> +
> +EXIT:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +/*
> +* Open dev node
> +*/
> +static int mip_dev_fs_open(struct inode *node, struct file *fp)
> +{
> +	struct mip_ts_info *info = container_of(node->i_cdev,
> +		struct mip_ts_info, cdev);
> +
> +	fp->private_data = info;
> +
> +	info->dev_fs_buf = kzalloc(1024 * 4, GFP_KERNEL);
> +
> +	return 0;
> +}
> +
> +/*
> +* Close dev node
> +*/
> +static int mip_dev_fs_release(struct inode *node, struct file *fp)
> +{
> +	struct mip_ts_info *info = fp->private_data;
> +
> +	kfree(info->dev_fs_buf);
> +
> +	return 0;
> +}
> +
> +/*
> +* Dev node info
> +*/
> +static const struct file_operations mip_dev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = mip_dev_fs_open,
> +	.release = mip_dev_fs_release,
> +	.read = mip_dev_fs_read,
> +	.write = mip_dev_fs_write,
> +};
> +
> +/*
> +* Create dev node
> +*/
> +static int mip_dev_create(struct mip_ts_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	int ret = 0;
> +
> +	if (alloc_chrdev_region(&info->mip_dev, 0, 1, MIP_DEVICE_NAME)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] alloc_chrdev_region\n", __func__);
> +		ret = -ENOMEM;
> +		goto ERROR;
> +	}
> +
> +	cdev_init(&info->cdev, &mip_dev_fops);
> +	info->cdev.owner = THIS_MODULE;
> +
> +	if (cdev_add(&info->cdev, info->mip_dev, 1)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] cdev_add\n", __func__);
> +		ret = -EIO;
> +		goto ERROR;
> +	}
> +
> +	return 0;
> +
> +ERROR:
> +	dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> +	return 0;
> +}

Please remove custom device interface. If this is purely for
development of the board to check if device responds you can access it
form userspace (via i2c dev interface).

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
> +	memset(info->print_buf, 0, PAGE_SIZE);
> +
> +	if (mip_get_fw_version(info, rbuf)) {
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] mip_get_fw_version\n", __func__);
> +
> +		sprintf(data, "F/W Version : ERROR\n");
> +		goto ERROR;
> +	}
> +
> +	sprintf(data,
> +		"F/W Version : %02X.%02X/%02X.%02X/%02X.%02X/%02X.%02X\n",
> +		rbuf[0], rbuf[1], rbuf[2], rbuf[3],
> +		rbuf[4], rbuf[5], rbuf[6], rbuf[7]);
> +
> +ERROR:
> +	strcat(info->print_buf, data);
> +
> +	ret = snprintf(buf, PAGE_SIZE, "%s\n", info->print_buf);
> +	return ret;
> +}
> +
> +/*
> +* Sysfs functions
> +*/
> +static DEVICE_ATTR(fw_version, 0660, mip_sys_fw_version, NULL);
> +
> +/*
> +* Sysfs attr list info
> +*/
> +static struct attribute *mip_sys_attr[] = {
> +	&dev_attr_fw_version.attr,
> +	NULL,
> +};
> +
> +/*
> +* Sysfs attr group info
> +*/
> +static const struct attribute_group mip_sys_attr_group = {
> +	.attrs = mip_sys_attr,
> +};
> +
> +/*
> +* Create sysfs test functions
> +*/
> +static int mip_sysfs_create(struct mip_ts_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +
> +	if (sysfs_create_group(&client->dev.kobj, &mip_sys_attr_group)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] sysfs_create_group\n", __func__);
> +		return -EAGAIN;
> +	}
> +
> +	info->print_buf = kzalloc(sizeof(u8) * PAGE_SIZE, GFP_KERNEL);

I do not believe you need to allocate whole page for this. In fact, in
most places you use print_buf you already have buffer of sufficient size
you can use directly.

> +	info->debug_buf = kzalloc(sizeof(u8) * PAGE_SIZE, GFP_KERNEL);

I do not see debug_buf being used.

> +	info->image_buf = kzalloc(sizeof(int) * PAGE_SIZE, GFP_KERNEL);

I do not see it being used either.

> +
> +	return 0;
> +}
> +
> +/*
> +* Remove sysfs test functions
> +*/
> +static void mip_sysfs_remove(struct mip_ts_info *info)
> +{
> +	sysfs_remove_group(&info->client->dev.kobj, &mip_sys_attr_group);
> +
> +	kfree(info->print_buf);
> +	kfree(info->debug_buf);
> +	kfree(info->image_buf);
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
> +		goto EXIT;
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
> +EXIT:
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
> +		goto EXIT;
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
> +EXIT:
> +	dev_info(&info->client->dev, MIP_DEVICE_NAME" - Disabled\n");
> +
> +	return 0;
> +}
> +
> +#if MIP_USE_INPUT_OPEN_CLOSE
> +/*
> +* Open input device
> +*/
> +static int mip_input_open(struct input_dev *dev)
> +{
> +	struct mip_ts_info *info = input_get_drvdata(dev);
> +
> +	if (info->init == true)
> +		info->init = false;

No, please shut off the controller in probe() and then power it up here
unconditionally.

> +	else
> +		mip_enable(info);
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
> +#endif
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
> +		goto ERROR;
> +	};
> +
> +	for (i = 0; i < MIP_FW_MAX_SECT_NUM; i++) {
> +		ver_buf[0 + i * 2] = rbuf[1 + i * 2];
> +		ver_buf[1 + i * 2] = rbuf[0 + i * 2];
> +	}
> +
> +	return 0;
> +
> +ERROR:
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
> +		goto ERROR;
> +
> +	for (i = 0; i < MIP_FW_MAX_SECT_NUM; i++)
> +		ver_buf_u16[i] = (rbuf[0 + i * 2] << 8) | rbuf[1 + i * 2];
> +
> +	return 0;
> +
> +ERROR:
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
> +		goto ERROR;
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
> +		goto EXIT;
> +	}
> +
> +	/* Read packet data */
> +	wbuf[0] = MIP_R0_EVENT;
> +	wbuf[1] = MIP_R1_EVENT_PACKET_DATA;
> +	if (mip_i2c_read(info, wbuf, 2, rbuf, size)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] Read packet data\n",
> +			__func__);
> +		goto ERROR;
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
> +EXIT:
> +	return IRQ_HANDLED;
> +
> +ERROR:
> +	if (RESET_ON_EVENT_ERROR) {
> +		dev_info(&client->dev,
> +			"%s - Reset on error\n", __func__);
> +
> +		mip_disable(info);

If I remember correctly you disable IRQ in mip_disable(). This will not
work from interrupt handler. If you really want to reset on error (by
the way, most drivers do not) you are likely have to do this from a
workqueue.

> +		mip_clear_input(info);
> +		mip_enable(info);
> +	}
> +
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
> +#if MIP_AUTOSET_RESOLUTION

Why would we not autoset it? 

> +	/* Set resolution by firmware info */
> +	info->max_x = (rbuf[0]) | (rbuf[1] << 8);

get_unaligned_le16()?

> +	info->max_y = (rbuf[2]) | (rbuf[3] << 8);

get_unaligned_le16()?


> +#else
> +	info->max_x = 1920;
> +	info->max_y = 1080;
> +#endif
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

What is node?

> +
> +	/* Key info */
> +	if (info->node_key > 0) {
> +		/* Enable touchkey */
> +		info->key_enable = true;
> +		info->key_num = info->node_key;
> +	}
> +
> +	/* Protocol */
> +#if MIP_AUTOSET_EVENT_FORMAT

Again, why would we not want to do this?

> +	wbuf[0] = MIP_R0_EVENT;
> +	wbuf[1] = MIP_R1_EVENT_SUPPORTED_FUNC;
> +	mip_i2c_read(info, wbuf, 2, rbuf, 7);
> +	info->event_format = (rbuf[4]) | (rbuf[5] << 8);
> +	info->event_size = rbuf[6];
> +#else
> +	info->event_format = 0;
> +	info->event_size = 6;
> +#endif
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
> +		dev_err(&info->client->dev,
> +			"%s [ERROR] request_firmware\n", __func__);
> +		goto ERROR;
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
> +		goto ERROR;
> +
> +	return ret;
> +
> +ERROR:
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
> +	memset(info->print_buf, 0, PAGE_SIZE);
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
> +	strcat(info->print_buf, data);
> +	result = snprintf(buf, PAGE_SIZE, "%s\n", info->print_buf);
> +	return result;
> +}
> +static DEVICE_ATTR(fw_update, 0660, mip_sys_fw_update, NULL);
> +
> +/*
> +* Sysfs attr info
> +*/
> +static struct attribute *mip_attrs[] = {
> +	&dev_attr_fw_update.attr,
> +	NULL,
> +};
> +
> +/*
> +* Sysfs attr group info
> +*/
> +static const struct attribute_group mip_attr_group = {
> +	.attrs = mip_attrs,
> +};

Why do you have 2 separate unnamed attribute groups?

> +
> +/*
> +* Initialize driver
> +*/
> +static int mip_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct mip_ts_info *info;
> +	struct input_dev *input_dev;
> +#if MIP_USE_ACPI
> +	struct acpi_device *adev;
> +	acpi_status a_status;
> +#endif
> +	int ret = 0;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] i2c_check_functionality\n",
> +			__func__);
> +		ret = -EIO;
> +		goto ERROR_I2C;
> +	}
> +
> +	/* Init info data */
> +	info = kzalloc(sizeof(struct mip_ts_info), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!info || !input_dev) {
> +		dev_err(&client->dev,
> +			"%s [ERROR]\n", __func__);
> +		ret = -ENOMEM;
> +		goto ERROR_INFO;
> +	}
> +
> +	info->client = client;
> +	info->input_dev = input_dev;
> +	info->irq = -1;
> +	info->init = true;
> +	info->power = -1;
> +	info->irq_enabled = false;
> +
> +	mutex_init(&info->lock);
> +
> +	/* Set platform data */
> +#if MIP_USE_ACPI
> +	a_status = acpi_bus_get_device(ACPI_HANDLE(&client->dev), &adev);
> +	if (ACPI_SUCCESS(a_status)) {
> +		if (strncmp(dev_name(&adev->dev), ACPI_ID, 8) != 0) {
> +			dev_err(&client->dev,
> +				"%s [ERROR] ACPI_ID mismatch [%s]\n",
> +				__func__, dev_name(&adev->dev));
> +			goto ERROR_INFO;
> +		}
> +	}
> +#else
> +	if (client->dev.of_node) {
> +		ret = mip_parse_devicetree(&client->dev, info);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"%s [ERROR] mip_parse_dt\n", __func__);
> +			goto ERROR_INFO;
> +		}
> +	} else {
> +		info->pdata = client->dev.platform_data;
> +		if (info->pdata == NULL) {
> +			dev_err(&client->dev,
> +				"%s [ERROR] dev.platform_data is null\n",
> +				__func__);
> +			ret = -EINVAL;
> +			goto ERROR_INFO;
> +		} else {
> +			info->gpio_intr = info->pdata->gpio_intr;
> +			info->gpio_ce = info->pdata->gpio_ce;
> +			info->gpio_vd33_en = info->pdata->gpio_vd33_en;
> +		}
> +	}
> +#endif

Please used devm_gpiod_* interface, then you do not need separate code
for ACPI, OF and platform data, at least where GPIOs are concerned.

> +
> +	/* Set input dev */
> +	info->input_dev->name = "MELFAS " CHIP_NAME " Touchscreen";
> +	info->input_dev->phys = info->phys;
> +	info->input_dev->id.bustype = BUS_I2C;
> +	info->input_dev->dev.parent = &client->dev;
> +
> +#if MIP_USE_INPUT_OPEN_CLOSE
> +	info->input_dev->open = mip_input_open;
> +	info->input_dev->close = mip_input_close;
> +#endif
> +
> +	/* Set info data */
> +	input_set_drvdata(input_dev, info);
> +	i2c_set_clientdata(client, info);
> +
> +	/* Power on */
> +	mip_power_on(info);
> +
> +	/* Firmware update */
> +#if MIP_USE_AUTO_FW_UPDATE
> +	ret = mip_fw_update_from_kernel(info);
> +	if (ret)
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_fw_update_from_kernel\n",
> +			__func__);
> +#endif
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
> +		goto ERROR_DEVICE;
> +	}
> +
> +	/* Set interrupt handler */
> +	ret = request_threaded_irq(client->irq, NULL, mip_interrupt,
> +		IRQF_TRIGGER_LOW | IRQF_ONESHOT, MIP_DEVICE_NAME, info);

Let's have platform set up interrupt flags for us (level or edge
trigger), so just have IRQF_ONESHOT here.

> +
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s [ERROR] request_threaded_irq\n", __func__);
> +		goto ERROR_IRQ;
> +	}
> +
> +	disable_irq(client->irq);
> +	info->irq = client->irq;
> +
> +	/* Enable device */
> +	mip_enable(info);
> +
> +	/* Create dev */
> +	if (mip_dev_create(info))
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_dev_create\n", __func__);
> +
> +	info->class = class_create(THIS_MODULE, MIP_DEVICE_NAME);
> +	device_create(info->class, NULL, info->mip_dev, NULL, MIP_DEVICE_NAME);

Why do we need a driver-private class?

> +
> +	/* Create sysfs */
> +	if (mip_sysfs_create(info))
> +		dev_err(&client->dev,
> +			"%s [ERROR] mip_sysfs_create\n", __func__);
> +
> +	if (sysfs_create_group(&client->dev.kobj, &mip_attr_group))
> +		dev_err(&client->dev,
> +			"%s [ERROR] sysfs_create_group\n", __func__);
> +
> +	dev_info(&client->dev,
> +		"MELFAS MIP4 Touchscreen is initialized successfully.\n");

We already have message from input core, we do not need this one.

> +	return 0;
> +
> +ERROR_IRQ:
> +	free_irq(info->irq, info);
> +ERROR_DEVICE:
> +	input_unregister_device(info->input_dev);
> +ERROR_INFO:
> +	kfree(info);
> +ERROR_I2C:
> +	dev_dbg(&client->dev, "%s [ERROR]\n", __func__);
> +	dev_err(&client->dev,
> +		"MELFAS MIP4 Touchscreen initialization failed.\n");

Driver core will print message when probe fails, no need for this one.

> +	return ret;
> +}
> +
> +/*
> +* Remove driver
> +*/
> +static int mip_remove(struct i2c_client *client)
> +{
> +	struct mip_ts_info *info = i2c_get_clientdata(client);
> +
> +	if (info->irq >= 0)
> +		free_irq(info->irq, info);

Why do we need this check? probe will fail without valid irq.

> +
> +	mip_sysfs_remove(info);
> +	sysfs_remove_group(&info->client->dev.kobj, &mip_attr_group);
> +	sysfs_remove_link(NULL, MIP_DEVICE_NAME);

What creates this link and why?

> +	kfree(info->print_buf);
> +
> +	device_destroy(info->class, info->mip_dev);
> +	class_destroy(info->class);
> +
> +	input_unregister_device(info->input_dev);
> +
> +	kfree(info);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM

Please drop #ifdef

> +/*
> +* Device suspend event handler
> +*/
> +int mip_suspend(struct device *dev)

static int __maybe_unused mip_suspend()

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip_ts_info *info = i2c_get_clientdata(client);
> +
> +	mip_disable(info);
> +
> +	return 0;
> +}
> +
> +/*
> +* Device resume event handler
> +*/
> +int mip_resume(struct device *dev)

static int __maybe_unused mip_resume()

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip_ts_info *info = i2c_get_clientdata(client);
> +

You need to check if there are users of the input device before enabling
it.

> +	mip_enable(info);
> +
> +	return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM
> +/*
> +* PM info
> +*/
> +const struct dev_pm_ops mip_pm_ops = {
> +	.suspend = mip_suspend,
> +	.resume = mip_resume,
> +};
> +#endif

use SIMPLE_DEV_PM_OPS instead.

> +
> +#if MIP_USE_DEVICETREE
> +/*
> +* Device tree match table
> +*/
> +static const struct of_device_id mip_match_table[] = {
> +	{.compatible = "melfas,"MIP_DEVICE_NAME,},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mip_match_table);
> +#endif
> +
> +#if MIP_USE_ACPI
> +static const struct acpi_device_id mip_acpi_match_table[] = {
> +	{ACPI_ID, 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, mip_acpi_match_table);
> +#endif
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
> +	.remove = mip_remove,
> +	.driver = {
> +		.name = MIP_DEVICE_NAME,
> +		.owner = THIS_MODULE,
> +#if MIP_USE_DEVICETREE
> +		.of_match_table = mip_match_table,
> +#endif

		.of_match_table = of_match_ptr(mip_match_table),

and drop ifdef.

> +#if MIP_USE_ACPI
> +		.acpi_match_table = ACPI_PTR(mip_acpi_match_table),
> +#endif

No need for this ifdef

> +#ifdef CONFIG_PM
> +		.pm = &mip_pm_ops,
> +#endif

No need for ifdef with SIMPLE_DEV_PM_OPS.

> +	},
> +};
> +
> +/*
> +* Init driver
> +*/
> +static int __init mip_init(void)
> +{
> +	return i2c_add_driver(&mip_driver);
> +}
> +
> +/*
> +* Exit driver
> +*/
> +static void __exit mip_exit(void)
> +{
> +	i2c_del_driver(&mip_driver);
> +}
> +
> +module_init(mip_init);
> +module_exit(mip_exit);

module_i2c_driver().

> +
> +MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
> +MODULE_VERSION("2016.01.08");
> +MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/input/melfas_mip4.h b/include/linux/input/melfas_mip4.h
> new file mode 100644
> index 0000000..3523e81
> --- /dev/null
> +++ b/include/linux/input/melfas_mip4.h
> @@ -0,0 +1,33 @@
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
> +	int gpio_intr;		/* Interrupt - Required */
> +	int gpio_ce;		/* Chip Enable/Reset - Optional */
> +	int gpio_vd33_en;	/* Power(VD33) control - Optional */
> +};
> +#endif
> +
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
