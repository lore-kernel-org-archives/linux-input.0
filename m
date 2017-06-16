From: Wang Yafei <wangyafei@goodix.com>
Subject: Re: [PATCH V2] Add driver for GOODiX GTx5 series touchsereen
Date: Fri, 16 Jun 2017 15:51:54 +0800
Message-ID: <5cda3a3f-657d-7f02-4975-61963c2bfa32@goodix.com>
References: <1302721b-ee36-f616-cd0c-1f4e52448740@goodix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1302721b-ee36-f616-cd0c-1f4e52448740@goodix.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@goodix.com
List-Id: linux-input@vger.kernel.org

Ping for review


On 06/13/2017 02:27 PM, Wang Yafei wrote:
> V2 changes:
>
> - replace touchscreen properties according to the description in
>   Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>
> - Droped all compat stuff for older kernels
>
> - Removed Android stuff (EARLY_SUSPEND, CONFIG_FB)
>
> - Use device_property_read_*  get device properties
>
> - use get-unaligned_*() API
>
> - Use dev_err() dev_dbg() for logging
>
> - remove pinctrl functions
>
> - remove some unused functions
>
> V1 info:
> This driver is for GOODiX GTx5 series touchscreen controllers
> such as GT8589, GT7589. This driver designed with hierarchial structure,
> for that can be modified to support subsequent controllers easily.
> Some zones of the touchscreen can be set to buttons(according to the
> hardware). That is why it handles button and multitouch events.
>
> A brief description of driver structure
> - Core Layer: This layer responsible for basic input events report,
>   GPIO pinctrl, Interrupt, Power resources manager and submodules
>   manager.
> - Hardware Layer: This layer responsible for controllers initialization,
>   irq handle as well as bus read/write.
> - External Module Layer: This layer used for support more features
>   such as firmware update, debug tools and gesture wakeup.
>
> Signed-off-by: Wang Yafei <wangyafei@goodix.com>
> ---
>  drivers/input/touchscreen/Kconfig                  |    1 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  .../input/touchscreen/goodix-ts-sunrise/Kconfig    |   36 +
>  .../input/touchscreen/goodix-ts-sunrise/Makefile   |    6 +
>  .../touchscreen/goodix-ts-sunrise/goodix-gtx5.txt  |   75 +
>  .../goodix-ts-sunrise/goodix_gtx5_i2c.c            |  895 ++++++++++++
>  .../goodix-ts-sunrise/goodix_gtx5_update.c         | 1450 ++++++++++++++++++++
>  .../touchscreen/goodix-ts-sunrise/goodix_ts_core.c | 1366 ++++++++++++++++++
>  .../touchscreen/goodix-ts-sunrise/goodix_ts_core.h |  553 ++++++++
>  .../goodix-ts-sunrise/goodix_ts_tools.c            |  542 ++++++++
>  10 files changed, 4925 insertions(+)
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/Kconfig
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/Makefile
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/goodix-gtx5.txt
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_i2c.c
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_update.c
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.c
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.h
>  create mode 100755 drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_tools.c
>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index cf26ca4..f3642bb 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -15,6 +15,7 @@ config TOUCHSCREEN_PROPERTIES
>  	def_tristate INPUT
>  	depends on INPUT
>  
> +source "drivers/input/touchscreen/goodix-ts-sunrise/Kconfig"
>  config TOUCHSCREEN_88PM860X
>  	tristate "Marvell 88PM860x touchscreen"
>  	depends on MFD_88PM860X
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 18e4769..d9408c0 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -6,6 +6,7 @@
>  
>  wm97xx-ts-y := wm97xx-core.o
>  
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_GTX5)	+= goodix-ts-sunrise/
>  obj-$(CONFIG_TOUCHSCREEN_PROPERTIES)	+= of_touchscreen.o
>  obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+= 88pm860x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/Kconfig b/drivers/input/touchscreen/goodix-ts-sunrise/Kconfig
> new file mode 100755
> index 0000000..8e16595
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/Kconfig
> @@ -0,0 +1,36 @@
> +#
> +# Goodix touchscreen driver configuration
> +#
> +menuconfig TOUCHSCREEN_GOODIX_GTX5
> +	bool "Goodix GTx5 touchscreen"
> +	depends on I2C
> +	default y
> +	help
> +	  Say Y here if you have a Goodix GTx5xx touchscreen connected
> +	  to your system.
> +
> +	  If unsure, say N.
> +
> +if TOUCHSCREEN_GOODIX_GTX5
> +
> +config TOUCHSCREEN_GOODIX_GTX5_UPDATE
> +	tristate "Goodix GTx5xx firmware update module"
> +	default y
> +	help
> +	  Say Y here to enable support for doing firmware update.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here.
> +
> +config TOUCHSCREEN_GOODIX_GTX5_TOOLS
> +	tristate "Goodix touch tools support"
> +	default n
> +	help
> +	  Say Y here to enable debug tools.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here.
> +
> +endif
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/Makefile b/drivers/input/touchscreen/goodix-ts-sunrise/Makefile
> new file mode 100755
> index 0000000..690f256
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/Makefile
> @@ -0,0 +1,6 @@
> +# Goodix Touchscreen Makefile
> +
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_GTX5)           += goodix_gtx5_i2c.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_GTX5)           += goodix_ts_core.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_GTX5_TOOLS)    += goodix_ts_tools.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_GTX5_UPDATE)    += goodix_gtx5_update.o
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/goodix-gtx5.txt b/drivers/input/touchscreen/goodix-ts-sunrise/goodix-gtx5.txt
> new file mode 100755
> index 0000000..116c3ec
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/goodix-gtx5.txt
> @@ -0,0 +1,75 @@
> +Device tree bindings for Goodix GTx5 series touchscreen controller
> +
> +Required properties:
> +
> +- compatible	: should be "goodix,gtx5" or "goodix,gsx" 
> +
> +- reg	: I2C address of the chip. Should be 0x5d or 0x14
> +- interrupt-parent	: Inerrupt controller to which the chip is connected
> +- interrupts	: Interrrupt to which the chip is connected
> +- touchscreen-size-x	: horizontal resolution of touchscreen          
> +                                  (in pixels)                                   
> +- touchscreen-size-y	: vertical resolution of touchscreen            
> +                                  (in pixels)                                  
> +- touchscreen-max-id	: panel supported max touch number.
> +- touchscreen-max-w	: panel max width value.
> +
> +
> +Optional properties:
> +- reset-gpios	: reset gpio.
> +- irq-gpios	: interrupt gpio. 
> +- irq-flags	: irq trigger type config, value should be:
> +                       1 - rising edge,
> +                       2 - falling edge,
> +                       4 - high level,
> +                       5 - low level.
> +- touchscreen-swapped-x-y: swap  x/y axis coordinates.
> +- touchscreen-key-map: keycode value map  /*KEY_HOMEPAGE, KEY_BACK*/
> +- power-on-delay-us: delay after power on.
> +- power-off-delay-us: delay after power off.
> +- normal-cfg: touch device normal config data.
> +- vtouch-supply	: power supply for the touch device.
> +Example:
> +i2c@00000000 {
> +	/* ... */
> +
> +	goodix-ts-i2c@14 {
> +		compatible = "goodix,gtx5";
> +		reg = <0x14>;
> +		interrupt-parent = <&msm_gpio>;
> +		interrupts = <13 0x2800>;
> +		vtouch-supply = <&pm8916_l15>;
> +		reset-gpios = <&msm_gpio 12 0x0>;
> +		irq-gpios = <&msm_gpio 13 0x2800>;
> +		irq-flags = <1>; /* 1:trigger rising, 2:trigger falling;*/
> +		touchscreen-max-id = <10>;
> +		touchscreen-size-x = <400>;
> +		touchscreen-size-y = <400>;
> +		touchscreen-max-w = <400>;
> +		touchscreen-max-pressure = <255>;
> +		touchscreen-swapped-x-y;
> +		touchscreen-key-map = <172 158>; /*KEY_HOMEPAGE, KEY_BACK*/
> +		sensor0 {
> +			normal-cfg = [
> +				02 00 00 09 09 01 07 02 00 00 00 00 01 00 3C 00 07 07
> +				00 00 00 00 00 00 40 01 40 01 C8 00 96 00 F4 01 F4 01
> +				F4 01 20 01 11 0A 0A 03 14 14 14 14 0A 0C 01 01 11 11
> +				11 00 14 14 14 14 14 14 14 14 14 00 00 0F 00 00 00 00
> +				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +				00 00 00 00 00 00 00 00 00 00 11 09 10 00 31 32 33 34
> +				00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 CA 64 00
> +				00 00 00 00 00 00 09 00 13 00 00 00 00 00 00 00 00 00
> +				50 B0 19 00 19 00 05 00 00 00 00 0A 05 00 00 00 00 00
> +				01 00 FF 00 0B 06 0D 02 FF 04 05 03 07 01 08 0A 0E 11
> +				0F 10 09 13 0C 16 17 14 18 12 19 15 1D 1E 1C 1F 1B 20
> +				1A 2A 29 28 25 2B 27 21 FF 24 22 2C 26 23 FF 00 00 00
> +				00 00 00 00 00 00 00 00 00 00 00 00 80 80 80 80 80 80
> +				80 80 80 80 80 80 80 80 80 80 9F 22 01 AE];
> +		};
> +		sensor1 {
> +			normal-cfg = [ ];
> +		};
> +	};
> +}
> +
> +
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_i2c.c b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_i2c.c
> new file mode 100755
> index 0000000..5a0585a
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_i2c.c
> @@ -0,0 +1,895 @@
> +/*
> + * Goodix GTx5 Touchscreen Dirver
> + * Hardware interface layer of touchdriver architecture.
> + *
> + * Copyright (C) 2015 - 2016 Goodix, Inc.
> + * Authors:  Wang Yafei <wangyafei@goodix.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be a reference
> + * to you, when you are integrating the GOODiX's CTP IC into your system,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/ctype.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include "goodix_ts_core.h"
> +
> +#define TS_DT_COMPATIBLE	"goodix,gtx5"
> +#define TS_DRIVER_NAME		"goodix_i2c"
> +#define I2C_MAX_TRANSFER_SIZE	256
> +#define TS_ADDR_LENGTH		2
> +
> +#define TS_REG_COORDS_BASE	0x824E
> +#define TS_REG_CMD		0x8040
> +#define TS_REG_REQUEST		0x8044
> +#define TS_REG_VERSION		0x8240
> +#define TS_REG_CFG_BASE		0x8050
> +
> +#define CFG_XMAX_OFFSET (0x8052 - 0x8050)
> +#define CFG_YMAX_OFFSET	(0x8054 - 0x8050)
> +
> +#define REQUEST_HANDLED	0x00
> +#define REQUEST_CONFIG	0x01
> +#define REQUEST_BAKREF	0x02
> +#define REQUEST_RESET	0x03
> +#define REQUEST_MAINCLK	0x04
> +#define REQUEST_IDLE	0x05
> +
> +#define TS_MAX_SENSORID	5
> +#define TS_CFG_MAX_LEN	495
> +/* set defalut irq flags as Falling edge */
> +#define DEFAULT_IRQ_FLAGS 2
> +#if TS_CFG_MAX_LEN > GOODIX_CFG_MAX_SIZE
> +#error GOODIX_CFG_MAX_SIZE too small, please fix.
> +#endif
> +
> +#ifdef CONFIG_OF
> +/*
> + * goodix_parse_dt_resolution - parse resolution from dt
> + * @dev: device
> + * @board_data: pointer to board data structure
> + * return: 0 - no error, <0 error
> + */
> +static int goodix_parse_dt_resolution(struct device *dev,
> +		struct goodix_ts_board_data *board_data)
> +{
> +	int r, err = 0;
> +
> +	r = device_property_read_u32(dev, "touchscreen-max-id",
> +				&board_data->panel_max_id);
> +	if (r || board_data->panel_max_id > GOODIX_MAX_TOUCH)
> +		board_data->panel_max_id = GOODIX_MAX_TOUCH;
> +
> +	r = device_property_read_u32(dev, "touchscreen-size-x",
> +				 &board_data->panel_max_x);
> +	if (r)
> +		err = -ENOENT;
> +
> +	r = device_property_read_u32(dev, "touchscreen-size-y",
> +				&board_data->panel_max_y);
> +	if (r)
> +		err = -ENOENT;
> +
> +	r = device_property_read_u32(dev, "touchscreen-max-w",
> +				&board_data->panel_max_w);
> +	if (r)
> +		err = -ENOENT;
> +
> +	board_data->swap_axis = device_property_read_bool(dev,
> +			"touchscreen-swapped-x-y");
> +
> +	return err;
> +}
> +
> +/**
> + * goodix_parse_dt - parse board data from dt
> + * @dev: pointer to device
> + * @board_data: pointer to board data structure
> + * return: 0 - no error, <0 error
> + */
> +static int goodix_parse_dt(struct device *dev,
> +	struct goodix_ts_board_data *board_data)
> +{
> +	int r;
> +
> +	if (!board_data) {
> +		dev_err(dev, "Invalid board data\n");
> +		return -EINVAL;
> +	}
> +
> +	r = device_property_read_u32(dev, "irq-flags",
> +			&board_data->irq_flags);
> +	if (r) {
> +		dev_info(dev, "Use default irq flags:falling_edge\n");
> +		board_data->irq_flags = DEFAULT_IRQ_FLAGS;
> +	}
> +
> +	board_data->avdd_name = "vtouch";
> +	r = device_property_read_u32(dev, "power-on-delay-us",
> +				&board_data->power_on_delay_us);
> +	if (!r) {
> +		/* 1000ms is too large, maybe you have pass a wrong value */
> +		if (board_data->power_on_delay_us > 1000 * 1000) {
> +			dev_warn(dev, "Power on delay time exceed 1s\n");
> +			board_data->power_on_delay_us = 0;
> +		}
> +	}
> +
> +	r = device_property_read_u32(dev, "power-off-delay-us",
> +				&board_data->power_off_delay_us);
> +	if (!r) {
> +		/* 1000ms is too large, maybe you have pass a wrong value */
> +		if (board_data->power_off_delay_us > 1000 * 1000) {
> +			dev_warn(dev, "Power off delay time exceed 1s\n");
> +			board_data->power_off_delay_us = 0;
> +		}
> +	}
> +
> +	/* get xyz resolutions */
> +	r = goodix_parse_dt_resolution(dev, board_data);
> +	if (r < 0) {
> +		dev_err(dev, "Failed to parse resolutions:%d\n", r);
> +		return r;
> +	}
> +
> +	/* parse key map */
> +	r = device_property_read_u32_array(dev, "panel-key-map",
> +			NULL, GOODIX_MAX_KEY);
> +	if (r > 0 && r <= GOODIX_MAX_KEY) {
> +		board_data->panel_max_key = r;
> +		r = device_property_read_u32_array(dev,
> +				"panel-key-map",
> +				&board_data->panel_key_map[0],
> +				board_data->panel_max_key);
> +		if (r)
> +			dev_err(dev, "Failed get key map info\n");
> +	} else {
> +		dev_info(dev, "No key map found\n");
> +	}
> +
> +	dev_dbg(dev, "[DT]id:%d, x:%d, y:%d, w:%d, p:%d\n",
> +			board_data->panel_max_id,
> +			board_data->panel_max_x,
> +			board_data->panel_max_y,
> +			board_data->panel_max_w);
> +	return 0;
> +}
> +
> +/**
> + * goodix_parse_dt_cfg - pares config data from devicetree dev
> + * @dev: pointer to device
> + * @cfg_type: config type such as normal_config, highsense_cfg ...
> + * @config: pointer to config data structure
> + * @sensor_id: sensor id
> + * return: 0 - no error, <0 error
> + */
> +static int goodix_parse_dt_cfg(struct goodix_ts_device *ts_dev,
> +		char *cfg_type, struct goodix_ts_config *config,
> +		unsigned int sensor_id)
> +{
> +	int r, len;
> +	char sub_node_name[24] = {0};
> +	struct fwnode_handle *fwnode;
> +	struct device *dev = ts_dev->dev;
> +	struct goodix_ts_board_data *ts_bdata = ts_dev->board_data;
> +
> +	u16 checksum;
> +
> +	BUG_ON(config == NULL);
> +	if (sensor_id > TS_MAX_SENSORID) {
> +		dev_err(dev, "Invalid sensor id\n");
> +		return -EINVAL;
> +	}
> +
> +	if (config->initialized) {
> +		dev_dbg(dev, "Config already initialized\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * config data are located in child node called
> +	 * 'sensorx', x is the sensor ID got from touch
> +	 * device.
> +	 */
> +	snprintf(sub_node_name, sizeof(sub_node_name),
> +			"sensor%u", sensor_id);
> +	fwnode = device_get_named_child_node(dev, "sub_node_name");
> +	if (!fwnode) {
> +		dev_dbg(dev, "Child property[%s] not found\n",
> +				sub_node_name);
> +		return -EINVAL;
> +	}
> +
> +	len = fwnode_property_read_u8_array(fwnode, cfg_type,
> +		NULL, TS_CFG_MAX_LEN);
> +	if (len <= 0 || len % 2 != 1) {
> +		dev_err(dev, "Invalid cfg type%s, size:%u\n", cfg_type, len);
> +		return -EINVAL;
> +	}
> +
> +	config->length = len;
> +
> +	mutex_init(&config->lock);
> +	mutex_lock(&config->lock);
> +
> +	r = fwnode_property_read_u8_array(fwnode, cfg_type,
> +		config->data, TS_CFG_MAX_LEN);
> +	if (r) {
> +		mutex_unlock(&config->lock);
> +		return r;
> +	}
> +
> +	/* modify max-x max-y resolution, little-endian */
> +	config->data[CFG_XMAX_OFFSET] = (u8)ts_bdata->panel_max_x;
> +	config->data[CFG_XMAX_OFFSET + 1] = (u8)(ts_bdata->panel_max_x >> 8);
> +	config->data[CFG_YMAX_OFFSET] = (u8)ts_bdata->panel_max_y;
> +	config->data[CFG_YMAX_OFFSET + 1] = (u8)(ts_bdata->panel_max_y >> 8);
> +
> +	/*
> +	 * checksum: u16 little-endian format
> +	 * the last byte of config is the config update flag
> +	 */
> +	checksum = checksum_le16(config->data, len - 3);
> +	checksum = 0 - checksum;
> +	config->data[len - 3] = (u8)checksum;
> +	config->data[len - 2] = (u8)(checksum >> 8 & 0xff);
> +	config->data[len - 1] = 0x01;
> +
> +	strlcpy(config->name, cfg_type, sizeof(config->name));
> +	config->reg_base = TS_REG_CFG_BASE;
> +	config->delay = 0;
> +	config->initialized = true;
> +	mutex_unlock(&config->lock);
> +
> +	dev_dbg(dev, "Config name:%s,ver:%02xh,size:%d,checksum:%04xh\n",
> +			config->name, config->data[0],
> +			config->length, checksum);
> +	return 0;
> +}
> +#endif
> +
> +/**
> + * goodix_i2c_read - read device register through i2c bus
> + * @dev: pointer to device data
> + * @addr: register address
> + * @data: read buffer
> + * @len: bytes to read
> + * return: 0 - read ok, < 0 - i2c transter error
> + */
> +static int goodix_i2c_read(struct goodix_ts_device *dev, unsigned int reg,
> +	unsigned char *data, unsigned int len)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->dev);
> +	unsigned int transfer_length = 0;
> +	unsigned int pos = 0, address = reg;
> +	unsigned char get_buf[64], addr_buf[2];
> +	int retry, r = 0;
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = !I2C_M_RD,
> +			.buf = &addr_buf[0],
> +			.len = TS_ADDR_LENGTH,
> +		}, {
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +		}
> +	};
> +
> +	if (likely(len < sizeof(get_buf))) {
> +		/* code optimize, use stack memory */
> +		msgs[1].buf = &get_buf[0];
> +	} else {
> +		msgs[1].buf = kzalloc(len > I2C_MAX_TRANSFER_SIZE
> +				? I2C_MAX_TRANSFER_SIZE : len, GFP_KERNEL);
> +		if (!msgs[1].buf)
> +			return -ENOMEM;
> +	}
> +
> +	while (pos != len) {
> +		if (unlikely(len - pos > I2C_MAX_TRANSFER_SIZE))
> +			transfer_length = I2C_MAX_TRANSFER_SIZE;
> +		else
> +			transfer_length = len - pos;
> +
> +		msgs[0].buf[0] = (address >> 8) & 0xFF;
> +		msgs[0].buf[1] = address & 0xFF;
> +		msgs[1].len = transfer_length;
> +
> +		for (retry = 0; retry < GOODIX_BUS_RETRY_TIMES; retry++) {
> +			if (likely(i2c_transfer(client->adapter, msgs, 2) == 2)) {
> +				memcpy(&data[pos], msgs[1].buf, transfer_length);
> +				pos += transfer_length;
> +				address += transfer_length;
> +				break;
> +			}
> +			dev_info(&client->dev, "I2c read retry[%d]:0x%x\n",
> +				retry + 1, reg);
> +			msleep(20);
> +		}
> +		if (unlikely(retry == GOODIX_BUS_RETRY_TIMES)) {
> +			dev_err(&client->dev,
> +				"I2c read failed,dev:%02x,reg:%04x,size:%u\n",
> +				client->addr, reg, len);
> +			r = -EBUS;
> +			goto read_exit;
> +		}
> +	}
> +
> +read_exit:
> +	if (unlikely(len >= sizeof(get_buf)))
> +		kfree(msgs[1].buf);
> +	return r;
> +}
> +
> +/**
> + * goodix_i2c_write - write device register through i2c bus
> + * @ts_dev: pointer to goodix device data
> + * @addr: register address
> + * @data: write buffer
> + * @len: bytes to write
> + * return: 0 - write ok; < 0 - i2c transter error.
> + */
> +static int goodix_i2c_write(struct goodix_ts_device *ts_dev, unsigned int reg,
> +		unsigned char *data, unsigned int len)
> +{
> +	struct i2c_client *client = to_i2c_client(ts_dev->dev);
> +	unsigned int pos = 0, transfer_length = 0;
> +	unsigned int address = reg;
> +	unsigned char put_buf[64];
> +	int retry, r = 0;
> +	struct i2c_msg msg = {
> +			.addr = client->addr,
> +			.flags = !I2C_M_RD,
> +	};
> +
> +	if (likely(len + TS_ADDR_LENGTH < sizeof(put_buf))) {
> +		/* code optimize,use stack memory*/
> +		msg.buf = &put_buf[0];
> +	} else {
> +		msg.buf = kmalloc(len + TS_ADDR_LENGTH > I2C_MAX_TRANSFER_SIZE
> +			? I2C_MAX_TRANSFER_SIZE : len + TS_ADDR_LENGTH, GFP_KERNEL);
> +		if (!msg.buf)
> +			return -ENOMEM;
> +	}
> +
> +	while (pos != len) {
> +		if (unlikely(len - pos > I2C_MAX_TRANSFER_SIZE - TS_ADDR_LENGTH))
> +			transfer_length = I2C_MAX_TRANSFER_SIZE - TS_ADDR_LENGTH;
> +		else
> +			transfer_length = len - pos;
> +
> +		msg.buf[0] = (unsigned char)((address >> 8) & 0xFF);
> +		msg.buf[1] = (unsigned char)(address & 0xFF);
> +		msg.len = transfer_length + 2;
> +		memcpy(&msg.buf[2], &data[pos], transfer_length);
> +
> +		for (retry = 0; retry < GOODIX_BUS_RETRY_TIMES; retry++) {
> +			if (likely(i2c_transfer(client->adapter, &msg, 1) == 1)) {
> +				pos += transfer_length;
> +				address += transfer_length;
> +				break;
> +			}
> +			dev_info(&client->dev, "I2c write retry[%d]\n", retry + 1);
> +			msleep(20);
> +		}
> +		if (unlikely(retry == GOODIX_BUS_RETRY_TIMES)) {
> +			dev_err(&client->dev,
> +				"I2c write failed,dev:%02x,reg:%04x,size:%u",
> +				client->addr, reg, len);
> +			r = -EBUS;
> +			goto write_exit;
> +		}
> +	}
> +
> +write_exit:
> +	if (likely(len + TS_ADDR_LENGTH >= sizeof(put_buf)))
> +		kfree(msg.buf);
> +	return r;
> +}
> +
> +static int goodix_read_version(struct goodix_ts_device *ts_dev,
> +		struct goodix_ts_version *version)
> +{
> +	u8 buffer[12];
> +	int r;
> +
> +	r = goodix_i2c_read(ts_dev, TS_REG_VERSION,
> +			buffer, sizeof(buffer));
> +	if (r < 0) {
> +		dev_err(ts_dev->dev, "Read chip version failed\n");
> +		if (version)
> +			version->valid = false;
> +		return r;
> +	}
> +
> +	/* if checksum is right and first 4 bytes are not invalid value */
> +	if (checksum_u8(buffer, sizeof(buffer)) == 0 &&
> +			isalnum(buffer[0]) && isalnum(buffer[1]) &&
> +			isalnum(buffer[2]) && isalnum(buffer[3])) {
> +		if (version) {
> +			memcpy(&version->pid[0], buffer, 4);
> +			version->pid[4] = '\0';
> +			version->cid = buffer[4];
> +			/* vid = main version + minor version */
> +			version->vid = get_unaligned_be16(&buffer[5]);
> +			version->sensor_id = buffer[10] & 0x0F;
> +			version->valid = true;
> +
> +			if (version->cid)
> +				dev_info(ts_dev->dev,
> +					"PID:%s,CID: %c,VID:%04x,SensorID:%u\n",
> +					version->pid, version->cid + 'A' - 1,
> +					version->vid, version->sensor_id);
> +			else
> +				dev_info(ts_dev->dev,
> +					"PID:%s,VID:%04x,SensorID:%u\n",
> +					version->pid, version->vid,
> +					version->sensor_id);
> +		}
> +	} else {
> +		dev_warn(ts_dev->dev, "Checksum error:%*ph\n",
> +			(int)sizeof(buffer), buffer);
> +		/* mark this version is invalid */
> +		if (version)
> +			version->valid = false;
> +		r = -EINVAL;
> +	}
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_send_config - send config data to device.
> + * @ts_dev: pointer to goodix device data
> + * @config: pointer to config data struct to be send
> + * @return: 0 - succeed, < 0 - failed
> + */
> +static int goodix_send_config(struct goodix_ts_device *ts_dev,
> +		struct goodix_ts_config *config)
> +{
> +	int r = 0;
> +
> +	if (!config || !config->data) {
> +		dev_warn(ts_dev->dev, "Null config data\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(ts_dev->dev, "Send %s,ver:%02xh,size:%d\n",
> +		config->name, config->data[0],
> +		config->length);
> +
> +	mutex_lock(&config->lock);
> +	r = goodix_i2c_write(ts_dev, config->reg_base,
> +			config->data, config->length);
> +	if (r)
> +		goto exit;
> +
> +	/* make sure the firmware accept the config data*/
> +	if (config->delay)
> +		msleep(config->delay);
> +exit:
> +	mutex_unlock(&config->lock);
> +	return r;
> +}
> +
> +static inline int goodix_cmds_init(struct goodix_ts_device *ts_dev)
> +{
> +	/* low power mode command */
> +	ts_dev->sleep_cmd.cmd_reg = TS_REG_CMD;
> +	ts_dev->sleep_cmd.length = 3;
> +	ts_dev->sleep_cmd.cmds[0] = 0x05;
> +	ts_dev->sleep_cmd.cmds[1] = 0x0;
> +	ts_dev->sleep_cmd.cmds[2] = 0 - 0x05;
> +	ts_dev->sleep_cmd.initialized = true;
> +
> +	return 0;
> +}
> +
> +/**
> + * goodix_hw_init - hardware initialize
> + *   Called by touch core module when bootup
> + * @ts_dev: pointer to touch device
> + * return: 0 - no error, <0 error
> + */
> +static int goodix_hw_init(struct goodix_ts_device *ts_dev)
> +{
> +	int r;
> +
> +	BUG_ON(!ts_dev);
> +	goodix_cmds_init(ts_dev);
> +
> +	/* goodix_hw_init may be called many times */
> +	if (!ts_dev->normal_cfg) {
> +		ts_dev->normal_cfg = devm_kzalloc(ts_dev->dev,
> +				sizeof(*ts_dev->normal_cfg), GFP_KERNEL);
> +		if (!ts_dev->normal_cfg) {
> +			dev_err(ts_dev->dev,
> +				"Failed to alloc memory for normal cfg\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	/* read chip version: PID/VID/sensor ID,etc.*/
> +	r = goodix_read_version(ts_dev, &ts_dev->chip_version);
> +	if (r < 0)
> +		return r;
> +
> +#ifdef CONFIG_OF
> +	/* parse normal-cfg from devicetree node */
> +	r = goodix_parse_dt_cfg(ts_dev, "normal-cfg",
> +			ts_dev->normal_cfg,
> +			ts_dev->chip_version.sensor_id);
> +	if (r < 0) {
> +		dev_warn(ts_dev->dev, "Failed to obtain normal-cfg\n");
> +		return r;
> +	}
> +#endif
> +
> +	ts_dev->normal_cfg->delay = 500;
> +	/* send normal-cfg to firmware */
> +	r = goodix_send_config(ts_dev, ts_dev->normal_cfg);
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_hw_reset - reset device
> + *
> + * @dev: pointer to touch device
> + * Returns 0 - succeed,<0 - failed
> + */
> +static void goodix_hw_reset(struct goodix_ts_device *dev)
> +{
> +	dev_dbg(dev->dev, "HW reset\n");
> +
> +	if (!dev->board_data->reset_gpiod) {
> +		msleep(80);
> +		return;
> +	}
> +	gpiod_direction_output(dev->board_data->reset_gpiod, 0);
> +	udelay(200);
> +	gpiod_direction_output(dev->board_data->reset_gpiod, 1);
> +	msleep(80);
> +}
> +
> +/**
> + * goodix_request_handler - handle firmware request
> + *
> + * @dev: pointer to touch device
> + * @request_data: requset information
> + * Returns 0 - succeed,<0 - failed
> + */
> +static int goodix_request_handler(struct goodix_ts_device *dev,
> +		struct goodix_request_data *request_data) {
> +	unsigned char buffer[1];
> +	int r;
> +
> +	r = goodix_i2c_read(dev, TS_REG_REQUEST, buffer, 1);
> +	if (r < 0)
> +		return r;
> +
> +	switch (buffer[0]) {
> +	case REQUEST_CONFIG:
> +		dev_dbg(dev->dev, "HW request config\n");
> +		goodix_send_config(dev, dev->normal_cfg);
> +		goto clear_requ;
> +	case REQUEST_BAKREF:
> +		dev_dbg(dev->dev, "HW request bakref\n");
> +		goto clear_requ;
> +	case REQUEST_RESET:
> +		dev_dbg(dev->dev, "HW requset reset\n");
> +		goto clear_requ;
> +	case REQUEST_MAINCLK:
> +		dev_dbg(dev->dev, "HW request mainclk\n");
> +		goto clear_requ;
> +	default:
> +		dev_dbg(dev->dev, "Unknown hw request:%d\n", buffer[0]);
> +		return 0;
> +	}
> +
> +clear_requ:
> +	buffer[0] = 0x00;
> +	r = goodix_i2c_write(dev, TS_REG_REQUEST, buffer, 1);
> +	return r;
> +}
> +
> +/**
> + * goodix_eventt_handler - handle firmware event
> + *
> + * @dev: pointer to touch device
> + * @ts_event: pointer to touch event structure
> + * Returns 0 - succeed,<0 - failed
> + */
> +static int goodix_event_handler(struct goodix_ts_device *dev,
> +		struct goodix_ts_event *ts_event)
> +{
> +#define BYTES_PER_COORD 8
> +	struct goodix_touch_data *touch_data =
> +			&ts_event->event_data.touch_data;
> +	struct goodix_ts_coords *coords = &touch_data->coords[0];
> +	int max_touch_num = dev->board_data->panel_max_id;
> +	unsigned char buffer[2 + BYTES_PER_COORD * max_touch_num];
> +	unsigned char coord_sta;
> +	int touch_num = 0, i, r;
> +	unsigned char chksum = 0;
> +
> +	r = goodix_i2c_read(dev, TS_REG_COORDS_BASE,
> +			buffer, 3 + BYTES_PER_COORD/* * 1*/);
> +	if (unlikely(r < 0))
> +		return r;
> +
> +	/* buffer[0]: event state */
> +	coord_sta = buffer[0];
> +	if (unlikely(coord_sta == 0x00)) {
> +		/* handle request event */
> +		ts_event->event_type = EVENT_REQUEST;
> +		goodix_request_handler(dev,
> +				&ts_event->event_data.request_data);
> +		goto exit_clean_sta;
> +	} else if (unlikely((coord_sta & 0x80) != 0x80)) {
> +		r = -EINVAL;
> +		return r;
> +	}
> +
> +	/* bit7 of coord_sta is 1, touch data is ready */
> +	/* handle touch event */
> +	touch_data->key_value = (coord_sta >> 4) & 0x01;
> +	touch_num = coord_sta & 0x0F;
> +	if (unlikely(touch_num > max_touch_num)) {
> +		touch_num = -EINVAL;
> +		goto exit_clean_sta;
> +	} else if (unlikely(touch_num > 1)) {
> +		r = goodix_i2c_read(dev,
> +				TS_REG_COORDS_BASE + 3 + BYTES_PER_COORD,
> +				&buffer[3 + BYTES_PER_COORD],
> +				(touch_num - 1) * BYTES_PER_COORD);
> +		if (unlikely(r < 0))
> +			goto exit_clean_sta;
> +	}
> +
> +	/* touch_num * BYTES_PER_COORD + 1(touch event state) + 1(checksum)
> +	 * + 1(key value)
> +	 */
> +	chksum = checksum_u8(&buffer[0], touch_num * BYTES_PER_COORD + 3);
> +	if (unlikely(chksum != 0)) {
> +		dev_warn(dev->dev, "Checksum error:%X\n", chksum);
> +		r = -EINVAL;
> +		goto exit_clean_sta;
> +	}
> +
> +	memset(touch_data->coords, 0x00, sizeof(touch_data->coords));
> +	for (i = 0; i < touch_num; i++) {
> +		coords->id = buffer[i * BYTES_PER_COORD + 1] & 0x0f;
> +		coords->x = get_unaligned_le16(&buffer[i * BYTES_PER_COORD + 2]);
> +		coords->y = get_unaligned_le16(&buffer[i * BYTES_PER_COORD + 4]);
> +		coords->w = get_unaligned_le16(&buffer[i * BYTES_PER_COORD + 6]);
> +
> +		dev_dbg(dev->dev, "D:[%d](%d, %d)[%d]\n",
> +			coords->id, coords->x, coords->y, coords->w);
> +		coords++;
> +	}
> +
> +	touch_data->touch_num = touch_num;
> +	/* mark this event as touch event */
> +	ts_event->event_type = EVENT_TOUCH;
> +	r = 0;
> +
> +exit_clean_sta:
> +	/* handshake */
> +	buffer[0] = 0x00;
> +	goodix_i2c_write(dev, TS_REG_COORDS_BASE, buffer, 1);
> +	return r;
> +}
> +
> +/**
> + * goodix_send_command - seng cmd to firmware
> + *
> + * @dev: pointer to device
> + * @cmd: pointer to command struct which cotain command data
> + * Returns 0 - succeed,<0 - failed
> + */
> +int goodix_send_command(struct goodix_ts_device *dev,
> +		struct goodix_ts_cmd *cmd)
> +{
> +	int ret;
> +
> +	if (!cmd || !cmd->initialized)
> +		return -EINVAL;
> +	ret = goodix_i2c_write(dev, cmd->cmd_reg, cmd->cmds,
> +			cmd->length);
> +	return ret;
> +}
> +
> +/**
> + * goodix_hw_suspend - Let touch deivce stay in lowpower mode.
> + * @dev: pointer to goodix touch device
> + * @return: 0 - succeed, < 0 - failed
> + */
> +static int goodix_hw_suspend(struct goodix_ts_device *dev)
> +{
> +	struct goodix_ts_cmd *sleep_cmd =
> +			&dev->sleep_cmd;
> +	int r = 0;
> +
> +	if (sleep_cmd->initialized) {
> +		r = goodix_send_command(dev, sleep_cmd);
> +		if (!r)
> +			dev_dbg(dev->dev, "Chip in sleep mode\n");
> +	} else {
> +		dev_dbg(dev->dev, "Uninitialized sleep command\n");
> +	}
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_hw_resume - Let touch deivce stay in active  mode.
> + * @dev: pointer to goodix touch device
> + * @return: 0 - succeed, < 0 - failed
> + */
> +static int goodix_hw_resume(struct goodix_ts_device *dev)
> +{
> +	struct goodix_ts_version ver;
> +	int r, retry = GOODIX_BUS_RETRY_TIMES;
> +
> +	for (; retry--;) {
> +		goodix_hw_reset(dev);
> +		r = goodix_read_version(dev, &ver);
> +		if (!r)
> +			break;
> +	}
> +
> +	return r;
> +}
> +
> +/* hardware opeation funstions */
> +static const struct goodix_ts_hw_ops hw_i2c_ops = {
> +	.init = goodix_hw_init,
> +	.read = goodix_i2c_read,
> +	.write = goodix_i2c_write,
> +	.reset = goodix_hw_reset,
> +	.event_handler = goodix_event_handler,
> +	.send_config = goodix_send_config,
> +	.send_cmd = goodix_send_command,
> +	.read_version = goodix_read_version,
> +	.suspend = goodix_hw_suspend,
> +	.resume = goodix_hw_resume,
> +};
> +
> +static struct platform_device *goodix_pdev;
> +static void goodix_pdev_release(struct device *dev)
> +{
> +	kfree(goodix_pdev);
> +}
> +
> +static int goodix_i2c_probe(struct i2c_client *client,
> +	const struct i2c_device_id *dev_id)
> +{
> +	struct goodix_ts_device *ts_device = NULL;
> +	struct goodix_ts_board_data *ts_bdata = NULL;
> +	int r = 0;
> +
> +	r = i2c_check_functionality(client->adapter,
> +		I2C_FUNC_I2C);
> +	if (!r)
> +		return -EIO;
> +
> +	/* board data */
> +	ts_bdata = devm_kzalloc(&client->dev,
> +			sizeof(struct goodix_ts_board_data), GFP_KERNEL);
> +	if (!ts_bdata)
> +		return -ENOMEM;
> +
> +#ifdef CONFIG_OF
> +	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
> +		/* parse devicetree property */
> +		r = goodix_parse_dt(client->dev, ts_bdata);
> +		if (r < 0)
> +			return r;
> +	} else
> +#endif
> +	{
> +		/* use platform data */
> +		dev_info(&client->dev, "use platform data\n");
> +		devm_kfree(&client->dev, ts_bdata);
> +		ts_bdata = client->dev.platform_data;
> +	}
> +
> +	if (!ts_bdata)
> +		return -ENODEV;
> +
> +	ts_device = devm_kzalloc(&client->dev,
> +		sizeof(struct goodix_ts_device), GFP_KERNEL);
> +	if (!ts_device)
> +		return -ENOMEM;
> +
> +	ts_bdata->irq = client->irq;
> +	ts_device->name = "GTx5 TouchDevcie";
> +	ts_device->dev = &client->dev;
> +	ts_device->board_data = ts_bdata;
> +	ts_device->hw_ops = &hw_i2c_ops;
> +
> +	/* ts core device */
> +	goodix_pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
> +	if (!goodix_pdev)
> +		return -ENOMEM;
> +
> +	goodix_pdev->name = GOODIX_CORE_DRIVER_NAME;
> +	goodix_pdev->id = 0;
> +	goodix_pdev->num_resources = 0;
> +	/*
> +	 * you could find this platform dev in
> +	 * /sys/devices/platform/goodix_ts.0
> +	 * goodix_pdev->dev.parent = &client->dev;
> +	 */
> +	goodix_pdev->dev.platform_data = ts_device;
> +	goodix_pdev->dev.release = goodix_pdev_release;
> +
> +	/* register platform device, then the goodix_ts_core module will probe
> +	 * the touch deivce.
> +	 */
> +	r = platform_device_register(goodix_pdev);
> +	return r;
> +}
> +
> +static int goodix_i2c_remove(struct i2c_client *client)
> +{
> +	platform_device_unregister(goodix_pdev);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gtx5_of_matchs[] = {
> +	{.compatible = TS_DT_COMPATIBLE,},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gtx5_of_matchs);
> +#endif
> +
> +static const struct i2c_device_id gtx5_id_table[] = {
> +	{TS_DRIVER_NAME, 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, gtx5_id_table);
> +
> +static struct i2c_driver goodix_i2c_driver = {
> +	.driver = {
> +		.name = TS_DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(gtx5_of_matchs),
> +	},
> +	.probe = goodix_i2c_probe,
> +	.remove = goodix_i2c_remove,
> +	.id_table = gtx5_id_table,
> +};
> +
> +static int __init goodix_i2c_init(void)
> +{
> +	return i2c_add_driver(&goodix_i2c_driver);
> +}
> +
> +static void __exit goodix_i2c_exit(void)
> +{
> +	i2c_del_driver(&goodix_i2c_driver);
> +}
> +
> +module_init(goodix_i2c_init);
> +module_exit(goodix_i2c_exit);
> +
> +MODULE_DESCRIPTION("Goodix GTx5 Touchscreen Hardware Module");
> +MODULE_AUTHOR("Goodix, Inc.");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_update.c b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_update.c
> new file mode 100755
> index 0000000..7dd0e6b
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_gtx5_update.c
> @@ -0,0 +1,1450 @@
> +/*
> + * Goodix GTx5 Touchscreen Driver.
> + *
> + * Copyright (C) 2015 - 2016 Goodix, Inc.
> + * Authors:  Wang Yafei <wangyafei@goodix.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be a reference
> + * to you, when you are integrating the GOODiX's CTP IC into your system,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include "goodix_ts_core.h"
> +
> +/* COMMON PART - START */
> +#define TS_DEFAULT_FIRMWARE			"goodix_ts_fw.bin"
> +
> +#define FW_HEADER_SIZE				256
> +#define FW_SUBSYS_INFO_SIZE			8
> +#define FW_SUBSYS_INFO_OFFSET			32
> +#define FW_SUBSYS_MAX_NUM			24
> +#define FW_NAME_MAX				128
> +
> +#define ISP_MAX_BUFFERSIZE			(1024 * 16)
> +
> +#define HW_REG_CPU_EN				0x4180
> +#define HW_REG_ILM_ACCESS			0x50C0
> +#define HW_REG_BANK_SELECT			0x50C4
> +#define HW_REG_ISP_ADDR				0x8000
> +#define HW_REG_ISP_STAT				0x4195
> +#define HW_REG_ISP_CMD				0x4196
> +#define HW_REG_ISP_PKT_INFO			0xFFF0
> +#define HW_REG_ISP_RESULT			0x4197
> +#define HW_REG_ISP_BUFFER			0x8000
> +#define HW_REG_BOOT_FLAG			0x434C
> +#define HW_REG_BOOT_CTRL0			0xF7CC
> +#define HW_REG_BOOT_CTRL1			0xF7EC
> +#define HW_REG_WDT				0x40B0
> +
> +#define CPU_CTRL_PENDING			0x00
> +#define CPU_CTRL_RUNNING			0x01
> +
> +#define ISP_STAT_IDLE				0xFF
> +#define ISP_STAT_READY				0xAA
> +#define ISP_STAT_WRITING			0xCC
> +#define ISP_FLASH_ERROR				0xEE
> +#define ISP_FLASH_SUCCESS			0xDD
> +#define ISP_CMD_PREPARE				0x55
> +#define ISP_CMD_FLASH				0xAA
> +
> +/**
> + * fw_subsys_info - subsytem firmware information
> + * @type: sybsystem type
> + * @size: firmware size
> + * @flash_addr: flash address
> + * @data: firmware data
> + */
> +struct fw_subsys_info {
> +	u8 type;
> +	u32 size;
> +	u32 flash_addr;
> +	const u8 *data;
> +};
> +
> +#pragma pack(1)
> +/**
> + * firmware_info
> + * @size: fw total length
> + * @checksum: checksum of fw
> + * @hw_pid: mask pid string
> + * @hw_pid: mask vid code
> + * @fw_pid: fw pid string
> + * @fw_vid: fw vid code
> + * @subsys_num: number of fw subsystem
> + * @chip_type: chip type
> + * @protocol_ver: firmware packing
> + *   protocol version
> + * @subsys: sybsystem info
> + */
> +struct firmware_info {
> +	u32 size;
> +	u16 checksum;
> +	u8 hw_pid[6];
> +	u8 hw_vid[3];
> +	u8 fw_pid[8];
> +	u8 fw_vid[3];
> +	u8 subsys_num;
> +	u8 chip_type;
> +	u8 protocol_ver;
> +	u8 reserved[3];
> +	struct fw_subsys_info subsys[FW_SUBSYS_MAX_NUM];
> +};
> +
> +/**
> + * firmware_packet - firmware packet information
> + * @packet_size: firmware packet size, max 4Kbytes.
> + * @flash_addr: device flash address
> + * @packet_checksum: checksum of the firmware in this packet
> + * @data: pointer to firmware data.
> + */
> +struct firmware_packet {
> +	u32 packet_size;
> +	u32 flash_addr;
> +	u32 packet_checksum;
> +	const u8 *data;
> +};
> +#pragma pack()
> +
> +/**
> + * firmware_data - firmware data structure
> + * @fw_info: firmware infromation
> + * @firmware: firmware data structure
> + */
> +struct firmware_data {
> +	struct firmware_info fw_info;
> +	const struct firmware *firmware;
> +};
> +
> +enum update_status {
> +	UPSTA_NOTWORK = 0,
> +	UPSTA_PREPARING,
> +	UPSTA_UPDATING,
> +	UPSTA_ABORT,
> +	UPSTA_SUCCESS,
> +	UPSTA_FAILED
> +};
> +
> +/**
> + * fw_update_ctrl - structure used to control the
> + *  firmware update process
> + * @status: update status
> + * @progress: indicate the progress of update
> + * @allow_reset: control the reset callback
> + * @allow_irq: control the irq callback
> + * @allow_suspend: control the suspend callback
> + * @allow_resume: allow resume callback
> + * @fw_data: firmware data
> + * @ts_dev: touch device
> + * @fw_name: firmware name
> + * @attr_fwimage: sysfs bin attrs, for storing fw image
> + * @fw_from_sysfs: whether the firmware image is loadind
> + *		from sysfs
> + */
> +struct fw_update_ctrl {
> +	enum update_status status;
> +	unsigned int progress;
> +	bool force_update;
> +
> +	bool allow_reset;
> +	bool allow_irq;
> +	bool allow_suspend;
> +	bool allow_resume;
> +
> +	struct firmware_data fw_data;
> +	struct goodix_ts_device *ts_dev;
> +
> +	char fw_name[FW_NAME_MAX];
> +	struct bin_attribute attr_fwimage;
> +	bool fw_from_sysfs;
> +};
> +
> +static struct goodix_ext_module goodix_fwu_module;
> +/**
> + * goodix_parse_firmware - parse firmware header information
> + *	and subsystem information from firmware data buffer
> + *
> + * @fw_data: firmware struct, contains firmware header info
> + *	and firmware data.
> + * return: 0 - OK, < 0 - error
> + */
> +static int goodix_parse_firmware(struct fw_update_ctrl *fwu_ctrl)
> +{
> +	const struct firmware *firmware;
> +	struct firmware_info *fw_info;
> +	struct firmware_data *fw_data = &fwu_ctrl->fw_data;
> +	const struct device *dev = fwu_ctrl->ts_dev->dev;
> +	unsigned int i, fw_offset, info_offset;
> +	u16 checksum;
> +	int r = 0;
> +
> +	if (!fw_data || !fw_data->firmware) {
> +		dev_err(dev, "Invalid firmware data\n");
> +		return -EINVAL;
> +	}
> +	fw_info = &fw_data->fw_info;
> +
> +	/* copy firmware head info */
> +	firmware = fw_data->firmware;
> +	if (firmware->size < FW_SUBSYS_INFO_OFFSET) {
> +		dev_err(dev, "Invalid firmware size:%zu\n", firmware->size);
> +		r = -EINVAL;
> +		goto err_size;
> +	}
> +	memcpy(fw_info, firmware->data, FW_SUBSYS_INFO_OFFSET);
> +
> +	/* check firmware size */
> +	fw_info->size = be32_to_cpu(fw_info->size);
> +	if (firmware->size != fw_info->size + 6) {
> +		dev_err(dev, "Bad firmware, size not match\n");
> +		r = -EINVAL;
> +		goto err_size;
> +	}
> +
> +	/* calculate checksum, note: sum of bytes, but check by u16 checksum */
> +	for (i = 6, checksum = 0; i < firmware->size; i++)
> +		checksum += firmware->data[i];
> +
> +	/* byte order change, and check */
> +	fw_info->checksum = be16_to_cpu(fw_info->checksum);
> +	if (checksum != fw_info->checksum) {
> +		dev_err(dev, "Bad firmware, cheksum error\n");
> +		r = -EINVAL;
> +		goto err_size;
> +	}
> +
> +	if (fw_info->subsys_num > FW_SUBSYS_MAX_NUM) {
> +		dev_err(dev, "Bad firmware, invalid subsys num\n");
> +		r = -EINVAL;
> +		goto err_size;
> +	}
> +
> +	/* parse subsystem info */
> +	fw_offset = FW_HEADER_SIZE;
> +	for (i = 0; i < fw_info->subsys_num; i++) {
> +		info_offset = FW_SUBSYS_INFO_OFFSET +
> +					i * FW_SUBSYS_INFO_SIZE;
> +
> +		fw_info->subsys[i].type = firmware->data[info_offset];
> +		fw_info->subsys[i].size =
> +			be32_to_cpup((__be32 *)&firmware->data[info_offset + 1]);
> +		fw_info->subsys[i].flash_addr =
> +			be16_to_cpup((__be16 *)&firmware->data[info_offset + 5]);
> +		fw_info->subsys[i].flash_addr <<= 8; /* important! */
> +
> +		if (fw_offset > firmware->size) {
> +			dev_err(dev, "Sybsys offset exceed Firmware size\n");
> +			goto err_size;
> +		}
> +
> +		fw_info->subsys[i].data = firmware->data + fw_offset;
> +		fw_offset += fw_info->subsys[i].size;
> +	}
> +
> +	dev_info(dev, "Firmware package protocol: V%u\n", fw_info->protocol_ver);
> +	dev_info(dev, "Fimware PID:GT%s\n", fw_info->fw_pid);
> +	dev_info(dev, "Fimware VID:%02X%02X%02X\n", fw_info->fw_vid[0],
> +				fw_info->fw_vid[1], fw_info->fw_vid[2]);
> +	dev_info(dev, "Firmware chip type:%02X\n", fw_info->chip_type);
> +	dev_info(dev, "Firmware size:%u\n", fw_info->size);
> +	dev_info(dev, "Firmware subsystem num:%u\n", fw_info->subsys_num);
> +
> +	for (i = 0; i < fw_info->subsys_num; i++) {
> +		dev_dbg(dev, "Index:%d\n", i);
> +		dev_dbg(dev, "Subsystem type:%02X\n", fw_info->subsys[i].type);
> +		dev_dbg(dev, "Subsystem size:%u\n", fw_info->subsys[i].size);
> +		dev_dbg(dev, "Subsystem flash_addr:%08X\n",
> +			fw_info->subsys[i].flash_addr);
> +		dev_dbg(dev, "Subsystem Ptr:%p\n", fw_info->subsys[i].data);
> +	}
> +
> +err_size:
> +	return r;
> +}
> +
> +/**
> + * goodix_check_update - compare the version of firmware running in
> + *  touch device with the version getting from the firmware file.
> + * @fw_info: firmware information to be compared
> + * return: 0 firmware in the touch device needs to be updated
> + *			< 0 no need to update firmware
> + */
> +static int goodix_check_update(struct goodix_ts_device *ts_dev,
> +		const struct firmware_info *fw_info)
> +{
> +	struct goodix_ts_version fw_ver = {0};
> +	const struct device *dev = ts_dev->dev;
> +	u16 fwimg_vid;
> +	u8 fwimg_cid;
> +	int r = 0;
> +
> +	/* read version from chip, if we got invalid firmware version, maybe
> +	 * fimware in flash is incorrect, so we need to update firmware
> +	 */
> +	r = ts_dev->hw_ops->read_version(ts_dev, &fw_ver);
> +	if (r == -EBUS)
> +		return r;
> +
> +	if (fw_ver.valid) {
> +		if (memcmp(fw_ver.pid, fw_info->fw_pid, 4)) {
> +			dev_err(dev, "Product ID is not match\n");
> +			return -EPERM;
> +		}
> +
> +		fwimg_cid = fw_info->fw_vid[0];
> +		fwimg_vid = fw_info->fw_vid[1] << 8 | fw_info->fw_vid[2];
> +		if (fw_ver.vid == fwimg_vid && fw_ver.cid == fwimg_cid) {
> +			dev_err(dev, "FW version is equal to the IC's\n");
> +			return -EPERM;
> +		} else if (fw_ver.vid > fwimg_vid) {
> +			dev_info(dev, "Warning: fw version is lower the IC's\n");
> +		}
> +	} /* else invalid firmware, update firmware */
> +
> +	dev_info(dev, "Firmware needs to be updated\n");
> +	return 0;
> +}
> +
> +/**
> + * goodix_reg_write_confirm - write register and confirm the value
> + *  in the register.
> + * @ts_dev: pointer to touch device
> + * @addr: register address
> + * @data: pointer to data buffer
> + * @len: data length
> + * return: 0 write success and confirm ok
> + *		   < 0 failed
> + */
> +static int goodix_reg_write_confirm(struct goodix_ts_device *ts_dev,
> +		unsigned int addr, unsigned char *data, unsigned int len)
> +{
> +	u8 *cfm, cfm_buf[32];
> +	int r, i;
> +
> +	if (len > sizeof(cfm_buf)) {
> +		cfm = kzalloc(len, GFP_KERNEL);
> +		if (!cfm)
> +			return -ENOMEM;
> +	} else {
> +		cfm = &cfm_buf[0];
> +	}
> +
> +	for (i = 0; i < GOODIX_BUS_RETRY_TIMES; i++) {
> +		r = ts_dev->hw_ops->write(ts_dev, addr, data, len);
> +		if (r < 0)
> +			goto exit;
> +
> +		r = ts_dev->hw_ops->read(ts_dev, addr, cfm, len);
> +		if (r < 0)
> +			goto exit;
> +
> +		if (memcmp(data, cfm, len)) {
> +			r = -EMEMCMP;
> +			continue;
> +		} else {
> +			r = 0;
> +			break;
> +		}
> +	}
> +
> +exit:
> +	if (cfm != &cfm_buf[0])
> +		kfree(cfm);
> +	return r;
> +}
> +
> +static inline int goodix_reg_write(struct goodix_ts_device *ts_dev,
> +		unsigned int addr, unsigned char *data, unsigned int len)
> +{
> +	return ts_dev->hw_ops->write(ts_dev, addr, data, len);
> +}
> +
> +static inline int goodix_reg_read(struct goodix_ts_device *ts_dev,
> +		unsigned int addr, unsigned char *data, unsigned int len)
> +{
> +	return ts_dev->hw_ops->read(ts_dev, addr, data, len);
> +}
> +
> +/**
> + * goodix_cpu_ctrl - Let cpu stay in pending state or running state
> + * @ts_dev: pointer to touch device
> + * @flag: control flag, which can be:
> + *		CPU_CTRL_PENDING - Pending cpu
> + *	Other type of control to cpu is not support.
> + * return: 0 OK, < 0 Failed, -EAGAIN try again
> + */
> +static int goodix_cpu_ctrl(struct goodix_ts_device *ts_dev, int flag)
> +{
> +	const struct device *dev = ts_dev->dev;
> +	u8 ctrl;
> +	int r;
> +
> +	if (flag == CPU_CTRL_PENDING) {
> +		dev_info(dev, "Pending CPU\n");
> +		ctrl = 0x04;
> +	} else if (flag == CPU_CTRL_RUNNING) {
> +		dev_info(dev, "Running CPU\n");
> +		ctrl = 0x00;
> +	} else {
> +		dev_err(dev, "Invalid cpu ctrl flag\n");
> +		return -EPERM;
> +	}
> +
> +	/* Pending Cpu */
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_CPU_EN, &ctrl, 1);
> +	if (unlikely(r < 0)) {
> +		dev_err(dev, "CPU ctrl failed:%d\n", r);
> +		r = -EAGAIN; /* hw reset and try again */
> +	}
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_isp_wait_stat - waitting ISP state
> + * @ts_dev: pointer to touch device
> + * @state: state to wait
> + * return: 0 - ok, < 0 error, -ETIMEOUT timeout
> + */
> +static int goodix_isp_wait_stat(struct goodix_ts_device *ts_dev, u16 state)
> +{
> +	const struct device *dev = ts_dev->dev;
> +	static u8 last_state;
> +	u8  isp_state;
> +	int i, r, err_cnt = 0;
> +
> +	for (i = 0; i < 200; i++) {
> +		/* read isp state */
> +		r = goodix_reg_read(ts_dev, HW_REG_ISP_STAT,
> +					&isp_state, 1);
> +		if (r < 0) {
> +			dev_err(dev, "Failed to read ISP state\n");
> +			if (++err_cnt > GOODIX_BUS_RETRY_TIMES)
> +				return r;
> +			continue;
> +		}
> +		err_cnt = 0;
> +
> +		if (isp_state != last_state) {
> +			switch (isp_state) {
> +			case ISP_STAT_IDLE:
> +				dev_info(dev, "ISP state: Idle\n");
> +				break;
> +			case ISP_STAT_WRITING:
> +				dev_info(dev, "ISP state: Writing...\n");
> +				break;
> +			case ISP_STAT_READY:
> +				dev_info(dev, "ISP state: Ready to write\n");
> +				break;
> +			default:
> +				dev_err(dev, "ISP state: Unknown\n");
> +				break;
> +			}
> +		}
> +
> +		last_state = isp_state;
> +		r = -ETIMEOUT;
> +		if (isp_state == state) {
> +			r = 0;
> +			break;
> +		}
> +
> +		usleep_range(5000, 5010);
> +	}
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_isp_flash_done - check whether flash is successful
> + * @ts_dev: pointer to touch device
> + * return: 0 - ok, < 0 error
> + */
> +static int goodix_isp_flash_done(struct goodix_ts_device *ts_dev)
> +{
> +	u8  isp_result;
> +	int r, i;
> +
> +	for (i = 0; i < 2; i++) {
> +		r = goodix_reg_read(ts_dev, HW_REG_ISP_RESULT,
> +				&isp_result, 1);
> +		if (r < 0) {
> +			/* bus error */
> +			break;
> +		} else if (isp_result == ISP_FLASH_SUCCESS) {
> +			dev_info(ts_dev->dev, "ISP result: OK!\n");
> +			r = 0;
> +			break;
> +		} else if (isp_result == ISP_FLASH_ERROR) {
> +			dev_err(ts_dev->dev, "ISP result: ERROR!\n");
> +			r = -EAGAIN;
> +		}
> +	}
> +	return r;
> +}
> +
> +/**
> + * goodix_isp_command - communication with ISP.
> + * @cmd: ISP command.
> + * return: 0 ok, <0 error
> + */
> +static int goodix_isp_command(struct goodix_ts_device *ts_dev, u8 cmd)
> +{
> +	switch (cmd) {
> +	case ISP_CMD_PREPARE:
> +		break;
> +	case ISP_CMD_FLASH:
> +		break;
> +	default:
> +		dev_err(ts_dev->dev, "Invalid ISP cmd\n");
> +		return -EINVAL;
> +	}
> +
> +	return goodix_reg_write(ts_dev, HW_REG_ISP_CMD, &cmd, 1);
> +}
> +
> +/**
> + * goodix_load_isp - load ISP program to deivce ram
> + * @ts_dev: pointer to touch device
> + * @fw_data: firmware data
> + * return 0 ok, <0 error
> + */
> +static inline int goodix_load_isp(struct goodix_ts_device *ts_dev,
> +			struct firmware_data *fw_data)
> +{
> +	struct fw_subsys_info *fw_isp;
> +	int r;
> +
> +	fw_isp = &fw_data->fw_info.subsys[0];
> +
> +	dev_info(ts_dev->dev, "Loading ISP program\n");
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_ISP_ADDR,
> +				(u8 *)fw_isp->data, fw_isp->size);
> +	if (r < 0)
> +		dev_err(ts_dev->dev, "Loading ISP error\n");
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_enter_update - update prepare, loading ISP program
> + *  and make sure the ISP is running.
> + * @fwu_ctrl: pointer to fimrware control structure
> + * return: 0 ok, <0 error
> + */
> +static int goodix_update_prepare(struct fw_update_ctrl *fwu_ctrl)
> +{
> +	struct goodix_ts_device *ts_dev = fwu_ctrl->ts_dev;
> +	const struct device *dev = fwu_ctrl->ts_dev->dev;
> +	u8 boot_val0[4] = {0xb8, 0x3f, 0x35, 0x56};
> +	u8 boot_val1[4] = {0xb9, 0x3e, 0xb5, 0x54};
> +	u8 reg_val[4] = {0x00};
> +	int r;
> +
> +	fwu_ctrl->allow_reset = true;
> +	ts_dev->hw_ops->reset(ts_dev);
> +	fwu_ctrl->allow_reset = false;
> +
> +	/* enable ILM access */
> +	reg_val[0] = 0x06;
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_ILM_ACCESS,
> +			reg_val, 1);
> +	if (r < 0) {
> +		dev_err(dev, "Failed to enable ILM access\n");
> +		return r;
> +	}
> +
> +	/* Pending CPU */
> +	r = goodix_cpu_ctrl(ts_dev, CPU_CTRL_PENDING);
> +	if (r < 0)
> +		return r;
> +
> +	/* disable watchdog timer */
> +	reg_val[0] = 0x00;
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_WDT,
> +			reg_val, 1);
> +	if (r < 0) {
> +		dev_err(dev, "Failed to disable watchdog\n");
> +		return r;
> +	}
> +
> +	/* select bank 2 */
> +	reg_val[0] = 0x02;
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_BANK_SELECT,
> +			reg_val, 1);
> +	if (r < 0) {
> +		dev_err(dev, "Failed to select bank2\n");
> +		return r;
> +	}
> +
> +	/* load ISP code */
> +	r = goodix_load_isp(ts_dev, &fwu_ctrl->fw_data);
> +	if (r < 0)
> +		return r;
> +
> +	/* Clear ISP state */
> +	reg_val[0] = reg_val[1] = 0x00;
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_ISP_STAT,
> +			reg_val, 2);
> +	if (r < 0) {
> +		dev_err(dev, "Failed to clear ISP state\n");
> +		return r;
> +	}
> +
> +	/* set boot flag */
> +	reg_val[0] = 0;
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_BOOT_FLAG,
> +			reg_val, 1);
> +	if (r < 0) {
> +		dev_err(dev, "Failed to set boot flag\n");
> +		return r;
> +	}
> +
> +	/* set boot from sRam */
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_BOOT_CTRL0,
> +			boot_val0, sizeof(boot_val0));
> +	if (r < 0) {
> +		dev_err(dev, "Failed to set boot flag\n");
> +		return r;
> +	}
> +
> +	/* set boot from sRam */
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_BOOT_CTRL1,
> +			boot_val1, sizeof(boot_val1));
> +	if (r < 0) {
> +		dev_err(dev, "Failed to set boot flag\n");
> +		return r;
> +	}
> +
> +	/* disbale ILM access */
> +	reg_val[0] = 0x00;
> +	r = goodix_reg_write_confirm(ts_dev, HW_REG_ILM_ACCESS,
> +			reg_val, 1);
> +	if (r < 0) {
> +		dev_err(dev, "Failed to disable ILM access\n");
> +		return r;
> +	}
> +
> +	/* Release CPU */
> +	r = goodix_cpu_ctrl(ts_dev, CPU_CTRL_RUNNING);
> +	if (r < 0)
> +		return r;
> +
> +	/* wait isp idel */
> +	r = goodix_isp_wait_stat(ts_dev, ISP_STAT_IDLE);
> +	if (r < 0) {
> +		dev_err(dev, "Wait ISP IDLE timeout\n");
> +		return r;
> +	}
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_write_fwdata - write firmware data to ISP buffer
> + * @ts_dev: pointer to touch device
> + * @fw_data: firmware data
> + * @size: size of data, size can not exceed ISP_MAX_BUFFERSIZE
> + *  + checksum size{2},
> + * return: 0 ok, <0 error
> + */
> +static int goodix_write_fwdata(struct goodix_ts_device *ts_dev,
> +			const u8 *fw_data, u32 size)
> +{
> +	if (!fw_data || size > ISP_MAX_BUFFERSIZE)
> +		return -EINVAL;
> +
> +	return  goodix_reg_write(ts_dev, HW_REG_ISP_BUFFER,
> +				(u8 *)fw_data, size);
> +}
> +
> +/**
> + * goodix_format_fw_packet - formate one flash packet
> + * @pkt: target firmware packet
> + * @flash_addr: flash address
> + * @size: packet size
> + * @data: packet data
> + */
> +static int goodix_format_fw_packet(struct firmware_packet *pkt,
> +	u32 flash_addr, u32 size, const u8 *data)
> +{
> +	if (!pkt || !data || size % 4)
> +		return -EINVAL;
> +
> +	/*
> +	 * checksum rule:sum of data in one format is equal to zero
> +	 * data format: byte/le16/be16/le32/be32/le64/be64
> +	 */
> +	pkt->flash_addr = cpu_to_le32(flash_addr);
> +	pkt->packet_size = cpu_to_le32(size);
> +	pkt->packet_checksum = checksum_le32((u8 *)data, size);
> +	pkt->data = data;
> +	return 0;
> +}
> +
> +/**
> + * goodix_send_fw_packet - send one firmware packet to ISP
> + * @ts_dev: target touch device
> + * @pkt: firmware packet
> + * return：0 ok, <0 error
> + */
> +static int goodix_send_fw_packet(struct goodix_ts_device *ts_dev,
> +		struct firmware_packet *pkt)
> +{
> +	u8 pkt_info[12];
> +	int r;
> +
> +	if (!pkt)
> +		return -EINVAL;
> +
> +	/* 1: wait ISP idle */
> +	r = goodix_isp_wait_stat(ts_dev, ISP_STAT_IDLE);
> +	if (r < 0)
> +		return r;
> +
> +	/* 2: write packet information */
> +	memcpy(pkt_info, pkt, sizeof(pkt_info));
> +	r = goodix_reg_write(ts_dev, HW_REG_ISP_PKT_INFO,
> +			pkt_info, sizeof(pkt_info));
> +	if (r < 0) {
> +		dev_err(ts_dev->dev, "Failed to write packet info\n");
> +		return r;
> +	}
> +
> +	/* 3: Make ISP ready to flash */
> +	r = goodix_isp_command(ts_dev, ISP_CMD_PREPARE);
> +	if (r  < 0) {
> +		dev_err(ts_dev->dev, "Failed to make ISP ready\n");
> +		return r;
> +	}
> +
> +	/* 4: write packet data(firmware block) to ISP buffer */
> +	r = goodix_write_fwdata(ts_dev, pkt->data, pkt->packet_size);
> +	if (r < 0) {
> +		dev_err(ts_dev->dev, "Failed to write firmware packet\n");
> +		return r;
> +	}
> +
> +	/* 5: wait ISP ready */
> +	r = goodix_isp_wait_stat(ts_dev, ISP_STAT_READY);
> +	if (r < 0) {
> +		dev_err(ts_dev->dev, "Failed to wait ISP ready\n");
> +		return r;
> +	}
> +
> +	/* 6: start writting to flash */
> +	r = goodix_isp_command(ts_dev, ISP_CMD_FLASH);
> +	if (r < 0) {
> +		dev_err(ts_dev->dev, "Failed to start flash\n");
> +		return r;
> +	}
> +
> +	/* 7: wait idle */
> +	r = goodix_isp_wait_stat(ts_dev, ISP_STAT_IDLE);
> +	if (r < 0) {
> +		dev_err(ts_dev->dev, "Error occurred when wait ISP idle\n");
> +		return r;
> +	};
> +
> +	/* check ISP result */
> +	r = goodix_isp_flash_done(ts_dev);
> +	if (r < 0) {
> +		dev_err(ts_dev->dev, "Flash fw packet failed:%d\n", r);
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * goodix_flash_subsystem - flash subsystem firmware,
> + *  Main flow of flashing firmware.
> + *	Each firmware subsystem is divided into several
> + *	packets, the max size of packet is limited to
> + *	@{ISP_MAX_BUFFERSIZE}
> + * @ts_dev: pointer to touch device
> + * @subsys: subsystem information
> + * return: 0 ok, < 0 error
> + */
> +static int goodix_flash_subsystem(struct goodix_ts_device *ts_dev,
> +				struct fw_subsys_info *subsys)
> +{
> +	struct firmware_packet fw_pkt;
> +	u32 data_size, total_size, offset;
> +	int r = 0;
> +
> +	/*
> +	 * if bus(i2c/spi) error occued, then exit, we will do
> +	 * hardware reset and re-prepare ISP and then retry
> +	 * flashing
> +	 */
> +	total_size = subsys->size;
> +	offset = 0;
> +	while (total_size > 0) {
> +		data_size = total_size > ISP_MAX_BUFFERSIZE ?
> +				ISP_MAX_BUFFERSIZE : total_size;
> +		dev_info(ts_dev->dev, "Flash firmware to %08x,size:%u bytes\n",
> +				subsys->flash_addr + offset, data_size);
> +
> +		/* format one firmware packet */
> +		r = goodix_format_fw_packet(&fw_pkt, subsys->flash_addr + offset,
> +				data_size, &subsys->data[offset]);
> +		if (r < 0) {
> +			dev_err(ts_dev->dev, "Invalid packet params\n");
> +			goto exit;
> +		}
> +
> +		/* send one firmware packet */
> +		r = goodix_send_fw_packet(ts_dev, &fw_pkt);
> +		if (r < 0) {
> +			dev_err(ts_dev->dev,
> +				"Failed to send firmware packet,err:%d\n", r);
> +			goto exit;
> +		}
> +
> +		offset += data_size;
> +		total_size -= data_size;
> +	} /* end while */
> +
> +exit:
> +	return r;
> +}
> +
> +/**
> + * goodix_flash_firmware - flash firmware
> + * @ts_dev: pointer to touch device
> + * @fw_data: firmware data
> + * return: 0 ok, < 0 error
> + */
> +static int goodix_flash_firmware(struct goodix_ts_device *ts_dev,
> +				struct firmware_data *fw_data)
> +{
> +	struct fw_update_ctrl *fw_ctrl;
> +	struct firmware_info  *fw_info;
> +	struct fw_subsys_info *fw_x;
> +	int retry = GOODIX_BUS_RETRY_TIMES;
> +	int i, r = 0, fw_num, prog_step;
> +
> +	/* start from subsystem 1, subsystem 0 is the ISP program */
> +	fw_ctrl = container_of(fw_data, struct fw_update_ctrl, fw_data);
> +	fw_info = &fw_data->fw_info;
> +	fw_num = fw_info->subsys_num;
> +
> +	/* we have 80% work here */
> +	prog_step = 80 / (fw_num - 1);
> +
> +	for (i = 1; i < fw_num && retry;) {
> +		dev_info(ts_dev->dev,
> +			"--- Start to flash subsystem[%d] ---", i);
> +		fw_x = &fw_info->subsys[i];
> +		r = goodix_flash_subsystem(ts_dev, fw_x);
> +		if (r == 0) {
> +			dev_info(ts_dev->dev,
> +				"--- End flash subsystem[%d]: OK ---", i);
> +			fw_ctrl->progress += prog_step;
> +			i++;
> +		} else if (r == -EAGAIN) {
> +			retry--;
> +			dev_err(ts_dev->dev,
> +				"--- End flash subsystem%d: Fail, errno:%d, retry:%d ---",
> +				i, r, GOODIX_BUS_RETRY_TIMES - retry);
> +		} else if (r < 0) { /* bus error */
> +			dev_err(ts_dev->dev,
> +				"--- End flash subsystem%d: Fatal error:%d exit ---",
> +				i, r);
> +			goto exit_flash;
> +		}
> +	}
> +
> +exit_flash:
> +	return r;
> +}
> +
> +/**
> + * goodix_update_finish - update finished, free resource
> + *  and reset flags---
> + * @fwu_ctrl: pointer to fw_update_ctrl structrue
> + * return: 0 ok, < 0 error
> + */
> +static int goodix_update_finish(struct fw_update_ctrl *fwu_ctrl)
> +{
> +	struct goodix_ts_version ver;
> +	int r = 0;
> +
> +	fwu_ctrl->ts_dev->hw_ops->reset(fwu_ctrl->ts_dev);
> +	r = fwu_ctrl->ts_dev->hw_ops->read_version(fwu_ctrl->ts_dev, &ver);
> +	return r;
> +}
> +
> +/**
> + * goodix_fw_update_proc - firmware update process, the entry of
> + *  firmware update flow
> + * @fwu_ctrl: firmware control
> + * return: 0 ok, < 0 error
> + */
> +int goodix_fw_update_proc(struct fw_update_ctrl *fwu_ctrl)
> +{
> +#define FW_UPDATE_RETRY	2
> +	const struct device *dev = fwu_ctrl->ts_dev->dev;
> +	int retry0 = FW_UPDATE_RETRY, retry1 = FW_UPDATE_RETRY;
> +	int r = 0;
> +
> +	if (fwu_ctrl->status == UPSTA_PREPARING ||
> +			fwu_ctrl->status == UPSTA_UPDATING) {
> +		dev_err(dev, "Firmware update already in progress\n");
> +		return -EBUSY;
> +	}
> +	fwu_ctrl->progress = 0;
> +	fwu_ctrl->status = UPSTA_PREPARING;
> +	r = goodix_parse_firmware(fwu_ctrl);
> +	if (r < 0) {
> +		fwu_ctrl->status = UPSTA_ABORT;
> +		goto err_parse_fw;
> +	}
> +	fwu_ctrl->progress = 10;
> +	if (fwu_ctrl->force_update == false) {
> +		r = goodix_check_update(fwu_ctrl->ts_dev,
> +				&fwu_ctrl->fw_data.fw_info);
> +		if (r < 0) {
> +			fwu_ctrl->status = UPSTA_ABORT;
> +			goto err_check_update;
> +		}
> +	}
> +start_update:
> +	fwu_ctrl->progress = 20;
> +	fwu_ctrl->status = UPSTA_UPDATING; /* show upgrading status */
> +	r = goodix_update_prepare(fwu_ctrl);
> +	if ((r == -EBUS || r == -EAGAIN) && --retry0 > 0) {
> +		dev_err(dev, "Bus error, retry prepare ISP:%d\n",
> +				FW_UPDATE_RETRY - retry0);
> +		goto start_update;
> +	} else if (r < 0) {
> +		dev_err(dev, "Failed to prepare ISP, exit update:%d\n", r);
> +		fwu_ctrl->status = UPSTA_FAILED;
> +		goto err_fw_prepare;
> +	}
> +	/* progress: 20%~100% */
> +	r = goodix_flash_firmware(fwu_ctrl->ts_dev, &fwu_ctrl->fw_data);
> +	if ((r == -EBUS || r == -ETIMEOUT) && --retry1 > 0) {
> +		/* we will retry[twice] if returns bus error[i2c/spi]
> +		 * we will do hardware reset and re-prepare ISP and then retry
> +		 * flashing
> +		 */
> +		dev_err(dev, "Bus error, retry firmware update:%d\n",
> +				FW_UPDATE_RETRY - retry1);
> +		goto start_update;
> +	} else if (r < 0) {
> +		dev_err(dev, "Fatal error, exit update:%d\n", r);
> +		fwu_ctrl->status = UPSTA_FAILED;
> +		goto err_fw_flash;
> +	}
> +	fwu_ctrl->status = UPSTA_SUCCESS;
> +err_fw_flash:
> +err_fw_prepare:
> +	goodix_update_finish(fwu_ctrl);
> +err_check_update:
> +err_parse_fw:
> +	if (fwu_ctrl->status == UPSTA_SUCCESS)
> +		dev_info(dev, "Firmware update successfully\n");
> +	else if (fwu_ctrl->status == UPSTA_FAILED)
> +		dev_err(dev, "Firmware update failed\n");
> +	fwu_ctrl->progress = 100; /* 100% */
> +	return r;
> +}
> +/* COMMON PART - END */
> +
> +/**
> + * goodix_request_firmware - request firmware data from user space
> + *
> + * @fw_data: firmware struct, contains firmware header info
> + *	and firmware data pointer.
> + * return: 0 - OK, < 0 - error
> + */
> +static int goodix_request_firmware(struct firmware_data *fw_data,
> +				const char *name)
> +{
> +	struct fw_update_ctrl *fw_ctrl =
> +		container_of(fw_data, struct fw_update_ctrl, fw_data);
> +	struct device *dev = fw_ctrl->ts_dev->dev;
> +	int r;
> +
> +	r = request_firmware(&fw_data->firmware, name, dev);
> +	if (r < 0)
> +		dev_err(dev,
> +			"Firmware image [%s] not available,errno:%d\n", name, r);
> +	else
> +		dev_info(dev, "Firmware image [%s] is ready\n", name);
> +	return r;
> +}
> +
> +/**
> + * relase firmware resources
> + *
> + */
> +static inline void goodix_release_firmware(struct firmware_data *fw_data)
> +{
> +	if (fw_data->firmware) {
> +		release_firmware(fw_data->firmware);
> +		fw_data->firmware = NULL;
> +	}
> +}
> +
> +static int goodix_fw_update_thread(void *data)
> +{
> +	struct fw_update_ctrl *fwu_ctrl = data;
> +	static DEFINE_MUTEX(fwu_lock);
> +	int r = -EINVAL;
> +
> +	if (!fwu_ctrl)
> +		return r;
> +
> +	if (goodix_register_ext_module(&goodix_fwu_module))
> +		return -EIO;
> +
> +	mutex_lock(&fwu_lock);
> +	/* judge where to get firmware data */
> +	if (!fwu_ctrl->fw_from_sysfs) {
> +		r = goodix_request_firmware(&fwu_ctrl->fw_data,
> +				fwu_ctrl->fw_name);
> +		if (r < 0) {
> +			fwu_ctrl->status = UPSTA_ABORT;
> +			fwu_ctrl->progress = 100;
> +			goto out;
> +		}
> +	} else {
> +		if (!fwu_ctrl->fw_data.firmware) {
> +			fwu_ctrl->status = UPSTA_ABORT;
> +			fwu_ctrl->progress = 100;
> +			r = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	/* DONT allow reset/irq/suspend/resume during update */
> +	fwu_ctrl->allow_irq = false;
> +	fwu_ctrl->allow_suspend = false;
> +	fwu_ctrl->allow_resume = false;
> +	goodix_ts_blocking_notify(NOTIFY_FWUPDATE_START, NULL);
> +
> +	/* ready to update */
> +	r = goodix_fw_update_proc(fwu_ctrl);
> +
> +	goodix_ts_blocking_notify(NOTIFY_FWUPDATE_END, NULL);
> +	fwu_ctrl->allow_reset = true;
> +	fwu_ctrl->allow_irq = true;
> +	fwu_ctrl->allow_suspend = true;
> +	fwu_ctrl->allow_resume = true;
> +
> +	/* clean */
> +	if (!fwu_ctrl->fw_from_sysfs) {
> +		goodix_release_firmware(&fwu_ctrl->fw_data);
> +	} else {
> +		fwu_ctrl->fw_from_sysfs = false;
> +		vfree(fwu_ctrl->fw_data.firmware);
> +		fwu_ctrl->fw_data.firmware = NULL;
> +	}
> +
> +out:
> +	goodix_unregister_ext_module(&goodix_fwu_module);
> +	mutex_unlock(&fwu_lock);
> +	return r;
> +}
> +
> +/* sysfs attributes */
> +static ssize_t goodix_sysfs_update_fw_store(
> +		struct goodix_ext_module *module,
> +		const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	ret = goodix_fw_update_thread(module->priv_data);
> +	if (ret)
> +		count = ret;
> +
> +	return count;
> +}
> +
> +static ssize_t goodix_sysfs_update_progress_show(
> +		struct goodix_ext_module *module,
> +		char *buf)
> +{
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", fw_ctrl->progress);
> +}
> +
> +static ssize_t goodix_sysfs_update_result_show(
> +		struct goodix_ext_module *module,
> +		char *buf)
> +{
> +	char *result = NULL;
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +
> +	switch (fw_ctrl->status) {
> +	case UPSTA_NOTWORK:
> +		result = "notwork";
> +		break;
> +	case UPSTA_PREPARING:
> +		result = "preparing";
> +		break;
> +	case UPSTA_UPDATING:
> +		result = "upgrading";
> +		break;
> +	case UPSTA_ABORT:
> +		result = "abort";
> +		break;
> +	case UPSTA_SUCCESS:
> +		result = "success";
> +		break;
> +	case UPSTA_FAILED:
> +		result = "failed";
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", result);
> +}
> +
> +static ssize_t goodix_sysfs_update_fwversion_show(
> +		struct goodix_ext_module *module,
> +		char *buf)
> +{
> +	struct goodix_ts_version fw_ver;
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +	int r = 0;
> +	char str[5];
> +
> +	/* read version from chip */
> +	r = fw_ctrl->ts_dev->hw_ops->read_version(fw_ctrl->ts_dev,
> +			&fw_ver);
> +	if (!r) {
> +		memcpy(str, fw_ver.pid, 4);
> +		str[4] = '\0';
> +		return scnprintf(buf, PAGE_SIZE, "PID:%s VID:%04x SENSOR_ID:%d\n",
> +				str, fw_ver.vid, fw_ver.sensor_id);
> +	}
> +	return 0;
> +}
> +
> +static ssize_t goodix_sysfs_fwsize_show(struct goodix_ext_module *module,
> +		char *buf)
> +{
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +	int r = -EINVAL;
> +
> +	if (fw_ctrl && fw_ctrl->fw_data.firmware)
> +		r = snprintf(buf, PAGE_SIZE, "%zu\n",
> +				fw_ctrl->fw_data.firmware->size);
> +	return r;
> +}
> +
> +static ssize_t goodix_sysfs_fwsize_store(struct goodix_ext_module *module,
> +		const char *buf, size_t count)
> +{
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +	struct firmware *fw;
> +	u8 **data;
> +	size_t size = 0;
> +
> +	if (!fw_ctrl)
> +		return -EINVAL;
> +
> +	if (sscanf(buf, "%zu", &size) < 0 || !size) {
> +		dev_err(fw_ctrl->ts_dev->dev, "Failed to get fwsize");
> +		return -EFAULT;
> +	}
> +
> +	fw = vmalloc(sizeof(*fw) + size);
> +	if (!fw)
> +		return -ENOMEM;
> +
> +	memset(fw, 0x00, sizeof(*fw) + size);
> +	data = (u8 **)&fw->data;
> +	*data = (u8 *)fw + sizeof(struct firmware);
> +	fw->size = size;
> +	fw_ctrl->fw_data.firmware = fw;
> +	fw_ctrl->fw_from_sysfs = true;
> +
> +	return count;
> +}
> +
> +static ssize_t goodix_sysfs_fwimage_store(struct file *file,
> +		struct kobject *kobj, struct bin_attribute *attr,
> +		char *buf, loff_t pos, size_t count)
> +{
> +	struct fw_update_ctrl *fw_ctrl;
> +	struct firmware_data *fw_data;
> +
> +	fw_ctrl = container_of(attr, struct fw_update_ctrl,
> +			attr_fwimage);
> +	fw_data = &fw_ctrl->fw_data;
> +
> +	if (!fw_data->firmware) {
> +		dev_err(fw_ctrl->ts_dev->dev, "Need set fw image size first");
> +		return -ENOMEM;
> +	}
> +
> +	if (fw_data->firmware->size == 0) {
> +		dev_err(fw_ctrl->ts_dev->dev, "Invalid firmware size");
> +		return -EINVAL;
> +	}
> +
> +	if (pos + count > fw_data->firmware->size)
> +		return -EFAULT;
> +
> +	memcpy((u8 *)&fw_data->firmware->data[pos], buf, count);
> +	fw_ctrl->force_update = true;
> +
> +	return count;
> +}
> +
> +static ssize_t goodix_sysfs_force_update_store(
> +		struct goodix_ext_module *module,
> +		const char *buf, size_t count)
> +{
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +	int val;
> +
> +	if (kstrtoint(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val)
> +		fw_ctrl->force_update = true;
> +	else
> +		fw_ctrl->force_update = false;
> +
> +	return count;
> +}
> +
> +
> +static ssize_t goodix_sysfs_update_hwversion_show(
> +		struct goodix_ext_module *module,
> +		char *buf)
> +{
> +	struct goodix_ts_version fw_ver;
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +	int r = 0;
> +	char str[5];
> +
> +	/* read version from chip */
> +	r = fw_ctrl->ts_dev->hw_ops->read_version(fw_ctrl->ts_dev,
> +			&fw_ver);
> +	if (!r) {
> +		memcpy(str, fw_ver.pid, 4);
> +		str[4] = '\0';
> +		return scnprintf(buf, PAGE_SIZE, "%s\n", str);
> +	}
> +	return 0;
> +}
> +
> +static ssize_t goodix_sysfs_update_fw_version_show(
> +		struct goodix_ext_module *module,
> +		char *buf)
> +{
> +	struct goodix_ts_version fw_ver;
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +	int r = 0;
> +
> +	/* read version from chip */
> +	r = fw_ctrl->ts_dev->hw_ops->read_version(fw_ctrl->ts_dev,
> +			&fw_ver);
> +	if (!r) {
> +		/* firmversion major+minor store formate is 2byte compress BCD */
> +		return scnprintf(buf, PAGE_SIZE, "%2x.%2x\n",
> +				fw_ver.vid >> 8, fw_ver.vid & 0xff);
> +
> +	}
> +	return 0;
> +}
> +
> +static ssize_t goodix_sysfs_fw_name_store(
> +		struct goodix_ext_module *module,
> +		const char *buf, size_t count)
> +{
> +	struct fw_update_ctrl *fwu_ctrl;
> +
> +	if (!module || !module->priv_data)
> +		return -ENOMEM;
> +
> +	fwu_ctrl = module->priv_data;
> +	if (count > FW_NAME_MAX) {
> +		dev_err(fwu_ctrl->ts_dev->dev, "Firmware name too long");
> +		return -EINVAL;
> +	}
> +	memset(fwu_ctrl->fw_name, 0, FW_NAME_MAX);
> +	memcpy(fwu_ctrl->fw_name, buf, count);
> +
> +	return count;
> +}
> +
> +static struct goodix_ext_attribute goodix_fwu_attrs[] = {
> +	__EXTMOD_ATTR(progress, 0444, goodix_sysfs_update_progress_show, NULL),
> +	__EXTMOD_ATTR(result, 0444, goodix_sysfs_update_result_show, NULL),
> +	__EXTMOD_ATTR(fwversion, 0444, goodix_sysfs_update_fwversion_show, NULL),
> +	__EXTMOD_ATTR(fwsize, 0644, goodix_sysfs_fwsize_show,
> +			goodix_sysfs_fwsize_store),
> +	__EXTMOD_ATTR(force_update, 0200, NULL, goodix_sysfs_force_update_store),
> +	__EXTMOD_ATTR(update_fw, 0200, NULL, goodix_sysfs_update_fw_store),
> +	__EXTMOD_ATTR(fw_version, 0444, goodix_sysfs_update_fw_version_show, NULL),
> +	__EXTMOD_ATTR(fw_name, 0200, NULL, goodix_sysfs_fw_name_store),
> +	__EXTMOD_ATTR(hw_version, 0444, goodix_sysfs_update_hwversion_show, NULL),
> +};
> +
> +static int goodix_syfs_init(struct goodix_ts_core *core_data,
> +		struct goodix_ext_module *module)
> +{
> +	struct fw_update_ctrl *fw_ctrl = module->priv_data;
> +	const struct device *dev = &core_data->pdev->dev;
> +	struct kobj_type *ktype;
> +	int ret = 0, i;
> +
> +	ktype = goodix_get_default_ktype();
> +	ret = kobject_init_and_add(&module->kobj,
> +			ktype,
> +			&core_data->pdev->dev.kobj,
> +			"fwupdate");
> +	if (ret) {
> +		dev_err(dev, "Create fwupdate sysfs node error!\n");
> +		goto exit_sysfs_init;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(goodix_fwu_attrs); i++) {
> +		if (sysfs_create_file(&module->kobj,
> +				&goodix_fwu_attrs[i].attr)) {
> +			dev_warn(dev, "Create sysfs attr file error\n");
> +			kobject_put(&module->kobj);
> +			ret = -EINVAL;
> +			goto exit_sysfs_init;
> +		}
> +	}
> +
> +	fw_ctrl->attr_fwimage.attr.name = "fwimage";
> +	fw_ctrl->attr_fwimage.attr.mode = 0200;
> +	fw_ctrl->attr_fwimage.size = 0;
> +	fw_ctrl->attr_fwimage.write = goodix_sysfs_fwimage_store;
> +	ret = sysfs_create_bin_file(&module->kobj,
> +			&fw_ctrl->attr_fwimage);
> +
> +exit_sysfs_init:
> +	return ret;
> +}
> +
> +static int goodix_fw_update_init(struct goodix_ts_core *core_data,
> +				struct goodix_ext_module *module)
> +{
> +	struct goodix_ts_board_data *ts_bdata = board_data(core_data);
> +	struct fw_update_ctrl *fwu_ctrl;
> +	static bool init_sysfs = true;
> +
> +	if (!core_data->ts_dev)
> +		return -ENODEV;
> +
> +	if (!module->priv_data) {
> +		module->priv_data = kzalloc(sizeof(struct fw_update_ctrl),
> +							GFP_KERNEL);
> +		if (!module->priv_data)
> +			return -ENOMEM;
> +	}
> +	fwu_ctrl = module->priv_data;
> +	fwu_ctrl->ts_dev = core_data->ts_dev;
> +
> +	/* find a valid firmware image name */
> +	if (strlen(fwu_ctrl->fw_name) == 0) {
> +		if (ts_bdata && ts_bdata->fw_name)
> +			strlcpy(fwu_ctrl->fw_name, ts_bdata->fw_name,
> +					sizeof(fwu_ctrl->fw_name));
> +		else
> +			strlcpy(fwu_ctrl->fw_name, TS_DEFAULT_FIRMWARE,
> +					sizeof(fwu_ctrl->fw_name));
> +	}
> +
> +	/* create sysfs interface */
> +	if (init_sysfs) {
> +		if (!goodix_syfs_init(core_data, module))
> +			init_sysfs = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static int goodix_fw_update_exit(struct goodix_ts_core *core_data,
> +				struct goodix_ext_module *module)
> +{
> +	return 0;
> +}
> +
> +static int goodix_fw_before_suspend(struct goodix_ts_core *core_data,
> +				struct goodix_ext_module *module)
> +{
> +	struct fw_update_ctrl *fwu_ctrl = module->priv_data;
> +
> +	return fwu_ctrl->allow_suspend ?
> +				EVT_HANDLED : EVT_CANCEL_SUSPEND;
> +}
> +
> +static int goodix_fw_before_resume(struct goodix_ts_core *core_data,
> +				struct goodix_ext_module *module)
> +{
> +	struct fw_update_ctrl *fwu_ctrl = module->priv_data;
> +
> +	return fwu_ctrl->allow_resume ?
> +				EVT_HANDLED : EVT_CANCEL_RESUME;
> +}
> +
> +static int goodix_fw_irq_event(struct goodix_ts_core *core_data,
> +				struct goodix_ext_module *module)
> +{
> +	struct fw_update_ctrl *fwu_ctrl = module->priv_data;
> +
> +	return fwu_ctrl->allow_irq ?
> +				EVT_HANDLED : EVT_CANCEL_IRQEVT;
> +}
> +
> +static int goodix_fw_before_reset(struct goodix_ts_core *core_data,
> +				struct goodix_ext_module *module)
> +{
> +	struct fw_update_ctrl *fwu_ctrl = module->priv_data;
> +
> +	return fwu_ctrl->allow_reset ?
> +				EVT_HANDLED : EVT_CANCEL_RESET;
> +}
> +
> +static const struct goodix_ext_module_funcs goodix_ext_funcs = {
> +	.init = goodix_fw_update_init,
> +	.exit = goodix_fw_update_exit,
> +	.before_reset = goodix_fw_before_reset,
> +	.after_reset = NULL,
> +	.before_suspend = goodix_fw_before_suspend,
> +	.after_suspend = NULL,
> +	.before_resume = goodix_fw_before_resume,
> +	.after_resume = NULL,
> +	.irq_event = goodix_fw_irq_event,
> +};
> +
> +static struct goodix_ext_module goodix_fwu_module = {
> +	.name = "goodix-fwu",
> +	.funcs = &goodix_ext_funcs,
> +	.priority = EXTMOD_PRIO_FWUPDATE,
> +};
> +
> +static int __init goodix_fwu_module_init(void)
> +{
> +	return goodix_register_ext_module(&goodix_fwu_module);
> +}
> +
> +static void __exit goodix_fwu_module_exit(void)
> +{
> +}
> +
> +module_init(goodix_fwu_module_init);
> +module_exit(goodix_fwu_module_exit);
> +
> +MODULE_DESCRIPTION("Goodix FWU Module");
> +MODULE_AUTHOR("Goodix, Inc.");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.c b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.c
> new file mode 100755
> index 0000000..f562b36
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.c
> @@ -0,0 +1,1366 @@
> + /*
> +  * Goodix GTx5 Touchscreen Driver
> +  * Core layer of touchdriver architecture.
> +  *
> +  * Copyright (C) 2015 - 2016 Goodix, Inc.
> +  * Authors:  Wang Yafei <wangyafei@goodix.com>
> +  *
> +  * This program is free software; you can redistribute it and/or modify
> +  * it under the terms of the GNU General Public License as published by
> +  * the Free Software Foundation; either version 2 of the License, or
> +  * (at your option) any later version.
> +  *
> +  * This program is distributed in the hope that it will be a reference
> +  * to you, when you are integrating the GOODiX's CTP IC into your system,
> +  * but WITHOUT ANY WARRANTY; without even the implied warranty of
> +  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +  * General Public License for more details.
> +  *
> +  */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +#include <linux/completion.h>
> +#include <linux/debugfs.h>
> +#include <linux/of_irq.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/input/mt.h>
> +#include "goodix_ts_core.h"
> +
> +#define INPUT_TYPE_B_PROTOCOL
> +
> +#define GOOIDX_INPUT_PHYS	"goodix_ts/input0"
> +#define PINCTRL_STATE_ACTIVE    "pmx_ts_active"
> +#define PINCTRL_STATE_SUSPEND   "pmx_ts_suspend"
> +
> +/*
> + * struct goodix_modules - external modules container
> + * @head: external modules list
> + * @initilized: whether this struct is initilized
> + * @mutex: mutex lock
> + * @count: current number of registered external module
> + * @wq: workqueue to do register work
> + * @core_exit: if goodix touch core exit, then no
> + *   registration is allowed.
> + * @core_data: core_data pointer
> + */
> +struct goodix_modules {
> +	struct list_head head;
> +	bool initilized;
> +	struct mutex mutex;
> +	unsigned int count;
> +	struct workqueue_struct *wq;
> +	bool core_exit;
> +	struct completion core_comp;
> +	struct goodix_ts_core *core_data;
> +};
> +static struct goodix_modules goodix_modules;
> +
> +/**
> + * __do_register_ext_module - register external module
> + * to register into touch core modules structure
> + */
> +static void  __do_register_ext_module(struct work_struct *work)
> +{
> +	struct goodix_ext_module *module =
> +			container_of(work, struct goodix_ext_module, work);
> +	struct goodix_ext_module *ext_module;
> +	struct list_head *insert_point = &goodix_modules.head;
> +
> +	/* waitting for core layer */
> +	if (!wait_for_completion_timeout(&goodix_modules.core_comp, 5 * HZ))
> +		return;
> +
> +	/* driver probe failed */
> +	if (goodix_modules.core_exit)
> +		return;
> +
> +	/* prority level *must* be set */
> +	if (module->priority == EXTMOD_PRIO_RESERVED)
> +		return;
> +
> +	mutex_lock(&goodix_modules.mutex);
> +	if (!list_empty(&goodix_modules.head)) {
> +		list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +			if (ext_module == module) {
> +				mutex_unlock(&goodix_modules.mutex);
> +				return;
> +			}
> +		}
> +
> +		list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +			/* small value of priority have higher priority level */
> +			if (ext_module->priority >= module->priority) {
> +				insert_point = &ext_module->list;
> +				break;
> +			}
> +		}
> +		/* else module will be inserted to goodix_modules->head */
> +	}
> +
> +	if (module->funcs && module->funcs->init) {
> +		if (module->funcs->init(goodix_modules.core_data,
> +					module) < 0) {
> +			mutex_unlock(&goodix_modules.mutex);
> +			return;
> +		}
> +	}
> +
> +	list_add(&module->list, insert_point->prev);
> +	goodix_modules.count++;
> +	mutex_unlock(&goodix_modules.mutex);
> +}
> +
> +/**
> + * goodix_register_ext_module - interface for external module
> + * to register into touch core modules structure
> + *
> + * @module: pointer to external module to be register
> + * return: 0 ok, <0 failed
> + */
> +int goodix_register_ext_module(struct goodix_ext_module *module)
> +{
> +	if (!module)
> +		return -EINVAL;
> +
> +	if (!goodix_modules.initilized) {
> +		goodix_modules.initilized = true;
> +		INIT_LIST_HEAD(&goodix_modules.head);
> +		mutex_init(&goodix_modules.mutex);
> +		init_completion(&goodix_modules.core_comp);
> +	}
> +
> +	if (goodix_modules.core_exit)
> +		return -EFAULT;
> +
> +	INIT_WORK(&module->work, __do_register_ext_module);
> +	schedule_work(&module->work);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(goodix_register_ext_module);
> +
> +/**
> + * goodix_unregister_ext_module - interface for external module
> + * to unregister external modules
> + *
> + * @module: pointer to external module
> + * return: 0 ok, <0 failed
> + */
> +int goodix_unregister_ext_module(struct goodix_ext_module *module)
> +{
> +	struct goodix_ext_module *ext_module;
> +	bool found = false;
> +
> +	if (!module)
> +		return -EINVAL;
> +
> +	if (!goodix_modules.initilized)
> +		return -EINVAL;
> +
> +	if (!goodix_modules.core_data)
> +		return -ENODEV;
> +
> +	mutex_lock(&goodix_modules.mutex);
> +	if (!list_empty(&goodix_modules.head)) {
> +		list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +			if (ext_module == module) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	} else {
> +		mutex_unlock(&goodix_modules.mutex);
> +		return -EFAULT;
> +	}
> +
> +	if (!found) {
> +		mutex_unlock(&goodix_modules.mutex);
> +		return -EFAULT;
> +	}
> +
> +	list_del(&module->list);
> +	mutex_unlock(&goodix_modules.mutex);
> +
> +	if (module->funcs && module->funcs->exit)
> +		module->funcs->exit(goodix_modules.core_data, module);
> +	goodix_modules.count--;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(goodix_unregister_ext_module);
> +
> +static void goodix_ext_sysfs_release(struct kobject *kobj)
> +{
> +	return;
> +}
> +
> +#define to_ext_module(kobj) container_of(kobj,\
> +				struct goodix_ext_module, kobj)
> +#define to_ext_attr(attr) container_of(attr,\
> +				struct goodix_ext_attribute, attr)
> +
> +static ssize_t goodix_ext_sysfs_show(struct kobject *kobj,
> +		struct attribute *attr, char *buf)
> +{
> +	struct goodix_ext_module *module = to_ext_module(kobj);
> +	struct goodix_ext_attribute *ext_attr = to_ext_attr(attr);
> +
> +	if (ext_attr->show)
> +		return ext_attr->show(module, buf);
> +
> +	return -EIO;
> +}
> +
> +static ssize_t goodix_ext_sysfs_store(struct kobject *kobj,
> +		struct attribute *attr, const char *buf, size_t count)
> +{
> +	struct goodix_ext_module *module = to_ext_module(kobj);
> +	struct goodix_ext_attribute *ext_attr = to_ext_attr(attr);
> +
> +	if (ext_attr->store)
> +		return ext_attr->store(module, buf, count);
> +
> +	return -EIO;
> +}
> +
> +static const struct sysfs_ops goodix_ext_ops = {
> +	.show = goodix_ext_sysfs_show,
> +	.store = goodix_ext_sysfs_store
> +};
> +
> +static struct kobj_type goodix_ext_ktype = {
> +	.release = goodix_ext_sysfs_release,
> +	.sysfs_ops = &goodix_ext_ops,
> +};
> +
> +struct kobj_type *goodix_get_default_ktype(void)
> +{
> +	return &goodix_ext_ktype;
> +}
> +EXPORT_SYMBOL_GPL(goodix_get_default_ktype);
> +
> +struct kobject *goodix_get_default_kobj(void)
> +{
> +	struct kobject *kobj = NULL;
> +
> +	if (goodix_modules.core_data &&
> +			goodix_modules.core_data->pdev)
> +		kobj = &goodix_modules.core_data->pdev->dev.kobj;
> +	return kobj;
> +}
> +EXPORT_SYMBOL_GPL(goodix_get_default_kobj);
> +
> +/* show external module information */
> +static ssize_t goodix_ts_extmod_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct goodix_ext_module *module;
> +	size_t offset = 0;
> +	int r;
> +
> +	mutex_lock(&goodix_modules.mutex);
> +	if (!list_empty(&goodix_modules.head)) {
> +		list_for_each_entry(module, &goodix_modules.head, list) {
> +			r = snprintf(&buf[offset], PAGE_SIZE,
> +					"priority:%u module:%s\n",
> +					module->priority, module->name);
> +			if (r < 0) {
> +				mutex_unlock(&goodix_modules.mutex);
> +				return -EINVAL;
> +			}
> +			offset += r;
> +		}
> +	}
> +
> +	mutex_unlock(&goodix_modules.mutex);
> +	return offset;
> +}
> +
> +/* show driver information */
> +static ssize_t goodix_ts_driver_info_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "DriverVersion:%s\n",
> +			GOODIX_DRIVER_VERSION);
> +}
> +
> +/* show chip infoamtion */
> +static ssize_t goodix_ts_chip_info_show(struct device  *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct goodix_ts_core *core_data =
> +		dev_get_drvdata(dev);
> +	struct goodix_ts_device *ts_dev = core_data->ts_dev;
> +	struct goodix_ts_version chip_ver;
> +	int r, cnt = 0;
> +
> +	cnt += snprintf(buf, PAGE_SIZE,
> +			"TouchDeviceName:%s\n", ts_dev->name);
> +	if (ts_dev->hw_ops->read_version) {
> +		r = ts_dev->hw_ops->read_version(ts_dev, &chip_ver);
> +		if (!r && chip_ver.valid) {
> +			cnt += snprintf(&buf[cnt], PAGE_SIZE,
> +					"PID:%s\nVID:%04x\nSensorID:%02x\n",
> +					chip_ver.pid, chip_ver.vid,
> +					chip_ver.sensor_id);
> +		}
> +	}
> +
> +	return cnt;
> +}
> +
> +/* show chip configuration data */
> +static ssize_t goodix_ts_config_data_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct goodix_ts_core *core_data =
> +		dev_get_drvdata(dev);
> +	struct goodix_ts_device *ts_dev = core_data->ts_dev;
> +	struct goodix_ts_config *ncfg = ts_dev->normal_cfg;
> +	u8 *data;
> +	int i, r, offset = 0;
> +
> +	if (ncfg && ncfg->initialized && ncfg->length < PAGE_SIZE) {
> +		data = kmalloc(ncfg->length, GFP_KERNEL);
> +		if (!data)
> +			return -ENOMEM;
> +
> +		r = ts_dev->hw_ops->read(ts_dev, ncfg->reg_base,
> +				&data[0], ncfg->length);
> +		if (r < 0) {
> +			kfree(data);
> +			return -EINVAL;
> +		}
> +
> +		for (i = 0; i < ncfg->length; i++) {
> +			if (i != 0 && i % 20 == 0)
> +				buf[offset++] = '\n';
> +			offset += snprintf(&buf[offset], PAGE_SIZE - offset,
> +					"%02x ", data[i]);
> +		}
> +		buf[offset++] = '\n';
> +		buf[offset++] = '\0';
> +		kfree(data);
> +		return offset;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/* reset chip */
> +static ssize_t goodix_ts_reset_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	struct goodix_ts_core *core_data =
> +		dev_get_drvdata(dev);
> +	struct goodix_ts_device *ts_dev = core_data->ts_dev;
> +	int en;
> +
> +	if (kstrtoint(buf, 10, &en))
> +		return -EINVAL;
> +
> +	if (en != 1)
> +		return -EINVAL;
> +
> +	if (ts_dev->hw_ops->reset)
> +		ts_dev->hw_ops->reset(ts_dev);
> +	return count;
> +
> +}
> +
> +/* show irq information */
> +static ssize_t goodix_ts_irq_info_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct goodix_ts_core *core_data =
> +		dev_get_drvdata(dev);
> +	struct irq_desc *desc;
> +	size_t offset = 0;
> +	int r;
> +
> +	r = snprintf(&buf[offset], PAGE_SIZE, "irq:%u\n",
> +			core_data->irq);
> +	if (r < 0)
> +		return -EINVAL;
> +
> +	offset += r;
> +	r = snprintf(&buf[offset], PAGE_SIZE - offset, "state:%s\n",
> +		atomic_read(&core_data->irq_enabled) ?
> +		"enabled" : "disabled");
> +	if (r < 0)
> +		return -EINVAL;
> +
> +	desc = irq_to_desc(core_data->irq);
> +	offset += r;
> +	r = snprintf(&buf[offset], PAGE_SIZE - offset, "disable-depth:%d\n",
> +		desc->depth);
> +	if (r < 0)
> +		return -EINVAL;
> +
> +	offset += r;
> +	r = snprintf(&buf[offset], PAGE_SIZE - offset, "trigger-count:%zu\n",
> +		core_data->irq_trig_cnt);
> +	if (r < 0)
> +		return -EINVAL;
> +
> +	offset += r;
> +	r = snprintf(&buf[offset], PAGE_SIZE - offset,
> +			"echo 0/1 > irq_info to disable/enable irq");
> +	if (r < 0)
> +		return -EINVAL;
> +
> +	offset += r;
> +	return offset;
> +}
> +
> +/* enable/disable irq */
> +static ssize_t goodix_ts_irq_info_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	struct goodix_ts_core *core_data =
> +		dev_get_drvdata(dev);
> +	int en;
> +
> +	if (kstrtoint(buf, 10, &en))
> +		return -EINVAL;
> +
> +	goodix_ts_irq_enable(core_data, en);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(extmod_info, 0444, goodix_ts_extmod_show, NULL);
> +static DEVICE_ATTR(driver_info, 0444, goodix_ts_driver_info_show, NULL);
> +static DEVICE_ATTR(chip_info, 0444, goodix_ts_chip_info_show, NULL);
> +static DEVICE_ATTR(config_data, 0444, goodix_ts_config_data_show, NULL);
> +static DEVICE_ATTR(reset, 0200, NULL, goodix_ts_reset_store);
> +static DEVICE_ATTR(irq_info, 0644,
> +		goodix_ts_irq_info_show, goodix_ts_irq_info_store);
> +
> +static struct attribute *sysfs_attrs[] = {
> +	&dev_attr_extmod_info.attr,
> +	&dev_attr_driver_info.attr,
> +	&dev_attr_chip_info.attr,
> +	&dev_attr_config_data.attr,
> +	&dev_attr_reset.attr,
> +	&dev_attr_irq_info.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group sysfs_group = {
> +	.attrs = sysfs_attrs,
> +};
> +
> +static int goodix_ts_sysfs_init(struct goodix_ts_core *core_data)
> +{
> +	return sysfs_create_group(&core_data->pdev->dev.kobj, &sysfs_group);
> +}
> +
> +static void goodix_ts_sysfs_exit(struct goodix_ts_core *core_data)
> +{
> +	sysfs_remove_group(&core_data->pdev->dev.kobj, &sysfs_group);
> +}
> +
> +/* event notifier */
> +static BLOCKING_NOTIFIER_HEAD(ts_notifier_list);
> +/**
> + * goodix_ts_register_client - register a client notifier
> + * @nb: notifier block to callback on events
> + *  see enum ts_notify_event in goodix_ts_core.h
> + */
> +int goodix_ts_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&ts_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(goodix_ts_register_notifier);
> +
> +/**
> + * goodix_ts_unregister_client - unregister a client notifier
> + * @nb: notifier block to callback on events
> + *	see enum ts_notify_event in goodix_ts_core.h
> + */
> +int goodix_ts_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&ts_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(goodix_ts_unregister_notifier);
> +
> +/**
> + * goodix_ts_blocking_notify - notify clients of certain events
> + *	see enum ts_notify_event in goodix_ts_core.h
> + */
> +int goodix_ts_blocking_notify(enum ts_notify_event evt, void *v)
> +{
> +	return blocking_notifier_call_chain(&ts_notifier_list,
> +			(unsigned long)evt, v);
> +}
> +EXPORT_SYMBOL_GPL(goodix_ts_blocking_notify);
> +
> +/**
> + * goodix_ts_input_report - report touch event to input subsystem
> + *
> + * @dev: input device pointer
> + * @touch_data: touch data pointer
> + * return: 0 ok, <0 failed
> + */
> +static int goodix_ts_input_report(struct input_dev *dev,
> +		struct goodix_touch_data *touch_data)
> +{
> +	struct goodix_ts_coords *coords = &touch_data->coords[0];
> +	struct goodix_ts_core *core_data = input_get_drvdata(dev);
> +	struct goodix_ts_board_data *ts_bdata = board_data(core_data);
> +	unsigned int touch_num = touch_data->touch_num, x, y;
> +	static u16 pre_fin;
> +	int i, id;
> +
> +	/* report touch-key */
> +	if (unlikely(touch_data->key_value)) {
> +		for (i = 0; i < ts_bdata->panel_max_key; i++) {
> +			input_report_key(dev, ts_bdata->panel_key_map[i],
> +					touch_data->key_value & (1 << i));
> +		}
> +	}
> +
> +	/* first touch down and last touch up condition */
> +	if (touch_num != 0 && pre_fin == 0x0000) {
> +		/* first touch down event */
> +		input_report_key(dev, BTN_TOUCH, 1);
> +		input_report_key(dev, BTN_TOOL_FINGER, 1);
> +	} else if (touch_num == 0 && pre_fin != 0x0000) {
> +		/* no finger exist */
> +		input_report_key(dev, BTN_TOUCH, 0);
> +		input_report_key(dev, BTN_TOOL_FINGER, 0);
> +	} else if (touch_num == 0 && pre_fin == 0x0000) {
> +		return 0;
> +	}
> +
> +	/* report abs */
> +	id = coords->id;
> +	for (i = 0; i < ts_bdata->panel_max_id; i++) {
> +		if (touch_num && i == id) {
> +			/* this is a valid touch down event */
> +#ifdef INPUT_TYPE_B_PROTOCOL
> +			input_mt_slot(dev, id);
> +			input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
> +#else
> +			input_report_abs(dev, ABS_MT_TRACKING_ID, id);
> +#endif
> +			if (unlikely(ts_bdata->swap_axis)) {
> +				x = coords->y;
> +				y = coords->x;
> +			} else {
> +				x = coords->x;
> +				y = coords->y;
> +			}
> +			input_report_abs(dev, ABS_MT_POSITION_X, x);
> +			input_report_abs(dev, ABS_MT_POSITION_Y, y);
> +			input_report_abs(dev, ABS_MT_TOUCH_MAJOR, coords->w);
> +			pre_fin |= 1 << i;
> +			id = (++coords)->id;
> +#ifndef INPUT_TYPE_B_PROTOCOL
> +			input_mt_sync(dev);
> +#endif
> +		} else {
> +			if (pre_fin & (1 << i)) {/* release touch */
> +#ifdef INPUT_TYPE_B_PROTOCOL
> +				input_mt_slot(dev, i);
> +				input_mt_report_slot_state(dev, MT_TOOL_FINGER,
> +						false);
> +#endif
> +				pre_fin &= ~(1 << i);
> +			}
> +		}
> +	}
> +
> +#ifndef INPUT_TYPE_B_PROTOCOL
> +	if (!pre_fin)
> +		input_mt_sync(dev);
> +#endif
> +	input_sync(dev);
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_threadirq_func - Bottom half of interrupt
> + * This functions is excuted in thread context,
> + * sleep in this function is permit.
> + *
> + * @core_data: pointer to touch core data
> + * return: 0 ok, <0 failed
> + */
> +static irqreturn_t goodix_ts_threadirq_func(int irq, void *data)
> +{
> +	struct goodix_ts_core *core_data = data;
> +	struct goodix_ts_device *ts_dev =  core_data->ts_dev;
> +	struct goodix_ext_module *ext_module;
> +	struct goodix_ts_event *ts_event = &core_data->ts_event;
> +	int r;
> +
> +	core_data->irq_trig_cnt++;
> +	/* inform external module */
> +	list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +		if (!ext_module->funcs->irq_event)
> +			continue;
> +		r = ext_module->funcs->irq_event(core_data, ext_module);
> +		if (r == EVT_CANCEL_IRQEVT)
> +			return IRQ_HANDLED;
> +	}
> +
> +	/* read touch data from touch device */
> +	r = ts_dev->hw_ops->event_handler(ts_dev, ts_event);
> +	if (likely(r >= 0)) {
> +		if (ts_event->event_type == EVENT_TOUCH) {
> +			/* report touch */
> +			goodix_ts_input_report(core_data->input_dev,
> +					&ts_event->event_data.touch_data);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * goodix_ts_init_irq - Requset interrupt line from system
> + * @core_data: pointer to touch core data
> + * return: 0 ok, <0 failed
> + */
> +static int goodix_ts_irq_setup(struct goodix_ts_core *core_data)
> +{
> +	const struct goodix_ts_board_data *ts_bdata =
> +			board_data(core_data);
> +	const struct device *dev = &core_data->pdev->dev;
> +	int r;
> +
> +	/* if ts_bdata->irq is invalid get it from irq-gpio */
> +	if (ts_bdata->irq <= 0)
> +		core_data->irq = gpiod_to_irq(ts_bdata->irq_gpiod);
> +	else
> +		core_data->irq = ts_bdata->irq;
> +
> +	dev_info(dev, "IRQ:%u,flags:%d\n", core_data->irq, (int)ts_bdata->irq_flags);
> +	r = devm_request_threaded_irq(&core_data->pdev->dev,
> +			core_data->irq, NULL,
> +			goodix_ts_threadirq_func,
> +			ts_bdata->irq_flags | IRQF_ONESHOT,
> +			GOODIX_CORE_DRIVER_NAME,
> +			core_data);
> +	if (r < 0)
> +		dev_err(dev, "Failed to requeset threaded irq:%d\n", r);
> +	else
> +		atomic_set(&core_data->irq_enabled, 1);
> +
> +	return r;
> +}
> +
> +/**
> + * goodix_ts_irq_enable - Enable/Disable a irq
> + * @core_data: pointer to touch core data
> + * enable: enable or disable irq
> + * return: 0 ok, <0 failed
> + */
> +int goodix_ts_irq_enable(struct goodix_ts_core *core_data,
> +			bool enable)
> +{
> +	const struct device *dev = &core_data->pdev->dev;
> +
> +	if (enable) {
> +		if (!atomic_cmpxchg(&core_data->irq_enabled, 0, 1)) {
> +			enable_irq(core_data->irq);
> +			dev_dbg(dev, "Irq enabled\n");
> +		}
> +	} else {
> +		if (atomic_cmpxchg(&core_data->irq_enabled, 1, 0)) {
> +			disable_irq(core_data->irq);
> +			dev_dbg(dev, "Irq disabled\n");
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(goodix_ts_irq_enable);
> +/**
> + * goodix_ts_power_init - Get regulator for touch device
> + * @core_data: pointer to touch core data
> + * return: 0 ok, <0 failed
> + */
> +static int goodix_ts_power_init(struct goodix_ts_core *core_data)
> +{
> +	struct device *dev = NULL;
> +	struct goodix_ts_board_data *ts_bdata;
> +
> +	/* dev:i2c client device or spi slave device*/
> +	dev =  core_data->ts_dev->dev;
> +	ts_bdata = board_data(core_data);
> +
> +	if (ts_bdata->avdd_name) {
> +		core_data->avdd = devm_regulator_get(dev, ts_bdata->avdd_name);
> +		if (IS_ERR_OR_NULL(core_data->avdd)) {
> +			core_data->avdd = NULL;
> +			return -ENOENT;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_power_on - Turn on power to the touch device
> + * @core_data: pointer to touch core data
> + * return: 0 ok, <0 failed
> + */
> +static int goodix_ts_power_on(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ts_board_data *ts_bdata =
> +			board_data(core_data);
> +	const struct device *dev = &core_data->pdev->dev;
> +	int r;
> +
> +	dev_info(dev, "Device power on\n");
> +	if (core_data->power_on)
> +		return 0;
> +
> +	if (core_data->avdd) {
> +		r = regulator_enable(core_data->avdd);
> +		if (!r) {
> +			if (ts_bdata->power_on_delay_us)
> +				usleep_range(ts_bdata->power_on_delay_us,
> +					ts_bdata->power_on_delay_us);
> +		} else {
> +			dev_err(dev, "Failed to enable analog power:%d\n", r);
> +			return r;
> +		}
> +	}
> +
> +	core_data->power_on = 1;
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_power_off - Turn off power to the touch device
> + * @core_data: pointer to touch core data
> + * return: 0 ok, <0 failed
> + */
> +static int goodix_ts_power_off(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ts_board_data *ts_bdata =
> +			board_data(core_data);
> +	const struct device *dev = &core_data->pdev->dev;
> +	int r;
> +
> +	dev_info(dev, "Device power off\n");
> +	if (!core_data->power_on)
> +		return 0;
> +
> +	if (core_data->avdd) {
> +		r = regulator_disable(core_data->avdd);
> +		if (!r) {
> +			if (ts_bdata->power_off_delay_us)
> +				usleep_range(ts_bdata->power_off_delay_us,
> +						ts_bdata->power_off_delay_us);
> +		} else {
> +			dev_err(dev, "Failed to disable analog power:%d\n", r);
> +			return r;
> +		}
> +	}
> +
> +	core_data->power_on = 0;
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_gpio_setup - Request gpio resources from GPIO subsysten
> + *	reset_gpio and irq_gpio number are obtained from goodix_ts_device
> + *  which created in hardware layer driver. e.g.goodix_xx_i2c.c
> + *	A goodix_ts_device should set those two fileds to right value
> + *	before registed to touch core driver.
> + * @core_data: pointer to touch core data
> + * return: 0 ok, <0 failed
> + */
> +static void goodix_ts_gpio_setup(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ts_board_data *ts_bdata = board_data(core_data);
> +	struct goodix_ts_device *ts_dev = core_data->ts_dev;
> +	const struct device *dev = &core_data->pdev->dev;
> +
> +	ts_bdata->reset_gpiod = devm_gpiod_get_optional(ts_dev->dev,
> +			"reset", GPIOD_OUT_LOW);
> +	if (!ts_bdata->reset_gpiod)
> +		dev_info(dev, "No reset gpio found\n");
> +
> +	ts_bdata->irq_gpiod = devm_gpiod_get_optional(ts_dev->dev,
> +			"irq", GPIOD_IN);
> +	if (!ts_bdata->irq_gpiod)
> +		dev_info(dev, "No irq gpio found\n");
> +
> +}
> +
> +/**
> + * goodix_input_set_params - set input parameters
> + */
> +static void goodix_ts_set_input_params(struct input_dev *input_dev,
> +		struct goodix_ts_board_data *ts_bdata)
> +{
> +	int i;
> +
> +	if (ts_bdata->swap_axis)
> +		swap(ts_bdata->panel_max_x, ts_bdata->panel_max_y);
> +
> +	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID,
> +			0, ts_bdata->panel_max_id, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> +			0, ts_bdata->panel_max_x, 0, 0);
> +
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> +			0, ts_bdata->panel_max_y, 0, 0);
> +
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
> +			0, ts_bdata->panel_max_w, 0, 0);
> +	if (ts_bdata->panel_max_key) {
> +		for (i = 0; i < ts_bdata->panel_max_key; i++)
> +			input_set_capability(input_dev, EV_KEY,
> +					ts_bdata->panel_key_map[i]);
> +	}
> +}
> +
> +/**
> + * goodix_ts_input_dev_config - Requset and config a input device
> + *  then register it to input sybsystem.
> + *  NOTE that some hardware layer may provide a input device
> + *  (ts_dev->input_dev not NULL).
> + * @core_data: pointer to touch core data
> + * return: 0 ok, <0 failed
> + */
> +static int goodix_ts_input_dev_config(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ts_board_data *ts_bdata = board_data(core_data);
> +	struct device *dev = &core_data->pdev->dev;
> +	struct input_dev *input_dev = NULL;
> +	int r;
> +
> +	input_dev = devm_input_allocate_device(dev);
> +	if (!input_dev) {
> +		dev_err(dev, "Failed to allocated input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	core_data->input_dev = input_dev;
> +	input_set_drvdata(input_dev, core_data);
> +
> +	input_dev->name = GOODIX_CORE_DRIVER_NAME;
> +	input_dev->phys = GOOIDX_INPUT_PHYS;
> +	input_dev->id.product = 0xDEAD;
> +	input_dev->id.vendor = 0xBEEF;
> +	input_dev->id.version = 10427;
> +
> +	__set_bit(EV_SYN, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
> +
> +#ifdef INPUT_PROP_DIRECT
> +	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> +#endif
> +
> +	/* set input parameters */
> +	goodix_ts_set_input_params(input_dev, ts_bdata);
> +
> +#ifdef INPUT_TYPE_B_PROTOCOL
> +	input_mt_init_slots(input_dev, ts_bdata->panel_max_id,
> +			INPUT_MT_DIRECT);
> +#endif
> +
> +	input_set_capability(input_dev, EV_KEY, KEY_POWER);
> +	r = input_register_device(input_dev);
> +	if (r < 0) {
> +		dev_err(dev, "Unable to register input device\n");
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_hw_init - Hardware initialize
> + *  poweron - hardware reset - sendconfig
> + * @core_data: pointer to touch core data
> + * return: 0 intilize ok, <0 failed
> + */
> +static int goodix_ts_hw_init(struct goodix_ts_core *core_data)
> +{
> +	const struct goodix_ts_hw_ops *hw_ops =
> +		ts_hw_ops(core_data);
> +	int r;
> +
> +	r = goodix_ts_power_on(core_data);
> +	if (r < 0)
> +		goto exit;
> +
> +	/* reset touch device */
> +	if (hw_ops->reset)
> +		hw_ops->reset(core_data->ts_dev);
> +
> +	/* init */
> +	if (hw_ops->init) {
> +		r = hw_ops->init(core_data->ts_dev);
> +		if (r < 0) {
> +			core_data->hw_err = true;
> +			goto exit;
> +		}
> +	}
> +
> +exit:
> +	/* if bus communication error occurred then exit driver binding, other
> +	 * errors will be ignored
> +	 */
> +	if (r != -EBUS)
> +		r = 0;
> +	return r;
> +}
> +
> +/**
> + * goodix_ts_esd_work - check hardware status and recovery
> + *  the hardware if needed.
> + */
> +static void goodix_ts_esd_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct goodix_ts_esd *ts_esd = container_of(dwork,
> +			struct goodix_ts_esd, esd_work);
> +	struct goodix_ts_core *core = container_of(ts_esd,
> +			struct goodix_ts_core, ts_esd);
> +	const struct goodix_ts_hw_ops *hw_ops = ts_hw_ops(core);
> +	int r = 0;
> +
> +	if (ts_esd->esd_on == false)
> +		return;
> +
> +	if (hw_ops->check_hw)
> +		r = hw_ops->check_hw(core->ts_dev);
> +	if (r < 0) {
> +		goodix_ts_power_off(core);
> +		goodix_ts_power_on(core);
> +		if (hw_ops->reset)
> +			hw_ops->reset(core->ts_dev);
> +	}
> +
> +	mutex_lock(&ts_esd->esd_mutex);
> +	if (ts_esd->esd_on)
> +		schedule_delayed_work(&ts_esd->esd_work, 2 * HZ);
> +	mutex_unlock(&ts_esd->esd_mutex);
> +}
> +
> +/**
> + * goodix_ts_esd_on - turn on esd protection
> + */
> +static void goodix_ts_esd_on(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ts_esd *ts_esd = &core_data->ts_esd;
> +	const struct device *dev = &core_data->pdev->dev;
> +
> +	mutex_lock(&ts_esd->esd_mutex);
> +	if (ts_esd->esd_on == false) {
> +		ts_esd->esd_on = true;
> +		schedule_delayed_work(&ts_esd->esd_work, 2 * HZ);
> +		mutex_unlock(&ts_esd->esd_mutex);
> +		dev_info(dev, "Esd on\n");
> +		return;
> +	}
> +	mutex_unlock(&ts_esd->esd_mutex);
> +}
> +
> +/**
> + * goodix_ts_esd_off - turn off esd protection
> + */
> +static void goodix_ts_esd_off(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ts_esd *ts_esd = &core_data->ts_esd;
> +	const struct device *dev = &core_data->pdev->dev;
> +
> +	mutex_lock(&ts_esd->esd_mutex);
> +	if (ts_esd->esd_on == true) {
> +		ts_esd->esd_on = false;
> +		cancel_delayed_work(&ts_esd->esd_work);
> +		mutex_unlock(&ts_esd->esd_mutex);
> +		dev_info(dev, "Esd off\n");
> +		return;
> +	}
> +	mutex_unlock(&ts_esd->esd_mutex);
> +}
> +
> +/**
> + * goodix_esd_notifier_callback - notification callback
> + *  under certain condition, we need to turn off/on the esd
> + *  protector, we use kernel notify call chain to achieve this.
> + *
> + *  for example: before firmware update we need to turn off the
> + *  esd protector and after firmware update finished, we should
> + *  turn on the esd protector.
> + */
> +static int goodix_esd_notifier_callback(struct notifier_block *nb,
> +		unsigned long action, void *data)
> +{
> +	struct goodix_ts_esd *ts_esd = container_of(nb,
> +			struct goodix_ts_esd, esd_notifier);
> +
> +	switch (action) {
> +	case NOTIFY_FWUPDATE_START:
> +	case NOTIFY_SUSPEND:
> +		goodix_ts_esd_off(ts_esd->ts_core);
> +		break;
> +	case NOTIFY_FWUPDATE_END:
> +	case NOTIFY_RESUME:
> +		goodix_ts_esd_on(ts_esd->ts_core);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_esd_init - initialize esd protection
> + */
> +static int goodix_ts_esd_init(struct goodix_ts_core *core)
> +{
> +	struct goodix_ts_esd *ts_esd = &core->ts_esd;
> +
> +	INIT_DELAYED_WORK(&ts_esd->esd_work, goodix_ts_esd_work);
> +	mutex_init(&ts_esd->esd_mutex);
> +	ts_esd->ts_core = core;
> +	ts_esd->esd_on = false;
> +	ts_esd->esd_notifier.notifier_call = goodix_esd_notifier_callback;
> +	goodix_ts_register_notifier(&ts_esd->esd_notifier);
> +
> +	if (core->ts_dev->board_data->esd_default_on == true
> +			&& core->ts_dev->hw_ops->check_hw)
> +		goodix_ts_esd_on(core);
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_suspend - Touchscreen suspend function
> + */
> +static int goodix_ts_suspend(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ext_module *ext_module;
> +	struct goodix_ts_device *ts_dev = core_data->ts_dev;
> +	const struct device *dev = &core_data->pdev->dev;
> +	int r;
> +
> +	dev_dbg(dev, "Suspend start\n");
> +	/*
> +	 * notify suspend event, inform the esd protector
> +	 * and charger detector to turn off the work
> +	 */
> +	goodix_ts_blocking_notify(NOTIFY_SUSPEND, NULL);
> +
> +	/* inform external module */
> +	mutex_lock(&goodix_modules.mutex);
> +	if (!list_empty(&goodix_modules.head)) {
> +		list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +			if (!ext_module->funcs->before_suspend)
> +				continue;
> +
> +			r = ext_module->funcs->before_suspend(core_data, ext_module);
> +			if (r == EVT_CANCEL_SUSPEND) {
> +				mutex_unlock(&goodix_modules.mutex);
> +				dev_dbg(dev, "Canceled by module:%s\n",
> +					ext_module->name);
> +				goto out;
> +			}
> +		}
> +	}
> +	mutex_unlock(&goodix_modules.mutex);
> +
> +	/* disable irq */
> +	goodix_ts_irq_enable(core_data, false);
> +
> +	/* let touch ic work in sleep mode */
> +	if (ts_dev && ts_dev->hw_ops->suspend)
> +		ts_dev->hw_ops->suspend(ts_dev);
> +	atomic_set(&core_data->suspended, 1);
> +
> +	/* inform exteranl modules */
> +	mutex_lock(&goodix_modules.mutex);
> +	if (!list_empty(&goodix_modules.head)) {
> +		list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +			if (!ext_module->funcs->after_suspend)
> +				continue;
> +
> +			r = ext_module->funcs->after_suspend(core_data, ext_module);
> +			if (r == EVT_CANCEL_SUSPEND) {
> +				mutex_unlock(&goodix_modules.mutex);
> +				dev_dbg(dev, "Canceled by module:%s\n",
> +					ext_module->name);
> +				goto out;
> +			}
> +		}
> +	}
> +	mutex_unlock(&goodix_modules.mutex);
> +
> +out:
> +	/* release all the touch IDs */
> +	core_data->ts_event.event_data.touch_data.touch_num = 0;
> +	goodix_ts_input_report(core_data->input_dev,
> +			&core_data->ts_event.event_data.touch_data);
> +	dev_dbg(dev, "Suspend end\n");
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_resume - Touchscreen resume function
> + * Called by PM/FB/EARLYSUSPEN module to wakeup device
> + */
> +static int goodix_ts_resume(struct goodix_ts_core *core_data)
> +{
> +	struct goodix_ext_module *ext_module;
> +	struct goodix_ts_device *ts_dev = core_data->ts_dev;
> +	const struct device *dev = &core_data->pdev->dev;
> +	int r;
> +
> +	dev_dbg(dev, "Resume start\n");
> +	mutex_lock(&goodix_modules.mutex);
> +	if (!list_empty(&goodix_modules.head)) {
> +		list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +			if (!ext_module->funcs->before_resume)
> +				continue;
> +
> +			r = ext_module->funcs->before_resume(core_data, ext_module);
> +			if (r == EVT_CANCEL_RESUME) {
> +				mutex_unlock(&goodix_modules.mutex);
> +				dev_dbg(dev, "Canceled by module:%s\n",
> +					ext_module->name);
> +				goto out;
> +			}
> +		}
> +	}
> +	mutex_unlock(&goodix_modules.mutex);
> +
> +	atomic_set(&core_data->suspended, 0);
> +	/* resume device */
> +	if (ts_dev && ts_dev->hw_ops->resume)
> +		ts_dev->hw_ops->resume(ts_dev);
> +
> +	goodix_ts_irq_enable(core_data, true);
> +
> +	mutex_lock(&goodix_modules.mutex);
> +	if (!list_empty(&goodix_modules.head)) {
> +		list_for_each_entry(ext_module, &goodix_modules.head, list) {
> +			if (!ext_module->funcs->after_resume)
> +				continue;
> +
> +			r = ext_module->funcs->after_resume(core_data, ext_module);
> +			if (r == EVT_CANCEL_RESUME) {
> +				mutex_unlock(&goodix_modules.mutex);
> +				dev_dbg(dev, "Canceled by module:%s\n",
> +					ext_module->name);
> +				goto out;
> +			}
> +		}
> +	}
> +	mutex_unlock(&goodix_modules.mutex);
> +
> +out:
> +	/*
> +	 * notify resume event, inform the esd protector
> +	 * and charger detector to turn on the work
> +	 */
> +	goodix_ts_blocking_notify(NOTIFY_RESUME, NULL);
> +	dev_dbg(dev, "Resume end\n");
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_pm_suspend - PM suspend function
> + * Called by kernel during system suspend phrase
> + */
> +static int __maybe_unused goodix_ts_pm_suspend(struct device *dev)
> +{
> +	struct goodix_ts_core *core_data =
> +		dev_get_drvdata(dev);
> +
> +	return goodix_ts_suspend(core_data);
> +}
> +/**
> + * goodix_ts_pm_resume - PM resume function
> + * Called by kernel during system wakeup
> + */
> +static int __maybe_unused goodix_ts_pm_resume(struct device *dev)
> +{
> +	struct goodix_ts_core *core_data =
> +		dev_get_drvdata(dev);
> +
> +	return goodix_ts_resume(core_data);
> +}
> +
> +/**
> + * goodix_generic_noti_callback - generic notifier callback
> + *  for goodix touch notification event.
> + */
> +static int goodix_generic_noti_callback(struct notifier_block *self,
> +		unsigned long action, void *data)
> +{
> +	struct goodix_ts_core *ts_core = container_of(self,
> +			struct goodix_ts_core, ts_notifier);
> +	const struct goodix_ts_hw_ops *hw_ops = ts_hw_ops(ts_core);
> +	int r;
> +
> +	switch (action) {
> +	case NOTIFY_FWUPDATE_END:
> +		if (ts_core->hw_err && hw_ops->init) {
> +			/* Firmware has been updated, we need to reinit
> +			 * the chip, read the sensor ID and send the
> +			 * correct config data based on sensor ID.
> +			 * The input parameters also needs to be updated.
> +			 */
> +			r = hw_ops->init(ts_core->ts_dev);
> +			if (r < 0)
> +				goto exit;
> +
> +			goodix_ts_set_input_params(ts_core->input_dev,
> +					ts_core->ts_dev->board_data);
> +			ts_core->hw_err = false;
> +		}
> +		break;
> +	}
> +
> +exit:
> +	return 0;
> +}
> +
> +/**
> + * goodix_ts_probe - called by kernel when a Goodix touch
> + *  platform driver is added.
> + */
> +static int goodix_ts_probe(struct platform_device *pdev)
> +{
> +	struct goodix_ts_core *core_data = NULL;
> +	struct goodix_ts_device *ts_device;
> +	int r;
> +
> +	ts_device = pdev->dev.platform_data;
> +	if (!ts_device || !ts_device->hw_ops || !ts_device->board_data) {
> +		dev_err(&pdev->dev, "Invalid touch device\n");
> +		return -ENODEV;
> +	}
> +
> +	core_data = devm_kzalloc(&pdev->dev, sizeof(struct goodix_ts_core),
> +						GFP_KERNEL);
> +	if (!core_data)
> +		return -ENOMEM;
> +
> +	/* touch core layer is a platform driver */
> +	core_data->pdev = pdev;
> +	core_data->ts_dev = ts_device;
> +	platform_set_drvdata(pdev, core_data);
> +
> +	r = goodix_ts_power_init(core_data);
> +	if (r < 0)
> +		dev_err(&pdev->dev, "Failed power init\n");
> +
> +	/* get GPIO resource if have */
> +	goodix_ts_gpio_setup(core_data);
> +
> +	/* initialize firmware */
> +	r = goodix_ts_hw_init(core_data);
> +	if (r < 0)
> +		goto out;
> +
> +	/* alloc/config/register input device */
> +	r = goodix_ts_input_dev_config(core_data);
> +	if (r < 0)
> +		goto out;
> +
> +	/* request irq line */
> +	r = goodix_ts_irq_setup(core_data);
> +	if (r < 0)
> +		goto out;
> +
> +	/* inform the external module manager that
> +	 * touch core layer is ready now
> +	 */
> +	goodix_modules.core_data = core_data;
> +	complete_all(&goodix_modules.core_comp);
> +
> +	/* create sysfs files */
> +	goodix_ts_sysfs_init(core_data);
> +
> +	/* esd protector */
> +	goodix_ts_esd_init(core_data);
> +
> +	/* generic notifier callback */
> +	core_data->ts_notifier.notifier_call = goodix_generic_noti_callback;
> +	goodix_ts_register_notifier(&core_data->ts_notifier);
> +
> +	return 0;
> +	/* we use resource managed api(devm_), no need to free resource */
> +out:
> +	goodix_modules.core_exit = true;
> +	complete_all(&goodix_modules.core_comp);
> +	dev_err(&pdev->dev, "Core layer probe failed");
> +	return r;
> +}
> +
> +static int goodix_ts_remove(struct platform_device *pdev)
> +{
> +	struct goodix_ts_core *core_data =
> +		platform_get_drvdata(pdev);
> +
> +	goodix_ts_power_off(core_data);
> +	goodix_ts_sysfs_exit(core_data);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(dev_pm_ops, goodix_ts_pm_suspend, goodix_ts_pm_resume);
> +
> +static const struct platform_device_id ts_core_ids[] = {
> +	{.name = GOODIX_CORE_DRIVER_NAME},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, ts_core_ids);
> +
> +static struct platform_driver goodix_ts_driver = {
> +	.driver = {
> +		.name = GOODIX_CORE_DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +		.pm = &dev_pm_ops,
> +	},
> +	.probe = goodix_ts_probe,
> +	.remove = goodix_ts_remove,
> +	.id_table = ts_core_ids,
> +};
> +
> +static int __init goodix_ts_core_init(void)
> +{
> +	if (!goodix_modules.initilized) {
> +		goodix_modules.initilized = true;
> +		INIT_LIST_HEAD(&goodix_modules.head);
> +		mutex_init(&goodix_modules.mutex);
> +		init_completion(&goodix_modules.core_comp);
> +	}
> +
> +	return platform_driver_register(&goodix_ts_driver);
> +}
> +
> +
> +static void __exit goodix_ts_core_exit(void)
> +{
> +	platform_driver_unregister(&goodix_ts_driver);
> +}
> +
> +module_init(goodix_ts_core_init);
> +module_exit(goodix_ts_core_exit);
> +
> +MODULE_DESCRIPTION("Goodix Touchscreen Core Module");
> +MODULE_AUTHOR("Goodix, Inc.");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.h b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.h
> new file mode 100755
> index 0000000..400746e
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_core.h
> @@ -0,0 +1,553 @@
> +/*
> + * Goodix GTx5 Touchscreen Driver
> + * Core layer of touchdriver architecture.
> + *
> + * Copyright (C) 2015 - 2016 Goodix, Inc.
> + * Authors:  Wang Yafei <wangyafei@goodix.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be a reference
> + * to you, when you are integrating the GOODiX's CTP IC into your system,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + */
> +#ifndef _GOODIX_TS_CORE_H_
> +#define _GOODIX_TS_CORE_H_
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/firmware.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/kthread.h>
> +#include <linux/version.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <asm/unaligned.h>
> +#ifdef CONFIG_OF
> +#include <linux/of_gpio.h>
> +#include <linux/regulator/consumer.h>
> +#endif
> +
> +#include <linux/gpio/consumer.h>
> +
> +/* macros definition */
> +#define GOODIX_CORE_DRIVER_NAME	"goodix_ts"
> +#define GOODIX_DRIVER_VERSION	"v0.8"
> +#define GOODIX_BUS_RETRY_TIMES	3
> +#define GOODIX_MAX_TOUCH	10
> +#define GOODIX_MAX_KEY		3
> +#define GOODIX_CFG_MAX_SIZE	1024
> +
> +/*
> + * struct goodix_ts_board_data -  board data
> + * @avdd_name: name of analoy regulator
> + * @reset_gpio: reset gpio number
> + * @irq_gpio: interrupt gpio number
> + * @irq_flag: irq trigger type
> + * @power_on_delay_us: power on delay time (us)
> + * @power_off_delay_us: power off delay time (us)
> + * @swap_axis: whether swaw x y axis
> + * @panel_max_id: max supported fingers
> + * @panel_max_x/y/w/p: resolution and size
> + * @panel_max_key: max supported keys
> + * @pannel_key_map: key map
> + * @fw_name: name of the firmware image
> + */
> +struct goodix_ts_board_data {
> +	const char *avdd_name;
> +	struct gpio_desc *reset_gpiod;
> +	struct gpio_desc *irq_gpiod;
> +	int irq;
> +	unsigned int  irq_flags;
> +
> +	unsigned int power_on_delay_us;
> +	unsigned int power_off_delay_us;
> +
> +	unsigned int swap_axis;
> +	unsigned int panel_max_id; /*max touch id*/
> +	unsigned int panel_max_x;
> +	unsigned int panel_max_y;
> +	unsigned int panel_max_w; /*major and minor*/
> +	unsigned int panel_max_key;
> +	unsigned int panel_key_map[GOODIX_MAX_KEY];
> +
> +	const char *fw_name;
> +	bool esd_default_on;
> +};
> +
> +/*
> + * struct goodix_ts_config - chip config data
> + * @initialized: whether intialized
> + * @name: name of this config
> + * @lock: mutex
> + * @reg_base: register base of config data
> + * @length: bytes of the config
> + * @delay: delay time after sending config
> + * @data: config data buffer
> + */
> +struct goodix_ts_config {
> +	bool initialized;
> +	char name[24];
> +	struct mutex lock;
> +	unsigned int reg_base;
> +	unsigned int length;
> +	unsigned int delay; /*ms*/
> +	unsigned char data[GOODIX_CFG_MAX_SIZE];
> +};
> +
> +/*
> + * struct goodix_ts_cmd - command package
> + * @initialized: whether initialized
> + * @cmd_reg: command register
> + * @length: command length in bytes
> + * @cmds: command data
> + */
> +#pragma pack(4)
> +struct goodix_ts_cmd {
> +	u32 initialized;
> +	u32 cmd_reg;
> +	u32 length;
> +	u8 cmds[3];
> +};
> +#pragma pack()
> +
> +/* interrupt event type */
> +enum ts_event_type {
> +	EVENT_INVALID,
> +	EVENT_TOUCH,
> +	EVENT_REQUEST,
> +};
> +
> +/* requset event type */
> +enum ts_request_type {
> +	REQUEST_INVALID,
> +	REQUEST_CONFIG,
> +	REQUEST_BAKREF,
> +	REQUEST_RESET,
> +	REQUEST_MAINCLK,
> +};
> +
> +/* notifier event */
> +
> +enum ts_notify_event {
> +	NOTIFY_FWUPDATE_START,
> +	NOTIFY_FWUPDATE_END,
> +	NOTIFY_SUSPEND,
> +	NOTIFY_RESUME,
> +};
> +
> +/* coordinate package */
> +struct goodix_ts_coords {
> +	int id;
> +	unsigned int x, y, w, p;
> +};
> +
> +/* touch event data */
> +struct goodix_touch_data {
> +	/* finger */
> +	int touch_num;
> +	struct goodix_ts_coords coords[GOODIX_MAX_TOUCH];
> +	/* key */
> +	u16 key_value;
> +};
> +
> +/* request event data */
> +struct goodix_request_data {
> +	enum ts_request_type request_type;
> +};
> +
> +/*
> + * struct goodix_ts_event - touch event struct
> + * @event_type: touch event type, touch data or
> + *	request event
> + * @event_data: event data
> + */
> +struct goodix_ts_event {
> +	enum ts_event_type event_type;
> +	union {
> +		struct goodix_touch_data touch_data;
> +		struct goodix_request_data request_data;
> +	} event_data;
> +};
> +
> +/*
> + * struct goodix_ts_version - firmware version
> + * @valid: whether these infomation is valid
> + * @pid: product id string
> + * @vid: firmware version code
> + * @cid: customer id code
> + * @sensor_id: sendor id
> + */
> +struct goodix_ts_version {
> +	bool valid;
> +	char pid[5];
> +	u16 vid;
> +	u8 cid;
> +	u8 sensor_id;
> +};
> +
> +/*
> + * struct goodix_ts_device - ts device data
> + * @name: device name
> + * @version: reserved
> + * @bus_type: i2c or spi
> + * @board_data: board data obtained from dts
> + * @normal_cfg: normal config data
> + * @highsense_cfg: high sense config data
> + * @hw_ops: hardware operations
> + * @chip_version: firmware version infomation
> + * @sleep_cmd: sleep commang
> + * @gesture_cmd: gesture command
> + * @dev: device pointer,may be a i2c or spi device
> + * @of_node: device node
> + */
> +struct goodix_ts_device {
> +	char *name;
> +	int version;
> +	int bus_type;
> +
> +	struct goodix_ts_board_data *board_data;
> +	struct goodix_ts_config *normal_cfg;
> +	struct goodix_ts_config *highsense_cfg;
> +	const struct goodix_ts_hw_ops *hw_ops;
> +
> +	struct goodix_ts_version chip_version;
> +	struct goodix_ts_cmd sleep_cmd;
> +	struct goodix_ts_cmd gesture_cmd;
> +
> +	struct device *dev;
> +};
> +
> +/*
> + * struct goodix_ts_hw_ops -  hardware opeartions
> + * @init: hardware initialization
> + * @reset: hardware reset
> + * @read: read data from touch device
> + * @write: write data to touch device
> + * @send_cmd: send command to touch device
> + * @send_config: send configuration data
> + * @read_version: read firmware version
> + * @event_handler: touch event handler
> + * @suspend: put touch device into low power mode
> + * @resume: put touch device into working mode
> + */
> +struct goodix_ts_hw_ops {
> +
> +	int (*init)(struct goodix_ts_device *dev);
> +	void (*reset)(struct goodix_ts_device *dev);
> +	int (*read)(struct goodix_ts_device *dev, unsigned int addr,
> +			 unsigned char *data, unsigned int len);
> +	int (*write)(struct goodix_ts_device *dev, unsigned int addr,
> +			unsigned char *data, unsigned int len);
> +	int (*send_cmd)(struct goodix_ts_device *dev,
> +			struct goodix_ts_cmd  *cmd);
> +	int (*send_config)(struct goodix_ts_device *dev,
> +			struct goodix_ts_config *config);
> +	int (*read_version)(struct goodix_ts_device *dev,
> +			struct goodix_ts_version *version);
> +	int (*event_handler)(struct goodix_ts_device *dev,
> +			struct goodix_ts_event *ts_event);
> +	int (*check_hw)(struct goodix_ts_device *dev);
> +	int (*suspend)(struct goodix_ts_device *dev);
> +	int (*resume)(struct goodix_ts_device *dev);
> +};
> +
> +/*
> + * struct goodix_ts_esd - esd protector structure
> + * @esd_work: esd delayed work
> + * @esd_on: true - turn on esd protection, false - turn
> + *  off esd protection
> + * @esd_mutex: protect @esd_on flag
> + */
> +struct goodix_ts_esd {
> +	struct delayed_work esd_work;
> +	struct mutex esd_mutex;
> +	struct notifier_block esd_notifier;
> +	struct goodix_ts_core *ts_core;
> +	bool esd_on;
> +};
> +
> +/*
> + * struct godix_ts_core - core layer data struct
> + * @pdev: core layer platform device
> + * @ts_dev: hardware layer touch device
> + * @input_dev: input device
> + * @avdd: analog regulator
> + * @pinctrl: pinctrl handler
> + * @pin_sta_active: active/normal pin state
> + * @pin_sta_suspend: suspend/sleep pin state
> + * @ts_event: touch event data struct
> + * @power_on: power on/off flag
> + * @irq: irq number
> + * @irq_enabled: irq enabled/disabled flag
> + * @suspended: suspend/resume flag
> + * @hw_err: indicate that hw_ops->init() failed
> + * @ts_notifier: generic notifier
> + * @ts_esd: esd protector structure
> + * @fb_notifier: framebuffer notifier
> + * @early_suspend: early suspend
> + */
> +struct goodix_ts_core {
> +	struct platform_device *pdev;
> +	struct goodix_ts_device *ts_dev;
> +	struct input_dev *input_dev;
> +
> +	struct regulator *avdd;
> +	struct goodix_ts_event ts_event;
> +	int power_on;
> +	int irq;
> +	size_t irq_trig_cnt;
> +
> +	atomic_t irq_enabled;
> +	atomic_t suspended;
> +	bool hw_err;
> +
> +	struct notifier_block ts_notifier;
> +	struct goodix_ts_esd ts_esd;
> +
> +#ifdef CONFIG_FB
> +	struct notifier_block fb_notifier;
> +#endif
> +};
> +
> +/* external module structures */
> +enum goodix_ext_priority {
> +	EXTMOD_PRIO_RESERVED = 0,
> +	EXTMOD_PRIO_FWUPDATE,
> +	EXTMOD_PRIO_GESTURE,
> +	EXTMOD_PRIO_HOTKNOT,
> +	EXTMOD_PRIO_DBGTOOL,
> +	EXTMOD_PRIO_DEFAULT,
> +};
> +
> +struct goodix_ext_module;
> +/* external module's operations callback */
> +struct goodix_ext_module_funcs {
> +	int (*init)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +	int (*exit)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +
> +	int (*before_reset)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +	int (*after_reset)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +
> +	int (*before_suspend)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +	int (*after_suspend)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +
> +	int (*before_resume)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +	int (*after_resume)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +
> +	int (*irq_event)(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module);
> +};
> +
> +/*
> + * struct goodix_ext_module - external module struct
> + * @list: list used to link into modules manager
> + * @name: name of external module
> + * @priority: module priority vlaue, zero is invalid
> + * @funcs: operations callback
> + * @priv_data: private data region
> + * @kobj: kobject
> + * @work: used to queue one work to do registration
> + */
> +struct goodix_ext_module {
> +	struct list_head list;
> +	char *name;
> +	enum goodix_ext_priority priority;
> +	const struct goodix_ext_module_funcs *funcs;
> +	void *priv_data;
> +	struct kobject kobj;
> +	struct work_struct work;
> +};
> +
> +/*
> + * struct goodix_ext_attribute - exteranl attribute struct
> + * @attr: attribute
> + * @show: show interface of external attribute
> + * @store: store interface of external attribute
> + */
> +struct goodix_ext_attribute {
> +	struct attribute attr;
> +	ssize_t (*show)(struct goodix_ext_module *, char *);
> +	ssize_t (*store)(struct goodix_ext_module *, const char *, size_t);
> +};
> +
> +/* external attrs helper macro */
> +#define __EXTMOD_ATTR(_name, _mode, _show, _store)	{	\
> +	.attr = {.name = __stringify(_name), .mode = _mode },	\
> +	.show   = _show,	\
> +	.store  = _store,	\
> +}
> +
> +/* external attrs helper macro, used to define external attrs */
> +#define DEFINE_EXTMOD_ATTR(_name, _mode, _show, _store)	\
> +static struct goodix_ext_attribute ext_attr_##_name = \
> +	__EXTMOD_ATTR(_name, _mode, _show, _store)
> +
> +/*
> + * get board data pointer
> + */
> +static inline struct goodix_ts_board_data *board_data(
> +		struct goodix_ts_core *core)
> +{
> +	return core->ts_dev->board_data;
> +}
> +
> +/*
> + * get touch hardware operations pointer
> + */
> +static inline const struct goodix_ts_hw_ops *ts_hw_ops(
> +		struct goodix_ts_core *core)
> +{
> +	return core->ts_dev->hw_ops;
> +}
> +
> +/*
> + * checksum helper functions
> + * checksum can be u8/le16/be16/le32/be32 format
> + * NOTE: the caller shoule be responsible for the
> + * legality of @data and @size parameters, so be
> + * careful when call these functions.
> + */
> +static inline u8 checksum_u8(u8 *data, u32 size)
> +{
> +	u8 checksum = 0;
> +	u32 i;
> +
> +	for (i = 0; i < size; i++)
> +		checksum += data[i];
> +	return checksum;
> +}
> +
> +static inline u16 checksum_le16(u8 *data, u32 size)
> +{
> +	u16 checksum = 0;
> +	u32 i;
> +
> +	for (i = 0; i < size; i += 2)
> +		checksum += le16_to_cpup((__le16 *)(data + i));
> +	return checksum;
> +}
> +
> +static inline u16 checksum_be16(u8 *data, u32 size)
> +{
> +	u16 checksum = 0;
> +	u32 i;
> +
> +	for (i = 0; i < size; i += 2)
> +		checksum += be16_to_cpup((__be16 *)(data + i));
> +	return checksum;
> +}
> +
> +static inline u32 checksum_le32(u8 *data, u32 size)
> +{
> +	u32 checksum = 0;
> +	u32 i;
> +
> +	for (i = 0; i < size; i += 4)
> +		checksum += le32_to_cpup((__le32 *)(data + i));
> +	return checksum;
> +}
> +
> +static inline u32 checksum_be32(u8 *data, u32 size)
> +{
> +	u32 checksum = 0;
> +	u32 i;
> +
> +	for (i = 0; i < size; i += 4)
> +		checksum += be32_to_cpup((__be32 *)(data + i));
> +	return checksum;
> +}
> +
> +/*
> + * define event action
> + * EVT_xxx macros are used in opeartions callback
> + * defined in @goodix_ext_module_funcs to control
> + * the behaviors of event such as suspend/resume/
> + * irq_event.
> + *
> + * generally there are two types of behaviors:
> + *	1. you want the flow of this event be canceled,
> + *	in this condition, you should return EVT_CANCEL_XXX
> + *	in the operations callback.
> + *		e.g. the firmware update module is updating
> + *		the firmware, you want to cancel suspend flow,
> + *		so you need to return EVT_CANCEL_SUSPEND in
> + *		suspend callback function.
> + *	2. you want the flow of this event continue, in
> + *	this condition, you should return EVT_HANDLED in
> + *	the callback function.
> + */
> +#define EVT_HANDLED			0
> +#define EVT_CONTINUE			0
> +#define EVT_CANCEL			1
> +#define EVT_CANCEL_IRQEVT		1
> +#define EVT_CANCEL_SUSPEND		1
> +#define EVT_CANCEL_RESUME		1
> +#define EVT_CANCEL_RESET		1
> +
> +/*
> + * errno define
> + * Note:
> + *	1. bus read/write functions defined in hardware
> + *	  layer code(e.g. goodix_xxx_i2c.c) *must* return
> + *	  -EBUS if failed to transfer data on bus.
> + */
> +#define EBUS					1000
> +#define ETIMEOUT				1001
> +#define ECHKSUM					1002
> +#define EMEMCMP					1003
> +
> +/**
> + * goodix_register_ext_module - interface for external module
> + * to register into touch core modules structure
> + *
> + * @module: pointer to external module to be register
> + * return: 0 ok, <0 failed
> + */
> +int goodix_register_ext_module(struct goodix_ext_module *module);
> +
> +/**
> + * goodix_unregister_ext_module - interface for external module
> + * to unregister external modules
> + *
> + * @module: pointer to external module
> + * return: 0 ok, <0 failed
> + */
> +int goodix_unregister_ext_module(struct goodix_ext_module *module);
> +
> +/**
> + * goodix_ts_irq_enable - Enable/Disable a irq
> +
> + * @core_data: pointer to touch core data
> + * enable: enable or disable irq
> + * return: 0 ok, <0 failed
> + */
> +int goodix_ts_irq_enable(struct goodix_ts_core *core_data, bool enable);
> +
> +struct kobj_type *goodix_get_default_ktype(void);
> +
> +/**
> + * goodix_ts_blocking_notify - notify clients of certain events
> + *	see enum ts_notify_event in goodix_ts_core.h
> + */
> +int goodix_ts_blocking_notify(enum ts_notify_event evt, void *v);
> +
> +#endif
> diff --git a/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_tools.c b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_tools.c
> new file mode 100755
> index 0000000..b0dd121
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix-ts-sunrise/goodix_ts_tools.c
> @@ -0,0 +1,542 @@
> +/*
> + * Goodix GTx5 Touchscreen Dirver
> + *
> + * Copyright (C) 2015 - 2016 Goodix, Inc.
> + * Authors:  Wang Yafei <wangyafei@goodix.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be a reference
> + * to you, when you are integrating the GOODiX's CTP IC into your system,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/compat.h>
> +#include <linux/kernel.h>
> +#include <linux/atomic.h>
> +#include <linux/miscdevice.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/fs.h>
> +#include <linux/list.h>
> +#include <linux/ioctl.h>
> +#include <linux/wait.h>
> +#include "goodix_ts_core.h"
> +
> +#define GOODIX_TOOLS_NAME		"gtp_tools"
> +#define GOODIX_TS_IOC_MAGIC		'G'
> +#define NEGLECT_SIZE_MASK		(~(_IOC_SIZEMASK << _IOC_SIZESHIFT))
> +
> +#define GTP_IRQ_ENABLE	_IO(GOODIX_TS_IOC_MAGIC, 0)
> +#define GTP_DEV_RESET	_IO(GOODIX_TS_IOC_MAGIC, 1)
> +#define GTP_SEND_COMMAND (_IOW(GOODIX_TS_IOC_MAGIC, 2, u8) & NEGLECT_SIZE_MASK)
> +#define GTP_SEND_CONFIG	(_IOW(GOODIX_TS_IOC_MAGIC, 3, u8) & NEGLECT_SIZE_MASK)
> +#define GTP_ASYNC_READ	(_IOR(GOODIX_TS_IOC_MAGIC, 4, u8) & NEGLECT_SIZE_MASK)
> +#define GTP_SYNC_READ	(_IOR(GOODIX_TS_IOC_MAGIC, 5, u8) & NEGLECT_SIZE_MASK)
> +#define GTP_ASYNC_WRITE	(_IOW(GOODIX_TS_IOC_MAGIC, 6, u8) & NEGLECT_SIZE_MASK)
> +
> +#define GOODIX_TS_IOC_MAXNR		6
> +
> +#define IRQ_FALG	(0x01 << 2)
> +
> +#define I2C_MSG_HEAD_LEN	20
> +#define MAX_DATA_LEN	4096
> +#define TS_REG_COORDS_BASE	0x824E
> +/*
> + * struct goodix_tools_data - goodix tools data message used in sync read
> + * @data: The buffer into which data is written
> + * @reg_addr: Slave device register start address to start read data
> + * @length: Number of data bytes in @data being read from slave device
> + * @filled: When buffer @data be filled will set this flag with 1, outhrwise 0
> + * @list_head:Eonnet every goodix_tools_data struct into a list
> + */
> +
> +struct goodix_tools_data {
> +	u32 reg_addr;
> +	u32 length;
> +	u8 *data;
> +	bool filled;
> +	struct list_head list;
> +};
> +
> +
> +/*
> + * struct goodix_tools_dev - goodix tools device struct
> + * @ts_core: The core data struct of ts driver
> + * @ops_mode: represent device work mode
> + * @rawdiffcmd: Set slave device into rawdata mode
> + * @normalcmd: Set slave device into normal mode
> + * @wq: Wait queue struct use in synchronous data read
> + * @mutex: Protect goodix_tools_dev
> + * @ref_count: reference count
> + * @ref_mutex: Protect ref_count
> + */
> +struct goodix_tools_dev {
> +	struct goodix_ts_core *ts_core;
> +	struct list_head head;
> +	unsigned int ops_mode;
> +	struct goodix_ts_cmd rawdiffcmd, normalcmd;
> +	wait_queue_head_t wq;
> +	struct mutex mutex;
> +	int ref_count;
> +	struct mutex ref_mutex;
> +	struct goodix_ext_module module;
> +} *goodix_tools_dev;
> +
> +static int goodix_tools_open(struct inode *inode, struct file *filp);
> +static int goodix_tools_release(struct inode *inode, struct file *filp);
> +static long goodix_tools_ioctl(struct file *filp, unsigned int cmd,
> +					unsigned long arg);
> +#ifdef CONFIG_COMPAT
> +static long goodix_tools_compat_ioctl(struct file *file, unsigned int cmd,
> +				unsigned long arg);
> +#endif
> +
> +static const struct file_operations goodix_tools_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= goodix_tools_open,
> +	.release	= goodix_tools_release,
> +	.unlocked_ioctl	= goodix_tools_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl = goodix_tools_compat_ioctl,
> +#endif
> +};
> +
> +static struct miscdevice goodix_tools_miscdev = {
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.name	= GOODIX_TOOLS_NAME,
> +	.fops	= &goodix_tools_fops,
> +};
> +/* read data from i2c asynchronous,
> + * success return bytes read, else return <= 0
> + */
> +static int async_read(struct goodix_tools_dev *dev, void __user *arg)
> +{
> +	u8 *databuf = NULL;
> +	int ret = 0;
> +	u32 reg_addr, length;
> +	u8 i2c_msg_head[I2C_MSG_HEAD_LEN];
> +	struct goodix_ts_device *ts_dev = dev->ts_core->ts_dev;
> +	const struct goodix_ts_hw_ops *hw_ops = ts_dev->hw_ops;
> +
> +	ret = copy_from_user(&i2c_msg_head, arg, I2C_MSG_HEAD_LEN);
> +	if (ret)
> +		return ret;
> +
> +	reg_addr = le32_to_cpup((__le32 *)&i2c_msg_head[0]);
> +	length = le32_to_cpup((__le32 *)&i2c_msg_head[4]);
> +	if (length > MAX_DATA_LEN)
> +		length = MAX_DATA_LEN;
> +
> +	databuf = kzalloc(length, GFP_KERNEL);
> +	if (!databuf)
> +		return -ENOMEM;
> +
> +	if (!hw_ops->read(ts_dev, reg_addr, databuf, length)) {
> +		if (copy_to_user((u8 *)arg + I2C_MSG_HEAD_LEN,
> +					databuf, length))
> +			ret = -EFAULT;
> +		else
> +			ret = length;
> +	} else {
> +		ret = -EBUSY;
> +	}
> +
> +	kfree(databuf);
> +	return ret;
> +}
> +
> +/* read data from i2c synchronous,
> + * success return bytes read, else return <= 0
> + */
> +static int sync_read(struct goodix_tools_dev *dev, void __user *arg)
> +{
> +	int ret = 0;
> +	u8 i2c_msg_head[I2C_MSG_HEAD_LEN];
> +	struct goodix_tools_data tools_data;
> +
> +	ret = copy_from_user(&i2c_msg_head, arg, I2C_MSG_HEAD_LEN);
> +	if (ret)
> +		return ret;
> +
> +	tools_data.reg_addr = le32_to_cpup((__le32 *)&i2c_msg_head[0]);
> +	tools_data.length = le32_to_cpup((__le32 *)&i2c_msg_head[4]);
> +	tools_data.filled = 0;
> +	if (tools_data.length > MAX_DATA_LEN)
> +		tools_data.length = MAX_DATA_LEN;
> +
> +	tools_data.data = kzalloc(tools_data.length, GFP_KERNEL);
> +	if (!tools_data.data)
> +		return -ENOMEM;
> +
> +	mutex_lock(&dev->mutex);
> +	list_add_tail(&tools_data.list, &dev->head);
> +	mutex_unlock(&dev->mutex);
> +	/* wait queue will timeout after 1 seconds */
> +	wait_event_interruptible_timeout(dev->wq, tools_data.filled == 1, HZ);
> +
> +	mutex_lock(&dev->mutex);
> +	list_del(&tools_data.list);
> +	mutex_unlock(&dev->mutex);
> +	if (tools_data.filled == 1) {
> +		if (copy_to_user((u8 *)arg + I2C_MSG_HEAD_LEN, tools_data.data,
> +							tools_data.length))
> +			ret = -EFAULT;
> +		else
> +			ret = tools_data.length;
> +	} else {
> +		ret = -EAGAIN;
> +		dev_dbg(goodix_tools_miscdev.this_device,
> +			"Wait queue timeout\n");
> +	}
> +
> +	kfree(tools_data.data);
> +	return ret;
> +}
> +
> +/* write data to i2c asynchronous,
> + * success return bytes write, else return <= 0
> + */
> +static int async_write(struct goodix_tools_dev *dev, void __user *arg)
> +{
> +	u8 *databuf;
> +	int ret = 0;
> +	u32 reg_addr, length;
> +	u8 i2c_msg_head[I2C_MSG_HEAD_LEN];
> +	struct goodix_ts_device *ts_dev = dev->ts_core->ts_dev;
> +	const struct goodix_ts_hw_ops *hw_ops = ts_dev->hw_ops;
> +
> +	ret = copy_from_user(&i2c_msg_head, arg, I2C_MSG_HEAD_LEN);
> +	if (ret)
> +		return -EFAULT;
> +
> +	reg_addr = le32_to_cpup((__le32 *)&i2c_msg_head[0]);
> +	length = le32_to_cpup((__le32 *)&i2c_msg_head[4]);
> +	if (length > MAX_DATA_LEN)
> +		length = MAX_DATA_LEN;
> +
> +	databuf = kzalloc(length, GFP_KERNEL);
> +	if (!databuf)
> +		return -ENOMEM;
> +
> +	ret = copy_from_user(databuf, (u8 *)arg + I2C_MSG_HEAD_LEN, length);
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto err_out;
> +	}
> +
> +	if (hw_ops->write(ts_dev, reg_addr, databuf, length))
> +		ret = -EBUSY;
> +	else
> +		ret = length;
> +
> +err_out:
> +	kfree(databuf);
> +	return ret;
> +}
> +
> +static int init_cfg_data(struct goodix_ts_config *cfg, void __user *arg)
> +{
> +	int ret = 0;
> +	u32 reg_addr, length;
> +	u8 i2c_msg_head[I2C_MSG_HEAD_LEN];
> +
> +	cfg->initialized = 0;
> +	mutex_init(&cfg->lock);
> +	ret = copy_from_user(&i2c_msg_head, arg, I2C_MSG_HEAD_LEN);
> +	if (ret)
> +		return -EFAULT;
> +
> +	reg_addr = le32_to_cpup((__le32 *)&i2c_msg_head[0]);
> +	length = le32_to_cpup((__le32 *)&i2c_msg_head[4]);
> +	if (length > MAX_DATA_LEN)
> +		length = MAX_DATA_LEN;
> +
> +	ret = copy_from_user(cfg->data, (u8 *)arg + I2C_MSG_HEAD_LEN, length);
> +	if (ret) {
> +		ret = -EFAULT;
> +		dev_dbg(goodix_tools_miscdev.this_device,
> +			"Copy data from user failed\n");
> +		goto err_out;
> +	}
> +	cfg->reg_base = reg_addr;
> +	cfg->length = length;
> +	strlcpy(cfg->name, "tools-send-cfg", sizeof(cfg->name));
> +	cfg->delay = 50;
> +	cfg->initialized = true;
> +	return 0;
> +
> +err_out:
> +	return ret;
> +}
> +/**
> + * goodix_tools_ioctl - ioctl implementation
> + *
> + * @filp: Pointer to file opened
> + * @cmd: Ioctl opertion command
> + * @arg: Command data
> + * Returns >=0 - succeed, else failed
> + */
> +static long goodix_tools_ioctl(struct file *filp, unsigned int cmd,
> +					unsigned long arg)
> +{
> +	int ret = 0;
> +	struct goodix_tools_dev *dev = filp->private_data;
> +	struct goodix_ts_device *ts_dev;
> +	const struct goodix_ts_hw_ops *hw_ops;
> +	struct goodix_ts_cmd temp_cmd;
> +	struct goodix_ts_config *temp_cfg;
> +
> +	if (dev->ts_core == NULL) {
> +		dev_err(goodix_tools_miscdev.this_device,
> +			"Tools module not register\n");
> +		return -EINVAL;
> +	}
> +	ts_dev = dev->ts_core->ts_dev;
> +	hw_ops = ts_dev->hw_ops;
> +
> +	if (_IOC_TYPE(cmd) != GOODIX_TS_IOC_MAGIC)
> +		return -ENOTTY;
> +	if (_IOC_NR(cmd) > GOODIX_TS_IOC_MAXNR)
> +		return -ENOTTY;
> +
> +
> +	switch (cmd & NEGLECT_SIZE_MASK) {
> +	case GTP_IRQ_ENABLE:
> +		if (arg == 1) {
> +			goodix_ts_irq_enable(dev->ts_core, true);
> +			mutex_lock(&dev->mutex);
> +			dev->ops_mode |= IRQ_FALG;
> +			mutex_unlock(&dev->mutex);
> +			dev_dbg(goodix_tools_miscdev.this_device,
> +				"IRQ enabled\n");
> +		} else if (arg == 0) {
> +			goodix_ts_irq_enable(dev->ts_core, false);
> +			mutex_lock(&dev->mutex);
> +			dev->ops_mode &= ~IRQ_FALG;
> +			mutex_unlock(&dev->mutex);
> +			dev_dbg(goodix_tools_miscdev.this_device,
> +				"IRQ disabled\n");
> +		} else {
> +			dev_dbg(goodix_tools_miscdev.this_device,
> +				"Irq already set with, arg = %ld\n", arg);
> +		}
> +		ret = 0;
> +		break;
> +	case GTP_DEV_RESET:
> +		hw_ops->reset(ts_dev);
> +		break;
> +	case GTP_SEND_COMMAND:
> +		ret = copy_from_user(&temp_cmd, (void __user *)arg,
> +					sizeof(struct goodix_ts_cmd));
> +		if (ret) {
> +			ret = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		ret = hw_ops->send_cmd(ts_dev, &temp_cmd);
> +		if (ret) {
> +			dev_warn(goodix_tools_miscdev.this_device,
> +				"Send command failed\n");
> +			ret = -EAGAIN;
> +		}
> +	break;
> +	case GTP_SEND_CONFIG:
> +		temp_cfg = kzalloc(sizeof(struct goodix_ts_config), GFP_KERNEL);
> +		if (!temp_cfg) {
> +			ret = -ENOMEM;
> +			goto err_out;
> +		}
> +		ret = init_cfg_data(temp_cfg, (void __user *)arg);
> +
> +		if (!ret) {
> +			ret = hw_ops->send_config(ts_dev, temp_cfg);
> +			if (ret) {
> +				dev_warn(goodix_tools_miscdev.this_device,
> +					"Failed send config\n");
> +				ret = -EAGAIN;
> +			}
> +		}
> +		kfree(temp_cfg);
> +	break;
> +	case GTP_ASYNC_READ:
> +		ret = async_read(dev, (void __user *)arg);
> +		if (ret < 0)
> +			dev_warn(goodix_tools_miscdev.this_device,
> +				"Async data read failed");
> +	break;
> +	case GTP_SYNC_READ:
> +		if (filp->f_flags & O_NONBLOCK) {
> +			dev_dbg(goodix_tools_miscdev.this_device,
> +				"Goodix tools now worked in sync_bus mode\n");
> +			ret = -EAGAIN;
> +			goto err_out;
> +		}
> +		ret = sync_read(dev, (void __user *)arg);
> +		if (ret < 0)
> +			dev_warn(goodix_tools_miscdev.this_device,
> +				"Sync data read failed\n");
> +	break;
> +	case GTP_ASYNC_WRITE:
> +		ret = async_write(dev, (void __user *)arg);
> +		if (ret < 0)
> +			dev_warn(goodix_tools_miscdev.this_device,
> +				"Async data write failed\n");
> +	break;
> +	default:
> +		dev_info(goodix_tools_miscdev.this_device, "Invalid cmd\n");
> +		ret = -ENOTTY;
> +		break;
> +	}
> +
> +err_out:
> +	return ret;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static long goodix_tools_compat_ioctl(struct file *file, unsigned int cmd,
> +				unsigned long arg)
> +{
> +	if (!file->f_op || !file->f_op->unlocked_ioctl)
> +		return -ENOTTY;
> +
> +	return goodix_tools_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> +}
> +#endif
> +
> +static int goodix_tools_open(struct inode *inode, struct file *filp)
> +{
> +	int ret = 0;
> +
> +	filp->private_data = goodix_tools_dev;
> +
> +	mutex_lock(&goodix_tools_dev->ref_mutex);
> +
> +	/* Only the first time open device need to register module */
> +	if (goodix_tools_dev->ref_count == 0)
> +		ret = goodix_register_ext_module(&goodix_tools_dev->module);
> +	if (!ret)
> +		goodix_tools_dev->ref_count++;
> +
> +	mutex_unlock(&goodix_tools_dev->ref_mutex);
> +	return ret;
> +}
> +
> +static int goodix_tools_release(struct inode *inode, struct file *filp)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&goodix_tools_dev->ref_mutex);
> +
> +	goodix_tools_dev->ref_count--;
> +	/* when the last close this dev node unregister the module */
> +	if (goodix_tools_dev->ref_count == 0)
> +		ret = goodix_unregister_ext_module(&goodix_tools_dev->module);
> +
> +	mutex_unlock(&goodix_tools_dev->ref_mutex);
> +	return ret;
> +}
> +
> +/**
> + * goodix_tools_module_irq - goodix tools Irq handle
> + * This functions is excuted when interrupt happened
> + *
> + * @core_data: pointer to touch core data
> + * @module: pointer to goodix_ext_module struct
> + * return: EVT_CONTINUE let other module handle this irq
> + */
> +static int goodix_tools_module_irq(struct goodix_ts_core *core_data,
> +	struct goodix_ext_module *module)
> +{
> +	struct goodix_tools_dev *dev = module->priv_data;
> +	struct goodix_ts_device *ts_dev = dev->ts_core->ts_dev;
> +	const struct goodix_ts_hw_ops *hw_ops = ts_dev->hw_ops;
> +	struct goodix_tools_data *tools_data;
> +	int r = 0;
> +	u8 evt_sta = 0;
> +
> +	if (!list_empty(&dev->head)) {
> +		r = hw_ops->read(ts_dev, TS_REG_COORDS_BASE, &evt_sta, 1);
> +		if (r < 0 || ((evt_sta & 0x80) == 0))
> +			return EVT_CONTINUE;
> +
> +		mutex_lock(&dev->mutex);
> +		list_for_each_entry(tools_data, &dev->head, list) {
> +			if (!hw_ops->read(ts_dev, tools_data->reg_addr,
> +					tools_data->data, tools_data->length)) {
> +				tools_data->filled = 1;
> +			}
> +		}
> +		mutex_unlock(&dev->mutex);
> +		wake_up(&dev->wq);
> +	}
> +	return EVT_CONTINUE;
> +}
> +
> +static int goodix_tools_module_init(struct goodix_ts_core *core_data,
> +			struct goodix_ext_module *module)
> +{
> +	struct goodix_tools_dev *dev = module->priv_data;
> +
> +	if (core_data) {
> +		dev->ts_core = core_data;
> +		return 0;
> +	} else {
> +		return -ENODEV;
> +	}
> +}
> +
> +static struct goodix_ext_module_funcs goodix_tools_module_funcs = {
> +	.irq_event = goodix_tools_module_irq,
> +	.init = goodix_tools_module_init,
> +};
> +
> +/**
> + * goodix_tools_init - init goodix tools device and register a miscdevice
> + *
> + * return: 0 success, else failed
> + */
> +static int __init goodix_tools_init(void)
> +{
> +	int ret;
> +
> +	goodix_tools_dev = kzalloc(sizeof(struct goodix_tools_dev), GFP_KERNEL);
> +	if (!goodix_tools_dev)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&goodix_tools_dev->head);
> +	goodix_tools_dev->ops_mode = 0;
> +	goodix_tools_dev->ops_mode |= IRQ_FALG;
> +	init_waitqueue_head(&goodix_tools_dev->wq);
> +	mutex_init(&goodix_tools_dev->mutex);
> +	goodix_tools_dev->ref_count = 0;
> +	mutex_init(&goodix_tools_dev->ref_mutex);
> +
> +	goodix_tools_dev->module.funcs = &goodix_tools_module_funcs;
> +	goodix_tools_dev->module.name = GOODIX_TOOLS_NAME;
> +	goodix_tools_dev->module.priv_data = goodix_tools_dev;
> +	goodix_tools_dev->module.priority = EXTMOD_PRIO_DBGTOOL;
> +
> +	ret = misc_register(&goodix_tools_miscdev);
> +
> +	return ret;
> +}
> +
> +static void __exit goodix_tools_exit(void)
> +{
> +	misc_deregister(&goodix_tools_miscdev);
> +	kfree(goodix_tools_dev);
> +}
> +
> +module_init(goodix_tools_init);
> +module_exit(goodix_tools_exit);
> +
> +MODULE_DESCRIPTION("Goodix tools Module");
> +MODULE_AUTHOR("Goodix, Inc.");
> +MODULE_LICENSE("GPL v2");
