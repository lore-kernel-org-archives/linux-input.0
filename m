Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E84F5E0;
	Sat, 17 Oct 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246619; cv=none; b=G1H2Xo7+hdUAsbMxzUBVEnouqLagmv4u4huTg+F7qs3mKaYOinhbBkAr+1ijDxYyUOQPoIZ7RST1TFwx4EW5otC5fHwTGobLxEY91wnZ1onr7nzsm1bdD/RoszXtH6GaRNYwB7oumX8RgqItw5LIMdjQKDe35xspqdokysrCbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246619; c=relaxed/simple;
	bh=RIZjVekdMiJGiPJizKJfpWWpdC3mduDBFv5TbqTMVl8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fjh6JOybLKCmtsi9Mbg4kEg7n0i0xR6Gb1jVoiedbg0K6q/rPkfbvTSj3q58Ko37FnPD9UJ2CtjjNIgKaeaude8RqkY0YJseg7QGIQlVlzxiyUU6dDIrbMqdRiZTtZ+1TnV/jC1QMVh0V7A7C3m8xMbfzI4BKUtaLVztFHQfLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oveaPm8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oveaPm8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DED1F000C4;
	Sat, 17 Oct 2026 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792246617;
	bh=TlW3uCCvPw8oRYqoh8XMlvnaGOk9Zc2ktOuL/qbySGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oveaPm8OzEOCbzY+SvVSAfSzMIFHFCJHr2xijfAKUMFBslehRYFVI2P3P3fwGgaU1
	 TpfuAfSkDMHGAjA3TGpP/YWBYh8nR2Cx0kObWcyGpD28UKNqWypVvz289WqAzL80ru
	 tAfSwbXbj5oVwOs6Ovqzpfr+KTTTdtNKFmiQkKhhDs71xIpc9soYMb/G61zcqcGG6l
	 vi+CQOlhST3LDnv2ahHOD5oHjB0ZIk7MepO/zDpTCztuh6s2F7cYzkGg7myfRXrDww
	 k3MqKzvXlst1ChLEzq2zbC36h+LtSX6TO4XCr122iv5w1LOSpM8Cu4smnSBYeeHT21
	 U1cfn/sZVZ4qw==
Message-ID: <sashiko-outbox-175542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] Input: edt-ft5x06 - move the controller bring-up
 into a helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luka Panio" <lukapanio@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017140827.290666-3-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-3-lukapanio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:16:56 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Input: edt-ft5x06: edt_ft5x06_ts_init_hw() registers device befo=
re IRQ
--

commit 5aab9a2f7e5d9f696c6cdfb8f9baf87581af8689
Author: Luka Panio <lukapanio@gmail.com>

Input: edt-ft5x06 - move the controller bring-up into a helper

This commit moves the controller reset release, hardware identification,
input device registration, and debugfs setup out of edt_ft5x06_probe()
into a new edt_ft5x06_ts_init_hw() helper function.

> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index 543cc62088c7a..536d633d97a78 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1116,16 +1116,96 @@ static void edt_ft5x06_disable_regulators(void *a=
rg)
>  	regulator_disable(data->iovcc);
>  }
> =20
> +/*
> + * Take the controller out of reset, identify it and register the input
> + * device.
> + */
> +static int edt_ft5x06_ts_init_hw(struct edt_ft5x06_ts_data *tsdata)
> +{

[ ... ]

> +	error =3D input_register_device(input);
> +	if (error)
> +		return error;
> +
> +	edt_ft5x06_ts_prepare_debugfs(tsdata);
> +
> +	return 0;
> +}
> +
>  int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
>  		     const struct edt_ft5x06_chip_data *chip_data, u16 bustype,
>  		     struct dentry *debugfs)
>  {

[ ... ]

> @@ -1225,78 +1305,22 @@ int edt_ft5x06_probe(struct device *dev, struct r=
egmap *regmap, int irq,

[ ... ]

> +	error =3D edt_ft5x06_ts_init_hw(tsdata);
> +	if (error)
>  		return error;
> -	}
> =20
>  	irq_flags =3D irq_get_trigger_type(irq);
>  	if (irq_flags =3D=3D IRQF_TRIGGER_NONE)
> @@ -1310,12 +1334,6 @@ int edt_ft5x06_probe(struct device *dev, struct re=
gmap *regmap, int irq,
>  		return error;
>  	}
> =20
> -	error =3D input_register_device(input);
> -	if (error)
> -		return error;
> -
> -	edt_ft5x06_ts_prepare_debugfs(tsdata);
> -
>  	dev_dbg(dev,
>  		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
>  		irq,

[Severity: Medium]
Previously, edt_ft5x06_probe() called devm_request_threaded_irq() before
calling input_register_device() and edt_ft5x06_ts_prepare_debugfs().

With edt_ft5x06_ts_init_hw() now running before devm_request_threaded_irq(),
the input device and debugfs files are published to userspace before the
touchscreen IRQ is requested.

If devm_request_threaded_irq() fails, the input device is announced to
userspace only to be immediately torn down during devres release.

Additionally, because edt_ft5x06_ts_prepare_debugfs() exposes the debugfs
mode file early, writing 1 to it before or during IRQ setup triggers:

edt_ft5x06_debugfs_mode_set()
  -> edt_ft5x06_factory_mode()
       disable_irq(tsdata->irq);
       if (!tsdata->raw_buffer) {
           tsdata->raw_bufsize =3D tsdata->num_x * tsdata->num_y *
                                 sizeof(u16);
           tsdata->raw_buffer =3D kzalloc(tsdata->raw_bufsize, GFP_KERNEL);
           ...
       }

Can this cause disable_irq() (or enable_irq() on error or when switching
back in edt_ft5x06_work_mode()) to be called before the IRQ is requested, or
cause irq_startup() inside devm_request_threaded_irq() to re-enable the
interrupt while tsdata->factory_mode is true?

Also, if devm_request_threaded_irq() fails after tsdata->raw_buffer is
allocated, edt_ft5x06_remove() -> edt_ft5x06_ts_teardown_debugfs() is not
run on probe failure. Does this leak tsdata->raw_buffer?

Should devm_request_threaded_irq() be called before edt_ft5x06_ts_init_hw()
(for example, with IRQF_NO_AUTOEN if needed until the hardware is ready), or
should input_register_device() and edt_ft5x06_ts_prepare_debugfs() happen
after the IRQ is requested?

oggler

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017140827.2906=
66-1-lukapanio@gmail.com?part=3D2
