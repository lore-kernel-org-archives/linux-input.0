Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5D3290C9
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206829; cv=none; b=kxqNC/xX/Mc4uLz/IQ9y7c7QO8nAUYT6P0sPj8ffCIc6dJDRNiuGh9fq4huy9bx5Wl+gsrut3Si+JDiH4d7/+NmMzRXrBmoecGHyH+bbhTwx7sghz7scGeWSDiifwp/Y3SWPgTKgamYbga/4KtTaFVVR/PbfDEXO1DaSvbfH4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206829; c=relaxed/simple;
	bh=MVnGjBzMF0TA3dOemueqBJCvzQjgrFbKIZy5x+gfLBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNbAKKIkFHo1Ff/LUQLtK1P/yLiPhBl/1EYQ7b8fVSrQ7VxLPgVOKVwiUyORX+1zhUZzuK5N4Ojzt1wHRLHsrAD0HUHduSGpY8IthV6Og6mTXoxT3izfEXz99ODq/NyVX4uMdlGAZMlV32//EnpMU31VKCR1Re93MNlPfjAeI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxsaBcka; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxsaBcka"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso666034eec.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773206827; x=1773811627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDj66m7ySANpkWKJsIiXq2ioKjYAQ6NoS9GjGRtQ+q4=;
        b=AxsaBckaTiWCrCxMFjSwvIhRi2w05M3RbRuIkynZz3HrlnR3p20HC+SY+TJjCiFapb
         kvslLpxVXGFQc72oic1uEu4vGbKedDG/FCEKoedibWq85Rvtm9t6TSG/Qhiqwdpbx+hx
         L0Mk8v1I/bY3o2ngQtJ6HWc7Jmkp0K+igjzRANnqlen0Futw/CtkR1U2GquUUEagek9c
         vuBF2lkILJJISAF9IYWEAIw6mJbYu/WEiHU7dfXCFp70nvExVabYRrt+/54S6g2mNSRz
         6yZRO8N5zZXdO6qEc2Ww/0FmCZhKFbfP2HKcCEdiDbPtAnBofifpUBFXTKIRw7Jr3aCn
         Hr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206827; x=1773811627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDj66m7ySANpkWKJsIiXq2ioKjYAQ6NoS9GjGRtQ+q4=;
        b=VD/E7eub5y6lDQgd7+1Lo6VeujIAqa2unLBAJTT38YJsFryzAyNij/BcoyQBW7NlQK
         Dl8xZp3U3DPBqY+mGANS9uojerxkQFh/gIbSivIYc+V37p1YIiBdkreTzW+mRqpmcILS
         cVrH+JHvzeq6mkHrJLBf/4k4UQ0ZjbH4jqR/wZC3M2dua2jO/WdoTYcmxNmRgu4vcCbH
         5svnCPcSztdfvxRhRzm4AocoHJOZxj6L/w3FwUVeelYtynKM0G17NmcFN6wiKBdE5/4j
         bRXuvQrZkUReHfC6vtoHcRtAf/Hyvxsz8N+luok3T3+I2/ojG+40IZ8mNpEHYtFVr28Q
         jGwA==
X-Forwarded-Encrypted: i=1; AJvYcCUsRy5K6YKpMdeHFBsWdeJ7n1eUctBK0o4pecIw16KKRmmRr1sC1LQSpEoEI1vRj6q+L79f4QJeF721Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbkh+OfLFpYrQoarFfAOWUJ0quNiGMKkg5fKPnW8nGQs3DBfsT
	Qccd2h5pRlzvXCZt68traKX71NvCIFFZ1oeRs0VZm7otfexcYbC6GItY
X-Gm-Gg: ATEYQzydrT1yQCoScIzGlLfc48B9LCuhr+LImhUCU9TyLi/OoTyY8Nz6rMeZc+2QclM
	7uQIDuid14XnXk7CtCCxmLQ91I9ce1xC5QSA2C2LY0yKL/oJu/Z51UmM5yXa0t9435xyNhHNZSu
	0u8y2Q+1wO3j4+GduqNcMkYPq4eLKddsgOOy0k/4HzLNdpeCb4m/qGESj7CGCBCr9aBCy85pGwW
	7xYNda2rQn7ijlVtFBE6qqDR3QKyx21SZGOJempyXABTA/ndYPW6FmbAJBGXLtwxehfGGd5Hd87
	Y1a0Bk/b3W79NC5Lh0pQzsNGKbJCMjbrGDfSEkNw29gykbMvs3wmqfrh/6C4RsB+sHfErN8Gho8
	oSZbn6Nv046ljMQCTd0udwquujD5D8T0/LzSSrnxg5kelJZGYnx7VL9XlqpU1w8B9i/QO1soaGn
	FR3087EU0Nq+gpF2Q4nvkRqfUOlC2yioZzOtG2SswQ/1hJ17aK1Pn0qX8mDmtUinpP
X-Received: by 2002:a05:7301:3f16:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-2be8a23c5f2mr497116eec.11.1773206826486;
        Tue, 10 Mar 2026 22:27:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a85ff37sm1158607eec.14.2026.03.10.22.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:27:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 22:27:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, Angela Czubak <acz@semihalf.com>
Subject: Re: [PATCH 07/12] HID: spi_hid: add ACPI support for SPI over HID
Message-ID: <abD6RJZa5D7LN3x0@google.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-7-1515ba218f3d@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-send-upstream-v1-7-1515ba218f3d@chromium.org>

On Tue, Mar 03, 2026 at 06:12:59AM +0000, Jingyuan Liang wrote:
> From: Angela Czubak <acz@semihalf.com>
> 
> Detect SPI HID devices described in ACPI.
> 
> Signed-off-by: Angela Czubak <acz@semihalf.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  drivers/hid/spi-hid/Kconfig        |  15 +++
>  drivers/hid/spi-hid/Makefile       |   1 +
>  drivers/hid/spi-hid/spi-hid-acpi.c | 253 +++++++++++++++++++++++++++++++++++++
>  drivers/hid/spi-hid/spi-hid-core.c |  27 +---
>  drivers/hid/spi-hid/spi-hid.h      |  44 +++++++
>  5 files changed, 316 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
> index 836fdefe8345..114b1e00da39 100644
> --- a/drivers/hid/spi-hid/Kconfig
> +++ b/drivers/hid/spi-hid/Kconfig
> @@ -10,6 +10,21 @@ menuconfig SPI_HID
>  
>  if SPI_HID
>  
> +config SPI_HID_ACPI
> +	tristate "HID over SPI transport layer ACPI driver"
> +	depends on ACPI
> +	select SPI_HID_CORE
> +	help
> +	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
> +	  other HID based devices which are connected to your computer via SPI.
> +	  This driver supports ACPI-based systems.
> +
> +	  If unsure, say N.
> +
> +	  This support is also available as a module.  If so, the module
> +	  will be called spi-hid-acpi. It will also build/depend on the
> +	  module spi-hid.
> +
>  config SPI_HID_CORE
>  	tristate
>  endif
> diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
> index 92e24cddbfc2..753c7b7a7844 100644
> --- a/drivers/hid/spi-hid/Makefile
> +++ b/drivers/hid/spi-hid/Makefile
> @@ -7,3 +7,4 @@
>  
>  obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
>  spi-hid-objs 			= spi-hid-core.o
> +obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
> diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
> new file mode 100644
> index 000000000000..612e74fe72f9
> --- /dev/null
> +++ b/drivers/hid/spi-hid/spi-hid-acpi.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HID over SPI protocol, ACPI related code
> + *
> + * Copyright (c) 2021 Microsoft Corporation
> + * Copyright (c) 2026 Google LLC
> + *
> + * This code was forked out of the HID over SPI core code, which is partially
> + * based on "HID over I2C protocol implementation:
> + *
> + * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
> + * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
> + * Copyright (c) 2012 Red Hat, Inc
> + *
> + * which in turn is partially based on "USB HID support for Linux":
> + *
> + * Copyright (c) 1999 Andreas Gal
> + * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
> + * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
> + * Copyright (c) 2007-2008 Oliver Neukum
> + * Copyright (c) 2006-2010 Jiri Kosina
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/reset.h>
> +#include <linux/uuid.h>
> +
> +#include "spi-hid.h"
> +
> +/* Config structure is filled with data from ACPI */
> +struct spi_hid_acpi_config {
> +	struct spihid_ops ops;
> +
> +	struct spi_hid_conf property_conf;
> +	u32 post_power_on_delay_ms;
> +	u32 minimal_reset_delay_ms;
> +	struct acpi_device *adev;
> +};
> +
> +/* HID SPI Device: 6e2ac436-0fcf41af-a265-b32a220dcfab */
> +static guid_t spi_hid_guid =
> +	GUID_INIT(0x6E2AC436, 0x0FCF, 0x41AF,
> +		  0xA2, 0x65, 0xB3, 0x2A, 0x22, 0x0D, 0xCF, 0xAB);
> +
> +static int spi_hid_acpi_populate_config(struct spi_hid_acpi_config *conf,
> +					struct acpi_device *adev)
> +{
> +	acpi_handle handle = acpi_device_handle(adev);
> +	union acpi_object *obj;
> +
> +	conf->adev = adev;
> +
> +	/* Revision 3 for HID over SPI V1, see specification. */
> +	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 1, NULL,
> +				      ACPI_TYPE_INTEGER);
> +	if (!obj) {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID input report header address failed");
> +		return -ENODEV;
> +	}
> +	conf->property_conf.input_report_header_address = obj->integer.value;
> +	ACPI_FREE(obj);
> +
> +	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 2, NULL,
> +				      ACPI_TYPE_INTEGER);
> +	if (!obj) {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID input report body address failed");
> +		return -ENODEV;
> +	}
> +	conf->property_conf.input_report_body_address = obj->integer.value;
> +	ACPI_FREE(obj);
> +
> +	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 3, NULL,
> +				      ACPI_TYPE_INTEGER);
> +	if (!obj) {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID output report header address failed");
> +		return -ENODEV;
> +	}
> +	conf->property_conf.output_report_address = obj->integer.value;
> +	ACPI_FREE(obj);
> +
> +	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 4, NULL,
> +				      ACPI_TYPE_BUFFER);
> +	if (!obj) {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID read opcode failed");
> +		return -ENODEV;
> +	}
> +	if (obj->buffer.length == 1) {
> +		conf->property_conf.read_opcode = obj->buffer.pointer[0];
> +	} else {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID read opcode, too long buffer");
> +		ACPI_FREE(obj);
> +		return -ENODEV;
> +	}
> +	ACPI_FREE(obj);
> +
> +	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 5, NULL,
> +				      ACPI_TYPE_BUFFER);
> +	if (!obj) {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID write opcode failed");
> +		return -ENODEV;
> +	}
> +	if (obj->buffer.length == 1) {
> +		conf->property_conf.write_opcode = obj->buffer.pointer[0];
> +	} else {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID write opcode, too long buffer");
> +		ACPI_FREE(obj);
> +		return -ENODEV;
> +	}
> +	ACPI_FREE(obj);
> +
> +	/* Value not provided in ACPI,*/
> +	conf->post_power_on_delay_ms = 5;
> +	conf->minimal_reset_delay_ms = 150;
> +
> +	if (!acpi_has_method(handle, "_RST")) {
> +		acpi_handle_err(handle, "No reset method for acpi handle");
> +		return -ENODEV;

I would return -EINVAL as we have the device with right _DSM but without
mandated by the spec _RST.

> +	}
> +
> +	/* FIXME: not reading hid-over-spi-flags, multi-SPI not supported */
> +
> +	return 0;
> +}
> +
> +static int spi_hid_acpi_power_none(struct spihid_ops *ops)
> +{
> +	return 0;
> +}
> +
> +static int spi_hid_acpi_power_down(struct spihid_ops *ops)
> +{
> +	struct spi_hid_acpi_config *conf = container_of(ops,
> +							struct spi_hid_acpi_config,
> +							ops);
> +
> +	return acpi_device_set_power(conf->adev, ACPI_STATE_D3);
> +}
> +
> +static int spi_hid_acpi_power_up(struct spihid_ops *ops)
> +{
> +	struct spi_hid_acpi_config *conf = container_of(ops,
> +							struct spi_hid_acpi_config,
> +							ops);
> +	int error;
> +
> +	error = acpi_device_set_power(conf->adev, ACPI_STATE_D0);
> +	if (error) {
> +		dev_err(&conf->adev->dev, "Error could not power up ACPI device: %d.", error);
> +		return error;
> +	}
> +
> +	if (conf->post_power_on_delay_ms)
> +		msleep(conf->post_power_on_delay_ms);
> +
> +	return 0;
> +}
> +
> +static int spi_hid_acpi_assert_reset(struct spihid_ops *ops)
> +{
> +	return 0;
> +}
> +
> +static int spi_hid_acpi_deassert_reset(struct spihid_ops *ops)
> +{
> +	struct spi_hid_acpi_config *conf = container_of(ops,
> +							struct spi_hid_acpi_config,
> +							ops);
> +
> +	return device_reset(&conf->adev->dev);
> +}
> +
> +static void spi_hid_acpi_sleep_minimal_reset_delay(struct spihid_ops *ops)
> +{
> +	struct spi_hid_acpi_config *conf = container_of(ops,
> +							struct spi_hid_acpi_config,
> +							ops);
> +	usleep_range(1000 * conf->minimal_reset_delay_ms,
> +		     1000 * (conf->minimal_reset_delay_ms + 1));

I'd probably use "fsleep(conf->minimal_reset_delay_ms * 1000)".

> +}
> +
> +static int spi_hid_acpi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct acpi_device *adev;
> +	struct spi_hid_acpi_config *config;
> +	int error;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev) {
> +		dev_err(dev, "Error could not get ACPI device.");
> +		return -ENODEV;
> +	}
> +
> +	config = devm_kzalloc(dev, sizeof(struct spi_hid_acpi_config),
> +			      GFP_KERNEL);
> +	if (!config)
> +		return -ENOMEM;
> +
> +	if (acpi_device_power_manageable(adev)) {
> +		config->ops.power_up = spi_hid_acpi_power_up;
> +		config->ops.power_down = spi_hid_acpi_power_down;
> +	} else {
> +		config->ops.power_up = spi_hid_acpi_power_none;
> +		config->ops.power_down = spi_hid_acpi_power_none;
> +	}
> +	config->ops.assert_reset = spi_hid_acpi_assert_reset;
> +	config->ops.deassert_reset = spi_hid_acpi_deassert_reset;
> +	config->ops.sleep_minimal_reset_delay =
> +		spi_hid_acpi_sleep_minimal_reset_delay;
> +
> +	error = spi_hid_acpi_populate_config(config, adev);
> +	if (error) {
> +		dev_err(dev, "%s: unable to populate config data.", __func__);
> +		return error;
> +	}

I would add a blank line.

> +	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
> +}
> +
> +static const struct acpi_device_id spi_hid_acpi_match[] = {
> +	{ "ACPI0C51", 0 },
> +	{ "PNP0C51", 0 },
> +	{ },

No comma on sentinels.

> +};
> +MODULE_DEVICE_TABLE(acpi, spi_hid_acpi_match);
> +
> +static struct spi_driver spi_hid_acpi_driver = {
> +	.driver = {
> +		.name	= "spi_hid_acpi",
> +		.owner	= THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(spi_hid_acpi_match),

This is dependent on ACPI, so no need to sue ACPI_PTR().

> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.dev_groups = spi_hid_groups,
> +	},
> +	.probe		= spi_hid_acpi_probe,
> +	.remove		= spi_hid_core_remove,
> +};
> +
> +module_spi_driver(spi_hid_acpi_driver);
> +
> +MODULE_DESCRIPTION("HID over SPI ACPI transport driver");
> +MODULE_AUTHOR("Angela Czubak <aczubak@google.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
> index e3273846267e..02beb209a92d 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
> @@ -43,6 +43,9 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> +#include "spi-hid.h"
> +#include "spi-hid-core.h"
> +
>  /* Protocol constants */
>  #define SPI_HID_READ_APPROVAL_CONSTANT		0xff
>  #define SPI_HID_INPUT_HEADER_SYNC_BYTE		0x5a
> @@ -105,30 +108,6 @@ struct spi_hid_output_report {
>  	u8 *content;
>  };
>  
> -/* struct spi_hid_conf - Conf provided to the core */
> -struct spi_hid_conf {
> -	u32 input_report_header_address;
> -	u32 input_report_body_address;
> -	u32 output_report_address;
> -	u8 read_opcode;
> -	u8 write_opcode;
> -};
> -
> -/**
> - * struct spihid_ops - Ops provided to the core
> - * @power_up: do sequencing to power up the device
> - * @power_down: do sequencing to power down the device
> - * @assert_reset: do sequencing to assert the reset line
> - * @deassert_reset: do sequencing to deassert the reset line
> - */
> -struct spihid_ops {
> -	int (*power_up)(struct spihid_ops *ops);
> -	int (*power_down)(struct spihid_ops *ops);
> -	int (*assert_reset)(struct spihid_ops *ops);
> -	int (*deassert_reset)(struct spihid_ops *ops);
> -	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
> -};
> -
>  static struct hid_ll_driver spi_hid_ll_driver;
>  
>  static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
> diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
> new file mode 100644
> index 000000000000..1fdd45262647
> --- /dev/null
> +++ b/drivers/hid/spi-hid/spi-hid.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Microsoft Corporation
> + * Copyright (c) 2026 Google LLC
> + */
> +
> +#ifndef SPI_HID_H
> +#define SPI_HID_H
> +
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +
> +/* struct spi_hid_conf - Conf provided to the core */
> +struct spi_hid_conf {
> +	u32 input_report_header_address;
> +	u32 input_report_body_address;
> +	u32 output_report_address;
> +	u8 read_opcode;
> +	u8 write_opcode;
> +};
> +
> +/**
> + * struct spihid_ops - Ops provided to the core
> + * @power_up: do sequencing to power up the device
> + * @power_down: do sequencing to power down the device
> + * @assert_reset: do sequencing to assert the reset line
> + * @deassert_reset: do sequencing to deassert the reset line
> + */
> +struct spihid_ops {
> +	int (*power_up)(struct spihid_ops *ops);
> +	int (*power_down)(struct spihid_ops *ops);
> +	int (*assert_reset)(struct spihid_ops *ops);
> +	int (*deassert_reset)(struct spihid_ops *ops);
> +	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
> +};
> +
> +int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
> +		       struct spi_hid_conf *conf);
> +
> +void spi_hid_core_remove(struct spi_device *spi);
> +
> +extern const struct attribute_group *spi_hid_groups[];
> +
> +#endif /* SPI_HID_H */

I am not sure if this belongs to this patch or if it should be better in
the patch introducing the main driver from the beginning.

For the ACPI part:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
