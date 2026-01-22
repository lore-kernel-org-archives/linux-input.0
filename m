Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E9392807
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119769; cv=none; b=GTcmTp0vsFqXry08z3Q4higdoUPdb6ijCpDBHfKSbQbGYguT1LoQTlxFbDDcG5jE8nV8zbhuEN0d/lZz2FElCwrrs7yjcA0DeoLjQ2IqDYbBVt6bIPx4JnA9/vL/G8C/ezfIHjeiobQhgWi5MEatMmA1gWH0WLvFxYXPK98y5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119769; c=relaxed/simple;
	bh=H8L7d1CvtHn12/L1yuSkn5AZixwuhC7Sc8teYBJbQBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZqi5R0F1oFjWxMH4OizrStP1m5iL+2UQl3Oy5SNwK88uobCXBoYSKuBFeDVufKMToiVk6+QRNUxQ8zv/KMdJ9GzzZHm2tzlOkZ9n0r3Dv1WXSPuOphhoArAUeBrsTLhRJIL9o0zQbcpH8FLmtHHv2y8pa8Tm5q2MqvQU0mp77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vj2rf-0002CL-HZ; Thu, 22 Jan 2026 23:09:19 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vj2rf-001zYK-29;
	Thu, 22 Jan 2026 23:09:19 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vj2re-009A5r-2t;
	Thu, 22 Jan 2026 23:09:18 +0100
Date: Thu, 22 Jan 2026 23:09:18 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: AThomas63 <andrew.thomas@touchnetix.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.satterthwaite@touchnetix.com,
	kamel.bouhara@bootlin.com, kernel@pengutronix.de
Subject: Re: [PATCH 1/1] Adding support for aXiom touchscreen controller
Message-ID: <20260122220918.uuy7rlvtcrsmfqmd@pengutronix.de>
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
 <20260122124819.273188-2-andrew.thomas@touchnetix.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122124819.273188-2-andrew.thomas@touchnetix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

The git-subject seems wrong, this should be:

"Input: Add support for ...."

also you miss a proper commit description.

On 26-01-22, AThomas63 wrote:
> Signed-off-by: AThomas63 <andrew.thomas@touchnetix.com>
> ---
>  drivers/input/touchscreen/Kconfig      |  30 ++
>  drivers/input/touchscreen/Makefile     |   3 +
>  drivers/input/touchscreen/axiom_core.c | 482 +++++++++++++++++++++++++
>  drivers/input/touchscreen/axiom_core.h | 128 +++++++
>  drivers/input/touchscreen/axiom_i2c.c  | 152 ++++++++
>  drivers/input/touchscreen/axiom_spi.c  | 159 ++++++++
>  6 files changed, 954 insertions(+)
>  create mode 100644 drivers/input/touchscreen/axiom_core.c
>  create mode 100644 drivers/input/touchscreen/axiom_core.h
>  create mode 100644 drivers/input/touchscreen/axiom_i2c.c
>  create mode 100644 drivers/input/touchscreen/axiom_spi.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 7d5b72ee07fa..f2b4fb317bdd 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -162,6 +162,36 @@ config TOUCHSCREEN_AUO_PIXCIR
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called auo-pixcir-ts.
>  
> +config TOUCHSCREEN_AXIOM_CORE
> +	tristate "TouchNetix Axiom touchscreen"

Nack, the spi or i2c should select the core.

> +	help
> +	  Say Y here if you have an Axiom touchscreen connected
> +	  to your system. You will also need to select appropriate
> +	  bus connection below.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called axiom_core.
> +
> +config TOUCHSCREEN_AXIOM_I2C
> +	tristate "support I2C bus connection"
> +	depends on TOUCHSCREEN_AXIOM_CORE && I2C
> +	help
> +	  Say Y here if the touchscreen is connected via I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called axiom_spi.
> +
> +config TOUCHSCREEN_AXIOM_SPI
> +	tristate "support SPI bus connection"
> +	depends on TOUCHSCREEN_AXIOM_CORE && SPI
> +	help
> +	  Say Y here if the touchscreen is connected via SPI bus.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called axiom_spi.
> +
>  config TOUCHSCREEN_BU21013
>  	tristate "BU21013 based touch panel controllers"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index ab9abd151078..9b7d572c4589 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -19,6 +19,9 @@ obj-$(CONFIG_TOUCHSCREEN_APPLE_Z2)	+= apple_z2.o
>  obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
>  obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_AXIOM_CORE)	+= axiom_core.o
> +obj-$(CONFIG_TOUCHSCREEN_AXIOM_I2C)	+= axiom_i2c.o
> +obj-$(CONFIG_TOUCHSCREEN_AXIOM_SPI)	+= axiom_spi.o
>  obj-$(CONFIG_TOUCHSCREEN_BU21013)	+= bu21013_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_BU21029)	+= bu21029_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_CHIPONE_ICN8318)	+= chipone_icn8318.o
> diff --git a/drivers/input/touchscreen/axiom_core.c b/drivers/input/touchscreen/axiom_core.c
> new file mode 100644
> index 000000000000..7983effe40f7
> --- /dev/null
> +++ b/drivers/input/touchscreen/axiom_core.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TouchNetix aXiom Touchscreen Driver
> + *
> + * Copyright (C) 2020-2026 TouchNetix Ltd.
> + *
> + * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
> + *            Pedro Torruella <pedro.torruella@touchnetix.com>
> + *            Bart Prescott <bartp@baasheep.co.uk>
> + *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
> + *            Andrew Thomas <andrew.thomas@touchnetix.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +// #define DEBUG // Enable debug messages

remove this

> +
> +#include <linux/device.h>
> +#include <linux/input/mt.h>
> +#include <linux/crc16.h>
> +#include <linux/property.h>
> +#include <linux/interrupt.h>
> +#include <linux/unaligned.h>
> +#include "axiom_core.h"
> +
> +/* u31 device info masks */
> +#define AX_DEV_ID_MASK GENMASK(14, 0)
> +#define AX_MODE BIT(15)
> +#define AX_FW_REV_MINOR_MASK GENMASK(7, 0)
> +#define AX_FW_REV_MAJOR_MASK GENMASK(15, 8)
> +#define AX_VARIANT_MASK GENMASK(5, 0)
> +#define AX_FW_STATUS BIT(7)
> +#define AX_TCP_REV_MASK GENMASK(15, 8)
> +#define AX_BOOT_REV_MINOR_MASK GENMASK(7, 0)
> +#define AX_BOOT_REV_MAJOR_MASK GENMASK(15, 8)
> +#define AX_NUM_USAGES_MASK GENMASK(7, 0)
> +#define AX_SILICON_REV_MASK GENMASK(11, 8)
> +#define AX_RUNTIME_FW_PATCH_MASK GENMASK(15, 12)
> +
> +/* u31 usage table entry masks */
> +#define AX_U31_USAGE_NUM_MASK GENMASK(7, 0)
> +#define AX_U31_START_PAGE_MASK GENMASK(15, 8)
> +#define AX_U31_NUM_PAGES_MASK GENMASK(7, 0)
> +#define AX_U31_MAX_OFFSET_MASK GENMASK(14, 8)
> +#define AX_U31_OFFSET_TYPE_BIT BIT(15)
> +#define AX_U31_UIF_REV_MASK GENMASK(7, 0)
> +#define AX_U31_USAGE_TYPE_MASK GENMASK(15, 8)
> +
> +/* u34 report masks */
> +#define AX_U34_LEN_MASK GENMASK(6, 0)
> +#define AX_U34_OVERFLOW BIT(7)
> +#define AX_U34_USAGE_MASK GENMASK(15, 8)
> +#define AX_U34_PAYLOAD_BUFFER 2
> +
> +/* u41 report masks */
> +#define AX_U41_PRESENT_MASK GENMASK(9, 0)
> +#define U41_X_Y_OFFSET (2)
> +#define U41_COORD_SIZE (4)
> +#define U41_Z_OFFSET (42)

Align your defines.

> +
> +static const char *const fw_variants[] = { "3D", "2D", "FORCE",
> +					   "0D", "XL", "TOUCHPAD" };

Check your code against the kernel coding style, this applies to many
code parts, I won't list them all.

> +
> +static int axiom_set_capabilities(struct input_dev *input_dev)
> +{
> +	input_dev->name = "TouchNetix aXiom Touchscreen";
> +	input_dev->phys = "input/axiom_ts";
> +
> +	// Single Touch

Coding style.

> +	input_set_abs_params(input_dev, ABS_X, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, 65535, 0, 0);
> +
> +	// Multi Touch
> +	// Min, Max, Fuzz (expected noise in px, try 4?) and Flat
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> +	// Min, Max, Fuzz (expected noise in px, try 4?) and Flat
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);

Max values are coming from the firmware.

> +
> +	input_mt_init_slots(input_dev, U41_MAX_TARGETS, INPUT_MT_DIRECT);

num-targets can be configured via firmware config IIRC, so nack.

> +
> +	return 0;
> +}
> +
> +static struct u31_usage_entry *usage_find_entry(struct axiom *ax, u16 usage)
> +{
> +	u16 i;
> +
> +	for (i = 0; i < ax->dev_info.num_usages; i++) {
> +		if (ax->usage_table[i].usage_num == usage)
> +			return &ax->usage_table[i];
> +	}
> +
> +	pr_err("aXiom-core: Usage u%02x not found in usage table\n", usage);
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static void axiom_unpack_device_info(const u8 *buf,
> +				     struct axiom_device_info *info)
> +{
> +	u16 w;
> +
> +	w = get_unaligned_le16(buf);
> +	info->device_id = FIELD_GET(AX_DEV_ID_MASK, w);
> +	info->mode = !!(w & AX_MODE);
> +
> +	w = get_unaligned_le16(buf + 2);
> +	info->runtime_fw_rev_minor = FIELD_GET(AX_FW_REV_MINOR_MASK, w);
> +	info->runtime_fw_rev_major = FIELD_GET(AX_FW_REV_MAJOR_MASK, w);
> +
> +	w = get_unaligned_le16(buf + 4);
> +	info->device_build_variant = FIELD_GET(AX_VARIANT_MASK, w);
> +	info->runtime_fw_status = !!(w & AX_FW_STATUS);
> +	info->tcp_revision = FIELD_GET(AX_TCP_REV_MASK, w);
> +
> +	w = get_unaligned_le16(buf + 6);
> +	info->bootloader_fw_rev_minor = FIELD_GET(AX_BOOT_REV_MINOR_MASK, w);
> +	info->bootloader_fw_rev_major = FIELD_GET(AX_BOOT_REV_MAJOR_MASK, w);
> +
> +	info->jedec_id = get_unaligned_le16(buf + 8);
> +
> +	w = get_unaligned_le16(buf + 10);
> +	info->num_usages = FIELD_GET(AX_NUM_USAGES_MASK, w);
> +	info->silicon_revision = FIELD_GET(AX_SILICON_REV_MASK, w);
> +	info->runtime_fw_rev_patch = FIELD_GET(AX_RUNTIME_FW_PATCH_MASK, w);
> +}
> +
> +static void axiom_unpack_usage_table(u8 *buf, struct axiom *ax)
> +{
> +	u8 *ptr;
> +	struct u31_usage_entry *entry;
> +	int i;
> +	u16 w;
> +	u16 report_len;
> +
> +	for (i = 0; i < ax->dev_info.num_usages && i < U31_MAX_USAGES; i++) {
> +		entry = &ax->usage_table[i];
> +		/* Calculate offset for this specific entry */
> +		ptr = buf + (i * SIZE_U31_USAGE_ENTRY);
> +
> +		w = get_unaligned_le16(ptr);
> +		entry->usage_num = FIELD_GET(AX_U31_USAGE_NUM_MASK, w);
> +		entry->start_page = FIELD_GET(AX_U31_START_PAGE_MASK, w);
> +
> +		w = get_unaligned_le16(ptr + 2);
> +		entry->num_pages = FIELD_GET(AX_U31_NUM_PAGES_MASK, w);
> +		entry->max_offset = FIELD_GET(AX_U31_MAX_OFFSET_MASK, w);
> +		entry->offset_type = !!(w & AX_U31_OFFSET_TYPE_BIT);
> +
> +		w = get_unaligned_le16(ptr + 4);
> +		entry->uifrevision = FIELD_GET(AX_U31_UIF_REV_MASK, w);
> +		entry->usage_type = FIELD_GET(AX_U31_USAGE_TYPE_MASK, w);
> +
> +		// Convert words to bytes
> +		report_len = (entry->max_offset + 1) * 2;
> +		if ((entry->usage_type == REPORT) &&
> +		    (report_len > ax->max_report_len)) {
> +			ax->max_report_len = report_len;
> +		}
> +	}
> +}
> +
> +static int axiom_init_dev_info(struct axiom *ax)
> +{
> +	int i;
> +	struct u31_usage_entry *u;
> +	int err;
> +	const char *variant_str;
> +
> +	/* Read page 0 of u31 */
> +	err = ax->bus_ops->read(ax->dev, 0x0, SIZE_U31_DEVICE_INFO,
> +				ax->read_buf);

No need for custom accessors, use regmap API.

> +	if (err)
> +		return -EIO;
> +
> +	axiom_unpack_device_info(ax->read_buf, &ax->dev_info);
> +
> +	if (ax->dev_info.device_build_variant < ARRAY_SIZE(fw_variants)) {
> +		variant_str = fw_variants[ax->dev_info.device_build_variant];
> +	} else {
> +		variant_str = "UNKNOWN";
> +	}
> +	char silicon_rev = (char)(0x41 + ax->dev_info.silicon_revision);
> +
> +	dev_info(ax->dev, "Firmware Info:\n");
> +	dev_info(ax->dev, "  BL Mode     : %u\n", ax->dev_info.mode);
> +	dev_info(ax->dev, "  Device ID   : %04x\n", ax->dev_info.device_id);
> +	dev_info(ax->dev, "  FW Revision : %u.%u.%u-%s %s\n",
> +		 ax->dev_info.runtime_fw_rev_major,
> +		 ax->dev_info.runtime_fw_rev_minor,
> +		 ax->dev_info.runtime_fw_rev_patch,
> +		 (ax->dev_info.runtime_fw_status == 0) ? "eng" : "prod",
> +		 variant_str);
> +	dev_info(ax->dev, "  BL Revision : %02x.%02x\n",
> +		 ax->dev_info.bootloader_fw_rev_major,
> +		 ax->dev_info.bootloader_fw_rev_minor);
> +	dev_info(ax->dev, "  Silicon     : 0x%04X (Rev %c)\n",
> +		 ax->dev_info.jedec_id, silicon_rev);
> +	dev_info(ax->dev, "  Num Usages  : %u\n", ax->dev_info.num_usages);

Why always dev_info()?

> +
> +	if (ax->dev_info.num_usages > U31_MAX_USAGES) {
> +		dev_err(ax->dev,
> +			"Num usages (%u) exceeds maximum supported (%u)\n",
> +			ax->dev_info.num_usages, U31_MAX_USAGES);
> +		return -EINVAL;
> +	}
> +
> +	/* Read the second page of u31 to get the usage table */
> +	err = ax->bus_ops->read(ax->dev, 0x100,
> +				sizeof(ax->usage_table[0]) *
> +					ax->dev_info.num_usages,
> +				ax->read_buf);

You don't check if the device is bootloader-mode so this may fail
depending on the device state.

> +	if (err)
> +		return -EIO;
> +
> +	axiom_unpack_usage_table(ax->read_buf, ax);
> +
> +	dev_info(ax->dev, "Usage Table:\n");
> +	for (i = 0; i < ax->dev_info.num_usages; i++) {
> +		u = &ax->usage_table[i];
> +
> +		dev_info(
> +			ax->dev,
> +			"  Usage: u%02x  Rev: %3u  Page: 0x%02x00  Num Pages: %3u\n",
> +			u->usage_num, u->uifrevision, u->start_page,
> +			u->num_pages);
> +	}
> +	dev_info(ax->dev, "Max Report Length: %u\n", ax->max_report_len);
> +
> +	if (ax->max_report_len > AXIOM_MAX_READ_SIZE) {
> +		dev_err(ax->dev,
> +			"aXiom maximum report length (%u) greater than allocated buffer size (%u).",
> +			ax->max_report_len, AXIOM_MAX_READ_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	/* Set u34 address to allow direct access to report reading address */
> +	u = usage_find_entry(ax, 0x34);
> +	if (IS_ERR(u))
> +		return PTR_ERR(u);
> +	ax->u34_address = u->start_page << 8;
> +
> +	return 0;
> +}
> +
> +static int axiom_process_u41_report(struct axiom *ax, u8 *report)
> +{
> +	int i;
> +	u16 target_present;
> +	bool active;
> +	u8 offset;
> +	enum u41_target_state_e state;
> +	u16 x;
> +	u16 y;
> +	s8 z;
> +
> +	target_present =
> +		FIELD_GET(AX_U41_PRESENT_MASK, get_unaligned_le16(&report[0]));
> +
> +	for (i = 0; i < U41_MAX_TARGETS; i++) {
> +		active = !!((target_present >> i) & 1);
> +
> +		offset = U41_X_Y_OFFSET + (i * U41_COORD_SIZE);
> +		x = get_unaligned_le16(&report[offset]);
> +		y = get_unaligned_le16(&report[offset + 2]);
> +		z = report[U41_Z_OFFSET + i];
> +
> +		if (!active)
> +			state = Target_State_Not_Present;
> +		else if (z >= 0)
> +			state = Target_State_Touching;
> +		else if ((z > U41_PROX_LEVEL) && (z < 0))
> +			state = Target_State_Hover;
> +		else if (z == U41_PROX_LEVEL)
> +			state = Target_State_Prox;
> +		else
> +			state = Target_State_Not_Present;
> +
> +		dev_dbg(ax->dev, "Target %d: x=%u y=%u z=%d present=%d\n", i, x,
> +			y, z, active);
> +
> +		switch (state) {
> +		case Target_State_Not_Present:
> +		case Target_State_Prox:
> +
> +			input_mt_slot(ax->input, i);
> +			input_mt_report_slot_inactive(ax->input);
> +			break;
> +
> +		case Target_State_Hover:
> +		case Target_State_Touching:
> +
> +			input_mt_slot(ax->input, i);
> +			input_report_abs(ax->input, ABS_MT_TRACKING_ID, i);
> +			input_report_abs(ax->input, ABS_MT_POSITION_X, x);
> +			input_report_abs(ax->input, ABS_MT_POSITION_Y, y);
> +
> +			if (state == Target_State_Touching) {
> +				input_report_abs(ax->input, ABS_MT_DISTANCE, 0);
> +				input_report_abs(ax->input, ABS_MT_PRESSURE, z);
> +			} else { /* Hover */
> +				input_report_abs(ax->input, ABS_MT_DISTANCE, -z);
> +				input_report_abs(ax->input, ABS_MT_PRESSURE, 0);
> +			}
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}
> +
> +	input_mt_sync_frame(ax->input);
> +	input_sync(ax->input);
> +
> +	return 0;
> +}
> +
> +static int axiom_process_report(struct axiom *ax, u8 *report)
> +{
> +	int err;
> +	struct u34_report_header hdr;
> +	u16 crc_calc;
> +	u16 crc_report;
> +	u8 len;
> +	u16 hdr_buf = get_unaligned_le16(&report[0]);
> +
> +	dev_dbg(ax->dev, "Payload Data %*ph\n", ax->max_report_len, report);
> +
> +	hdr.report_length = FIELD_GET(AX_U34_LEN_MASK, hdr_buf);
> +	hdr.overflow = !!(hdr_buf & AX_U34_OVERFLOW);
> +	hdr.report_usage = FIELD_GET(AX_U34_USAGE_MASK, hdr_buf);
> +
> +	len = hdr.report_length << 1;
> +	if (hdr.report_length == 0) {
> +		dev_err(ax->dev, "Zero length report discarded.\n");
> +		return -EIO;
> +	}
> +
> +	// Length is 16 bit words and remove the size of the CRC16 itself
> +	crc_report = (report[len - 1] << 8) | (report[len - 2]);
> +	crc_calc = crc16(0, report, (len - 2));
> +
> +	if (crc_calc != crc_report) {
> +		dev_err(ax->dev,
> +			"CRC mismatch! Expected: %04X, Calculated CRC: %04X. Report discarded.\n",
> +			crc_report, crc_calc);
> +		return -EIO;
> +	}
> +
> +	switch (hdr.report_usage) {
> +	case AX_2DCTS_REPORT_ID:
> +		err = axiom_process_u41_report(ax,
> +					       &report[AX_U34_PAYLOAD_BUFFER]);

May I ask why you guys write in your programming manual, that the host
needs to check the usage-revision and you completely ignore this?

> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static void axiom_poll(struct input_dev *input_dev)
> +{
> +	struct axiom *ax = input_get_drvdata(input_dev);
> +	int err;
> +
> +	/* Read touch reports from u34 */
> +	err = ax->bus_ops->read(ax->dev, ax->u34_address, ax->max_report_len,
> +				ax->read_buf);
> +	if (err)
> +		return;
> +
> +	err = axiom_process_report(ax, ax->read_buf);
> +	if (err)
> +		dev_err(ax->dev, "Failed to process report: %d\n", err);
> +}
> +
> +static irqreturn_t axiom_irq(int irq, void *handle)
> +{
> +	struct axiom *ax = handle;
> +	int err;
> +
> +	/* Read touch reports from u34 */
> +	err = ax->bus_ops->read(ax->dev, ax->u34_address, ax->max_report_len,
> +				ax->read_buf);
> +	if (err)
> +		goto out;
> +
> +	err = axiom_process_report(ax, ax->read_buf);
> +	if (err)
> +		dev_err(ax->dev, "Failed to process report: %d\n", err);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +struct axiom *axiom_probe(const struct axiom_bus_ops *bus_ops,
> +			  struct device *dev, int irq)
> +{
> +	struct axiom *ax;
> +	struct input_dev *input_dev;
> +	int err;
> +	bool poll_enable = false;
> +	u8 poll_period = 0;

Reverse christmas tree, coding style.

> +
> +	ax = devm_kzalloc(dev, sizeof(*ax), GFP_KERNEL);
> +	if (!ax)
> +		return ERR_PTR(-ENOMEM);
> +
> +	input_dev = devm_input_allocate_device(dev);
> +	if (!input_dev) {
> +		pr_err("ERROR: aXiom-core: Failed to allocate memory for input device!\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	poll_enable = device_property_read_bool(dev, "axiom,poll-enable");

There is common dt-property for poll.

> +
> +	device_property_read_u8(dev, "axiom,poll-period", &poll_period);
> +	if (!poll_period)
> +		poll_period = AX_POLLING_PERIOD_MS;
> +
> +	ax->dev = dev;
> +	ax->input = input_dev;
> +	ax->bus_ops = bus_ops;
> +	ax->irq = irq;

You allocate absolute no ext. resources like regulators or reset-gpios.

> +
> +	dev_info(dev, "aXiom Probe\n");
> +	if (poll_enable)
> +		dev_info(dev, "Polling Period : %u\n", poll_period);
> +	else
> +		dev_info(dev, "Device IRQ : %u\n", ax->irq);

Useless dev_info()'s

> +
> +	axiom_set_capabilities(input_dev);

Capabilities should be set after you know which firmware you're running
on, e.g. if the firmware supports 3D touchevents.

I will stop now. As said, I'm very surprised why you guys went this way
instead of just adding the SPI support to my patchset?

Your driver is missing the basics like checking the usage-revision which
is clearly written within your programming-guide. Also this driver is
missing the fw-update and cfg-update mechanism as well as basic resource
handling like ext. power-supplies.

I'd really appreciate if you guys could provide feedback to the driver
I've send so we can fix some "Downstream" comments :)

Regards,
  Marco

> +
> +	err = axiom_init_dev_info(ax);
> +	if (err) {
> +		dev_err(ax->dev, "Failed to read device info, err: %d\n", err);
> +		return ERR_PTR(err);
> +	}
> +
> +	if (poll_enable) {
> +		err = input_setup_polling(input_dev, axiom_poll);
> +		if (err) {
> +			dev_err(ax->dev, "could not set up polling mode, %d\n",
> +				err);
> +			return ERR_PTR(err);
> +		}
> +
> +		input_set_poll_interval(input_dev, poll_period);
> +	} else {
> +		err = devm_request_threaded_irq(ax->dev, ax->irq, NULL,
> +						axiom_irq,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						"axiom_irq", ax);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	err = input_register_device(input_dev);
> +	if (err) {
> +		dev_err(ax->dev, "Failed to register input device: %d\n", err);
> +		return ERR_PTR(err);
> +	}
> +
> +	input_set_drvdata(input_dev, ax);
> +
> +	return ax;
> +}
> +EXPORT_SYMBOL_GPL(axiom_probe);
> +
> +MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
> +MODULE_DESCRIPTION("aXiom touchscreen core logic");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("axiom");
> +MODULE_VERSION("1.0.0");
> diff --git a/drivers/input/touchscreen/axiom_core.h b/drivers/input/touchscreen/axiom_core.h
> new file mode 100644
> index 000000000000..ca77f9038cb1
> --- /dev/null
> +++ b/drivers/input/touchscreen/axiom_core.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * TouchNetix aXiom Touchscreen Driver
> + *
> + * Copyright (C) 2020-2026 TouchNetix Ltd.
> + *
> + * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
> + *            Pedro Torruella <pedro.torruella@touchnetix.com>
> + *            Bart Prescott <bartp@baasheep.co.uk>
> + *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
> + *            Andrew Thomas <andrew.thomas@touchnetix.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifndef __AXIOM_CORE_H
> +#define __AXIOM_CORE_H
> +
> +#include <linux/input.h>
> +
> +#define AX_POLLING_PERIOD_MS (10)
> +
> +#define AXIOM_USE_TOUCHSCREEN_INTERFACE // registers the axiom device as a touch screen instead of as a mouse pointer
> +#define U46_ENABLE_RAW_FORCE_DATA // enables the raw data for up to 4 force channels to be sent to the input subsystem
> +
> +#define AXIOM_PAGE_SIZE (256)
> +// u31 has 2 pages for usage table entries. (2 * PAGE_SIZE) / U31_BYTES_PER_USAGE = 85
> +#define AXIOM_MAX_READ_SIZE (2 * AXIOM_PAGE_SIZE)
> +#define SIZE_U31_DEVICE_INFO (12)
> +#define SIZE_U31_USAGE_ENTRY (6)
> +#define U31_MAX_USAGES (85U)
> +#define U41_MAX_TARGETS (10U)
> +#define U41_PROX_LEVEL (-128)
> +#define AXIOM_HOLDOFF_DELAY_US (40)
> +
> +enum ax_comms_op_e { AX_WR_OP = 0, AX_RD_OP = 1 };
> +
> +enum report_ids_e {
> +	AX_2DCTS_REPORT_ID = 0x41,
> +};
> +
> +enum axiom_mode_e {
> +	AX_RUNTIME_STATE = 0,
> +	AX_BOOTLOADER_STATE = 1,
> +};
> +
> +enum usage_type_e {
> +	UNKNOWN = 0,
> +	OTHER = 1,
> +	REPORT = 2,
> +	REGISTER = 3,
> +	REGISTER_READ_ONLY_ = 4,
> +	CDU = 5,
> +	CDU_READ_ONLY_ = 6,
> +};
> +
> +struct axiom_device_info {
> +	u16 device_id;
> +	u8 mode;
> +	u8 runtime_fw_rev_minor;
> +	u8 runtime_fw_rev_major;
> +	u8 device_build_variant;
> +	u8 runtime_fw_status;
> +	u8 tcp_revision;
> +	u8 bootloader_fw_rev_minor;
> +	u8 bootloader_fw_rev_major;
> +	u8 jedec_id;
> +	u8 num_usages;
> +	u8 silicon_revision;
> +	u8 runtime_fw_rev_patch;
> +};
> +
> +struct u31_usage_entry {
> +	u8 usage_num;
> +	u8 start_page;
> +	u8 num_pages;
> +	u8 max_offset;
> +	u8 offset_type;
> +	u8 uifrevision;
> +	u8 usage_type;
> +};
> +
> +struct axiom_cmd_header {
> +	u16 target_address;
> +	u16 length : 15;
> +	u16 rd_wr : 1;
> +};
> +
> +struct axiom_bus_ops {
> +	u16 bustype;
> +	int (*write)(struct device *dev, u16 addr, u16 length, void *values);
> +	int (*read)(struct device *dev, u16 addr, u16 length, void *values);
> +};
> +
> +enum u41_target_state_e {
> +	Target_State_Not_Present = 0,
> +	Target_State_Prox = 1,
> +	Target_State_Hover = 2,
> +	Target_State_Touching = 3,
> +};
> +
> +struct axiom {
> +	struct device *dev;
> +	int irq;
> +	struct input_dev *input;
> +	const struct axiom_bus_ops *bus_ops;
> +	struct axiom_device_info dev_info;
> +	struct u31_usage_entry usage_table[U31_MAX_USAGES];
> +	u16 max_report_len;
> +	u16 u34_address;
> +
> +	u8 read_buf[AXIOM_MAX_READ_SIZE];
> +};
> +
> +struct u34_report_header {
> +	u8 report_length;
> +	u8 overflow;
> +	u8 report_usage;
> +};
> +
> +struct axiom *axiom_probe(const struct axiom_bus_ops *bus_ops,
> +			  struct device *dev, int irq);
> +
> +#endif /* __AXIOM_CORE_H */
> diff --git a/drivers/input/touchscreen/axiom_i2c.c b/drivers/input/touchscreen/axiom_i2c.c
> new file mode 100644
> index 000000000000..66071cc0f7b3
> --- /dev/null
> +++ b/drivers/input/touchscreen/axiom_i2c.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TouchNetix aXiom Touchscreen Driver
> + *
> + * Copyright (C) 2020-2026 TouchNetix Ltd.
> + *
> + * Author(s): Bart Prescott <bartp@baasheep.co.uk>
> + *            Pedro Torruella <pedro.torruella@touchnetix.com>
> + *            Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
> + *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
> + *            Andrew Thomas <andrew.thomas@touchnetix.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +// #define DEBUG // Enable debug messages
> +
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include "axiom_core.h"
> +
> +static int axiom_i2c_read_block_data(struct device *dev, u16 addr, u16 length,
> +				     void *values)
> +{
> +	int error;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct axiom_cmd_header cmd_header = { .target_address = addr,
> +					       .length = length,
> +					       .rd_wr = AX_RD_OP };
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = sizeof(cmd_header),
> +			.buf = (u8 *)&cmd_header,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = length,
> +			.buf = values,
> +		},
> +	};
> +
> +	error = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (error < 0) {
> +		dev_err(dev, "I2C transfer error: %d\n", error);
> +		return error;
> +	}
> +
> +	udelay(AXIOM_HOLDOFF_DELAY_US);
> +
> +	return error != ARRAY_SIZE(msgs) ? -EIO : 0;
> +}
> +
> +static int axiom_i2c_write_block_data(struct device *dev, u16 addr, u16 length,
> +				      void *values)
> +{
> +	int error;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct axiom_cmd_header cmd_header = { .target_address = addr,
> +					       .length = length,
> +					       .rd_wr = AX_WR_OP };
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = sizeof(cmd_header),
> +			.buf = (u8 *)&cmd_header,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = length,
> +			.buf = values,
> +		},
> +	};
> +
> +	error = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (error < 0) {
> +		dev_err(dev, "I2C transfer error: %d\n", error);
> +		return error;
> +	}
> +
> +	udelay(AXIOM_HOLDOFF_DELAY_US);
> +
> +	return error != ARRAY_SIZE(msgs) ? -EIO : 0;
> +}
> +
> +static const struct axiom_bus_ops axiom_i2c_bus_ops = {
> +	.bustype = BUS_I2C,
> +	.write = axiom_i2c_write_block_data,
> +	.read = axiom_i2c_read_block_data,
> +};
> +
> +static int axiom_i2c_probe(struct i2c_client *client)
> +{
> +	struct axiom *axiom;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "I2C functionality not Supported\n");
> +		return -EIO;
> +	}
> +
> +	axiom = axiom_probe(&axiom_i2c_bus_ops, &client->dev, client->irq);
> +	if (IS_ERR(axiom))
> +		return dev_err_probe(&client->dev, PTR_ERR(axiom),
> +				     "failed to register input device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id axiom_i2c_id_table[] = {
> +	{ "axiom-i2c" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> +
> +static const struct of_device_id axiom_i2c_dt_ids[] = {
> +	{
> +		.compatible = "tnx,axiom-i2c",
> +		.data = "axiom",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, axiom_i2c_dt_ids);
> +
> +static struct i2c_driver axiom_i2c_driver = {
> +	.driver = {
> +		.name = "axiom_i2c",
> +		.of_match_table = of_match_ptr(axiom_i2c_dt_ids),
> +	},
> +	.id_table = axiom_i2c_id_table,
> +	.probe = axiom_i2c_probe,
> +};
> +
> +module_i2c_driver(axiom_i2c_driver);
> +
> +MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
> +MODULE_DESCRIPTION("aXiom touchscreen I2C bus driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("axiom");
> +MODULE_VERSION("1.0.0");
> diff --git a/drivers/input/touchscreen/axiom_spi.c b/drivers/input/touchscreen/axiom_spi.c
> new file mode 100644
> index 000000000000..a67ad3645689
> --- /dev/null
> +++ b/drivers/input/touchscreen/axiom_spi.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TouchNetix aXiom Touchscreen Driver
> + *
> + * Copyright (C) 2018-2023 TouchNetix Ltd.
> + *
> + * Author(s): Mark Satterthwaite <mark.satterthwaite@touchnetix.com>
> + *            Bart Prescott <bartp@baasheep.co.uk>
> + *            Hannah Rossiter <hannah.rossiter@touchnetix.com>
> + *            Andrew Thomas <andrew.thomas@touchnetix.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +// #define DEBUG // Enable debug messages
> +
> +#include <linux/of.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/input.h>
> +#include "axiom_core.h"
> +
> +#define SPI_PADDING_LEN 32
> +
> +static int axiom_spi_transfer(struct device *dev, enum ax_comms_op_e op,
> +			      u16 addr, u16 length, void *values)
> +{
> +	int ret;
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_transfer xfr_header;
> +	struct spi_transfer xfr_padding;
> +	struct spi_transfer xfr_payload;
> +	struct spi_message msg;
> +	struct axiom_cmd_header cmd_header = { .target_address = addr,
> +					       .length = length,
> +					       .rd_wr = op };
> +	u8 pad_buf[SPI_PADDING_LEN] = { 0 };
> +
> +	memset(&xfr_header, 0, sizeof(xfr_header));
> +	memset(&xfr_padding, 0, sizeof(xfr_padding));
> +	memset(&xfr_payload, 0, sizeof(xfr_payload));
> +
> +	/* Setup the SPI transfer operations */
> +	xfr_header.tx_buf = &cmd_header;
> +	xfr_header.len = sizeof(cmd_header);
> +
> +	xfr_padding.tx_buf = pad_buf;
> +	xfr_padding.len = sizeof(pad_buf);
> +
> +	switch (op) {
> +	case AX_WR_OP:
> +		xfr_payload.tx_buf = values;
> +		break;
> +	case AX_RD_OP:
> +		xfr_payload.rx_buf = values;
> +		break;
> +	default:
> +		dev_err(dev, "%s: invalid operation: %d\n", __func__, op);
> +		return -EINVAL;
> +	}
> +	xfr_payload.len = length;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfr_header, &msg);
> +	spi_message_add_tail(&xfr_padding, &msg);
> +	spi_message_add_tail(&xfr_payload, &msg);
> +
> +	ret = spi_sync(spi, &msg);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to SPI transfer, error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	udelay(AXIOM_HOLDOFF_DELAY_US);
> +
> +	return 0;
> +}
> +
> +static int axiom_spi_read_block_data(struct device *dev, u16 addr, u16 length,
> +				     void *values)
> +{
> +	return axiom_spi_transfer(dev, AX_RD_OP, addr, length, values);
> +}
> +
> +static int axiom_spi_write_block_data(struct device *dev, u16 addr, u16 length,
> +				      void *values)
> +{
> +	return axiom_spi_transfer(dev, AX_WR_OP, addr, length, values);
> +}
> +
> +static const struct axiom_bus_ops axiom_spi_bus_ops = {
> +	.bustype = BUS_SPI,
> +	.write = axiom_spi_write_block_data,
> +	.read = axiom_spi_read_block_data,
> +};
> +
> +static int axiom_spi_probe(struct spi_device *spi)
> +{
> +	struct axiom *axiom;
> +	int error;
> +
> +	/* Set up SPI */
> +	spi->bits_per_word = 8;
> +	spi->mode = SPI_MODE_0;
> +	spi->max_speed_hz = 4000000;
> +
> +	if (spi->irq == 0)
> +		dev_err(&spi->dev, "No IRQ specified!\n");
> +
> +	error = spi_setup(spi);
> +	if (error < 0) {
> +		dev_err(&spi->dev, "%s: SPI setup error %d\n", __func__, error);
> +		return error;
> +	}
> +	axiom = axiom_probe(&axiom_spi_bus_ops, &spi->dev, spi->irq);
> +	if (IS_ERR(axiom))
> +		return dev_err_probe(&spi->dev, PTR_ERR(axiom),
> +				     "failed to register input device\n");
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id axiom_spi_id_table[] = {
> +	{ "axiom-spi" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, axiom_spi_id_table);
> +
> +static const struct of_device_id axiom_spi_dt_ids[] = {
> +	{
> +		.compatible = "tnx,axiom-spi",
> +		.data = "axiom",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, axiom_spi_dt_ids);
> +
> +static struct spi_driver axiom_spi_driver = {
> +	.id_table = axiom_spi_id_table,
> +	.driver = {
> +		.name = "axiom_spi",
> +		.of_match_table = of_match_ptr(axiom_spi_dt_ids),
> +	},
> +	.probe = axiom_spi_probe,
> +};
> +
> +module_spi_driver(axiom_spi_driver);
> +
> +MODULE_AUTHOR("TouchNetix <support@touchnetix.com>");
> +MODULE_DESCRIPTION("aXiom touchscreen SPI bus driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("axiom");
> +MODULE_VERSION("1.0.0");
> -- 
> 2.43.0
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
