Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C444DE715
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070772; cv=none; b=kX2dFSIc/LmF6HiFB8Wsu/E0V19j3p+fG6CLTfxW6W2aXVBj3BhqY9tuRWEToglVuwahdt9sVfckHAQAmbI/+ZwL9u/yrN7cZLLvtH6gNO2zfa30sKvclo8FElFjNr/i+OMWe/QEIy5ihmh38B+sGxmTbQQlaa7xn3r0ZaekV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070772; c=relaxed/simple;
	bh=/hyB+hEw6RLudRjQ7dI1d4NFysBDKsw1sQJA+/qf+iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHbj1dqvMepa6j3D3E9pUvTMvFtt/L/eJsRghgva/bwlJchYAk4kF9QPM5PpYTVZ75X/2AAK5aWuN9s8vsHwGf6kGbClzyQUb+mIJ1nQ+onW5DXJPg11inuEKX6ilcyD9JCoRBdBeAliYCmPwh2BsEjPOyXkN+gvXCVcBFjf8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=UbU7CoLf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="UbU7CoLf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso34270745e9.3
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790070768; x=1790675568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYbygSoXTPt7jaWPgoihIOPAkjKBdxHc4l1yrHc4AGQ=;
        b=UbU7CoLfLA/KildSyTRxEZBDk5ouIV5wcTT9FwSAVXX8IztropXtW1B9tVhPOnvuDZ
         vFXmRhh3nCtiSGXIfhRbM1IfCHFksGd16/TQWuamEwysvpbtDXAouWp3f3T+OQMWV8zv
         69/gXuQV4zk/6RRYvJbtHDq99YWgX7WplJUvOnpz5o0Vxf2gHJnI146KvWlx3w/mG8p/
         8lOCdfWMGH1kq2abyoeVe6OMV/AHqxEHBiVp8lyzWHj+9/tTK1tykmdHCa3vs5fVY1rm
         VoVgspEI1ogbm6jhKX3gm1axLHQ3goZHo3FI4UuVNbvDOqbBUbZb6V28XFZMLChN5ohE
         AAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070768; x=1790675568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QYbygSoXTPt7jaWPgoihIOPAkjKBdxHc4l1yrHc4AGQ=;
        b=sLBqptFTEAwz08s9qQzPsHD0iy5389WZLONAIZbdlkCSozAmTBE4yhXrbbQDhRKuit
         fM0+5SQEfTGWz1uUQjnVfhcVZHp634nz4o/7UN/ReN5pxE84j3x8hGOdo0U4kO5yY7QE
         9uASe0xaa/GjAVwa203c0KIuU3DjTNm8+y8PAFqmUMwLN8wYpc0D6cJUFZDMHDnIm6hj
         cvsNadgSwPe+laLo/qfflc4t/Os5ld/h+qY4nsnQN/5kCW3uId4ENlkQBKEMEfq/LGX3
         lhA1gZMm177NXp3/iokCE2FzY6OtsqvZB68WlCE2jXSuA3YR/VqAY46O4tGQ3/cdnptZ
         lFBw==
X-Forwarded-Encrypted: i=1; AKwUvBwv5wnKfujMINXb9uWwLWFYTF07FjphVgSsxirH3YJHY3IsJ9FXLPoQpXUDi3/ORDa3WVn3zgJEq01GkA==@vger.kernel.org
X-Gm-Message-State: AFuF++mr5nJWU4GOqu1PjeY7c+FCIOIJhncZE9mjYtrO21TzQEaTFWLg
	gDVS9HJHInkRPSQPNV+u9h4cgxF37TxnYJLGvUOQ5Wyf71l59XeuK4ndiS0A5+KwIKk=
X-Gm-Gg: AYBFou0vWWvdqWQ8p7lmcSanD8eM+fM4tsPgqjM8h3oq8ErQP13sVtzbRzJ/SlmmEcI
	RhT2G+v6AT9d22OI4D7d+EzrDpO5UxQAZBWoPHhlf3Z/vL8xJdp6OWnIFymPCHnC7rjmZ6vQjkh
	cuYVeVQzaNrIBpkvnduBPT18UVWrxPypUL+XO8fOndDSBQyczMEVqpBhEa4JWfcF4C0ADpcZeIg
	Y4DSvLOJWIvhPEu1HEiIl0uWU6N8SJIan+hKJhee5MpcIDkscf65Lz0xXUWZaAx9+5sAl60V6iI
	c9D5Iva/CgOEDWmE9AAz/E4+doaW+OpvnsORwvCI6a5CH0D0HenMXa3Y9stxKHZPk3Cx1PZyNta
	GRk1QHQ9Y9DMkHG7oQytuHoqWS9vIBJRfqS3ORJL0A0BXOys73hsQWu+ZujXmXJMxW0HLcNa8W6
	dJgdp9ZB7+G8ZwT+hKW9sY2zQ51eFxwlzMskIp4jTHr/iAy/7ITGgKVqeqp82AVHzfuIwftbPv6
	PxZ7M96DtEmTx7z0BitKkG38R+JIJwZvLZ+d2pWim76Pz0tr/WoDircCk4pM0QrAJtVPeqCQu3p
	A2K0LAr7BbxajfGLYja5bUdNZvG0iWeYiLk/nR2eQNCQf1oJXAT0/fb2Ebk=
X-Received: by 2002:a05:600c:46cf:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49fc5687b6cmr202804085e9.2.1790070767607;
        Tue, 22 Sep 2026 02:52:47 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaa9dbd6sm42235115e9.2.2026.09.22.02.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:52:46 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:52:44 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: kavakliyigitcan@gmail.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 02/10] backlight: add Kinetic KTD3136 driver
Message-ID: <arJP7AMM5DqNoc8e@aspen.lan>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-2-0e68e63a18d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-ginkgo-submission-final-v1-2-0e68e63a18d4@gmail.com>

On Fri, Sep 11, 2026 at 11:50:59AM +0300, YİĞİTCAN KAVAKLI via B4 Relay wrote:
>  obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
> diff --git a/drivers/video/backlight/ktd3136-backlight.c b/drivers/video/backlight/ktd3136-backlight.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a8ebe3b23c99f3ada9f45c60688f8b8c78d72def
> --- /dev/null
> +++ b/drivers/video/backlight/ktd3136-backlight.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Kinetic Technologies KTD3136 3-Channel LED Backlight Driver
> + *
> + * Copyright (C) 2026
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define KTD3136_REG_DEV_ID		0x00
> +#define KTD3136_REG_SW_RESET		0x01
> +#define KTD3136_REG_MODE		0x02
> +#define KTD3136_REG_CONTROL		0x03
> +#define KTD3136_REG_RATIO_LSB		0x04
> +#define KTD3136_REG_RATIO_MSB		0x05
> +#define KTD3136_REG_PWM			0x06
> +#define KTD3136_REG_STATUS		0x0A
> +
> +#define KTD3136_DEV_ID_VAL		0x18
> +#define KTD3136_DEV_ID_VAL2		0x19
> +
> +#define KTD3136_MODE_ON			0xC9	/* Boost ON, 3 channels enabled */
> +#define KTD3136_MODE_STANDBY		0x98	/* Standby mode */
> +#define KTD3136_CONTROL_LINEAR		0x02	/* Linear dimming mapping */
> +#define KTD3136_PWM_DEFAULT		0x1B	/* Default PWM/boost frequency */
> +
> +#define KTD3136_DEFAULT_MAX_BRIGHTNESS	2047	/* 11-bit resolution */
> +#define KTD3136_DEFAULT_BRIGHTNESS	2047
> +
> +struct ktd3136_data {
> +	struct i2c_client *client;
> +	struct backlight_device *bd;
> +	struct gpio_desc *enable_gpio;
> +	struct regulator *vin;
> +	/* Protects chip registers and state */
> +	struct mutex lock;
> +	bool is_enabled;
> +};
> +
> +static int ktd3136_write(struct ktd3136_data *chip, u8 reg, u8 val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(chip->client, reg, val);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev, "failed to write reg 0x%02x: %d\n", reg, ret);
> +
> +	return ret;
> +}
> +
> +static int ktd3136_read(struct ktd3136_data *chip, u8 reg)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(chip->client, reg);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev, "failed to read reg 0x%02x: %d\n", reg, ret);
> +
> +	return ret;
> +}
> +
> +static int ktd3136_power_on(struct ktd3136_data *chip)
> +{
> +	int ret;
> +
> +	if (chip->is_enabled)
> +		return 0;
> +
> +	if (chip->enable_gpio) {
> +		gpiod_set_value_cansleep(chip->enable_gpio, 1);
> +		/* Allow oscillator and internal logic to stabilize */
> +		usleep_range(2000, 3000);
> +	}
> +
> +	ret = ktd3136_write(chip, KTD3136_REG_CONTROL, KTD3136_CONTROL_LINEAR);
> +	if (ret < 0)
> +		goto err_off;
> +
> +	ret = ktd3136_write(chip, KTD3136_REG_PWM, KTD3136_PWM_DEFAULT);
> +	if (ret < 0)
> +		goto err_off;
> +
> +	chip->is_enabled = true;
> +	return 0;
> +
> +err_off:
> +	if (chip->enable_gpio)
> +		gpiod_set_value_cansleep(chip->enable_gpio, 0);
> +	return ret;
> +}
> +
> +static void ktd3136_power_off(struct ktd3136_data *chip)
> +{
> +	if (!chip->is_enabled)
> +		return;
> +
> +	ktd3136_write(chip, KTD3136_REG_MODE, KTD3136_MODE_STANDBY);
> +
> +	if (chip->enable_gpio)
> +		gpiod_set_value_cansleep(chip->enable_gpio, 0);

Why does this powering off leave the regulator active?


> +
> +	chip->is_enabled = false;
> +}
> +
> +static int ktd3136_update_status(struct backlight_device *bd)
> +{
> +	struct ktd3136_data *chip = bl_get_data(bd);
> +	int brightness = backlight_get_brightness(bd);
> +	int ret = 0;
> +	u8 lsb, msb;
> +
> +	mutex_lock(&chip->lock);
> +
> +	if (backlight_is_blank(bd) || brightness == 0) {
> +		ktd3136_power_off(chip);
> +		goto out;
> +	}
> +
> +	ret = ktd3136_power_on(chip);
> +	if (ret < 0)
> +		goto out;
> +
> +	lsb = brightness & 0x07;
> +	msb = (brightness >> 3) & 0xFF;
> +
> +	ret = ktd3136_write(chip, KTD3136_REG_RATIO_LSB, lsb);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ktd3136_write(chip, KTD3136_REG_RATIO_MSB, msb);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ktd3136_write(chip, KTD3136_REG_MODE, KTD3136_MODE_ON);
> +
> +out:
> +	mutex_unlock(&chip->lock);
> +	return ret;
> +}
> +
> +static const struct backlight_ops ktd3136_backlight_ops = {
> +	.options = BL_CORE_SUSPENDRESUME,
> +	.update_status = ktd3136_update_status,
> +};
> +
> +static int ktd3136_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct backlight_properties props;
> +	struct ktd3136_data *chip;
> +	int ret, val;
> +	u32 def_brightness = KTD3136_DEFAULT_BRIGHTNESS;
> +	u32 max_brightness = KTD3136_DEFAULT_MAX_BRIGHTNESS;
> +
> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client = client;
> +	mutex_init(&chip->lock);
> +
> +	chip->vin = devm_regulator_get_optional(dev, "vin");
> +	if (IS_ERR(chip->vin)) {
> +		ret = PTR_ERR(chip->vin);
> +		if (ret != -ENODEV)
> +			return dev_err_probe(dev, ret, "Failed to get vin regulator\n");
> +		chip->vin = NULL;
> +	}
> +
> +	if (chip->vin) {
> +		ret = regulator_enable(chip->vin);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to enable vin regulator\n");
> +	}

Why is the regulator managed here rather than in the power_on/off functions?

Also, you need to keep track of the regulator state. You must "put" the
regulator before allowing devm to clean it up (handling the regulator
state in power_on/off would solve this).


> +
> +	chip->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->enable_gpio))
> +		return dev_err_probe(dev, PTR_ERR(chip->enable_gpio),
> +				     "Failed to get enable GPIO\n");
> +
> +	if (chip->enable_gpio)
> +		usleep_range(2000, 3000);
> +
> +	val = ktd3136_read(chip, KTD3136_REG_DEV_ID);
> +	if (val < 0)
> +		return dev_err_probe(dev, val, "Failed to read device ID\n");
> +
> +	if (val != KTD3136_DEV_ID_VAL && val != KTD3136_DEV_ID_VAL2) {
> +		dev_err(dev, "Unknown device ID: 0x%02x\n", val);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(dev, "Kinetic KTD3136 detected (ID: 0x%02x)\n", val);

Remove this. Happy noises are still noise!


> +
> +	device_property_read_u32(dev, "max-brightness", &max_brightness);
> +	if (max_brightness > KTD3136_DEFAULT_MAX_BRIGHTNESS)
> +		max_brightness = KTD3136_DEFAULT_MAX_BRIGHTNESS;
> +
> +	device_property_read_u32(dev, "default-brightness", &def_brightness);
> +	if (def_brightness > max_brightness)
> +		def_brightness = max_brightness;
> +
> +	memset(&props, 0, sizeof(props));
> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = max_brightness;
> +	props.brightness = def_brightness;

The scale property needs to be set here.


Daniel.
