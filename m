Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F435CB6C;
	Fri, 23 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160568; cv=none; b=gHf22+x7dJjoGk43YzN5ukF7NmSW9qTGjOFpM0Q5r0ek7DQRm4SxFiowO4iqwfNZTFl05Cvee8Hgac/rYjlsfpUADumIwTyuUMivE0MkRZf9VJqxXtRMKBFTl9GnAhX7b2AZyD1Xt6Wis1OMZiwlajHZhV5TEC6U0XEn+uZz6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160568; c=relaxed/simple;
	bh=+W4Gd7hmvu2/5/nAO1KD379Amm0yDAkFNhibA73/L4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzlvcRTyEOI2DlbzNQx8y1A3kTC9/J81cyxu2IHd7HIPx+WSoS/um8a1uSVuHzHSM6x2xs0eJBSTlxPAUQEeLy+XBZD1IdmQArZhwdpHxCjvV8IKWo5KwZB0zC4i8r/d3uOqs2XovZtN0cL8vgColelJ/vdvv9g3JTR65n5xgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2trqvpL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2trqvpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED57AC116D0;
	Fri, 23 Jan 2026 09:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160567;
	bh=+W4Gd7hmvu2/5/nAO1KD379Amm0yDAkFNhibA73/L4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C2trqvpLEox8booG9mVWQoqvZGPcDp50NuZu6V2IJhpcUXHaYrHZbYcOavcNUXvQb
	 cvFuBLaSTOnZuH3XK6L1OUJqnOJNE16SxDtKVzc8wqb7ZsbaMNUDyWNBZqZjslNBex
	 v4VINWWXkIKfPwmYVhouLdi1pV41+fbGPSWn/HWjdeTUdxPHKIAoVommVaR66C0K1m
	 RhL0qYsKU4fZ58PeX2yUy194+xV0z0Ji5Hed65LYQA3En3l/K7+BJ710Eh6rLb3bAV
	 7fKeJKWWqLNkhE7bZpmA5iQ34NuGJXCPiRNRlquzKdG2cmG8y10o6RvW3lqlF9nJWU
	 oPqZCf94/On1A==
Message-ID: <a0d900a4-7694-41b1-99bc-ebb69469c5b3@kernel.org>
Date: Fri, 23 Jan 2026 10:29:24 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Adding support for aXiom touchscreen controller
To: AThomas63 <andrew.thomas@touchnetix.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 mark.satterthwaite@touchnetix.com, m.felsch@pengutronix.de,
 kamel.bouhara@bootlin.com
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
 <20260122124819.273188-2-andrew.thomas@touchnetix.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260122124819.273188-2-andrew.thomas@touchnetix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2026 13:48, AThomas63 wrote:
> Signed-off-by: AThomas63 <andrew.thomas@touchnetix.com>


Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Running checkpatch is really basic and EVERY kernel guide asks you to do
that. Not doing it is not an excuse for your first patch, becasue when
writing first patch you should follow the first-patch guidelines or
kernel docs closely.


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

This should not be user-selectable. It's useless alone. Just "tristate"
and change the depending drivers to select it.

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


...

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

No code in the kernel has such license boilerplate. Please use recent
Linux drivers as starting code. It's really pointless to send to
upstream some old vendor code, because you will repeat all the
mistakes/issues/old style which we fixed already over last 15 years.

> + *


...

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

Drop of_match_ptr, leads to warnings here.

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

Drop alias. You should not need MODULE_ALIAS() in normal cases. If you
need it, usually it means your device ID table is wrong (e.g. misses
either entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a
substitute for incomplete ID table.

> +MODULE_VERSION("1.0.0");


Best regards,
Krzysztof
