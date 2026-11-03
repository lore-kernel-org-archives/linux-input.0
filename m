Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736148;
	b=EExVUSxArMZphM7h3W4a8Qm0qIHaifAFedC1wLg5VpTaZ6GfBQHFLyUsqLjTXYFqxPch
	 yTjZbW0Uov7/vOd+Ily3TIP3XoE8RG2Idd6pyrLkrWgs4rq2eWs0+J2Fhcv8zx6mln3JN
	 fx2AWK+/xi7RqqGZoFFq1mZqJacJi/8G5X7sR4b4zEp+CV5XgmDZlDJoVaWp5d7f4+c8K
	 Oi2UT4wWsw/t//uA5BXg9BWQtv8ZMDmwNAiwdUA4a6IE1JZ3ONjq6QVdGXZ5QN1I9tctl
	 bP/i7cgqlciOOQJFCRIBFYKHWbXQXWK/rXy/IzZEWu/VyhR3zaxUg/Qd6UkUIW2rKwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JXKgP8NvWBMDICYMceAdXiB+d2mm0l021tsooHUk0nI=;
	b=OQP59wrzxls/ku19NNOdbecyBscSVI8iHwvs7QBj3aKGmis90JVs4tcxDPUqDFKydd78
	 xS6USTFyTaeKnpJNJ5x1GboWSJvW5jELnWl9XUZ4stsvKLZHgVu58A+dGOBnW9lMpDUP3
	 a2g3FBRvS7RkNeiZe1aTd8s86YM/mxSxynL++kOIaEZZCJzd98tQyHSw4qo7avoR2Orej
	 gaBihb5mo9imXTtO0khY+Lqn3bGpEx06twJHdcQ/j9t6kFwvHju2cdw51ZPaNAtvlaOLa
	 ueBSz9vKW2nfwNQBdgj84mDACJkmhAzoGfXCcQTqUieK22tB5cPprzUKCjwbhAhqyjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqY60YX7;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777E606A330
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 20:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B777E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqY60YX7
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2761c69fbso38908c88.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793736147; x=1794340947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JXKgP8NvWBMDICYMceAdXiB+d2mm0l021tsooHUk0nI=;
        b=VqY60YX7v8zgxI9xGHnBm3fI6aR0ID8Ct0mY+MKC9DHEJ7iiPC311TyL4/XhhoZvYW
         bkfpRoEtcG03oN3jk97wYDCh9aso4m7RLJwpMUaeoCe3MkUR1OyWL9Gwt+jZw1VDf6uC
         uCVJoxWS2nsLKHZ4O1mosfbegjmKG0YB+IjILarWIzolB+3K0cxA4xKn0VQy0V7AxuNh
         jF7XgpRxiN+bd0zcjyfF9h7jHCYmU9lLvE2PtqrZVQEAz0AyMk6InGdlu9CuVebBBcb+
         Lb2JgflMAHMPoQfKyBZKocXRzIx84tsNAEuiRTsdY2t/qnYVaAVxKm52r3LMBJSpburw
         lNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736147; x=1794340947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JXKgP8NvWBMDICYMceAdXiB+d2mm0l021tsooHUk0nI=;
        b=2NK0/4svYJiw7J3gzZPPWVyvYSHmC7p/dr/z9xEv62G0gMJqXMRCOSP65OQckaZeAO
         v+pMsaiK9L/oyZhyN1YS2MDpQci4RcBPziqSlF/5B1c9AidEfomgngVIGEva8sInvEF9
         HzAK7taS9z7/rCPJL4iBAligyl37yHQKV68LaF+fA1xQZGTgXv51j9ngmKEQ3NA5JIkT
         l4pGRywvqWo5TNPsg9DVe6oR+FWGjFNgtESbzZrIRC8DmAfUH/V0IsS7cG+UvbTHHbwN
         LF+e0r7TYv6VzTzXoOrOdYZMQCslV/pmhrgAEBflv/0amo0ywYOgL2A7ouoTF7ZcQ1VS
         dxvA==
X-Forwarded-Encrypted: i=1; AKwUvByN1Y756bhh7rDo6gyjuYRIIZ1zKooBVS5kxeWkI32gQfU8ArK1qVPu/KVum/8nbCBlMUTdnavEaQPF7w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+EjB8Etx6EPExxWKrFZxvc2gqMdNtiVbHMFX0f0JkH200+PmPA
	vAATOB7TsxmkFHBDMyDTJScGY3KmbltXiQU8I70n3qBhlAbTBfNT8iyJ
X-Gm-Gg: AYBFou0Ba51PkhRWklcS1QkZNgXov+LQcOFrHbqC1kPrkfwFytkE5My+dXDZNvKy+dS
	Na23/wU6q/hDqydOH8DL+4Ill+TelhVrkQP7vLzmxzgNRFdwVaKrjV/ACchFt8cPfofOUvk43tA
	Z16PZ6gs58a2YJ425Wpa0o1xZsbMHbSibuvEnJocCvlvAwrc5VhA/GOZyTWD8rkNLQG4i4FNwkP
	CIiqP7ty9EaIKn89SstiidOxIJCJVQ8UmD6hW8l43ICCJYtKKKG/yGOUeM+w8wDnjatuNfNyucH
	ttOHXRoPwydY4Z7xZ5hvMRDJn/tnphDCDq3o2/4ZqJDV3JNPBEi8Qq6DelaXQUgBUaVQe+uQuv6
	j8habgxaDip77mMyP9duOrbZVi1gsYdV/Y10EMXZPYMZTnknc967Z6EloQllp1luBrFZ6CEMyHW
	0W91hdmrjXsC/Ew+Nuj6+FpjbGFrfqu3YcBNjejhsrtmAvN3Pv8rSYRVYXHKn9aEEEb/Ye8rKPR
	ldwAjLSiULcR08M83zdo7wazGGZlMKYlCekiH30a37UeCuBIwt5eWm4tv+dKkJeFDwyc+0jEKeM
	O6NwbdnQdCISGZbGSmYI3Ubhx93RF0AvHR15p4moIEXg4s3UMHAAfRFYgQFnODtGYKhf
X-Received: by 2002:a05:7022:170c:b0:145:287:ce91 with SMTP id a92af1059eb24-1ac59dd30ebmr21798770c88.14.1793736146378;
        Tue, 03 Nov 2026 12:02:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3784f78sm591496eec.2.2026.11.03.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:02:25 -0800 (PST)
Date: Tue, 3 Nov 2026 12:02:21 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add FocalTech FT3683G touchscreen driver
Message-ID: <auo7GvY0Ufq_7DTn@google.com>
References: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me>
 <20261030-focaltech-ft3683g-v1-2-38b2f941b039@pm.me>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-focaltech-ft3683g-v1-2-38b2f941b039@pm.me>

Hi Alexander,

On Fri, Oct 30, 2026 at 05:27:15AM +0000, Alexander Koskovich wrote:
> Add a driver for the FocalTech FT3683G, a flexible OLED capacitive
> touch controller supporting 10-point multitouch over SPI. This touch
> controller is found in the Nothing Phone (3a).
> 
> The driver implements the SPI transport layer, touch event parsing for
> the FocalTech protocol v2 format, and basic power management.
> 
> The existing edt-ft5x06 driver is not reused, as the FT3683G uses
> FocalTech's newer v2 reporting protocol (protocol version header) over
> SPI with a custom framing (length header, dummy bytes, status byte and
> a CRC-16/MCRF4XX trailer) instead of plain register access.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/input/touchscreen/Kconfig             |  12 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/focaltech_ft3683g.c | 365 ++++++++++++++++++++++++++
>  4 files changed, 379 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68efbf580964..79f3d6211cb5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10503,6 +10503,7 @@ M:	Alexander Koskovich <akoskovich@pm.me>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/input/touchscreen/focaltech,ft3683g.yaml
> +F:	drivers/input/touchscreen/focaltech_ft3683g.c
>  
>  FOCUSRITE CONTROL PROTOCOL/SCARLETT2 MIXER DRIVERS (Scarlett Gen 2+, Clarett, and Vocaster)
>  M:	Geoffrey D. Bennett <g@b4.vu>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 9b9ae8ac3f7f..f7ade03f4a0e 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1414,4 +1414,16 @@ config TOUCHSCREEN_HIMAX_HX83112B
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called himax_hx83112b.
>  
> +config TOUCHSCREEN_FOCALTECH_FT3683G
> +	tristate "Focaltech FT3683G touchscreen driver"
> +	depends on SPI
> +	select CRC_CCITT
> +	help
> +	  Say Y here to enable support for FocalTech FT3683G touchscreens.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called focaltech_ft3683g.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index bfd9de83389d..45cdd7bb7d6f 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -119,3 +119,4 @@ obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>  obj-$(CONFIG_TOUCHSCREEN_IQS7211)	+= iqs7211.o
>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
>  obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
> +obj-$(CONFIG_TOUCHSCREEN_FOCALTECH_FT3683G)	+= focaltech_ft3683g.o
> diff --git a/drivers/input/touchscreen/focaltech_ft3683g.c b/drivers/input/touchscreen/focaltech_ft3683g.c
> new file mode 100644
> index 000000000000..5c8133ffb265
> --- /dev/null
> +++ b/drivers/input/touchscreen/focaltech_ft3683g.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FocalTech FT3683G Touchscreen Driver
> + *
> + * Copyright (c) 2012-2020 FocalTech Systems, Ltd.
> + * Copyright (c) Alexander Koskovich <akoskovich@pm.me>
> + */
> +
> +#include <linux/cache.h>
> +#include <linux/crc-ccitt.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +
> +#define FT3683G_MAX_POINTS	10
> +
> +#define FT3683G_SPI_CMD_READ	0xa0
> +#define FT3683G_SPI_DUMMY	3
> +#define FT3683G_SPI_RETRIES	3
> +#define FT3683G_SPI_CS_DELAY_US	150
> +
> +#define FT3683G_REG_CHIP_ID	0xa3
> +#define FT3683G_REG_CHIP_ID2	0x9f
> +
> +#define FT3683G_CHIP_IDH	0x56
> +#define FT3683G_CHIP_IDL	0x72
> +
> +#define FT3683G_REG_TOUCH_DATA	0x01
> +
> +#define FT3683G_TOUCH_LEN	8
> +#define FT3683G_TOUCH_HEADER	4
> +#define FT3683G_TOUCH_BUF_SIZE	(FT3683G_MAX_POINTS * FT3683G_TOUCH_LEN + \
> +				 FT3683G_TOUCH_HEADER)
> +
> +#define FT3683G_TOUCH_OFF_XH	0
> +#define FT3683G_TOUCH_OFF_XL	1
> +#define FT3683G_TOUCH_OFF_YH	2
> +#define FT3683G_TOUCH_OFF_YL	3
> +
> +#define FT3683G_EVENT_DOWN	0
> +#define FT3683G_EVENT_UP	1
> +#define FT3683G_EVENT_CONTACT	2
> +
> +#define FT3683G_PROTOCOL_V2	0x02
> +
> +#define FT3683G_FW_INIT		0xff
> +
> +struct ft3683g_data {
> +	struct spi_device *spi;
> +	struct input_dev *input;
> +	struct touchscreen_properties props;
> +	struct regulator_bulk_data supplies[2];
> +	struct gpio_desc *reset_gpio;
> +	struct device *dev;
> +	struct mutex spi_lock; /* protects tx_buf/rx_buf */

In what cases will there be concurrent accss?

> +	u8 tx_buf[256] ____cacheline_aligned;
> +	u8 rx_buf[256] ____cacheline_aligned;
> +};
> +
> +static int ft3683g_spi_read(struct ft3683g_data *ts, u8 addr,
> +			    u8 *data, u32 len)
> +{
> +	struct spi_transfer xfer = { };
> +	u32 dp = 4 + FT3683G_SPI_DUMMY;
> +	u32 txlen = dp + len + 2;
> +	u16 crc_calc, crc_read;
> +	int error, i;
> +
> +	guard(mutex)(&ts->spi_lock);
> +
> +	memset(ts->tx_buf, 0, txlen);
> +	ts->tx_buf[0] = addr;
> +	ts->tx_buf[1] = FT3683G_SPI_CMD_READ;
> +	ts->tx_buf[2] = (len >> 8) & 0xff;
> +	ts->tx_buf[3] = len & 0xff;

cpu_to_be16p()? or put_unaligned_be16()?

> +
> +	xfer.tx_buf = ts->tx_buf;
> +	xfer.rx_buf = ts->rx_buf;
> +	xfer.len = txlen;
> +
> +	for (i = 0; i < FT3683G_SPI_RETRIES; i++) {
> +		error = spi_sync_transfer(ts->spi, &xfer, 1);
> +		if (error)
> +			continue;
> +
> +		if (ts->rx_buf[3] & 0xa0) {

What is 0xa0? GENMASK()? Something els?

> +			fsleep(FT3683G_SPI_CS_DELAY_US);
> +			continue;
> +		}
> +
> +		crc_calc = crc_ccitt(0xffff, &ts->rx_buf[dp], len);
> +		crc_read = ts->rx_buf[dp + len] |
> +			   (ts->rx_buf[dp + len + 1] << 8);

get_unaligned_le16()?

> +		if (crc_calc != crc_read) {
> +			fsleep(FT3683G_SPI_CS_DELAY_US);
> +			continue;
> +		}
> +
> +		memcpy(data, &ts->rx_buf[dp], len);
> +		return 0;
> +	}
> +
> +	return error ? error : -EIO;
> +}
> +
> +static int ft3683g_read_reg(struct ft3683g_data *ts, u8 addr, u8 *val)
> +{
> +	return ft3683g_spi_read(ts, addr, val, 1);
> +}
> +
> +static int ft3683g_check_chip_id(struct ft3683g_data *ts)
> +{
> +	u8 idh, idl;
> +	int error;
> +
> +	error = ft3683g_read_reg(ts, FT3683G_REG_CHIP_ID, &idh);
> +	if (error)
> +		return error;
> +
> +	error = ft3683g_read_reg(ts, FT3683G_REG_CHIP_ID2, &idl);
> +	if (error)
> +		return error;
> +
> +	if (idh != FT3683G_CHIP_IDH || idl != FT3683G_CHIP_IDL) {
> +		dev_err(ts->dev,
> +			"chip ID mismatch: expected %02x%02x, got %02x%02x\n",
> +			FT3683G_CHIP_IDH, FT3683G_CHIP_IDL, idh, idl);
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(ts->dev, "chip ID: %02x%02x\n", idh, idl);
> +	return 0;
> +}
> +
> +static irqreturn_t ft3683g_irq(int irq, void *dev_id)
> +{
> +	struct ft3683g_data *ts = dev_id;
> +	u8 buf[FT3683G_TOUCH_BUF_SIZE];
> +	unsigned int x, y, id, event;
> +	int event_num, i, base;
> +	u8 protocol;
> +	int error;
> +
> +	error = ft3683g_spi_read(ts, FT3683G_REG_TOUCH_DATA,
> +				 buf, sizeof(buf));
> +	if (error) {
> +		dev_err_ratelimited(ts->dev, "failed to read touch data: %d\n",
> +				    error);
> +		return IRQ_HANDLED;

Why not IRQ_NONE?

> +	}
> +
> +	if (!memchr_inv(&buf[1], FT3683G_FW_INIT, 4)) {
> +		input_mt_sync_frame(ts->input);
> +		input_sync(ts->input);
> +		return IRQ_HANDLED;

I'd do "goto out".

> +	}
> +
> +	protocol = (buf[1] >> 4) & 0x0f;
> +	if (protocol != FT3683G_PROTOCOL_V2)
> +		return IRQ_HANDLED;
> +
> +	event_num = buf[1] & 0x0f;
> +	if (!event_num || event_num > FT3683G_MAX_POINTS)
> +		return IRQ_HANDLED;
> +
> +	for (i = 0; i < event_num; i++) {
> +		base = FT3683G_TOUCH_LEN * i + FT3683G_TOUCH_HEADER;
> +
> +		event = buf[base + FT3683G_TOUCH_OFF_XH] >> 6;
> +		id = buf[base + FT3683G_TOUCH_OFF_YH] >> 4;
> +		if (id >= FT3683G_MAX_POINTS)
> +			continue;
> +
> +		input_mt_slot(ts->input, id);
> +
> +		if (event == FT3683G_EVENT_DOWN ||
> +		    event == FT3683G_EVENT_CONTACT) {

Could be written as:

		if (input_mt_report_slot_state(ts->input, MT_TOOL_FINGER,
					       event == FT3683G_EVENT_DOWN ||
							event == FT3683G_EVENT_CONTACT) {
			...

>
> +			x = ((buf[base + FT3683G_TOUCH_OFF_XH] & 0x0f) << 8) |
> +			    buf[base + FT3683G_TOUCH_OFF_XL];

get_unaligned_xx16()?

> +			y = ((buf[base + FT3683G_TOUCH_OFF_YH] & 0x0f) << 8) |
> +			    buf[base + FT3683G_TOUCH_OFF_YL];
> +
> +			input_mt_report_slot_state(ts->input,
> +						   MT_TOOL_FINGER, true);
> +			touchscreen_report_pos(ts->input, &ts->props,
> +					       x, y, true);
> +		} else {
> +			input_mt_report_slot_state(ts->input,
> +						   MT_TOOL_FINGER, false);
> +		}
> +	}
> +
> +	input_mt_sync_frame(ts->input);
> +	input_sync(ts->input);
> +	return IRQ_HANDLED;
> +}
> +
> +static int ft3683g_power_on(struct ft3683g_data *ts)
> +{
> +	int error;
> +
> +	gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +	usleep_range(2000, 3000);
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
> +	if (error) {
> +		dev_err(ts->dev, "failed to enable regulators: %d\n", error);
> +		return error;
> +	}
> +
> +	usleep_range(2000, 3000);
> +	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +	msleep(50);
> +
> +	return 0;
> +}
> +
> +static void ft3683g_power_off(struct ft3683g_data *ts)
> +{
> +	gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
> +}
> +
> +static void ft3683g_power_off_act(void *data)
> +{
> +	struct ft3683g_data *ts = data;
> +
> +	ft3683g_power_off(ts);
> +}
> +
> +static int ft3683g_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ft3683g_data *ts;
> +	int error;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->dev = dev;
> +	ts->spi = spi;
> +	spi_set_drvdata(spi, ts);
> +	mutex_init(&ts->spi_lock);
> +
> +	ts->supplies[0].supply = "vddio";
> +	ts->supplies[1].supply = "vci";
> +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
> +					ts->supplies);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to get regulators\n");
> +
> +	ts->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ts->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio),
> +				     "failed to request reset gpio\n");
> +
> +	error = ft3683g_power_on(ts);
> +	if (error)
> +		return error;
> +
> +	error = devm_add_action_or_reset(dev, ft3683g_power_off_act, ts);
> +	if (error)
> +		return error;
> +
> +	error = ft3683g_check_chip_id(ts);
> +	if (error)
> +		return error;
> +
> +	ts->input = devm_input_allocate_device(dev);
> +	if (!ts->input)
> +		return -ENOMEM;
> +
> +	ts->input->name = "FocalTech FT3683G Touchscreen";
> +	ts->input->id.bustype = BUS_SPI;
> +	input_set_drvdata(ts->input, ts);
> +
> +	input_set_capability(ts->input, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(ts->input, EV_ABS, ABS_MT_POSITION_Y);
> +	touchscreen_parse_properties(ts->input, true, &ts->props);
> +
> +	error = input_mt_init_slots(ts->input, FT3683G_MAX_POINTS,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to init MT slots\n");
> +
> +	error = devm_request_threaded_irq(dev, spi->irq, NULL, ft3683g_irq,
> +					  IRQF_ONESHOT, "ft3683g", ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to request IRQ\n");
> +
> +	error = input_register_device(ts->input);
> +	if (error)
> +		return dev_err_probe(dev, error,
> +				     "failed to register input device\n");
> +
> +	return 0;
> +}
> +
> +static int ft3683g_suspend(struct device *dev)
> +{
> +	struct ft3683g_data *ts = dev_get_drvdata(dev);
> +
> +	disable_irq(ts->spi->irq);
> +
> +	input_mt_sync_frame(ts->input);
> +	input_sync(ts->input);

Why is this needed? We do not do that in any other drivers.

Thanks.

-- 
Dmitry
