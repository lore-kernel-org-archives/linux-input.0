Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574328371;
	Sat,  6 Jun 2026 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780759258; cv=none; b=mYc4SxrHgUIGhI6cTXk9XMkcBEt9nciwi6IIbjz0XZ7ChoXU46vTJ3693g7xgMHL/iyBTlWmKGm6k3mwMwvjTZVpjmugInOAXIRl9BYagEshw31b/JOxE+rZueHujB/ZBROaHNMzB52QkSI6re2/f6SRJfSvEhTjZcgFagrvin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780759258; c=relaxed/simple;
	bh=E+7MlXMZBFsMqaasNRcRRlL86EZAL3PlGz9YqYmiQao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BJbanlsBUTEeQ/EonUgrPA/rE/ox80VBheSSUBVzmIPhGHAZWTmuFvmqJXZ5CR7thLTheU2f5WphLR9p9vhml2Ffw2M1qPAy7aQPstuVCYsPpNZifXdLHvIeeEoCTg+4/g2VsKXZTA8NIPHEedUilUHih4ZqODTtgKO5h6GI4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f27VoBJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f27VoBJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77161F00893;
	Sat,  6 Jun 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780759257;
	bh=9YSlc33MJ+RqRLNKmkClZGu824oEjAFa0dZkAAtlIp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f27VoBJ8ekns3NIBJ6qIg0zmGePtXDytDN0CifSZ5lm0+5sq9zaio7DeO9ufdLHZ9
	 pNfBg7JbI0RTDV/Ja4izeFOMI4EEZH4JMO2e9A6sODqLMV/PmuLd79s9Bth4/g/TVe
	 rXjL8JhLjBgK5uJTKR/bfekkHkAiUdq3E2V2eTcruSTRy+NvqfMLk+CfD3aO6n5Z9/
	 s9HdFZCkvLMoRsMi2N15Fd7pQIu9b5k2mrrmk2xx5PF2NYdBqdir9y79+KguUyotPX
	 WYYO10Dl9nlGTqgY93p0JN7OqKx686o1G5ksJqO/3RaT68OyiH1uZKxN/0f9diHS+X
	 YgvivsCspBMWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] Input: cap11xx - add support for CAP1114
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260606150458.250606-9-jerrysteve1101@gmail.com>
References: <20260606150458.250606-9-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:20:56 +0000
Message-Id: <20260606152056.B77161F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Buffer overflow when reading the 'microchip,calib-sensitivity' dev=
ice tree property for devices with >8 channels.
- [High] Failure to mask `STATUS1` before ORing `STATUS2` can cause phantom=
 key presses for channels 7 and 8.
- [Low] Bitmask calculation for 'microchip,signal-guard' truncates settings=
 for channels 8 and above.
--

commit 8885b1d0f98cb8d5ca53ba5fd9a458743481d5be
Author: Jun Yan <jerrysteve1101@gmail.com>

Input: cap11xx - add support for CAP1114

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support. The CAP1114 uses two separate control registers
for LED output management and requires two button status registers for touch
input state reporting.

> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> index 408880cf65167..2aba3b508947d 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c

[ ... ]

> @@ -311,6 +337,20 @@ static irqreturn_t cap11xx_thread_func(int irq_num, =
void *data)
>  	if (ret < 0)
>  		goto out;
> =20
> +	if (priv->model->num_channels > 8) {
> +		unsigned int status2;
> +
> +		ret =3D regmap_read(priv->regmap, priv->model->sensor_input_reg_base +=
 1, &status2);
> +		if (ret < 0)
> +			goto out;
> +
> +		/*
> +		 * CAP1114 STATUS1 register only contains data for the first 6 channel=
s.
> +		 * the remaining channels is stored in STATUS2.
> +		 */
> +		status |=3D FIELD_PREP(GENMASK(13, 6), status2);

[Severity: High]
If the hardware sets reserved bits 6 or 7 in the first status register to 1,
will they be preserved and incorrectly reported as touch events for channels
7 and 8?

Since the status variable (which holds STATUS1) is not masked before this OR
operation, any reserved bits set in STATUS1 could overlap with the shifted
status2 values.

Should the status variable be masked to clear bits 6 and 7 before ORing in
status2?

> +	}
> +
>  	for (i =3D 0; i < priv->idev->keycodemax; i++)

[ ... ]

> @@ -572,6 +625,14 @@ static const struct cap11xx_hw_model cap1106_model =
=3D {
>  	.has_repeat_en =3D true,
>  };
> =20
> +static const struct cap11xx_hw_model cap1114_model =3D {
> +	.product_id =3D 0x3a,
> +	.led_output_control_reg_base =3D CAP1114_REG_LED_OUTPUT_CONTROL1,
> +	.sensor_input_reg_base =3D CAP1114_REG_BUTTON_STATUS1,
> +	.num_channels =3D 14, .num_leds =3D 11, .num_sensor_thresholds =3D 8,

[Severity: High]
Does configuring num_channels to 14 cause a buffer overflow when parsing the
device tree?

In struct cap11xx_priv, calib_sensitivities is defined as a fixed 8-element
array:

struct cap11xx_priv {
        ...
        u32 calib_sensitivities[8];
        u32 keycodes[];
};

When cap11xx_init_keys() parses the microchip,calib-sensitivity property, it
requests num_channels elements:

of_property_read_u32_array(node, "microchip,calib-sensitivity",
                           priv->calib_sensitivities,
                           priv->model->num_channels)

If the device tree provides 14 elements, won't this write 56 bytes into the
32-byte array, overflowing into the adjacent keycodes flexible array?

[Severity: Low]
Additionally, does setting num_channels to 14 cause truncation in the
microchip,signal-guard bitmask logic?

In cap11xx_init_keys(), priv->signal_guard_inputs_mask is typed as a u8, but
the initialization loop runs up to num_channels:

if (u32_val)
        priv->signal_guard_inputs_mask |=3D 0x01 << i;

For i >=3D 8, does the shifted bit exceed the 8-bit width and get silently
truncated to 0 during the assignment?

> +	.has_grouped_sensors =3D true,
> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606150458.2506=
06-1-jerrysteve1101@gmail.com?part=3D8
