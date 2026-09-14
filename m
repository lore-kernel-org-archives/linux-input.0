Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BF466B63;
	Mon, 14 Sep 2026 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397746; cv=none; b=e9cu8efufevky2sheCCxS21kv/Gk7Gj2owij9qbpL/wGwguYjmqeOyFc3lam5LiKdJJZ/b2BgmV8H06Jc3rtuREX0rkUDzXwBC2Z/1cHEjhGm/43by4K1XqnkBofJ9S9n8K79oW4bt3T++kSrYKvqZkHpYJwvbjRFrS25F/FW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397746; c=relaxed/simple;
	bh=dQwK+cwCBonNIh5/ybERkDEPW83sIZmGv00AMk0lAPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j46QKe7MnGv1Ik+GDZFsG+wtarpPHDmCedYtRe14TiUIMzqU9wvbhEBJqrtlQkKJNJZ+e+Mxgsewv54USlQVcdN4Dq2PuUr46VXNRWN5niV8+Pxa6FB5DzhqDukC0Bze7CTa/vwep8JhnFo/cyPvf48nXBCy5QtxMHrIYVRYTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no/kJeTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no/kJeTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2F31F000FF;
	Mon, 14 Sep 2026 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397745;
	bh=ZMomBy+TyZUSbO8Rj6XCABV5bQgTRjD+USeZ0IM/oiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=no/kJeTe7B3eu6flXGAhF4Bdzjfrry2XfM8MpcK+wlwHCBPtO2UlbrIpuwx7S7BuA
	 zw+bZ+uEIT8c6WbDGDXFkh0S3HMQLHFEHaHlWcx/ZjT3SpYLmxLzFa3liiI0Wwuk/3
	 ZqyzVgIr9AktIOun+52SfjXm9U+me8mK59YQxiBWVNZ2OeaEMrvXdvy61QzF71l4BW
	 GUY38+0WYG3BiXG0Hv3HOI7bSrfkagAhDe83te1NkZs/sW3PYqRDGbl9UKZwq6dVkV
	 W8OlClKsT0TpMCu6U/O8ELyEVYFJ3IpD4rSRyawH/Not5kWEnfTZjV05nAp3jkU1de
	 I8idPWJdjj8dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Input - aw8695: Add driver for AW8695 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-2-156f7549149a@fairphone.com>
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
 <20260914-aw8695_haptic_fp4_driver-v1-2-156f7549149a@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:55:44 +0000
Message-Id: <20260914145544.DE2F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The haptic motor will vibrate indefinitely if the system enters =
suspend while an effect is playing, due to missing PM callbacks.
- [Low] Returning an error-producing action directly instead of using expli=
cit failure paths in functions with multiple failure points.
--

commit aaa9fe6e99ccfee800cc251fa21a6409a47045f8
Author: Luca Weiss <luca.weiss@fairphone.com>

Input - aw8695: Add driver for AW8695 haptics

Add a driver for interfacing with the Awinic AW8695 LRA Haptic Driver.
The chip supports multiple modes of which only RAM mode is implemented.

> diff --git a/drivers/input/misc/aw8695.c b/drivers/input/misc/aw8695.c
> index 0000000000000..ea72562a7c2a7
> --- /dev/null
> +++ b/drivers/input/misc/aw8695.c
> @@ -0,0 +1,753 @@

[ ... ]

> +static int aw8695_stop(struct aw8695_data *haptics)
> +{
> +	int err;
> +	unsigned int read_buf;
> +	struct device *dev =3D &haptics->client->dev;
> +
> +	err =3D regmap_update_bits(haptics->regmap, AW8695_GO_REG,
> +				 AW8695_GO_ENABLE, 0);
> +	if (err)
> +		return err;
> +
> +	err =3D regmap_read_poll_timeout(haptics->regmap, AW8695_GLB_STATE_REG,=
 read_buf,
> +			(read_buf & 0x0f) =3D=3D 0, 2000, 2000 * 100);
> +	if (err) {
> +		dev_err(dev, "Did not enter standby: %d\n	Trying to force it...\n", er=
r);
> +		err =3D aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
> +		return err;
> +	}
> +
> +	return aw8695_play_mode(haptics, AW8695_STANDBY_MODE);

[Severity: Low]
This isn't a bug, but can we use explicit error handling here instead of
directly returning the aw8695_play_mode() error code? The input subsystem
prefers checking the error and returning 0 explicitly in functions with
multiple failure points.

> +}
> +
> +static int aw8695_play_sine(struct aw8695_data *haptics)
> +{
> +	int err;
> +
> +	err =3D aw8695_stop(haptics);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Configure for waveform #1 to be played infinitely,
> +	 * and waveform #2 to not be played.
> +	 */
> +	err =3D regmap_write(haptics->regmap, AW8695_WAVSEQ1_REG, 0x1);
> +	if (err)
> +		return err;
> +
> +	err =3D regmap_write(haptics->regmap, AW8695_WAVSEQ2_REG, 0x0);
> +	if (err)
> +		return err;
> +
> +	err =3D regmap_write(haptics->regmap, AW8695_WAVLOOP1_REG,
> +			   FIELD_PREP(AW8695_WAVLOOP1_SEQ1_MASK,
> +				      AW8695_WAVLOOP_INFINITE) |
> +			   FIELD_PREP(AW8695_WAVLOOP1_SEQ2_MASK, 0));

[Severity: Medium]
Since this configures the hardware to play the waveform infinitely, it reli=
es
entirely on the software timer to stop the haptic effect. If the system ent=
ers
suspend while an effect is playing, will the haptic motor vibrate indefinit=
ely
until the system wakes up and the timer resumes?

> +	if (err)
> +		return err;
> +
> +	/* Configure for RAM mode */
> +	err =3D aw8695_play_mode(haptics, AW8695_RAM_MODE);
> +	if (err)
> +		return err;
> +
> +	/* Start vibration */
> +	return regmap_update_bits(haptics->regmap, AW8695_GO_REG,
> +				  AW8695_GO_ENABLE, AW8695_GO_ENABLE);

[Severity: Low]
This isn't a bug, but could this be converted to an explicit error check and
return 0 to match the input subsystem's preferred coding style?

[ ... ]

> +static int aw8695_init(struct aw8695_data *haptics)
> +{
> +	int err;
> +	unsigned int read_buf;
> +	struct device *dev =3D &haptics->client->dev;

[ ... ]

> +	/* bemf config */
> +	err =3D regmap_write(haptics->regmap, AW8695_BEMF_VTHH_H_REG,
> +			   FIELD_GET(AW8695_HIGH_MASK, AW8695_BEMF_UPPER_THRESHOLD));
> +	if (err)
> +		return err;
> +	err =3D regmap_write(haptics->regmap, AW8695_BEMF_VTHH_L_REG,
> +			   FIELD_GET(AW8695_LOW_MASK, AW8695_BEMF_UPPER_THRESHOLD));
> +	if (err)
> +		return err;
> +	err =3D regmap_write(haptics->regmap, AW8695_BEMF_VTHL_H_REG,
> +			   FIELD_GET(AW8695_HIGH_MASK, AW8695_BEMF_LOWER_THRESHOLD));
> +	if (err)
> +		return err;
> +	return regmap_write(haptics->regmap, AW8695_BEMF_VTHL_L_REG,
> +			    FIELD_GET(AW8695_LOW_MASK, AW8695_BEMF_LOWER_THRESHOLD));

[Severity: Low]
This isn't a bug, but should this return be expanded into an explicit error
check returning 0?

> +}
> +
> +static int aw8695_ram_init(struct aw8695_data *haptics)
> +{
> +	int err;

[ ... ]

> +	err =3D regmap_noinc_write(haptics->regmap, AW8695_RAMDATA_REG,
> +				  aw8695_sine_waveform, ARRAY_SIZE(aw8695_sine_waveform));
> +	if (err)
> +		return err;
> +
> +	/* Disable SRAM init */
> +	return regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
> +				  AW8695_SYSCTRL_RAMINIT_EN, 0);

[Severity: Low]
This isn't a bug, but should this have an explicit error check instead of
directly returning the regmap_update_bits() result?

[ ... ]

> +static struct i2c_driver aw8695_driver =3D {
> +	.driver =3D {
> +		.name =3D "aw8695",
> +		.of_match_table =3D aw8695_of_id,
> +	},
> +	.probe =3D aw8695_probe,
> +};

[Severity: Medium]
Should this driver populate pm callbacks in the driver struct? If the system
enters suspend while playing an infinitely looping waveform, the software
timer will freeze, potentially leaving the motor running indefinitely. A
suspend handler might be needed to safely stop the hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-aw8695_hap=
tic_fp4_driver-v1-0-156f7549149a@fairphone.com?part=3D2
