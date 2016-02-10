From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [V3] Input: Add MELFAS MIP4 Touchscreen driver
Date: Tue, 9 Feb 2016 20:44:44 -0800
Message-ID: <20160210044444.GA31689@dtor-ws>
References: <1454417655-2023-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35437 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbcBJEos (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 23:44:48 -0500
Received: by mail-pf0-f182.google.com with SMTP id c10so5641857pfc.2
        for <linux-input@vger.kernel.org>; Tue, 09 Feb 2016 20:44:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1454417655-2023-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Sangwion,

On Tue, Feb 02, 2016 at 09:54:15PM +0900, Sangwon Jee wrote:
> This is an input driver for MELFAS MIP4 Touchscreen devices,
> made by the original vendor, MELFAS.
>
> MIP4 means MELFAS Interface Protocol Version 4.
> MELFAS MMS400, MMS500, MCS8000, MIT200, MIT300, MIT400, MFS10 and other
> recent touchscreen devices are using MIP4 and supported by this driver.
>
> There are two MELFAS touchscreen drivers(mcs5000_ts, mms114) in the kernel.
> But those drivers are for discontinued models and not supported by MELFAS.

Please find my latest comments below, They basically document the
changes that I made to the driver in the version attached below.

Thanks!

>
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>
> ---
>  drivers/input/touchscreen/Kconfig       |   11 +
>  drivers/input/touchscreen/Makefile      |    1 +
>  drivers/input/touchscreen/melfas_mip4.c | 1972 +++++++++++++++++++++++++++++++
>  3 files changed, 1984 insertions(+)
>  create mode 100644 drivers/input/touchscreen/melfas_mip4.c
>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 53a97b3..f193049 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -491,6 +491,17 @@ config TOUCHSCREEN_MMS114
>    To compile this driver as a module, choose M here: the
>    module will be called mms114.
>  
> +config TOUCHSCREEN_MELFAS_MIP4
> + tristate "MELFAS MIP4 Touchscreen"
> + depends on I2C
> + help
> +  Say Y here if you have a MELFAS MIP4 Touchscreen device.
> +
> +  If unsure, say N.
> +
> +  To compile this driver as a module, choose M here:
> +  the module will be called melfas_mip4.
> +
>  config TOUCHSCREEN_MTOUCH
>   tristate "MicroTouch serial touchscreens"
>   select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 968ff12..4b518c7 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_LPC32XX) += lpc32xx_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MAX11801) += max11801_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MC13783) += mc13783_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MCS5000) += mcs5000_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_MELFAS_MIP4) += melfas_mip4.o
>  obj-$(CONFIG_TOUCHSCREEN_MIGOR) += migor_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_MMS114) += mms114.o
>  obj-$(CONFIG_TOUCHSCREEN_MTOUCH) += mtouch.o
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> new file mode 100644
> index 0000000..323734d
> --- /dev/null
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -0,0 +1,1972 @@
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
> +/*****************************************************************
> + * Platform
> + *****************************************************************/
> +
> +#define MIP_DEVICE_NAME "mip4_ts"
> +#define ACPI_ID "MLFS0000"
> +
> +/*****************************************************************
> + * Protocol
> + * Version : MIP 4.0 Rev 4.4
> + *****************************************************************/
> +
> +/* Address */
> +#define MIP_R0_BOOT 0x00
> +#define MIP_R1_BOOT_MODE 0x01
> +#define MIP_R1_BOOT_BUF_ADDR 0x10
> +#define MIP_R1_BOOT_STATUS 0x20
> +#define MIP_R1_BOOT_CMD 0x30
> +#define MIP_R1_BOOT_TARGET_ADDR 0x40
> +#define MIP_R1_BOOT_SIZE 0x44
> +
> +#define MIP_R0_INFO 0x01
> +#define MIP_R1_INFO_PRODUCT_NAME 0x00
> +#define MIP_R1_INFO_RESOLUTION_X 0x10
> +#define MIP_R1_INFO_RESOLUTION_Y 0x12
> +#define MIP_R1_INFO_NODE_NUM_X 0x14
> +#define MIP_R1_INFO_NODE_NUM_Y 0x15
> +#define MIP_R1_INFO_KEY_NUM 0x16
> +#define MIP_R1_INFO_VERSION_BOOT 0x20
> +#define MIP_R1_INFO_VERSION_CORE 0x22
> +#define MIP_R1_INFO_VERSION_APP 0x24
> +#define MIP_R1_INFO_VERSION_PARAM 0x26
> +#define MIP_R1_INFO_SECT_BOOT_START 0x30
> +#define MIP_R1_INFO_SECT_BOOT_END 0x31
> +#define MIP_R1_INFO_SECT_CORE_START 0x32
> +#define MIP_R1_INFO_SECT_CORE_END 0x33
> +#define MIP_R1_INFO_SECT_APP_START 0x34
> +#define MIP_R1_INFO_SECT_APP_END 0x35
> +#define MIP_R1_INFO_SECT_PARAM_START 0x36
> +#define MIP_R1_INFO_SECT_PARAM_END 0x37
> +#define MIP_R1_INFO_BUILD_DATE 0x40
> +#define MIP_R1_INFO_BUILD_TIME 0x44
> +#define MIP_R1_INFO_CHECKSUM_PRECALC 0x48
> +#define MIP_R1_INFO_CHECKSUM_REALTIME 0x4A
> +#define MIP_R1_INFO_PROTOCOL_NAME 0x50
> +#define MIP_R1_INFO_PROTOCOL_VERSION 0x58
> +#define MIP_R1_INFO_IC_ID 0x70
> +#define MIP_R1_INFO_IC_NAME 0x71
> +#define MIP_R1_INFO_IC_VENDOR_ID 0x75
> +#define MIP_R1_INFO_IC_HW_CATEGORY 0x77
> +#define MIP_R1_INFO_CONTACT_THD_SCR 0x78
> +#define MIP_R1_INFO_CONTACT_THD_KEY 0x7A
> +
> +#define MIP_R0_EVENT 0x02
> +#define MIP_R1_EVENT_SUPPORTED_FUNC 0x00
> +#define MIP_R1_EVENT_FORMAT 0x04
> +#define MIP_R1_EVENT_SIZE 0x06
> +#define MIP_R1_EVENT_PACKET_INFO 0x10
> +#define MIP_R1_EVENT_PACKET_DATA 0x11
> +
> +#define MIP_R0_CTRL 0x06
> +#define MIP_R1_CTRL_READY_STATUS 0x00
> +#define MIP_R1_CTRL_EVENT_READY 0x01
> +#define MIP_R1_CTRL_MODE 0x10
> +#define MIP_R1_CTRL_EVENT_TRIGGER_TYPE 0x11
> +#define MIP_R1_CTRL_RECALIBRATE 0x12
> +#define MIP_R1_CTRL_POWER_STATE 0x13
> +#define MIP_R1_CTRL_GESTURE_TYPE 0x14
> +#define MIP_R1_CTRL_DISABLE_ESD_ALERT 0x18
> +#define MIP_R1_CTRL_CHARGER_MODE 0x19
> +#define MIP_R1_CTRL_HIGH_SENS_MODE 0x1A
> +#define MIP_R1_CTRL_WINDOW_MODE 0x1B
> +#define MIP_R1_CTRL_PALM_REJECTION 0x1C
> +#define MIP_R1_CTRL_EDGE_CORRECTION 0x1D
> +#define MIP_R1_CTRL_ENTER_GLOVE_MODE 0x1E
> +#define MIP_R1_CTRL_I2C_ON_LPM 0x1F
> +#define MIP_R1_CTRL_GESTURE_DEBUG 0x20
> +#define MIP_R1_CTRL_PALM_EVENT 0x22
> +#define MIP_R1_CTRL_PROXIMITY_SENSING 0x23
> +
> +/* Value */
> +#define MIP_BOOT_MODE_BOOT 0x01
> +#define MIP_BOOT_MODE_APP 0x02
> +
> +#define MIP_BOOT_STATUS_BUSY 0x05
> +#define MIP_BOOT_STATUS_ERROR 0x0E
> +#define MIP_BOOT_STATUS_DONE 0xA0
> +
> +#define MIP_BOOT_CMD_MASS_ERASE 0x15
> +#define MIP_BOOT_CMD_PROGRAM 0x54
> +#define MIP_BOOT_CMD_ERASE 0x8F
> +#define MIP_BOOT_CMD_WRITE 0xA5
> +#define MIP_BOOT_CMD_READ 0xC2
> +
> +#define MIP_EVENT_INPUT_TYPE_KEY 0
> +#define MIP_EVENT_INPUT_TYPE_SCREEN 1
> +#define MIP_EVENT_INPUT_TYPE_PROXIMITY 2
> +
> +/*****************************************************************
> + * Header
> + *****************************************************************/
> +
> +/* Config driver */
> +#define I2C_RETRY_COUNT 3 /* 2~ */
> +
> +/* Input value */
> +#define MAX_FINGER_NUM 10
> +#define MAX_KEY_NUM 4
> +#define INPUT_TOUCH_MAJOR_MIN 0
> +#define INPUT_TOUCH_MAJOR_MAX 255
> +#define INPUT_TOUCH_MINOR_MIN 0
> +#define INPUT_TOUCH_MINOR_MAX 255
> +#define INPUT_PRESSURE_MIN 0
> +#define INPUT_PRESSURE_MAX 255
> +#define PIXELS_PER_MM 6
> +
> +/* Firmware update */
> +#define FW_PATH "melfas_mip4.fw"
> +
> +#define MIP_FW_MAX_SECT_NUM 4
> +#define MIP_FW_UPDATE_DEBUG 0 /* 0 (default) or 1 */
> +
> +/*
> +* Firmware update error code
> +*/
> +enum fw_update_errno {
> + fw_err_file_read = -4,
> + fw_err_file_open = -3,
> + fw_err_file_type = -2,
> + fw_err_download = -1,
> + fw_err_none = 0,
> + fw_err_uptodate = 1,
> +};

We should be using standard Linux error codes when indicating errors,
not driver-specific values.

> +
> +/*
> +* Device info structure
> +*/
> +struct mip_ts_info {
> + struct i2c_client *client;
> + struct input_dev *input_dev;
> + struct melfas_mip4_platform_data *pdata;

There is no melfas_mip4_platform_data anymore.

> + char phys[32];
> + dev_t mip_dev;
> + struct class *class;
> + struct mutex lock;
> + int irq;
> + struct gpio_desc *gpio_ce;
> + bool enabled;
> + bool irq_enabled;
> + bool wake_enabled;
> + char *fw_name;
> + u8 product_name[16];
> + int max_x;
> + int max_y;
> + u8 node_x;
> + u8 node_y;
> + u8 node_key;
> + u8 fw_version[8];
> + u8 event_size;
> + int event_format;
> + u8 touch_state[MAX_FINGER_NUM];
> + bool key_enable;
> + int key_num;
> + int key_code[MAX_KEY_NUM];

I do not see where we set up key codes to be emitted. I left key
handling in for now, but we need to resolve this.

> + u8 gesture_wakeup_mode;
> + u8 glove_mode;
> + u8 charger_mode;
> + u8 cover_mode;
> + u8 esd_cnt;
> + bool disable_esd;

The last few members are not used anywhere.

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
> +/*
> +* Reboot chip
> +*/
> +static void __maybe_unused mip_reboot(struct mip_ts_info *info)
> +{
> + mip_power_off(info);
> + mip_power_on(info);
> +}
> +
> +/*
> +* I2C Read
> +*/
> +static int mip_i2c_read(struct mip_ts_info *info, char *write_buf,
> + unsigned int write_len, char *read_buf, unsigned int read_len)
> +{
> + int retry = I2C_RETRY_COUNT;
> + int res;
> +
> + struct i2c_msg msg[] = {
> + {
> + .addr = info->client->addr,
> + .flags = 0,
> + .buf = write_buf,
> + .len = write_len,
> + }, {
> + .addr = info->client->addr,
> + .flags = I2C_M_RD,
> + .buf = read_buf,
> + .len = read_len,
> + },
> + };
> +
> + while (retry--) {
> + res = i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg));
> +
> + if (res == ARRAY_SIZE(msg))
> + goto done;
> + else if (res < 0)
> + dev_err(&info->client->dev,
> + "%s i2c_transfer - errno[%d]\n",
> + __func__, res);
> + else
> + dev_err(&info->client->dev,
> + "%s i2c_transfer - size[%lu] result[%d]\n",
> + __func__, ARRAY_SIZE(msg), res);
> + }
> +
> + return 1;
> +
> +done:
> + return 0;
> +}
> +
> +/*
> +* I2C Write
> +*/
> +static int __maybe_unused mip_i2c_write(struct mip_ts_info *info,
> + char *write_buf, unsigned int write_len)
> +{
> + int retry = I2C_RETRY_COUNT;
> + int res;
> +
> + while (retry--) {
> + res = i2c_master_send(info->client, write_buf, write_len);
> +
> + if (res == write_len)
> + goto done;
> + else if (res < 0)
> + dev_err(&info->client->dev,
> + "%s i2c_master_send - errno [%d]\n",
> + __func__, res);
> + else
> + dev_err(&info->client->dev,
> + "%s length mismatch - write[%d] result[%d]\n",
> + __func__, write_len, res);
> + }
> +
> + return 1;
> +
> +done:
> + return 0;
> +}
> +
> +/*
> +* Power off
> +*/
> +static int mip_power_off(struct mip_ts_info *info)
> +{
> + if (!IS_ERR_OR_NULL(info->gpio_ce))
> + gpiod_set_value_cansleep(info->gpio_ce, 0);
> +
> + return 0;
> +}
> +
> +/*
> +* Power on
> +*/
> +static int mip_power_on(struct mip_ts_info *info)
> +{
> + if (!IS_ERR_OR_NULL(info->gpio_ce))
> + gpiod_set_value_cansleep(info->gpio_ce, 1);
> +
> + /* Booting delay : 200~300ms */
> + usleep_range(200 * 1000, 300 * 1000);
> +
> + return 0;
> +}
> +
> +/*
> +* Clear touch input event status
> +*/
> +static void mip_clear_input(struct mip_ts_info *info)
> +{
> + int i;
> +
> + /* Screen */
> + for (i = 0; i < MAX_FINGER_NUM; i++) {
> + input_mt_slot(info->input_dev, i);
> + input_mt_report_slot_state(info->input_dev,
> + MT_TOOL_FINGER, 0);
> + }
> +
> + /* Key */
> + if (info->key_enable == true) {
> + for (i = 0; i < info->key_num; i++)
> + input_report_key(info->input_dev, info->key_code[i], 0);
> + }
> +
> + input_sync(info->input_dev);
> +}
> +
> +/*
> +* Input event handler - Report input event
> +*/
> +static void mip_input_event_handler(struct mip_ts_info *info, u8 sz, u8 *buf)
> +{
> + int i;
> + int type;
> + int id;
> + int hover = 0;
> + int palm = 0;
> + int state = 0;
> + int x, y, z;
> + int size = 0;
> + int pressure_stage = 0;
> + int pressure = 0;
> + int touch_major = 0;
> + int touch_minor = 0;
> +
> + for (i = 0; i < sz; i += info->event_size) {
> + u8 *packet = &buf[i];
> +
> + /* Event format & type */
> + switch (info->event_format) {
> + case 0:
> + case 1:
> + type = (packet[0] & 0x40) >> 6;
> + break;
> + case 3:
> + type = (packet[0] & 0xF0) >> 4;
> + break;
> + default:
> + dev_err(&info->client->dev,
> + "%s Unknown event format[%d]\n",
> + __func__, info->event_format);
> + goto error;
> + }
> +
> + dev_dbg(&info->client->dev, "%s - Type[%d]\n",
> + __func__, type);
> +
> + /* Report input event */
> + switch (type) {
> + case MIP_EVENT_INPUT_TYPE_KEY:
> + /* Key event */
> + switch (info->event_format) {
> + case 0:
> + case 1:
> + id = packet[0] & 0x0F;
> + state = (packet[0] & 0x80) >> 7;
> + break;
> + case 3:
> + id = packet[0] & 0x0F;
> + state = (packet[1] & 0x01);
> + break;
> + default:
> + dev_err(&info->client->dev,
> + "%s Unknown event format[%d]\n",
> + __func__, info->event_format);
> + goto error;
> + }
> +
> + /* Report key event */
> + if ((id >= 1) && (id <= info->key_num)) {
> + int keycode = info->key_code[id - 1];
> +
> + input_report_key(info->input_dev,
> + keycode, state);
> +
> + dev_dbg(&info->client->dev,
> + "%s - Key : ID[%d] Code[%d] Event[%d]\n",
> + __func__, id, keycode, state);
> + } else {
> + dev_err(&info->client->dev,
> + "%s Unknown Key ID[%d]\n",
> + __func__, id);
> + continue;
> + }
> + break;
> +
> + case MIP_EVENT_INPUT_TYPE_SCREEN:
> + /* Screen event */
> + switch (info->event_format) {
> + case 0:
> + /* Touch only */
> + state = (packet[0] & 0x80) >> 7;
> + hover = (packet[0] & 0x20) >> 5;
> + palm = (packet[0] & 0x10) >> 4;
> + id = (packet[0] & 0x0F) - 1;
> + x = ((packet[1] & 0x0F) << 8) | packet[2];
> + y = (((packet[1] >> 4) & 0x0F) << 8) |
> + packet[3];
> + pressure = packet[4];
> + size = packet[5];
> + touch_major = packet[5];
> + touch_minor = packet[5];
> + break;
> +
> + case 1:
> + /* Touch only */
> + state = (packet[0] & 0x80) >> 7;
> + hover = (packet[0] & 0x20) >> 5;
> + palm = (packet[0] & 0x10) >> 4;
> + id = (packet[0] & 0x0F) - 1;
> + x = ((packet[1] & 0x0F) << 8) | packet[2];
> + y = (((packet[1] >> 4) & 0x0F) << 8) |
> + packet[3];
> + pressure = packet[4];
> + size = packet[5];
> + touch_major = packet[6];
> + touch_minor = packet[7];
> + break;
> +
> + case 3:
> + /* Touch + Force(Pressure) */
> + id = (packet[0] & 0x0F) - 1;
> + hover = (packet[1] & 0x04) >> 2;
> + palm = (packet[1] & 0x02) >> 1;
> + state = (packet[1] & 0x01);
> + x = ((packet[2] & 0x0F) << 8) | packet[3];
> + y = (((packet[2] >> 4) & 0x0F) << 8) |
> + packet[4];
> + z = packet[5];
> + size = packet[6];
> + pressure_stage = (packet[7] & 0xF0) >> 4;
> + pressure = ((packet[7] & 0x0F) << 8) |
> + packet[8];
> + touch_major = packet[9];
> + touch_minor = packet[10];
> + break;
> +
> + default:
> + dev_err(&info->client->dev,
> + "%s Unknown event format[%d]\n",
> + __func__, info->event_format);
> + goto error;
> + }
> +
> + /* Report screen event */
> + switch (state) {
> + case 0:
> + /* Release event */
> + input_mt_slot(info->input_dev, id);
> + input_mt_report_slot_state(info->input_dev,
> + MT_TOOL_FINGER, 0);
> +
> + dev_dbg(&info->client->dev,
> + "%s - Screen : ID[%d] Release\n",
> + __func__, id);
> + break;
> + case 1:
> + /* Press or Move event */
> + input_mt_slot(info->input_dev, id);
> + input_mt_report_slot_state(info->input_dev,
> + MT_TOOL_FINGER, true);
> + input_report_abs(info->input_dev,
> + ABS_MT_POSITION_X, x);
> + input_report_abs(info->input_dev,
> + ABS_MT_POSITION_Y, y);
> + input_report_abs(info->input_dev,
> + ABS_MT_PRESSURE, pressure);
> + input_report_abs(info->input_dev,
> + ABS_MT_TOUCH_MAJOR, touch_major);
> + input_report_abs(info->input_dev,
> + ABS_MT_TOUCH_MINOR, touch_minor);
> +
> + input_report_abs(info->input_dev, ABS_X, x);
> + input_report_abs(info->input_dev, ABS_Y, y);
> +
> + dev_dbg(&info->client->dev,
> + "%s - Screen : ID[%d] X[%d] Y[%d] Z[%d]\n",
> + __func__, id, x, y, pressure);
> + break;
> + default:
> + dev_err(&info->client->dev,
> + "%s Unknown event state[%d]\n",
> + __func__, state);
> + goto error;
> + }
> + break;
> +
> + default:
> + dev_err(&info->client->dev,
> + "%s Unknown event type[%d]\n",
> + __func__, type);
> + goto error;
> + }
> + }
> +
> + goto exit;
> +
> +error:
> + dev_err(&info->client->dev, "%s\n", __func__);
> +exit:
> + input_sync(info->input_dev);

This better be split up a bit.

> +}
> +
> +/*
> +* Config input device
> +*/
> +static void mip_config_input(struct mip_ts_info *info)
> +{
> + struct input_dev *input_dev = info->input_dev;
> +
> + /* Screen */
> + input_mt_init_slots(input_dev, MAX_FINGER_NUM, INPUT_MT_DIRECT);

You need to first set up MT axes and then call input_mt_init_slots() so
that it can set up ST axes for you. You should also try handling errors
returned by input_mt_init_slots().

> +
> + input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> + info->max_x, 0, 0);
> + input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> + info->max_y, 0, 0);
> + input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0,
> + INPUT_PRESSURE_MAX, 0, 0);
> + input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> + INPUT_TOUCH_MAJOR_MAX, 0, 0);
> + input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0,
> + INPUT_TOUCH_MINOR_MAX, 0, 0);
> + input_abs_set_res(input_dev, ABS_MT_POSITION_X,
> + PIXELS_PER_MM);
> + input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
> + PIXELS_PER_MM);

We can not hard code this, it has to come from firmware. I'm dropping
this for now.

> +
> + input_set_abs_params(input_dev, ABS_X, 0,
> + info->max_x, 0, 0);
> + input_set_abs_params(input_dev, ABS_Y, 0,
> + info->max_y, 0, 0);
> + input_abs_set_res(input_dev, ABS_X,
> + PIXELS_PER_MM);
> + input_abs_set_res(input_dev, ABS_Y,
> + PIXELS_PER_MM);

Same here.

> +}
> +
> +/*****************************************************************
> + * Firmware update
> + *****************************************************************/
> +
> +/* Firmware Info */
> +#define BL_PAGE_SIZE 512 /* 512 */
> +#define BL_PACKET_SIZE 128 /* 128, 64, 32 or 16 */
> +
> +/*
> +* Firmware binary tail info
> +*/
> +struct mip_bin_tail {
> + u8 tail_mark[4];
> + char chip_name[4];
> + u32 bin_start_addr;
> + u32 bin_length;

You need endianness annotation for fields wider than u8.

> +
> + u16 ver_boot;
> + u16 ver_core;
> + u16 ver_app;
> + u16 ver_param;
> + u8 boot_start;
> + u8 boot_end;
> + u8 core_start;
> + u8 core_end;
> + u8 app_start;
> + u8 app_end;
> + u8 param_start;
> + u8 param_end;
> +
> + u8 checksum_type;
> + u8 hw_category;
> + u16 param_id;
> + u32 param_length;
> + u32 build_date;
> + u32 build_time;
> +
> + u32 reserved1;
> + u32 reserved2;
> + u16 reserved3;
> + u16 tail_size;
> + u32 crc;
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
> + u8 write_buf[2];
> + u8 result = 0;
> + int cnt = 1000;
> + int ret = 0;
> +
> + struct i2c_msg msg[2] = {
> + {
> + .addr = info->client->addr,
> + .flags = 0,
> + .buf = write_buf,
> + .len = 2,
> + }, {
> + .addr = info->client->addr,
> + .flags = I2C_M_RD,
> + .buf = &result,
> + .len = 1,
> + },
> + };
> +
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_STATUS;
> +
> + do {
> + if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> + != ARRAY_SIZE(msg)) {
> + dev_err(&info->client->dev,
> + "%s i2c_transfer\n", __func__);
> + ret = -1;
> + goto exit;
> + }
> +
> + switch (result) {
> + case MIP_BOOT_STATUS_DONE:
> + dev_dbg(&info->client->dev, "%s - Done\n", __func__);
> + ret = 0;
> + goto exit;
> + case MIP_BOOT_STATUS_BUSY:
> + dev_dbg(&info->client->dev, "%s - Busy\n", __func__);
> + ret = -EBUSY;
> + usleep_range(1000, 2000);
> + break;
> + case MIP_BOOT_STATUS_ERROR:
> + dev_err(&info->client->dev, "%s - Error\n", __func__);
> + ret = -EIO;
> + goto exit;
> + default:
> + dev_err(&info->client->dev,
> + "%s wrong value [0x%02X]\n",
> + __func__, result);
> + ret = -EINVAL;
> + usleep_range(1000, 2000);
> + break;
> + }
> + } while (--cnt);
> +
> + if (!cnt) {
> + dev_err(&info->client->dev,
> + "%s count overflow - cnt[%d] status[0x%02X]\n",
> + __func__, cnt, result);
> + ret = -EBUSY;
> + }
> +
> +exit:
> + return ret;
> +}
> +
> +/*
> +* Bootloader - Change mode
> +*/
> +static int mip_bl_change_mode(struct mip_ts_info *info, u8 mode)
> +{
> + u8 write_buf[8];
> + u8 read_buf[8];
> + int cnt = 10;
> + int ret = 0;
> +
> + struct i2c_msg msg[2] = {
> + {
> + .addr = info->client->addr,
> + .flags = 0,
> + .buf = write_buf,
> + .len = 2,
> + }, {
> + .addr = info->client->addr,
> + .flags = I2C_M_RD,
> + .buf = read_buf,
> + .len = 1,
> + },
> + };
> +
> + do {
> + /* Write */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_MODE;
> + write_buf[2] = mode;
> + if (i2c_master_send(info->client, write_buf, 3) != 3) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> + dev_dbg(&info->client->dev,
> + "%s - Write : Mode [%d]\n", __func__, mode);
> +
> + /* Wait */
> + msleep(1000);
> +
> + /* Read */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_MODE;
> + if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> + != ARRAY_SIZE(msg)) {
> + dev_err(&info->client->dev,
> + "%s i2c_transfer\n", __func__);
> + ret = -1;
> + goto error;
> + }
> + dev_dbg(&info->client->dev, "%s - Read : Mode [%d]\n",
> + __func__, read_buf[0]);
> +
> + if (read_buf[0] == mode)
> + break;
> +
> + } while (--cnt);
> +
> + if (!cnt) {
> + dev_err(&info->client->dev,
> + "%s count overflow - cnt [%d]\n",
> + __func__, cnt);
> + goto error;
> + }
> +
> + return ret;
> +
> +error:
> + dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> + return ret;
> +}
> +
> +/*
> +* Bootloader - Read info
> +*/
> +static int mip_bl_read_info(struct mip_ts_info *info, u16 *buf_addr)
> +{
> + u8 write_buf[8];
> + u8 read_buf[8];
> + int ret = 0;
> +
> + struct i2c_msg msg[2] = {
> + {
> + .addr = info->client->addr,
> + .flags = 0,
> + .buf = write_buf,
> + .len = 2,
> + }, {
> + .addr = info->client->addr,
> + .flags = I2C_M_RD,
> + .buf = read_buf,
> + .len = 2,
> + },
> + };
> +
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_BUF_ADDR;
> + if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> + != ARRAY_SIZE(msg)) {
> + dev_err(&info->client->dev,
> + "%s i2c_transfer\n", __func__);
> + ret = -1;
> + goto error;
> + }
> +
> + *buf_addr = (u16)((read_buf[1] << 8) | read_buf[0]);

*buf_addr = get_unaligned_le16(read_buf);

> + dev_dbg(&info->client->dev,
> + "%s - Buf Addr [0x%04X]\n", __func__, *buf_addr);
> +
> + return ret;
> +
> +error:
> + dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> + return ret;
> +}
> +
> +/*
> +* Bootloader - Program Page
> +*/
> +static int mip_bl_program_page(struct mip_ts_info *info, int offset,
> + const u8 *data, int length, int buf_addr)
> +{
> + u8 write_buf[2 + BL_PAGE_SIZE];
> + int buf_offset = 0;
> +
> + if (length > BL_PAGE_SIZE) {
> + dev_err(&info->client->dev,
> + "%s page length overflow\n", __func__);
> + goto error;
> + }
> +
> + /* Addr */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_TARGET_ADDR;
> + put_unaligned_le32(offset, &write_buf[2]);
> + if (i2c_master_send(info->client, write_buf, 6) != 6) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> + dev_dbg(&info->client->dev,
> + "%s - Addr [0x%06X]\n", __func__, offset);
> +
> + /* Size */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_SIZE;
> + put_unaligned_le32(length, &write_buf[2]);
> + if (i2c_master_send(info->client, write_buf, 6) != 6) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> + dev_dbg(&info->client->dev,
> + "%s - Size [%d]\n", __func__, length);
> +
> + /* Data */
> + for (buf_offset = 0; buf_offset < length;
> + buf_offset += BL_PACKET_SIZE) {
> + write_buf[0] = (u8)(((buf_addr + buf_offset) >> 8) & 0xFF);
> + write_buf[1] = (u8)((buf_addr + buf_offset) & 0xFF);

put_unaligned_be16(buf_addr + buf_offset, write_buf);

> + memcpy(&write_buf[2], &data[buf_offset], BL_PACKET_SIZE);
> + if (i2c_master_send(info->client, write_buf,
> + (2 + BL_PACKET_SIZE))
> + != (2 + BL_PACKET_SIZE)) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> + dev_dbg(&info->client->dev,
> + "%s - PacketSize[%d] BufOffset[0x%04X]\n",
> + __func__, BL_PACKET_SIZE, buf_offset);
> + }
> +
> + /* Command */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_CMD;
> + write_buf[2] = MIP_BOOT_CMD_PROGRAM;
> + if (i2c_master_send(info->client, write_buf, 3) != 3) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> +
> + /* Status */
> + if (mip_bl_read_status(info) != 0)
> + goto error;
> +
> + return 0;
> +
> +error:
> + dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> + return -1;
> +}
> +
> +/*
> +* Bootloader - Read Page
> +*/
> +static int mip_bl_read_page(struct mip_ts_info *info, int offset,
> + u8 *data, int length, int buf_addr)
> +{
> + u8 write_buf[8];
> + u8 read_buf[BL_PACKET_SIZE];
> + int buf_offset = 0;
> +
> + struct i2c_msg msg[2] = {
> + {
> + .addr = info->client->addr,
> + .flags = 0,
> + .buf = write_buf,
> + .len = 2,
> + }, {
> + .addr = info->client->addr,
> + .flags = I2C_M_RD,
> + .buf = read_buf,
> + .len = BL_PACKET_SIZE,
> + },
> + };
> +
> + /* Addr */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_TARGET_ADDR;
> + put_unaligned_le32(offset, &write_buf[2]);
> + if (i2c_master_send(info->client, write_buf, 6) != 6) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> + dev_dbg(&info->client->dev, "%s - Addr [0x%06X]\n",
> + __func__, offset);
> +
> + /* Size */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_SIZE;
> + put_unaligned_le32(length, &write_buf[2]);
> + if (i2c_master_send(info->client, write_buf, 6) != 6) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> + dev_dbg(&info->client->dev,
> + "%s - Size [%d]\n", __func__, length);
> +
> + /* Command */
> + write_buf[0] = MIP_R0_BOOT;
> + write_buf[1] = MIP_R1_BOOT_CMD;
> + write_buf[2] = MIP_BOOT_CMD_READ;
> + if (i2c_master_send(info->client, write_buf, 3) != 3) {
> + dev_err(&info->client->dev,
> + "%s i2c_master_send\n", __func__);
> + goto error;
> + }
> +
> + /* Status */
> + if (mip_bl_read_status(info) != 0)
> + goto error;
> +
> + /* Read */
> + for (buf_offset = 0; buf_offset < length;
> + buf_offset += BL_PACKET_SIZE) {
> + write_buf[0] = (u8)(((buf_addr + buf_offset) >> 8) & 0xFF);
> + write_buf[1] = (u8)((buf_addr + buf_offset) & 0xFF);
> + if (i2c_transfer(info->client->adapter, msg, ARRAY_SIZE(msg))
> + != ARRAY_SIZE(msg)) {
> + dev_err(&info->client->dev,
> + "%s i2c_transfer\n", __func__);
> + goto error;
> + }
> + memcpy(&data[buf_offset], read_buf, BL_PACKET_SIZE);
> + dev_dbg(&info->client->dev,
> + "%s - PacketSize[%d] BufOffset [0x%04X]\n",
> + __func__, BL_PACKET_SIZE, buf_offset);
> + }
> +
> + return 0;
> +
> +error:
> + dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> + return -1;
> +}
> +
> +/*
> +* Bootloader - Start bootloader mode
> +*/
> +static int mip_bl_enter(struct mip_ts_info *info)
> +{
> + if (mip_bl_change_mode(info, MIP_BOOT_MODE_BOOT) != 0)
> + goto error;
> +
> + return 0;
> +
> +error:
> + dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> + return -1;
> +}
> +
> +/*
> +* Bootloader - Exit bootloader mode
> +*/
> +static int mip_bl_exit(struct mip_ts_info *info)
> +{
> + if (mip_bl_change_mode(info, MIP_BOOT_MODE_APP) != 0)
> + goto error;
> +
> + return 0;
> +
> +error:
> + dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> + return -1;

Ideally you propagate errors from lower levels to upper levels instead
of clobbering them as yo do here with -1.

> +}
> +
> +/*
> +* Flash chip firmware
> +*/
> +static int mip_flash_fw(struct mip_ts_info *info, const u8 *fw_data,
> + size_t fw_size, bool force, bool section)
> +{
> + struct i2c_client *client = info->client;
> + struct mip_bin_tail *bin_info;
> + int ret = 0;
> + int retry = 3;
> + u8 rbuf[BL_PAGE_SIZE];
> + int offset = 0;
> + u32 offset_start = 0;
> + u32 offset_end = 0;
> + int bin_size = 0;
> + u8 *bin_data;
> + u16 tail_size = 0;
> + u8 tail_mark[4] = MIP_BIN_TAIL_MARK;
> + u16 ver_chip[MIP_FW_MAX_SECT_NUM];
> + u16 buf_addr = 0;
> + u8 bin_type = 0;

There is bunch of unneded initializations here.

> +
> + /* Check tail size */
> + tail_size = (fw_data[fw_size - 5] << 8) | fw_data[fw_size - 6];

get_unaligned_le16().

> + if (tail_size != MIP_BIN_TAIL_SIZE) {
> + dev_err(&client->dev,
> + "%s wrong tail size [%d]\n",
> + __func__, tail_size);
> + ret = fw_err_file_type;
> + goto error_file;
> + }
> +
> + /* Check bin format */
> + if (memcmp(&fw_data[fw_size - tail_size], tail_mark, 4)) {
> + dev_err(&client->dev,
> + "%s wrong tail mark\n", __func__);
> + ret = fw_err_file_type;
> + goto error_file;
> + }
> +
> + /* Read bin info */
> + bin_info = (struct mip_bin_tail *)&fw_data[fw_size - tail_size];
> +
> +#if MIP_FW_UPDATE_DEBUG
> + print_hex_dump(KERN_ERR, MIP_DEVICE_NAME " Bin Info : ",
> + DUMP_PREFIX_OFFSET, 16, 1, bin_info, tail_size, false);
> +#endif
> +
> + /* Check bin size */
> + if (bin_info->bin_start_addr + bin_info->bin_length == fw_size) {
> + bin_size = bin_info->bin_start_addr
> + + bin_info->bin_length;
> + offset_start = bin_info->bin_start_addr;
> + } else if (bin_info->bin_length == fw_size) {
> + bin_size = bin_info->bin_length;
> + offset_start = 0;
> + } else {
> + dev_err(&client->dev,
> + "%s wrong bin size\n", __func__);
> + ret = fw_err_file_type;
> + goto error_file;
> + }
> + offset_end = bin_size - BL_PAGE_SIZE;
> +
> + dev_dbg(&client->dev,
> + "%s - Bin : Size[%d] Start[0x%04X] End[0x%04X]\n",
> + __func__, bin_size, offset_start, offset_end);
> +
> + /* Check F/W version */
> + dev_info(&client->dev,
> + "F/W file version [0x%04X 0x%04X 0x%04X 0x%04X]\n",
> + bin_info->ver_boot, bin_info->ver_core,
> + bin_info->ver_app, bin_info->ver_param);
> +
> + /* Check F/W type */
> + if ((bin_info->ver_boot != 0xEEEE) &&
> + (bin_info->ver_boot != 0xFFFF) &&
> + (bin_info->ver_core == 0xEEEE) &&
> + (bin_info->ver_app == 0xEEEE) &&
> + (bin_info->ver_param == 0xEEEE)) {
> + bin_type = 0;
> + dev_info(&client->dev, "F/W type [Bootloader]\n");
> + } else if ((bin_info->ver_boot == 0xEEEE) &&
> + (bin_info->ver_core != 0xEEEE) &&
> + (bin_info->ver_core != 0xFFFF) &&
> + (bin_info->ver_app != 0xEEEE) &&
> + (bin_info->ver_app != 0xFFFF) &&
> + (bin_info->ver_param != 0xEEEE) &&
> + (bin_info->ver_param != 0xFFFF)) {
> + bin_type = 1;
> + dev_info(&client->dev, "F/W type [Main]\n");
> + } else {
> + dev_err(&client->dev,
> + "%s wrong file type\n", __func__);
> + ret = fw_err_file_type;
> + goto error_file;
> + }
> +
> + if (force == true) {
> + /* Force update */
> + dev_info(&client->dev,
> + "Skip chip firmware version check\n");
> + } else {
> + /* Read firmware version from chip */
> + while (retry--) {
> + if (mip_get_fw_version_u16(info, ver_chip))
> + mip_reboot(info);
> + else
> + break;
> + }
> + if (retry < 0) {
> + dev_err(&client->dev,
> + "%s Unknown chip firmware version\n",
> + __func__);
> + } else {
> + dev_info(&client->dev,
> + "Chip firmware version [0x%04X 0x%04X 0x%04X 0x%04X]\n",
> + ver_chip[0], ver_chip[1],
> + ver_chip[2], ver_chip[3]);
> +
> + /* Compare version */
> + if ((ver_chip[0] == bin_info->ver_boot) &&
> + (ver_chip[1] == bin_info->ver_core) &&
> + (ver_chip[2] == bin_info->ver_app) &&
> + (ver_chip[3] == bin_info->ver_param)) {
> + dev_info(&client->dev,
> + "Chip firmware is already up-to-date\n");
> + ret = fw_err_uptodate;
> + goto uptodate;
> + }
> + }
> + }
> +
> + /* Read bin data */
> + bin_data = kzalloc(sizeof(u8) * (bin_size), GFP_KERNEL);
> + memcpy(bin_data, fw_data, bin_size);

Why do we need to copy the data over into a temporary buffer?

> +
> + /* Enter bootloader mode */
> + dev_dbg(&client->dev,
> + "%s - Enter bootloader mode\n", __func__);
> +
> + if (mip_bl_enter(info) != 0) {
> + dev_err(&client->dev,
> + "%s mip_bl_enter\n", __func__);
> + ret = fw_err_download;
> + goto error_update;
> + }
> +
> + /* Read info */
> + if (mip_bl_read_info(info, &buf_addr)) {
> + dev_err(&client->dev,
> + "%s mip_bl_read_info\n", __func__);
> + ret = fw_err_download;
> + goto error_update;
> + }
> + dev_dbg(&client->dev,
> + "%s - Buffer Addr [0x%04X]\n", __func__, buf_addr);
> +
> + /* Program & Verify */
> + dev_dbg(&client->dev,
> + "%s - Program & Verify\n", __func__);
> +
> + dev_dbg(&client->dev,
> + "%s - Size : Page[%d] Packet[%d]\n",
> + __func__, BL_PAGE_SIZE, BL_PACKET_SIZE);
> +
> + for (offset = offset_start; offset < bin_size;
> + offset += BL_PAGE_SIZE) {
> + /* Program */
> + if (mip_bl_program_page(info, offset, &bin_data[offset],
> + BL_PAGE_SIZE, buf_addr)) {
> + dev_err(&client->dev,
> + "%s mip_bl_program_page : offset[0x%08X]\n",
> + __func__, offset);
> + ret = fw_err_download;
> + goto error_update;
> + }
> + dev_dbg(&client->dev,
> + "%s - mip_bl_program_page : offset[0x%08X]\n",
> + __func__, offset);
> +
> + /* Verify */
> + if (mip_bl_read_page
> + (info, offset, rbuf, BL_PAGE_SIZE, buf_addr)) {
> + dev_err(&client->dev,
> + "%s mip_bl_read_page : offset[0x%08X]\n",
> + __func__, offset);
> + ret = fw_err_download;
> + goto error_update;
> + }
> + dev_dbg(&client->dev,
> + "%s - mip_bl_read_page : offset[0x%08X]\n",
> + __func__, offset);
> +
> +#if MIP_FW_UPDATE_DEBUG
> + print_hex_dump(KERN_ERR, MIP_DEVICE_NAME " F/W File : ",
> + DUMP_PREFIX_OFFSET, 16, 1, &bin_data[offset],
> + BL_PAGE_SIZE, false);
> + print_hex_dump(KERN_ERR, MIP_DEVICE_NAME " F/W Chip : ",
> + DUMP_PREFIX_OFFSET, 16, 1, rbuf,
> + BL_PAGE_SIZE, false);
> +#endif
> +
> + if (memcmp(rbuf, &bin_data[offset], BL_PAGE_SIZE)) {
> + dev_err(&client->dev,
> + "%s Verify failed : offset[0x%08X]\n",
> + __func__, offset);
> + ret = fw_err_download;
> + goto error_update;
> + }
> + }
> +
> + /* Exit bootloader mode */
> + dev_dbg(&client->dev,
> + "%s - Exit bootloader mode\n", __func__);
> +
> + if (mip_bl_exit(info) != 0) {
> + dev_err(&client->dev,
> + "%s mip_bl_exit\n", __func__);
> + ret = fw_err_download;
> + goto error_update;
> + }
> +
> + /* Reset chip */
> + mip_reboot(info);
> +
> + /* Check chip firmware version */
> + if (mip_get_fw_version_u16(info, ver_chip)) {
> + dev_err(&client->dev,
> + "%s Unknown chip firmware version\n",
> + __func__);
> + ret = fw_err_download;
> + goto error_update;
> + } else {
> + if (bin_type == 0) {
> + if (ver_chip[0] == bin_info->ver_boot) {
> + dev_dbg(&client->dev,
> + "%s - Version check OK\n", __func__);
> + } else {
> + dev_err(&client->dev,
> + "Version mismatch after flash.\n");
> + dev_err(&client->dev,
> + "Chip[0x%04X 0xEEEE 0xEEEE 0xEEEE]\n",
> + ver_chip[0]);
> + dev_err(&client->dev,
> + "File[0x%04X 0xEEEE 0xEEEE 0xEEEE]\n",
> + bin_info->ver_boot);
> + ret = fw_err_download;
> + goto error_update;
> + }
> + } else if (bin_type == 1) {
> + if ((ver_chip[1] == bin_info->ver_core) &&
> + (ver_chip[2] == bin_info->ver_app) &&
> + (ver_chip[3] == bin_info->ver_param)) {
> + dev_dbg(&client->dev,
> + "%s - Version check OK\n", __func__);
> + } else {
> + dev_err(&client->dev,
> + "Version mismatch after flash.\n");
> + dev_err(&client->dev,
> + "Chip[0xEEEE 0x%04X 0x%04X 0x%04X]\n",
> + ver_chip[1], ver_chip[2], ver_chip[3]);
> + dev_err(&client->dev,
> + "File[0xEEEE 0x%04X 0x%04X 0x%04X]\n",
> + bin_info->ver_core, bin_info->ver_app,
> + bin_info->ver_param);
> + ret = fw_err_download;
> + goto error_update;
> + }
> + }
> + }

I think if we want to validate the resulting version it should be done
by userspace. Kernel's task is to write the data, if write succeeds then
kernel's task is done.

> +
> + kfree(bin_data);
> +
> +uptodate:
> + goto exit;
> +
> +error_update:
> + kfree(bin_data);
> +
> + /* Reset chip */
> + mip_reboot(info);
> +
> +error_file:
> + dev_err(&client->dev, "%s [ERROR]\n", __func__);
> +
> +exit:
> + return ret;
> +}
> +
> +/*
> +* Enable device
> +*/
> +static int mip_enable(struct mip_ts_info *info)
> +{
> + if (info->enabled) {
> + dev_err(&info->client->dev,
> + "%s device already enabled\n", __func__);
> + goto error;
> + }
> +
> + if (info->wake_enabled) {
> + /* Disable wake-up */
> + disable_irq_wake(info->irq);
> + info->wake_enabled = false;

I think this only needs to be done in suspend/resume path.

> + } else {
> + /* Power on */
> + mip_power_on(info);
> + }
> +
> + mutex_lock(&info->lock);
> +
> + if (info->irq_enabled == false) {
> + enable_irq(info->client->irq);
> + info->irq_enabled = true;
> + }
> +
> + info->enabled = true;
> +
> + mutex_unlock(&info->lock);
> +
> +error:
> + dev_info(&info->client->dev, MIP_DEVICE_NAME" - Enabled\n");
> +
> + return 0;
> +}
> +
> +/*
> +* Disable device
> +*/
> +static int mip_disable(struct mip_ts_info *info)
> +{
> + if (!info->enabled) {
> + dev_err(&info->client->dev,
> + "%s device already disabled\n", __func__);
> + goto error;
> + }
> +
> + mutex_lock(&info->lock);
> +
> + disable_irq(info->client->irq);
> + info->irq_enabled = false;
> +
> + mutex_unlock(&info->lock);
> +
> + if (device_may_wakeup(&info->client->dev)) {
> + /* Enable wake-up */
> + info->wake_enabled = (enable_irq_wake(info->irq) == 0);
> + } else {
> + /* Power off */
> + mip_power_off(info);
> + }
> +
> + mip_clear_input(info);
> +
> + info->enabled = false;
> +
> +error:
> + dev_info(&info->client->dev, MIP_DEVICE_NAME" - Disabled\n");
> +
> + return 0;
> +}
> +
> +/*
> +* Open input device
> +*/
> +static int mip_input_open(struct input_dev *dev)
> +{
> + struct mip_ts_info *info = input_get_drvdata(dev);
> +
> + mip_enable(info);
> +
> + return 0;
> +}
> +
> +/*
> +* Close input device
> +*/
> +static void mip_input_close(struct input_dev *dev)
> +{
> + struct mip_ts_info *info = input_get_drvdata(dev);
> +
> + mip_disable(info);
> +}
> +
> +/*
> +* Read chip firmware version
> +*/
> +static int mip_get_fw_version(struct mip_ts_info *info, u8 *ver_buf)
> +{
> + u8 rbuf[8];
> + u8 wbuf[2];
> + int i;
> +
> + wbuf[0] = MIP_R0_INFO;
> + wbuf[1] = MIP_R1_INFO_VERSION_BOOT;
> + if (mip_i2c_read(info, wbuf, 2, rbuf, 8)) {
> + goto error;
> + };
> +
> + for (i = 0; i < MIP_FW_MAX_SECT_NUM; i++) {
> + ver_buf[0 + i * 2] = rbuf[1 + i * 2];
> + ver_buf[1 + i * 2] = rbuf[0 + i * 2];
> + }
> +
> + return 0;
> +
> +error:
> + memset(ver_buf, 0xFF, 8);
> +
> + dev_err(&info->client->dev, "%s\n", __func__);
> + return 1;
> +}
> +
> +/*
> +* Read chip firmware version for u16
> +*/
> +static int __maybe_unused mip_get_fw_version_u16
> + (struct mip_ts_info *info, u16 *ver_buf_u16)
> +{
> + u8 rbuf[8];
> + int i;
> +
> + if (mip_get_fw_version(info, rbuf))
> + goto error;
> +
> + for (i = 0; i < MIP_FW_MAX_SECT_NUM; i++)
> + ver_buf_u16[i] = (rbuf[0 + i * 2] << 8) | rbuf[1 + i * 2];
> +
> + return 0;
> +
> +error:
> + memset(ver_buf_u16, 0xFFFF, 4);
> +
> + dev_err(&info->client->dev, "%s\n", __func__);
> + return 1;
> +}
> +
> +/*
> +* Interrupt handler
> +*/
> +static irqreturn_t mip_interrupt(int irq, void *dev_id)
> +{
> + struct mip_ts_info *info = dev_id;
> + struct i2c_client *client = info->client;
> + u8 wbuf[8];
> + u8 rbuf[256];
> + unsigned int size = 0;
> + u8 category = 0;
> + u8 alert_type = 0;
> +
> + /* Read packet info */
> + wbuf[0] = MIP_R0_EVENT;
> + wbuf[1] = MIP_R1_EVENT_PACKET_INFO;
> + if (mip_i2c_read(info, wbuf, 2, rbuf, 1)) {
> + dev_err(&client->dev,
> + "%s Read packet info\n", __func__);
> + goto error;
> + }
> +
> + size = (rbuf[0] & 0x7F);
> + category = ((rbuf[0] >> 7) & 0x1);
> + dev_dbg(&client->dev,
> + "%s - packet info : size[%d] category[%d]\n",
> + __func__, size, category);
> +
> + /* Check size */
> + if (size <= 0) {
> + dev_err(&client->dev,
> + "%s Packet size [%d]\n",
> + __func__, size);
> + goto exit;
> + }
> +
> + /* Read packet data */
> + wbuf[0] = MIP_R0_EVENT;
> + wbuf[1] = MIP_R1_EVENT_PACKET_DATA;
> + if (mip_i2c_read(info, wbuf, 2, rbuf, size)) {
> + dev_err(&client->dev,
> + "%s Read packet data\n",
> + __func__);
> + goto error;
> + }
> +
> + /* Event handler */
> + if (category == 0) {
> + /* Touch event */
> + info->esd_cnt = 0;
> +
> + mip_input_event_handler(info, size, rbuf);
> + } else {
> + /* Alert event */
> + alert_type = rbuf[0];
> +
> + dev_dbg(&client->dev,
> + "%s - alert type [%d]\n",
> + __func__, alert_type);
> + }
> +
> +exit:
> + return IRQ_HANDLED;
> +
> +error:
> + dev_err(&client->dev, "%s\n", __func__);
> + return IRQ_HANDLED;
> +}
> +
> +/*
> +* Initial config
> +*/
> +static int mip_init_config(struct mip_ts_info *info)
> +{
> + u8 wbuf[8];
> + u8 rbuf[64];
> +
> + /* Product name */
> + wbuf[0] = MIP_R0_INFO;
> + wbuf[1] = MIP_R1_INFO_PRODUCT_NAME;
> + mip_i2c_read(info, wbuf, 2, rbuf, 16);
> + memcpy(info->product_name, rbuf, 16);
> + dev_dbg(&info->client->dev,
> + "%s - product_name[%s]\n",
> + __func__, info->product_name);
> +
> + /* Firmware version */
> + mip_get_fw_version(info, rbuf);
> + memcpy(info->fw_version, rbuf, 8);
> + dev_info(&info->client->dev,
> + "%s - F/W Version : %02X.%02X %02X.%02X %02X.%02X %02X.%02X\n",
> + __func__, info->fw_version[0], info->fw_version[1],
> + info->fw_version[2], info->fw_version[3], info->fw_version[4],
> + info->fw_version[5], info->fw_version[6], info->fw_version[7]);
> +
> + /* Resolution */
> + wbuf[0] = MIP_R0_INFO;
> + wbuf[1] = MIP_R1_INFO_RESOLUTION_X;
> + mip_i2c_read(info, wbuf, 2, rbuf, 7);
> +
> + /* Set resolution by firmware info */
> + info->max_x = get_unaligned_le16(&rbuf[0]);
> + info->max_y = get_unaligned_le16(&rbuf[2]);
> + dev_dbg(&info->client->dev, "%s - max_x[%d] max_y[%d]\n",
> + __func__, info->max_x, info->max_y);
> +
> + /* Node info */
> + info->node_x = rbuf[4];
> + info->node_y = rbuf[5];
> + info->node_key = rbuf[6];
> + dev_dbg(&info->client->dev,
> + "%s - node_x[%d] node_y[%d] node_key[%d]\n",
> + __func__, info->node_x, info->node_y, info->node_key);
> +
> + /* Key info */
> + if (info->node_key > 0) {
> + /* Enable touchkey */
> + info->key_enable = true;
> + info->key_num = info->node_key;
> + }
> +
> + /* Protocol */
> + wbuf[0] = MIP_R0_EVENT;
> + wbuf[1] = MIP_R1_EVENT_SUPPORTED_FUNC;
> + mip_i2c_read(info, wbuf, 2, rbuf, 7);
> + info->event_format = (rbuf[4]) | (rbuf[5] << 8);
> + info->event_size = rbuf[6];
> + dev_dbg(&info->client->dev,
> + "%s - event_format[%d] event_size[%d]\n",
> + __func__, info->event_format, info->event_size);
> +
> + return 0;
> +}
> +
> +/*
> +* Update firmware
> +*/
> +static int mip_fw_update(struct mip_ts_info *info, char *fw_path)
> +{
> + const char *fw_name = fw_path;
> + const struct firmware *fw;
> + int retires = 3;
> + int ret = fw_err_none;
> +
> + /* Disable IRQ */
> + mutex_lock(&info->lock);
> + disable_irq(info->client->irq);
> +
> + /* Get firmware */
> + request_firmware(&fw, fw_name, &info->client->dev);
> +
> + if (!fw) {
> + dev_err(&info->client->dev,
> + "%s request_firmware\n", __func__);
> + goto error;
> + }

We should also propagate error code returned by request_firmware().

> +
> + /* Update firmware */
> + do {
> + ret = mip_flash_fw(info, fw->data, fw->size, false, true);
> + if (ret >= fw_err_none)
> + break;
> + } while (--retires);
> +
> + if (!retires) {
> + dev_err(&info->client->dev,
> + "%s mip_flash_fw failed\n", __func__);
> + ret = fw_err_download;
> + }
> +
> + release_firmware(fw);
> +
> + /* Enable IRQ */
> + enable_irq(info->client->irq);
> + mutex_unlock(&info->lock);
> +
> + if (ret < fw_err_none)
> + goto error;
> +
> + return ret;
> +
> +error:
> + dev_err(&info->client->dev, "%s [ERROR]\n", __func__);
> + return ret;
> +}
> +
> +static ssize_t mip_sys_update_fw(struct device *dev,
> + struct device_attribute *attr, char *buf)
> +{
> + struct i2c_client *client = to_i2c_client(dev);
> + struct mip_ts_info *info = i2c_get_clientdata(client);
> + int result = 0;
> + u8 data[255];
> + int ret = 0;
> +
> + /* Update firmware */
> + ret = mip_fw_update(info, FW_PATH);
> +
> + switch (ret) {
> + case fw_err_none:
> + sprintf(data, "F/W update success.\n");
> + break;
> + case fw_err_uptodate:
> + sprintf(data, "F/W is already up-to-date.\n");
> + break;
> + case fw_err_download:
> + sprintf(data, "F/W update failed : Download error\n");
> + break;
> + case fw_err_file_type:
> + sprintf(data, "F/W update failed : File type error\n");
> + break;
> + case fw_err_file_open:
> + sprintf(data, "F/W update failed : File open error\n");
> + break;
> + case fw_err_file_read:
> + sprintf(data, "F/W update failed : File read error\n");
> + break;
> + default:
> + sprintf(data, "F/W update failed.\n");
> + break;
> + }
> +
> + result = snprintf(buf, 255, "%s\n", data);
> + return result;
> +}
> +static DEVICE_ATTR(update_fw, 0660, mip_sys_update_fw, NULL);

The proper permission for update_fw sysfs node should be S_IWUSR (i.e.
only root can write, since firmware update is "write" operation).
Instead of returning error strings we should return error codes.

> +
> +/*
> +* Print chip firmware version
> +*/
> +static ssize_t mip_sys_fw_version(struct device *dev,
> + struct device_attribute *attr, char *buf)
> +{
> + struct mip_ts_info *info = dev_get_drvdata(dev);
> + u8 data[255];
> + int ret;
> + u8 rbuf[16];
> +
> + if (mip_get_fw_version(info, rbuf)) {
> + dev_err(&info->client->dev,
> + "%s mip_get_fw_version\n", __func__);
> +
> + sprintf(data, "F/W Version : ERROR\n");
> + goto error;
> + }
> +
> + dev_info(&info->client->dev,
> + "%s F/W Version : %02X.%02X/%02X.%02X/%02X.%02X/%02X.%02X\n",
> + __func__, rbuf[0], rbuf[1], rbuf[2], rbuf[3],
> + rbuf[4], rbuf[5], rbuf[6], rbuf[7]);
> +
> + sprintf(data,
> + "F/W Version : %02X.%02X/%02X.%02X/%02X.%02X/%02X.%02X\n",
> + rbuf[0], rbuf[1], rbuf[2], rbuf[3],
> + rbuf[4], rbuf[5], rbuf[6], rbuf[7]);
> +
> +error:
> + ret = snprintf(buf, 255, "%s", data);
> + return ret;
> +}
> +static DEVICE_ATTR(fw_version, 0660, mip_sys_fw_version, NULL);

S_IRUGO. Anyone should be able to read version.

> +
> +/*
> +* Sysfs attr info
> +*/
> +static struct attribute *mip_attrs[] = {
> + &dev_attr_fw_version.attr,
> + &dev_attr_update_fw.attr,
> + NULL,
> +};
> +
> +/*
> +* Sysfs attr group info
> +*/
> +static const struct attribute_group mip_attr_group = {
> + .attrs = mip_attrs,
> +};
> +
> +/*
> +* Create sysfs
> +*/
> +static int mip_sysfs_create(struct mip_ts_info *info)
> +{
> + struct i2c_client *client = info->client;
> +
> + if (sysfs_create_group(&client->dev.kobj, &mip_attr_group)) {
> + dev_err(&client->dev,
> + "%s sysfs_create_group\n", __func__);
> + return -EAGAIN;

Why -EAGAIN and not error that sysfs_create_group() retured us?

> + }
> +
> + return 0;
> +}
> +
> +/*
> +* Remove sysfs
> +*/
> +static void mip_sysfs_remove(void *_info)
> +{
> + struct mip_ts_info *info = _info;
> +
> + sysfs_remove_group(&info->client->dev.kobj, &mip_attr_group);
> +}
> +
> +/*
> +* Get platform data
> +*/
> +static int mip_platform_data(struct mip_ts_info *info)
> +{
> + int ret = 0;
> +
> + /* Get platform data */
> +#ifndef CONFIG_ACPI
> + if (!info->client->dev.of_node) {
> + info->pdata = dev_get_platdata(&info->client->dev);
> + if (info->pdata == NULL) {
> + ret = -EINVAL;
> + dev_err(&info->client->dev,
> + "%s dev_get_platdata\n", __func__);
> + return ret;
> + }
> + }
> +#endif

The above is not needed, there is no platform data anymore.

> +
> + /* Get GPIO */
> + info->gpio_ce = devm_gpiod_get_optional(&info->client->dev,
> + "ce", GPIOD_OUT_LOW);
> + if (IS_ERR(info->gpio_ce)) {
> + ret = PTR_ERR(info->gpio_ce);
> + dev_err(&info->client->dev,
> + "%s gpio_ce\n", __func__);
> + return ret;
> + }
> +
> + return ret;
> +}
> +
> +/*
> +* Initialize driver
> +*/
> +static int mip_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> + struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> + struct mip_ts_info *info;
> + struct input_dev *input_dev;
> + int ret = 0;
> +
> + if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> + dev_err(&client->dev,
> + "%s i2c_check_functionality\n",
> + __func__);
> + return -ENODEV;
> + }
> +
> + /* Init info data */
> + info = devm_kzalloc(&client->dev,
> + sizeof(struct mip_ts_info), GFP_KERNEL);
> + input_dev = devm_input_allocate_device(&client->dev);
> + if (!info || !input_dev) {
> + dev_err(&client->dev,
> + "%s\n", __func__);
> + return -ENOMEM;
> + }
> +
> + info->client = client;
> + info->input_dev = input_dev;
> + info->irq_enabled = false;
> + mutex_init(&info->lock);
> +
> + /* Get platform data */
> + ret = mip_platform_data(info);
> + if (ret) {
> + dev_err(&client->dev,
> + "%s mip_platform_data\n",
> + __func__);
> + return -ENODEV;
> + }
> +
> + /* Set input dev */
> + info->input_dev->name = "MELFAS MIP4 Touchscreen";
> + info->input_dev->phys = info->phys;
> + info->input_dev->id.bustype = BUS_I2C;
> + info->input_dev->id.vendor = 0x13C5;
> + info->input_dev->open = mip_input_open;
> + info->input_dev->close = mip_input_close;
> +
> + /* Set driver data */
> + input_set_drvdata(input_dev, info);
> + i2c_set_clientdata(client, info);
> +
> + /* Power on */
> + mip_power_on(info);
> +
> + /* Initial config */
> + mip_init_config(info);
> +
> + /* Config input interface */
> + mip_config_input(info);
> +
> + /* Register input device */
> + ret = input_register_device(input_dev);
> + if (ret) {
> + dev_err(&client->dev,
> + "%s input_register_device\n",
> + __func__);
> + return -ENODEV;
> + }
> +
> + /* Set interrupt handler */
> + ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> + mip_interrupt, IRQF_ONESHOT, MIP_DEVICE_NAME, info);
> +
> + if (ret) {
> + dev_err(&client->dev,
> + "%s request_threaded_irq\n", __func__);
> + return -EIO;
> + }
> +
> + disable_irq(client->irq);
> + info->irq = client->irq;
> +
> + /* Set wake-up */
> + device_init_wakeup(&client->dev, true);
> + device_set_wakeup_enable(&client->dev, true);
> +
> + /* Create sysfs */
> + if (mip_sysfs_create(info))
> + dev_err(&client->dev,
> + "%s mip_sysfs_create\n", __func__);
> +
> + devm_add_action(&client->dev, mip_sysfs_remove, info);
> +
> + return 0;
> +}
> +
> +/*
> +* Device suspend event handler
> +*/
> +static int __maybe_unused mip_suspend(struct device *dev)
> +{
> + struct i2c_client *client = to_i2c_client(dev);
> + struct mip_ts_info *info = i2c_get_clientdata(client);
> + struct input_dev *input_dev = info->input_dev;
> +
> + mutex_lock(&input_dev->mutex);
> +
> + if (input_dev->users)
> + mip_disable(info);
> +
> + mutex_unlock(&input_dev->mutex);
> +
> + return 0;
> +}
> +
> +/*
> +* Device resume event handler
> +*/
> +static int __maybe_unused mip_resume(struct device *dev)
> +{
> + struct i2c_client *client = to_i2c_client(dev);
> + struct mip_ts_info *info = i2c_get_clientdata(client);
> + struct input_dev *input_dev = info->input_dev;
> +
> + mutex_lock(&input_dev->mutex);
> +
> + if (input_dev->users)
> + mip_enable(info);
> +
> + mutex_unlock(&input_dev->mutex);
> +
> + return 0;
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
> + {.compatible = "melfas,"MIP_DEVICE_NAME,},
> + {},
> +};
> +MODULE_DEVICE_TABLE(of, mip_match_table);
> +
> +/*
> +* ACPI match table
> +*/
> +static const struct acpi_device_id mip_acpi_match_table[] = {
> + {ACPI_ID, 0},
> + {},
> +};
> +MODULE_DEVICE_TABLE(acpi, mip_acpi_match_table);
> +
> +/*
> +* I2C Device ID
> +*/
> +static const struct i2c_device_id mip_id[] = {
> + {MIP_DEVICE_NAME, 0},
> + {},
> +};
> +MODULE_DEVICE_TABLE(i2c, mip_id);
> +
> +/*
> +* I2C driver info
> +*/
> +static struct i2c_driver mip_driver = {
> + .id_table = mip_id,
> + .probe = mip_probe,
> + .driver = {
> + .name = MIP_DEVICE_NAME,
> + .of_match_table = of_match_ptr(mip_match_table),
> + .acpi_match_table = ACPI_PTR(mip_acpi_match_table),
> + .pm = &mip_pm_ops,
> + },
> +};
> +
> +module_i2c_driver(mip_driver);
> +
> +MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
> +MODULE_VERSION("2016.02.02");
> +MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
> +MODULE_LICENSE("GPL");
> +
> --
> 1.9.1
>

Thanks.

-- 
Dmitry


Input: add MELFAS MIP4 Touchscreen driver

From: Sangwon Jee <jeesw@melfas.com>

This is an input driver for MELFAS MIP4 Touchscreen devices, such as
MMS400, MMS500, MCS8000, MIT200, MIT300, MIT400, MFS10. All devices
implementing MIP4 protocol (MELFAS Interface Protocol Version 4) should me
supported by this driver.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig       |   11 
 drivers/input/touchscreen/Makefile      |    1 
 drivers/input/touchscreen/melfas_mip4.c | 1499 +++++++++++++++++++++++++++++++
 3 files changed, 1511 insertions(+)
 create mode 100644 drivers/input/touchscreen/melfas_mip4.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 09f0cf6..bf3269d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -491,6 +491,17 @@ config TOUCHSCREEN_MMS114
 	  To compile this driver as a module, choose M here: the
 	  module will be called mms114.
 
+config TOUCHSCREEN_MELFAS_MIP4
+	tristate "MELFAS MIP4 Touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have a MELFAS MIP4 Touchscreen device.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called melfas_mip4.
+
 config TOUCHSCREEN_MTOUCH
 	tristate "MicroTouch serial touchscreens"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 2139c25..50083f2 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+= lpc32xx_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+= max11801_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MC13783)	+= mc13783_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+= mcs5000_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MELFAS_MIP4)	+= melfas_mip4.o
 obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MMS114)	+= mms114.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
new file mode 100644
index 0000000..b8e9ead
--- /dev/null
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -0,0 +1,1499 @@
+/*
+ * MELFAS MIP4 Touchscreen
+ *
+ * Copyright (C) 2016 MELFAS Inc.
+ *
+ * Author : Sangwon Jee <jeesw@melfas.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#define MIP4_DEVICE_NAME	"mip4_ts"
+
+/*****************************************************************
+ * Protocol
+ * Version : MIP 4.0 Rev 4.4
+ *****************************************************************/
+
+/* Address */
+#define MIP4_R0_BOOT				0x00
+#define MIP4_R1_BOOT_MODE			0x01
+#define MIP4_R1_BOOT_BUF_ADDR			0x10
+#define MIP4_R1_BOOT_STATUS			0x20
+#define MIP4_R1_BOOT_CMD			0x30
+#define MIP4_R1_BOOT_TARGET_ADDR		0x40
+#define MIP4_R1_BOOT_SIZE			0x44
+
+#define MIP4_R0_INFO				0x01
+#define MIP4_R1_INFO_PRODUCT_NAME		0x00
+#define MIP4_R1_INFO_RESOLUTION_X		0x10
+#define MIP4_R1_INFO_RESOLUTION_Y		0x12
+#define MIP4_R1_INFO_NODE_NUM_X			0x14
+#define MIP4_R1_INFO_NODE_NUM_Y			0x15
+#define MIP4_R1_INFO_KEY_NUM			0x16
+#define MIP4_R1_INFO_VERSION_BOOT		0x20
+#define MIP4_R1_INFO_VERSION_CORE		0x22
+#define MIP4_R1_INFO_VERSION_APP		0x24
+#define MIP4_R1_INFO_VERSION_PARAM		0x26
+#define MIP4_R1_INFO_SECT_BOOT_START		0x30
+#define MIP4_R1_INFO_SECT_BOOT_END		0x31
+#define MIP4_R1_INFO_SECT_CORE_START		0x32
+#define MIP4_R1_INFO_SECT_CORE_END		0x33
+#define MIP4_R1_INFO_SECT_APP_START		0x34
+#define MIP4_R1_INFO_SECT_APP_END		0x35
+#define MIP4_R1_INFO_SECT_PARAM_START		0x36
+#define MIP4_R1_INFO_SECT_PARAM_END		0x37
+#define MIP4_R1_INFO_BUILD_DATE			0x40
+#define MIP4_R1_INFO_BUILD_TIME			0x44
+#define MIP4_R1_INFO_CHECKSUM_PRECALC		0x48
+#define MIP4_R1_INFO_CHECKSUM_REALTIME		0x4A
+#define MIP4_R1_INFO_PROTOCOL_NAME		0x50
+#define MIP4_R1_INFO_PROTOCOL_VERSION		0x58
+#define MIP4_R1_INFO_IC_ID			0x70
+#define MIP4_R1_INFO_IC_NAME			0x71
+#define MIP4_R1_INFO_IC_VENDOR_ID		0x75
+#define MIP4_R1_INFO_IC_HW_CATEGORY		0x77
+#define MIP4_R1_INFO_CONTACT_THD_SCR		0x78
+#define MIP4_R1_INFO_CONTACT_THD_KEY		0x7A
+
+#define MIP4_R0_EVENT				0x02
+#define MIP4_R1_EVENT_SUPPORTED_FUNC		0x00
+#define MIP4_R1_EVENT_FORMAT			0x04
+#define MIP4_R1_EVENT_SIZE			0x06
+#define MIP4_R1_EVENT_PACKET_INFO		0x10
+#define MIP4_R1_EVENT_PACKET_DATA		0x11
+
+#define MIP4_R0_CTRL				0x06
+#define MIP4_R1_CTRL_READY_STATUS		0x00
+#define MIP4_R1_CTRL_EVENT_READY		0x01
+#define MIP4_R1_CTRL_MODE			0x10
+#define MIP4_R1_CTRL_EVENT_TRIGGER_TYPE		0x11
+#define MIP4_R1_CTRL_RECALIBRATE		0x12
+#define MIP4_R1_CTRL_POWER_STATE		0x13
+#define MIP4_R1_CTRL_GESTURE_TYPE		0x14
+#define MIP4_R1_CTRL_DISABLE_ESD_ALERT		0x18
+#define MIP4_R1_CTRL_CHARGER_MODE		0x19
+#define MIP4_R1_CTRL_HIGH_SENS_MODE		0x1A
+#define MIP4_R1_CTRL_WINDOW_MODE		0x1B
+#define MIP4_R1_CTRL_PALM_REJECTION		0x1C
+#define MIP4_R1_CTRL_EDGE_CORRECTION		0x1D
+#define MIP4_R1_CTRL_ENTER_GLOVE_MODE		0x1E
+#define MIP4_R1_CTRL_I2C_ON_LPM			0x1F
+#define MIP4_R1_CTRL_GESTURE_DEBUG		0x20
+#define MIP4_R1_CTRL_PALM_EVENT			0x22
+#define MIP4_R1_CTRL_PROXIMITY_SENSING		0x23
+
+/* Value */
+#define MIP4_BOOT_MODE_BOOT			0x01
+#define MIP4_BOOT_MODE_APP			0x02
+
+#define MIP4_BOOT_STATUS_BUSY			0x05
+#define MIP4_BOOT_STATUS_ERROR			0x0E
+#define MIP4_BOOT_STATUS_DONE			0xA0
+
+#define MIP4_BOOT_CMD_MASS_ERASE		0x15
+#define MIP4_BOOT_CMD_PROGRAM			0x54
+#define MIP4_BOOT_CMD_ERASE			0x8F
+#define MIP4_BOOT_CMD_WRITE			0xA5
+#define MIP4_BOOT_CMD_READ			0xC2
+
+#define MIP4_EVENT_INPUT_TYPE_KEY		0
+#define MIP4_EVENT_INPUT_TYPE_SCREEN		1
+#define MIP4_EVENT_INPUT_TYPE_PROXIMITY		2
+
+#define I2C_RETRY_COUNT				3	/* 2~ */
+
+#define MIP4_BUF_SIZE				128
+#define MIP4_MAX_FINGERS			10
+#define MIP4_MAX_KEYS				4
+
+#define MIP4_TOUCH_MAJOR_MIN			0
+#define MIP4_TOUCH_MAJOR_MAX			255
+#define MIP4_TOUCH_MINOR_MIN			0
+#define MIP4_TOUCH_MINOR_MAX			255
+#define MIP4_PRESSURE_MIN			0
+#define MIP4_PRESSURE_MAX			255
+
+#define MIP4_FW_NAME			"melfas_mip4.fw"
+#define MIP4_FW_UPDATE_DEBUG		0	/* 0 (default) or 1 */
+
+struct mip4_fw_version {
+	u16 boot;
+	u16 core;
+	u16 app;
+	u16 param;
+};
+
+struct mip4_ts {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct gpio_desc *gpio_ce;
+
+	char phys[32];
+	char product_name[16];
+
+	unsigned int max_x;
+	unsigned int max_y;
+	u8 node_x;
+	u8 node_y;
+	u8 node_key;
+
+	struct mip4_fw_version fw_version;
+
+	unsigned int event_size;
+	unsigned int event_format;
+
+	unsigned int key_num;
+	unsigned short key_code[MIP4_MAX_KEYS];
+
+	bool wake_irq_enabled;
+
+	u8 buf[MIP4_BUF_SIZE];
+};
+
+static int mip4_i2c_xfer(struct mip4_ts *ts,
+			 char *write_buf, unsigned int write_len,
+			 char *read_buf, unsigned int read_len)
+{
+	struct i2c_msg msg[] = {
+		{
+			.addr = ts->client->addr,
+			.flags = 0,
+			.buf = write_buf,
+			.len = write_len,
+		}, {
+			.addr = ts->client->addr,
+			.flags = I2C_M_RD,
+			.buf = read_buf,
+			.len = read_len,
+		},
+	};
+	int retry = I2C_RETRY_COUNT;
+	int res;
+	int error;
+
+	do {
+		res = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
+		if (res == ARRAY_SIZE(msg))
+			return 0;
+
+		error = res < 0 ? res : -EIO;
+		dev_err(&ts->client->dev,
+			"%s - i2c_transfer failed: %d (%d)\n",
+			__func__, error, res);
+	} while (--retry);
+
+	return error;
+}
+
+static void mip4_parse_fw_version(const u8 *buf, struct mip4_fw_version *v)
+{
+	v->boot  = get_unaligned_le16(buf + 0);
+	v->core  = get_unaligned_le16(buf + 2);
+	v->app   = get_unaligned_le16(buf + 4);
+	v->param = get_unaligned_le16(buf + 6);
+}
+
+/*
+ * Read chip firmware version
+ */
+static int mip4_get_fw_version(struct mip4_ts *ts)
+{
+	u8 cmd[] = { MIP4_R0_INFO, MIP4_R1_INFO_VERSION_BOOT };
+	u8 buf[sizeof(ts->fw_version)];
+	int error;
+
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), buf, sizeof(buf));
+	if (error) {
+		memset(&ts->fw_version, 0xff, sizeof(ts->fw_version));
+		return error;
+	}
+
+	mip4_parse_fw_version(buf, &ts->fw_version);
+
+	return 0;
+}
+
+/*
+ * Fetch device characteristics
+ */
+static int mip4_query_device(struct mip4_ts *ts)
+{
+	int error;
+	u8 cmd[2];
+	u8 buf[8];
+
+	/* Product name */
+	cmd[0] = MIP4_R0_INFO;
+	cmd[1] = MIP4_R1_INFO_PRODUCT_NAME;
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd),
+			      ts->product_name, sizeof(ts->product_name));
+	if (error)
+		dev_warn(&ts->client->dev,
+			 "Failed to retrieve product name: %d\n", error);
+	else
+		dev_dbg(&ts->client->dev, "product name: %.*s\n",
+			(int)sizeof(ts->product_name), ts->product_name);
+
+	/* Firmware version */
+	error = mip4_get_fw_version(ts);
+	if (error)
+		dev_warn(&ts->client->dev,
+			"Failed to retrieve FW version: %d\n", error);
+	else
+		dev_dbg(&ts->client->dev, "F/W Version: %04X %04X %04X %04X\n",
+			 ts->fw_version.boot, ts->fw_version.core,
+			 ts->fw_version.app, ts->fw_version.param);
+
+	/* Resolution */
+	cmd[0] = MIP4_R0_INFO;
+	cmd[1] = MIP4_R1_INFO_RESOLUTION_X;
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), buf, 7);
+	if (error) {
+		dev_warn(&ts->client->dev,
+			 "Failed to retrieve touchscreen parameters: %d\n",
+			 error);
+	} else {
+		ts->max_x = get_unaligned_le16(&buf[0]);
+		ts->max_y = get_unaligned_le16(&buf[2]);
+		dev_dbg(&ts->client->dev, "max_x: %d, max_y: %d\n",
+			ts->max_x, ts->max_y);
+
+		ts->node_x = buf[4];
+		ts->node_y = buf[5];
+		ts->node_key = buf[6];
+		dev_dbg(&ts->client->dev,
+			"node_x: %d, node_y: %d, node_key: %d\n",
+			ts->node_x, ts->node_y, ts->node_key);
+
+		/* Key ts */
+		if (ts->node_key > 0)
+			ts->key_num = ts->node_key;
+	}
+
+	/* Protocol */
+	cmd[0] = MIP4_R0_EVENT;
+	cmd[1] = MIP4_R1_EVENT_SUPPORTED_FUNC;
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), buf, 7);
+	if (error) {
+		dev_warn(&ts->client->dev,
+			"Failed to retrieve device type: %d\n", error);
+		ts->event_format = 0xff;
+	} else {
+		ts->event_format = get_unaligned_le16(&buf[4]);
+		ts->event_size = buf[6];
+		dev_dbg(&ts->client->dev, "event_format: %d, event_size: %d\n",
+			ts->event_format, ts->event_size);
+
+		if (ts->event_format == 2 || ts->event_format > 3)
+			dev_warn(&ts->client->dev,
+				 "Unknown event format %d\n", ts->event_format);
+	}
+
+	return 0;
+}
+
+static int mip4_power_on(struct mip4_ts *ts)
+{
+	if (ts->gpio_ce) {
+		gpiod_set_value_cansleep(ts->gpio_ce, 1);
+
+		/* Booting delay : 200~300ms */
+		usleep_range(200 * 1000, 300 * 1000);
+	}
+
+	return 0;
+}
+
+static void mip4_power_off(struct mip4_ts *ts)
+{
+	if (ts->gpio_ce)
+		gpiod_set_value_cansleep(ts->gpio_ce, 0);
+}
+
+/*
+ * Clear touch input event status
+ */
+static void mip4_clear_input(struct mip4_ts *ts)
+{
+	int i;
+
+	/* Screen */
+	for (i = 0; i < MIP4_MAX_FINGERS; i++) {
+		input_mt_slot(ts->input, i);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, 0);
+	}
+
+	/* Keys */
+	for (i = 0; i < ts->key_num; i++)
+		input_report_key(ts->input, ts->key_code[i], 0);
+
+	input_sync(ts->input);
+}
+
+static int mip4_enable(struct mip4_ts *ts)
+{
+	int error;
+
+	error = mip4_power_on(ts);
+	if (error)
+		return error;
+
+	enable_irq(ts->client->irq);
+
+	return 0;
+}
+
+static void mip4_disable(struct mip4_ts *ts)
+{
+	disable_irq(ts->client->irq);
+
+	mip4_power_off(ts);
+
+	mip4_clear_input(ts);
+}
+
+/*****************************************************************
+ * Input handling
+ *****************************************************************/
+
+static void mip4_report_keys(struct mip4_ts *ts, u8 *packet)
+{
+	u8 key;
+	bool down;
+
+	switch (ts->event_format) {
+	case 0:
+	case 1:
+		key = packet[0] & 0x0F;
+		down = packet[0] & 0x80;
+		break;
+
+	case 3:
+	default:
+		key = packet[0] & 0x0F;
+		down = packet[1] & 0x01;
+		break;
+	}
+
+	/* Report key event */
+	if (key >= 1 && key <= ts->key_num) {
+		unsigned short keycode = ts->key_code[key - 1];
+
+		dev_dbg(&ts->client->dev,
+			"Key - ID: %d, keycode: %d, state: %d\n",
+			key, keycode, down);
+
+		input_event(ts->input, EV_MSC, MSC_SCAN, keycode);
+		input_report_key(ts->input, keycode, down);
+
+	} else {
+		dev_err(&ts->client->dev, "Unknown key: %d\n", key);
+	}
+}
+
+static void mip4_report_touch(struct mip4_ts *ts, u8 *packet)
+{
+	int id;
+	bool hover;
+	bool palm;
+	bool state;
+	u16 x, y;
+	u8 pressure_stage = 0;
+	u8 pressure;
+	u8 size;
+	u8 touch_major;
+	u8 touch_minor;
+
+	switch (ts->event_format) {
+	case 0:
+	case 1:
+		/* Touch only */
+		state = packet[0] & BIT(7);
+		hover = packet[0] & BIT(5);
+		palm = packet[0] & BIT(4);
+		id = (packet[0] & 0x0F) - 1;
+		x = ((packet[1] & 0x0F) << 8) | packet[2];
+		y = (((packet[1] >> 4) & 0x0F) << 8) |
+			packet[3];
+		pressure = packet[4];
+		size = packet[5];
+		if (ts->event_format == 0) {
+			touch_major = packet[5];
+			touch_minor = packet[5];
+		} else {
+			touch_major = packet[6];
+			touch_minor = packet[7];
+		}
+		break;
+
+	case 3:
+	default:
+		/* Touch + Force(Pressure) */
+		id = (packet[0] & 0x0F) - 1;
+		hover = packet[1] & BIT(2);
+		palm = packet[1] & BIT(1);
+		state = packet[1] & BIT(0);
+		x = ((packet[2] & 0x0F) << 8) | packet[3];
+		y = (((packet[2] >> 4) & 0x0F) << 8) |
+			packet[4];
+		size = packet[6];
+		pressure_stage = (packet[7] & 0xF0) >> 4;
+		pressure = ((packet[7] & 0x0F) << 8) |
+			packet[8];
+		touch_major = packet[9];
+		touch_minor = packet[10];
+		break;
+	}
+
+	dev_dbg(&ts->client->dev,
+		"Screen - Slot: %d State: %d X: %04d Y: %04d Z: %d\n",
+		id, state, x, y, pressure);
+
+	if (unlikely(id < 0 || id >= MIP4_MAX_FINGERS)) {
+		dev_err(&ts->client->dev, "Screen - invalid slot ID: %d\n", id);
+	} else if (state) {
+		/* Press or Move event */
+		input_mt_slot(ts->input, id);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, true);
+		input_report_abs(ts->input, ABS_MT_POSITION_X, x);
+		input_report_abs(ts->input, ABS_MT_POSITION_Y, y);
+		input_report_abs(ts->input, ABS_MT_PRESSURE, pressure);
+		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, touch_major);
+		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR, touch_minor);
+	} else {
+		/* Release event */
+		input_mt_slot(ts->input, id);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, 0);
+	}
+
+	input_mt_sync_frame(ts->input);
+}
+
+static int mip4_handle_packet(struct mip4_ts *ts, u8 *packet)
+{
+	u8 type;
+
+	switch (ts->event_format) {
+	case 0:
+	case 1:
+		type = (packet[0] & 0x40) >> 6;
+		break;
+
+	case 3:
+		type = (packet[0] & 0xF0) >> 4;
+		break;
+
+	default:
+		/* Should not happen unless we have corrupted firmware */
+		return -EINVAL;
+	}
+
+	dev_dbg(&ts->client->dev, "Type: %d\n", type);
+
+	/* Report input event */
+	switch (type) {
+	case MIP4_EVENT_INPUT_TYPE_KEY:
+		mip4_report_keys(ts, packet);
+		break;
+
+	case MIP4_EVENT_INPUT_TYPE_SCREEN:
+		mip4_report_touch(ts, packet);
+		break;
+
+	default:
+		dev_err(&ts->client->dev, "Unknown event type: %d\n", type);
+		break;
+	}
+
+	return 0;
+}
+
+static irqreturn_t mip4_interrupt(int irq, void *dev_id)
+{
+	struct mip4_ts *ts = dev_id;
+	struct i2c_client *client = ts->client;
+	unsigned int i;
+	int error;
+	u8 cmd[2];
+	u8 size;
+	bool alert;
+
+	/* Read packet info */
+	cmd[0] = MIP4_R0_EVENT;
+	cmd[1] = MIP4_R1_EVENT_PACKET_INFO;
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), ts->buf, 1);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to read packet info: %d\n", error);
+		goto out;
+	}
+
+	size = ts->buf[0] & 0x7F;
+	alert = ts->buf[0] & BIT(7);
+	dev_dbg(&client->dev, "packet size: %d, alert: %d\n", size, alert);
+
+	/* Check size */
+	if (!size) {
+		dev_err(&client->dev, "Empty packet\n");
+		goto out;
+	}
+
+	/* Read packet data */
+	cmd[0] = MIP4_R0_EVENT;
+	cmd[1] = MIP4_R1_EVENT_PACKET_DATA;
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), ts->buf, size);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to read packet data: %d\n", error);
+		goto out;
+	}
+
+	if (alert) {
+		dev_dbg(&client->dev, "Alert: %d\n", ts->buf[0]);
+	} else {
+		for (i = 0; i < size; i += ts->event_size) {
+			error = mip4_handle_packet(ts, &ts->buf[i]);
+			if (error)
+				break;
+		}
+
+		input_sync(ts->input);
+	}
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int mip4_input_open(struct input_dev *dev)
+{
+	struct mip4_ts *ts = input_get_drvdata(dev);
+
+	return mip4_enable(ts);
+}
+
+static void mip4_input_close(struct input_dev *dev)
+{
+	struct mip4_ts *ts = input_get_drvdata(dev);
+
+	mip4_disable(ts);
+}
+
+/*****************************************************************
+ * Firmware update
+ *****************************************************************/
+
+/* Firmware Info */
+#define MIP4_BL_PAGE_SIZE		512	/* 512 */
+#define MIP4_BL_PACKET_SIZE		512	/* 512, 256, 128, 64, ... */
+
+/*
+ * Firmware binary tail info
+ */
+
+struct mip4_bin_tail {
+	u8 tail_mark[4];
+	u8 chip_name[4];
+
+	__le32 bin_start_addr;
+	__le32 bin_length;
+
+	__le16 ver_boot;
+	__le16 ver_core;
+	__le16 ver_app;
+	__le16 ver_param;
+
+	u8 boot_start;
+	u8 boot_end;
+	u8 core_start;
+	u8 core_end;
+	u8 app_start;
+	u8 app_end;
+	u8 param_start;
+	u8 param_end;
+
+	u8 checksum_type;
+	u8 hw_category;
+
+	__le16 param_id;
+	__le32 param_length;
+	__le32 build_date;
+	__le32 build_time;
+
+	__le32 reserved1;
+	__le32 reserved2;
+	__le16 reserved3;
+	__le16 tail_size;
+	__le32 crc;
+} __packed;
+
+#define MIP4_BIN_TAIL_MARK	"MBT\001"
+#define MIP4_BIN_TAIL_SIZE	(sizeof(struct mip4_bin_tail))
+
+/*
+* Bootloader - Read status
+*/
+static int mip4_bl_read_status(struct mip4_ts *ts)
+{
+	u8 cmd[] = { MIP4_R0_BOOT, MIP4_R1_BOOT_STATUS };
+	u8 result;
+	struct i2c_msg msg[] = {
+		{
+			.addr = ts->client->addr,
+			.flags = 0,
+			.buf = cmd,
+			.len = sizeof(cmd),
+		}, {
+			.addr = ts->client->addr,
+			.flags = I2C_M_RD,
+			.buf = &result,
+			.len = sizeof(result),
+		},
+	};
+	int ret;
+	int error;
+	int retry = 1000;
+
+	do {
+		ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret != ARRAY_SIZE(msg)) {
+			error = ret < 0 ? ret : -EIO;
+			dev_err(&ts->client->dev,
+				"Failed to read bootloader status: %d\n",
+				error);
+			return error;
+		}
+
+		switch (result) {
+		case MIP4_BOOT_STATUS_DONE:
+			dev_dbg(&ts->client->dev, "%s - done\n", __func__);
+			return 0;
+
+		case MIP4_BOOT_STATUS_ERROR:
+			dev_err(&ts->client->dev, "Bootloader failure\n");
+			return -EIO;
+
+		case MIP4_BOOT_STATUS_BUSY:
+			dev_dbg(&ts->client->dev, "%s - Busy\n", __func__);
+			error = -EBUSY;
+			break;
+
+		default:
+			dev_err(&ts->client->dev,
+				"Unexpected bootloader status: %#02x\n",
+				result);
+			error = -EINVAL;
+			break;
+		}
+
+		usleep_range(1000, 2000);
+	} while (--retry);
+
+	return error;
+}
+
+/*
+* Bootloader - Change mode
+*/
+static int mip4_bl_change_mode(struct mip4_ts *ts, u8 mode)
+{
+	u8 mode_chg_cmd[] = { MIP4_R0_BOOT, MIP4_R1_BOOT_MODE, mode };
+	u8 mode_read_cmd[] = { MIP4_R0_BOOT, MIP4_R1_BOOT_MODE };
+	u8 result;
+	struct i2c_msg msg[] = {
+		{
+			.addr = ts->client->addr,
+			.flags = 0,
+			.buf = mode_read_cmd,
+			.len = sizeof(mode_read_cmd),
+		}, {
+			.addr = ts->client->addr,
+			.flags = I2C_M_RD,
+			.buf = &result,
+			.len = sizeof(result),
+		},
+	};
+	int retry = 10;
+	int ret;
+	int error;
+
+	do {
+		/* Send mode change command */
+		ret = i2c_master_send(ts->client,
+				      mode_chg_cmd, sizeof(mode_chg_cmd));
+		if (ret != sizeof(mode_chg_cmd)) {
+			error = ret < 0 ? ret : -EIO;
+			dev_err(&ts->client->dev,
+				"Failed to send %d mode change: %d (%d)\n",
+				mode, error, ret);
+			return error;
+		}
+
+		dev_dbg(&ts->client->dev,
+			"Sent mode change request (mode: %d)\n", mode);
+
+		/* Wait */
+		msleep(1000);
+
+		/* Verify target mode */
+		ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret != ARRAY_SIZE(msg)) {
+			error = ret < 0 ? ret : -EIO;
+			dev_err(&ts->client->dev,
+				"Failed to read device mode: %d\n", error);
+			return error;
+		}
+
+		dev_dbg(&ts->client->dev,
+			"Current device mode: %d, want: %d\n", result, mode);
+
+		if (result == mode)
+			return 0;
+
+	} while (--retry);
+
+	return -EIO;
+}
+
+/*
+ * Bootloader - Start bootloader mode
+ */
+static int mip4_bl_enter(struct mip4_ts *ts)
+{
+	return mip4_bl_change_mode(ts, MIP4_BOOT_MODE_BOOT);
+}
+
+/*
+ * Bootloader - Exit bootloader mode
+ */
+static int mip4_bl_exit(struct mip4_ts *ts)
+{
+	return mip4_bl_change_mode(ts, MIP4_BOOT_MODE_APP);
+}
+
+static int mip4_bl_get_address(struct mip4_ts *ts, u16 *buf_addr)
+{
+	u8 cmd[] = { MIP4_R0_BOOT, MIP4_R1_BOOT_BUF_ADDR };
+	u8 result[sizeof(u16)];
+	struct i2c_msg msg[] = {
+		{
+			.addr = ts->client->addr,
+			.flags = 0,
+			.buf = cmd,
+			.len = sizeof(cmd),
+		}, {
+			.addr = ts->client->addr,
+			.flags = I2C_M_RD,
+			.buf = result,
+			.len = sizeof(result),
+		},
+	};
+	int ret;
+	int error;
+
+	ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"Failed to retrieve bootloader buffer address: %d\n",
+			error);
+		return error;
+	}
+
+	*buf_addr = get_unaligned_le16(result);
+	dev_dbg(&ts->client->dev,
+		"Bootloader buffer address %#04x\n", *buf_addr);
+
+	return 0;
+}
+
+static int mip4_bl_program_page(struct mip4_ts *ts, int offset,
+				const u8 *data, int length, u16 buf_addr)
+{
+	u8 cmd[6];
+	u8 *data_buf;
+	u16 buf_offset;
+	int ret;
+	int error;
+
+	dev_dbg(&ts->client->dev, "Writing page @%#06x (%d)\n",
+		offset, length);
+
+	if (length > MIP4_BL_PAGE_SIZE || length % MIP4_BL_PACKET_SIZE) {
+		dev_err(&ts->client->dev,
+			"Invalid page length: %d\n", length);
+		return -EINVAL;
+	}
+
+	data_buf = kmalloc(2 + MIP4_BL_PACKET_SIZE, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+
+	/* Addr */
+	cmd[0] = MIP4_R0_BOOT;
+	cmd[1] = MIP4_R1_BOOT_TARGET_ADDR;
+	put_unaligned_le32(offset, &cmd[2]);
+	ret = i2c_master_send(ts->client, cmd, 6);
+	if (ret != 6) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"Failed to send write page address: %d\n", error);
+		goto out;
+	}
+
+	/* Size */
+	cmd[0] = MIP4_R0_BOOT;
+	cmd[1] = MIP4_R1_BOOT_SIZE;
+	put_unaligned_le32(length, &cmd[2]);
+	ret = i2c_master_send(ts->client, cmd, 6);
+	if (ret != 6) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"Failed to send write page size: %d\n", error);
+		goto out;
+	}
+
+	/* Data */
+	for (buf_offset = 0;
+	     buf_offset < length;
+	     buf_offset += MIP4_BL_PACKET_SIZE) {
+		dev_dbg(&ts->client->dev,
+			"writing chunk at %#04x (size %d)\n",
+			buf_offset, MIP4_BL_PACKET_SIZE);
+		put_unaligned_be16(buf_addr + buf_offset, data_buf);
+		memcpy(&data_buf[2], &data[buf_offset], MIP4_BL_PACKET_SIZE);
+		ret = i2c_master_send(ts->client,
+				      data_buf, 2 + MIP4_BL_PACKET_SIZE);
+		if (ret != 2 + MIP4_BL_PACKET_SIZE) {
+			error = ret < 0 ? ret : -EIO;
+			dev_err(&ts->client->dev,
+				"Failed to read chunk at %#04x (size %d): %d\n",
+				buf_offset, MIP4_BL_PACKET_SIZE, error);
+			goto out;
+		}
+	}
+
+	/* Command */
+	cmd[0] = MIP4_R0_BOOT;
+	cmd[1] = MIP4_R1_BOOT_CMD;
+	cmd[2] = MIP4_BOOT_CMD_PROGRAM;
+	ret = i2c_master_send(ts->client, cmd, 3);
+	if (ret != 3) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"Failed to send 'write' command: %d\n", error);
+		goto out;
+	}
+
+	/* Status */
+	error = mip4_bl_read_status(ts);
+
+out:
+	kfree(data_buf);
+	return error ? error : 0;
+}
+
+static int mip4_bl_verify_page(struct mip4_ts *ts, int offset,
+			       const u8 *data, int length, int buf_addr)
+{
+	u8 cmd[8];
+	u8 *read_buf;
+	int buf_offset;
+	struct i2c_msg msg[] = {
+		{
+			.addr = ts->client->addr,
+			.flags = 0,
+			.buf = cmd,
+			.len = 2,
+		}, {
+			.addr = ts->client->addr,
+			.flags = I2C_M_RD,
+			.len = MIP4_BL_PACKET_SIZE,
+		},
+	};
+	int ret;
+	int error;
+
+	dev_dbg(&ts->client->dev, "Validating page @%#06x (%d)\n",
+		offset, length);
+
+	/* Addr */
+	cmd[0] = MIP4_R0_BOOT;
+	cmd[1] = MIP4_R1_BOOT_TARGET_ADDR;
+	put_unaligned_le32(offset, &cmd[2]);
+	ret = i2c_master_send(ts->client, cmd, 6);
+	if (ret != 6) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"Failed to send read page address: %d\n", error);
+		return error;
+	}
+
+	/* Size */
+	cmd[0] = MIP4_R0_BOOT;
+	cmd[1] = MIP4_R1_BOOT_SIZE;
+	put_unaligned_le32(length, &cmd[2]);
+	ret = i2c_master_send(ts->client, cmd, 6);
+	if (ret != 6) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"Failed to send read page size: %d\n", error);
+		return error;
+	}
+
+	/* Command */
+	cmd[0] = MIP4_R0_BOOT;
+	cmd[1] = MIP4_R1_BOOT_CMD;
+	cmd[2] = MIP4_BOOT_CMD_READ;
+	ret = i2c_master_send(ts->client, cmd, 3);
+	if (ret != 3) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"Failed to send 'read' command: %d\n", error);
+		return error;
+	}
+
+	/* Status */
+	error = mip4_bl_read_status(ts);
+	if (error)
+		return error;
+
+	/* Read */
+	msg[1].buf = read_buf = kmalloc(MIP4_BL_PACKET_SIZE, GFP_KERNEL);
+	if (!read_buf)
+		return -ENOMEM;
+
+	for (buf_offset = 0;
+	     buf_offset < length;
+	     buf_offset += MIP4_BL_PACKET_SIZE) {
+		dev_dbg(&ts->client->dev,
+			"reading chunk at %#04x (size %d)\n",
+			buf_offset, MIP4_BL_PACKET_SIZE);
+		put_unaligned_be16(buf_addr + buf_offset, cmd);
+		ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret != ARRAY_SIZE(msg)) {
+			error = ret < 0 ? ret : -EIO;
+			dev_err(&ts->client->dev,
+				"Failed to read chunk at %#04x (size %d): %d\n",
+				buf_offset, MIP4_BL_PACKET_SIZE, error);
+			break;
+		}
+
+		if (memcmp(&data[buf_offset], read_buf, MIP4_BL_PACKET_SIZE)) {
+			dev_err(&ts->client->dev,
+				"Failed to validate chunk at %#04x (size %d)\n",
+				buf_offset, MIP4_BL_PACKET_SIZE);
+#if MIP4_FW_UPDATE_DEBUG
+			print_hex_dump(KERN_DEBUG,
+				       MIP4_DEVICE_NAME " F/W File: ",
+				       DUMP_PREFIX_OFFSET, 16, 1,
+				       data + offset, MIP4_BL_PACKET_SIZE,
+				       false);
+			print_hex_dump(KERN_DEBUG,
+				       MIP4_DEVICE_NAME " F/W Chip: ",
+				       DUMP_PREFIX_OFFSET, 16, 1,
+				       read_buf, MIP4_BL_PAGE_SIZE, false);
+#endif
+			error = -EINVAL;
+			break;
+		}
+	}
+
+	kfree(read_buf);
+	return error ? error : 0;
+}
+
+/*
+ * Flash chip firmware
+ */
+static int mip4_flash_fw(struct mip4_ts *ts,
+			 const u8 *fw_data, u32 fw_size, u32 fw_offset)
+{
+	struct i2c_client *client = ts->client;
+	int offset;
+	u16 buf_addr;
+	int error, error2;
+
+	/* Enter bootloader mode */
+	dev_dbg(&client->dev, "Entering bootloader mode\n");
+
+	error = mip4_bl_enter(ts);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to enter bootloader mode: %d\n",
+			error);
+		return error;
+	}
+
+	/* Read info */
+	error = mip4_bl_get_address(ts, &buf_addr);
+	if (error)
+		goto exit_bl;
+
+	/* Program & Verify */
+	dev_dbg(&client->dev,
+		"Program & Verify, page size: %d, packet size: %d\n",
+		MIP4_BL_PAGE_SIZE, MIP4_BL_PACKET_SIZE);
+
+	for (offset = fw_offset;
+	     offset < fw_offset + fw_size;
+	     offset += MIP4_BL_PAGE_SIZE) {
+		/* Program */
+		error = mip4_bl_program_page(ts, offset, fw_data + offset,
+					     MIP4_BL_PAGE_SIZE, buf_addr);
+		if (error)
+			break;
+
+		/* Verify */
+		error = mip4_bl_verify_page(ts, offset, fw_data + offset,
+					    MIP4_BL_PAGE_SIZE, buf_addr);
+		if (error)
+			break;
+	}
+
+exit_bl:
+	/* Exit bootloader mode */
+	dev_dbg(&client->dev, "Exiting bootloader mode\n");
+
+	error2 = mip4_bl_exit(ts);
+	if (error2) {
+		dev_err(&client->dev,
+			"Failed to exit bootloader mode: %d\n", error2);
+		if (!error)
+			error = error2;
+	}
+
+	/* Reset chip */
+	mip4_power_off(ts);
+	mip4_power_on(ts);
+
+	mip4_query_device(ts);
+
+	/* Refresh device parameters */
+	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, ts->max_x, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, ts->max_y, 0, 0);
+	input_set_abs_params(ts->input, ABS_X, 0, ts->max_x, 0, 0);
+	input_set_abs_params(ts->input, ABS_Y, 0, ts->max_y, 0, 0);
+
+	return error ? error : 0;
+}
+
+static int mip4_parse_firmware(struct mip4_ts *ts, const struct firmware *fw,
+			       u32 *fw_offset_start, u32 *fw_size,
+			       const struct mip4_bin_tail **pfw_info)
+{
+	const struct mip4_bin_tail *fw_info;
+	struct mip4_fw_version fw_version;
+	u16 tail_size;
+
+	if (fw->size < MIP4_BIN_TAIL_SIZE) {
+		dev_err(&ts->client->dev,
+			"Invalid firmware, size mismatch (tail %zd vs %zd)\n",
+			MIP4_BIN_TAIL_SIZE, fw->size);
+		return -EINVAL;
+	}
+
+	fw_info = (const void *)&fw->data[fw->size - MIP4_BIN_TAIL_SIZE];
+
+#if MIP4_FW_UPDATE_DEBUG
+	print_hex_dump(KERN_ERR, MIP4_DEVICE_NAME " Bin Info: ",
+		       DUMP_PREFIX_OFFSET, 16, 1, *fw_info, tail_size, false);
+#endif
+
+	tail_size = get_unaligned_le16(&fw_info->tail_size);
+	if (tail_size != MIP4_BIN_TAIL_SIZE) {
+		dev_err(&ts->client->dev,
+			"wrong tail size: %d (expected %zd)\n",
+			tail_size, MIP4_BIN_TAIL_SIZE);
+		return -EINVAL;
+	}
+
+	/* Check bin format */
+	if (memcmp(fw_info->tail_mark, MIP4_BIN_TAIL_MARK,
+		   sizeof(fw_info->tail_mark))) {
+		dev_err(&ts->client->dev,
+			"unable to locate tail marker (%*ph vs %*ph)\n",
+			(int)sizeof(fw_info->tail_mark), fw_info->tail_mark,
+			(int)sizeof(fw_info->tail_mark), MIP4_BIN_TAIL_MARK);
+		return -EINVAL;
+	}
+
+	*fw_offset_start = get_unaligned_le32(&fw_info->bin_start_addr);
+	*fw_size = get_unaligned_le32(&fw_info->bin_length);
+
+	dev_dbg(&ts->client->dev,
+		"F/W Data offset: %#08x, size: %d\n",
+		*fw_offset_start, *fw_size);
+
+	if (*fw_size % MIP4_BL_PAGE_SIZE) {
+		dev_err(&ts->client->dev,
+			"encoded fw length %d is not multiple of pages (%d)\n",
+			*fw_size, MIP4_BL_PAGE_SIZE);
+		return -EINVAL;
+	}
+
+	if (fw->size != *fw_offset_start + *fw_size) {
+		dev_err(&ts->client->dev,
+			"Wrong firmware size, expected %d bytes, got %zd\n",
+			*fw_offset_start + *fw_size, fw->size);
+		return -EINVAL;
+	}
+
+	mip4_parse_fw_version((const u8 *)&fw_info->ver_boot, &fw_version);
+
+	dev_dbg(&ts->client->dev,
+		"F/W file version %04X %04X %04X %04X\n",
+		fw_version.boot, fw_version.core,
+		fw_version.app, fw_version.param);
+
+	dev_dbg(&ts->client->dev, "F/W chip version: %04X %04X %04X %04X\n",
+		 ts->fw_version.boot, ts->fw_version.core,
+		 ts->fw_version.app, ts->fw_version.param);
+
+	/* Check F/W type */
+	if (fw_version.boot != 0xEEEE && fw_version.boot != 0xFFFF &&
+	    fw_version.core == 0xEEEE &&
+	    fw_version.app == 0xEEEE &&
+	    fw_version.param == 0xEEEE) {
+		dev_dbg(&ts->client->dev, "F/W type: Bootloader\n");
+	} else if (fw_version.boot == 0xEEEE &&
+		   fw_version.core != 0xEEEE && fw_version.core != 0xFFFF &&
+		   fw_version.app != 0xEEEE && fw_version.app != 0xFFFF &&
+		   fw_version.param != 0xEEEE && fw_version.param != 0xFFFF) {
+		dev_dbg(&ts->client->dev, "F/W type: Main\n");
+	} else {
+		dev_err(&ts->client->dev, "Wrong firmware type\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mip4_execute_fw_update(struct mip4_ts *ts, const struct firmware *fw)
+{
+	const struct mip4_bin_tail *fw_info;
+	u32 fw_start_offset;
+	u32 fw_size;
+	int retires = 3;
+	int error;
+
+	error = mip4_parse_firmware(ts, fw,
+				    &fw_start_offset, &fw_size, &fw_info);
+	if (error)
+		return error;
+
+	if (ts->input->users) {
+		disable_irq(ts->client->irq);
+	} else {
+		error = mip4_power_on(ts);
+		if (error)
+			return error;
+	}
+
+	/* Update firmware */
+	do {
+		error = mip4_flash_fw(ts, fw->data, fw_size, fw_start_offset);
+		if (!error)
+			break;
+	} while (--retires);
+
+	if (error)
+		dev_err(&ts->client->dev,
+			"Failed to flash firmware: %d\n", error);
+
+	/* Enable IRQ */
+	if (ts->input->users)
+		enable_irq(ts->client->irq);
+	else
+		mip4_power_off(ts);
+
+	return error ? error : 0;
+}
+
+static ssize_t mip4_sysfs_fw_update(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	const struct firmware *fw;
+	int error;
+
+	error = request_firmware(&fw, MIP4_FW_NAME, dev);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to retrieve firmware %s: %d\n",
+			MIP4_FW_NAME, error);
+		return error;
+	}
+
+	/*
+	 * Take input mutex to prevent racing with itself and also with
+	 * userspace opening and closing the device and also suspend/resume
+	 * transitions.
+	 */
+	mutex_lock(&ts->input->mutex);
+
+	error = mip4_execute_fw_update(ts, fw);
+
+	mutex_unlock(&ts->input->mutex);
+
+	release_firmware(fw);
+
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Firmware update failed: %d\n", error);
+		return error;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mip4_sysfs_fw_update);
+
+static ssize_t mip4_sysfs_read_fw_version(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	size_t count;
+
+	/* Take lock to prevent racing with firmware update */
+	mutex_lock(&ts->input->mutex);
+
+	count = snprintf(buf, PAGE_SIZE, "%04X %04X %04X %04X\n",
+			 ts->fw_version.boot, ts->fw_version.core,
+			 ts->fw_version.app, ts->fw_version.param);
+
+	mutex_unlock(&ts->input->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(fw_version, S_IRUGO, mip4_sysfs_read_fw_version, NULL);
+
+static struct attribute *mip4_attrs[] = {
+	&dev_attr_fw_version.attr,
+	&dev_attr_update_fw.attr,
+	NULL,
+};
+
+static const struct attribute_group mip4_attr_group = {
+	.attrs = mip4_attrs,
+};
+
+static void mip4_sysfs_remove(void *_data)
+{
+	struct mip4_ts *ts = _data;
+
+	sysfs_remove_group(&ts->client->dev.kobj, &mip4_attr_group);
+}
+
+static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct mip4_ts *ts;
+	struct input_dev *input;
+	int error;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "Not supported I2C adapter\n");
+		return -ENXIO;
+	}
+
+	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(&client->dev);
+	if (!input)
+		return -ENOMEM;
+
+	ts->client = client;
+	ts->input = input;
+
+	snprintf(ts->phys, sizeof(ts->phys),
+		 "%s/input0", dev_name(&client->dev));
+
+	ts->gpio_ce = devm_gpiod_get_optional(&client->dev,
+					      "ce", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->gpio_ce)) {
+		error = PTR_ERR(ts->gpio_ce);
+		if (error != EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get gpio: %d\n", error);
+		return error;
+	}
+
+	error = mip4_power_on(ts);
+	if (error)
+		return error;
+	error = mip4_query_device(ts);
+	mip4_power_off(ts);
+	if (error)
+		return error;
+
+	input->name = "MELFAS MIP4 Touchscreen";
+	input->phys = ts->phys;
+
+	input->id.bustype = BUS_I2C;
+	input->id.vendor = 0x13c5;
+
+	input->open = mip4_input_open;
+	input->close = mip4_input_close;
+
+	input_set_drvdata(input, ts);
+
+	input->keycode = ts->key_code;
+	input->keycodesize = sizeof(*ts->key_code);
+	input->keycodemax = ts->key_num;
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, ts->max_x, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ts->max_y, 0, 0);
+	input_set_abs_params(input, ABS_MT_PRESSURE,
+			     MIP4_PRESSURE_MIN, MIP4_PRESSURE_MAX, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,
+			     MIP4_TOUCH_MAJOR_MIN, MIP4_TOUCH_MAJOR_MAX, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR,
+			     MIP4_TOUCH_MINOR_MIN, MIP4_TOUCH_MINOR_MAX, 0, 0);
+
+	error = input_mt_init_slots(input, MIP4_MAX_FINGERS, INPUT_MT_DIRECT);
+	if (error)
+		return error;
+
+	i2c_set_clientdata(client, ts);
+
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, mip4_interrupt,
+					  IRQF_ONESHOT, MIP4_DEVICE_NAME, ts);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to request interrupt %d: %d\n",
+			client->irq, error);
+		return error;
+	}
+
+	disable_irq(client->irq);
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to register input device: %d\n", error);
+		return error;
+	}
+
+	error = sysfs_create_group(&client->dev.kobj, &mip4_attr_group);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to create sysfs attribute group: %d\n", error);
+		return error;
+	}
+
+	error = devm_add_action(&client->dev, mip4_sysfs_remove, ts);
+	if (error) {
+		mip4_sysfs_remove(ts);
+		dev_err(&client->dev,
+			"Failed to install sysfs remoce action: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused mip4_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	struct input_dev *input = ts->input;
+
+	mutex_lock(&input->mutex);
+
+	if (device_may_wakeup(dev))
+		ts->wake_irq_enabled = enable_irq_wake(client->irq) == 0;
+	else if (input->users)
+		mip4_disable(ts);
+
+	mutex_unlock(&input->mutex);
+
+	return 0;
+}
+
+static int __maybe_unused mip4_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	struct input_dev *input = ts->input;
+
+	mutex_lock(&input->mutex);
+
+	if (ts->wake_irq_enabled)
+		disable_irq_wake(client->irq);
+	else if (input->users)
+		mip4_enable(ts);
+
+	mutex_unlock(&input->mutex);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(mip4_pm_ops, mip4_suspend, mip4_resume);
+
+#ifdef CONFIG_OF
+static const struct of_device_id mip4_of_match[] = {
+	{ .compatible = "melfas,"MIP4_DEVICE_NAME, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mip4_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id mip4_acpi_match[] = {
+	{ "MLFS0000", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, mip4_acpi_match);
+#endif
+
+static const struct i2c_device_id mip4_i2c_ids[] = {
+	{ MIP4_DEVICE_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mip4_i2c_ids);
+
+static struct i2c_driver mip4_driver = {
+	.id_table = mip4_i2c_ids,
+	.probe = mip4_probe,
+	.driver = {
+		.name = MIP4_DEVICE_NAME,
+		.of_match_table = of_match_ptr(mip4_of_match),
+		.acpi_match_table = ACPI_PTR(mip4_acpi_match),
+		.pm = &mip4_pm_ops,
+	},
+};
+module_i2c_driver(mip4_driver);
+
+MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
+MODULE_VERSION("2016.01.13");
+MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
+MODULE_LICENSE("GPL");
