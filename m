Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2230251791
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917191; cv=none; b=guHhnzMB8j+sDhU0RuZiLtS8vx993SH6pAELMfScZ9mfqGFJYze5QXFkEiA6aqGvp8AdGjgdueNpJjhqxnNVTY8oGYfmoE3ZKBhM4BDEIkzBHWrSvLSWASQzgMtPEFxrtO3fFJ2cDb8I+nxWAu3G+W+TpxT+N+TtA4CIrsMtjss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917191; c=relaxed/simple;
	bh=DuF6dqn7qjlgP50TsVjM9qQeFPak58ahoU8SLhz62ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7kvMOZSU8NrSHJmZtj2wrCGmhSiLrxSHLzvSbbYf0TWzE6AlmraQMaSs3/j/7bDa7MKd458zbZjaXHl+jsEUk0VNlCobqkBaq+fpBL48U5OtXsAEaodxkr9dtyx1FYYuVCUQeMy7knXm5okvKUq3nll/lWre+q8Sr4pa4NhZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLxW7i6t; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLxW7i6t"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so69992eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917189; x=1771521989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QB4DaCqxhZjla4MvBqmYY9LcQT1xs4w6zhTDHbsCso=;
        b=nLxW7i6t6rTsizNQWZFmHkw9o2yYZrO4odk4oJf2wg3BEXdI/OwG+2BY4gkEX7CN4j
         /LG0mddIGFAfriBTru3QHc/XZK9I8MNkSgkvD7Go8AGdnVqVIGv49cehDFoahnNp8tea
         TgpYOXGV4Z5BDYCxYIVrjVowVMInob0CDvw2E+JRx2CWTcJrt5w2VooETx/MJQ9jg9TT
         ReoeaYuxSUoy3/ffuFxOzZkl+SciPy5PzGFpGRRpxKzwZJrNRTLahfT3ztWd+CY/i0V5
         5xMG8UDA86aIGPKBx/fGgSp369zh+jECykuVg7N7MMK7TvVcYV30TzI2kLXdf5nXMdjv
         gqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917189; x=1771521989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QB4DaCqxhZjla4MvBqmYY9LcQT1xs4w6zhTDHbsCso=;
        b=nosAv3NYK6U+Uy+1zfu1SL96wfroBI+N+gJzfyftlSzKCDrTkULGlmsFoeYPWZ528S
         DyN38BH/Sd+e5C8mE8WPgeU0GgKYwGtUjtpslh8FY1eFP8ozCgLO4nBR4FaN4y9cUkf7
         evMD3LNrGkKDB/JAAL5zxpsxDwSIjmXxxt8Mo9ZSxcmuekh8Cax1QrauIXrGxN8mCBWh
         Ytke80d7rzbsgaz7QZqHhiNveRbXBHVsdYvjcBxoDZ+vNxDgRXVY4/HJvRxqxHepCkXh
         GEcJos8UIliem92mkNMbryIaFHmFLuDrdrHYs60Q5jhWDyAHoKSM3DkSV0CkzU8/bN0O
         XCaQ==
X-Gm-Message-State: AOJu0Yyf5tvlU8LxOHaBkt78F1eVSeUOWtXpdshIscnA7OzfnQ1+9lbs
	DX1Qr38TOYDxmCg0QPQ34z0CBGDdZD6u0ggZcuTFESgwr+sgPH+GMl6B
X-Gm-Gg: AZuq6aJudak6foZvnQJf9Jy+z8PtL6oxa7v02tnIvWqeeKBgO+SfVzctnTJRGACDnMe
	HGy+yABPVW3U4jC11e2XZYLSq3rfuZBW0SOvzbb4WlxHcJxO/uBlhy/9t5OPj6q3Gt6EQA2GjdB
	EGG4UPAH9llOnYXdAi+d9i1sgRqukN0nmh5vkscgBDubrDvVHgsb5g6b2u0EWfdJmezW4gJ4/Fe
	0KYIqG2XI9A5Lyf/u2C9Hlijl1rhY8CIHS76y49mtkYpls686qGpsHXRNdJG7P6CSfQF4cyJ/Th
	w/q6NFqdxOuzU8B9Qee1ss82bIIBUSUIzsGE6ZIMy2GR3amYoeifN0G1NsfbX7eyPm+xGA5O9m2
	/Zdu9Q9FmJf3rrOdXzPypgJ+SCiZokPpjHQzXokqzQBiN9PWfIg8yD/bDgMecZB13MvSadaUI03
	oHlAUWKrWaL1BEwvOHUea5XvCaOneFk9rSTY++yug8+yNuksbn/WpZcKFnL5d/EVz7
X-Received: by 2002:a05:7300:cb86:b0:2ba:6aef:697a with SMTP id 5a478bee46e88-2bab937bf6bmr23865eec.24.1770917187387;
        Thu, 12 Feb 2026 09:26:27 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:7027:6cb0:48e2:2882])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dd00ae7sm3924359eec.31.2026.02.12.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:26:26 -0800 (PST)
Date: Thu, 12 Feb 2026 09:26:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 2/5] input: drv260x: Add support for ACPI-enumerated
 devices
Message-ID: <aY4MqXG2zr01Pk4Q@google.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-3-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211235902.4156624-3-jekhor@gmail.com>

Hi Yauhen,

On Thu, Feb 12, 2026 at 01:46:52AM +0200, Yauhen Kharuzhy wrote:
> Add ACPI ids and GPIO lookup mapping for drv2604 haptics device.
> Found in Lenovo Yoga Book YB1-X91L tablet.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/input/misc/drv260x.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 18360bdfe877..f613c81fa2ba 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/acpi.h>

Sort alphabetically please.

>  
>  #include <dt-bindings/input/ti-drv260x.h>
>  
> @@ -419,6 +420,12 @@ static const struct regmap_config drv260x_regmap_config = {
>  	.cache_type = REGCACHE_NONE,
>  };
>  
> +static const struct acpi_gpio_params enable_gpio = { 0, 0, false };
> +static const struct acpi_gpio_mapping acpi_drv260x_default_gpios[] = {
> +	{ "enable-gpio", &enable_gpio, 1 },
> +	{ }
> +};

I'd rather move this ACPI/device-specifin handling into drivers/platform/x86/x86-android-tablets/lenovo.c

> +
>  static int drv260x_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -426,6 +433,14 @@ static int drv260x_probe(struct i2c_client *client)
>  	u32 voltage;
>  	int error;
>  
> +	if (has_acpi_companion(dev)) {
> +		error = devm_acpi_dev_add_driver_gpios(dev, acpi_drv260x_default_gpios);
> +		if (error) {
> +			dev_err(dev, "can't add GPIO ACPI mapping\n");
> +			return error;
> +		}
> +	}
> +
>  	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
>  	if (!haptics)
>  		return -ENOMEM;
> @@ -484,8 +499,10 @@ static int drv260x_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	haptics->enable_gpio = devm_gpiod_get_optional(dev, "enable",
> -						       GPIOD_OUT_HIGH);
> +	haptics->enable_gpio = devm_gpiod_get_optional(dev,
> +			"enable", GPIOD_OUT_HIGH);

Why this change?

> +
> +	dev_dbg(dev, "Enable gpio = 0x%p\n", haptics->enable_gpio);

?

>  	if (IS_ERR(haptics->enable_gpio))
>  		return PTR_ERR(haptics->enable_gpio);
>  
> @@ -606,6 +623,14 @@ static const struct i2c_device_id drv260x_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, drv260x_id);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id drv260x_acpi_match[] = {
> +	{ "DRV2604", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, drv260x_acpi_match);
> +#endif
> +
>  static const struct of_device_id drv260x_of_match[] = {
>  	{ .compatible = "ti,drv2604", },
>  	{ .compatible = "ti,drv2604l", },
> @@ -621,6 +646,7 @@ static struct i2c_driver drv260x_driver = {
>  		.name	= "drv260x-haptics",
>  		.of_match_table = drv260x_of_match,
>  		.pm	= pm_sleep_ptr(&drv260x_pm_ops),
> +		.acpi_match_table = ACPI_PTR(drv260x_acpi_match),
>  	},
>  	.id_table = drv260x_id,
>  };

Thanks.

-- 
Dmitry
