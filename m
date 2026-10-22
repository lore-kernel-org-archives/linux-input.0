Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661743;
	b=wqzAbnKdo0Yu2qno7QoABBr9g0274PpPfhobbmxMELne/uuIjzpkyg0xK8gtYsYF2J9p
	 E55kWSbdjM7vNTjhfb8m2IYUuwbsnaBWIwGOVqmaKFDtVCngZsaIoPcqHMWpl34Zox5ev
	 stPreR6S9vUMVvHX0fG6bOQlpuOIuyl4kUFQLNXssRGpSdlLm+IOQyjYRmAsXXYcKpG22
	 waDiQrL3uVkoig3ZsAszX7HLP5J0jDTCmQCqmIgD/2k6S1/0Xg1R2FFc1cYzA7RZouSns
	 FV6u0Aac9niTbbcIV5v/Y8qkhY9KYdcvv0NS59+xevfTjSWT/hywWtOotbq3kBjdETA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rppKc8alnneBcjIkymJdxx/thSCbWLN1x/JkD151gWw=;
	b=nBTfPcCRgBj27kA+FIYDlZrUbwhZX5K/CDBhTHYcjFuHssi5BqfJmxg5dTD/MOYlVUEA
	 bgXml17PQrrSew4bTbrANGjsSmi3zKj2zl5UWH/+TCdGtX5ibzdPImvv3UvRQIG891Gy9
	 wtEqJ8QPEUFOe4R2Wut2QVvAqYZ654mdE9w6F2m9zooiVoZUmyANKaRI1s1uYTyrO06OI
	 g2il/PG7yqi+aadx9PSa2Ds3GCWzJqIArlwxmaHGFqAT+0ahCe+iXbJkuJvDJEvXTP8ne
	 bkNVUvS+ait1CfMqdlJxpF3/+sO4QLVVZK6+mDQPCFpi1YpC0yxKlE89eh0glmkiyUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUJ6G++A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE3606A31A;
	Thu, 22 Oct 2026 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUJ6G++A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8F81F000C2;
	Thu, 22 Oct 2026 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661742;
	bh=rppKc8alnneBcjIkymJdxx/thSCbWLN1x/JkD151gWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUJ6G++AKjzQ00d4/14t0XZ1YDXhgatQnnR9lDzvJ5JlVgXuVAcSNDLpme7G1ySV0
	 86qDECAgL8uG9+71djjGg/tKYOfkvZYusaaem/kdUyL7ndpNdG3oXBVnRuq3EKrvsR
	 BiA6vviaJ+Ob1rM/Q3Lv1QayCIObDsuwtGBmeoVbOxHF53TWHoJ0AJQm1RO/B5JIQ4
	 1AZmK/3KIBj8K238B267JhpqyvGACUYXU7rAujxdEaqGefoMEnmSddp16JIaDfu5u6
	 R6QrQc1EIgepcAEOaAi3UF+mNUKc/tmXEYbP+pbbF1v09THpQXv5DUB0bzRY5B4AZg
	 3x4nyL9p0uoNg==
Message-ID: <sashiko-outbox-181268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] Input - aw8695: Add driver for AW8695 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261022-aw8695_haptic_fp4_driver-v3-2-ac8c14377e82@fairphone.com>
References: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
 <20261022-aw8695_haptic_fp4_driver-v3-2-ac8c14377e82@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 09:35:41 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Input: aw8695: aw8695_play_sine() never programs haptics->level =
into hardware
- [Medium] Input: aw8695: stale haptics->level after aw8695_stop() in suspe=
nd and close
- [Medium] Input: aw8695: broken PM state and work ordering in aw8695_resum=
e()
--

commit bce746a2c97df6a59e51d7534cd56d7486fc93b8
Author: Luca Weiss <luca.weiss@fairphone.com>

Input - aw8695: Add driver for AW8695 haptics

This commit adds an input force-feedback driver for the Awinic AW8695
haptic controller using RAM mode playback of a sine wave.

> diff --git a/drivers/input/misc/aw8695.c b/drivers/input/misc/aw8695.c
> new file mode 100644
> index 0000000000000..45c68c673c26c
> --- /dev/null
> +++ b/drivers/input/misc/aw8695.c
> @@ -0,0 +1,805 @@

[ ... ]

> +static int aw8695_haptics_play(struct input_dev *dev, void *data,
> +			       struct ff_effect *effect)
> +{
> +	struct aw8695_data *haptics =3D input_get_drvdata(dev);
> +	int level;
> +
> +	level =3D effect->u.rumble.strong_magnitude;
> +	if (!level)
> +		level =3D effect->u.rumble.weak_magnitude;
> +
> +	if (haptics->level =3D=3D level)
> +		return 0;
> +
> +	haptics->level =3D level;
> +	schedule_work(&haptics->play_work);
> +
> +	return 0;
> +}

[ ... ]

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
> +	if (err)
> +		return err;
> +
> +	/* Configure for RAM mode */
> +	err =3D aw8695_play_mode(haptics, AW8695_RAM_MODE);
> +	if (err)
> +		return err;
> +
> +	/* Start vibration */
> +	err =3D regmap_update_bits(haptics->regmap, AW8695_GO_REG,
> +				 AW8695_GO_ENABLE, AW8695_GO_ENABLE);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void aw8695_close(struct input_dev *input)
> +{
> +	struct aw8695_data *haptics =3D input_get_drvdata(input);
> +	struct device *dev =3D &haptics->client->dev;
> +	int err;
> +
> +	cancel_work_sync(&haptics->play_work);
> +	err =3D aw8695_stop(haptics);
> +	if (err)
> +		dev_err(dev, "Failed to stop haptics: %d\n", err);
> +}

[Severity: Medium]
When aw8695_close() or aw8695_suspend() stops the motor via aw8695_stop(),
haptics->level is not reset to 0. Similarly, if aw8695_haptics_play() is
called while play_work is disabled during system suspend, haptics->level is
updated even though schedule_work(&haptics->play_work) does not queue the
work and aw8695_resume() does not restart playback.

If a subsequent effect is played with the same magnitude after the device is
reopened or resumed, won't aw8695_haptics_play() see haptics->level =3D=3D =
level
and return early without starting vibration?

> +
> +static void aw8695_haptics_play_work(struct work_struct *work)
> +{
> +	struct aw8695_data *haptics =3D
> +		container_of(work, struct aw8695_data, play_work);
> +	struct device *dev =3D &haptics->client->dev;
> +	int err;
> +
> +	if (haptics->suspend)
> +		return;
> +
> +	if (haptics->level)
> +		err =3D aw8695_play_sine(haptics);
> +	else
> +		err =3D aw8695_stop(haptics);
> +
> +	if (err)
> +		dev_err(dev, "Failed to execute work command: %d\n", err);
> +}

[Severity: Medium]
In aw8695_haptics_play(), the 16-bit rumble magnitude is stored in
haptics->level and play_work is scheduled whenever that value changes.
However, aw8695_haptics_play_work() only checks whether haptics->level is
non-zero, and aw8695_play_sine() never writes a scaled gain value to the
hardware.

As a result, all effects play at a fixed amplitude, and any change between
two non-zero magnitudes (for example, during an ff-memless periodic envelope
fade in ml_effect_timer() or a gain update) causes aw8695_play_sine() to ca=
ll
aw8695_stop(), poll AW8695_GLB_STATE_REG for standby, and restart the same
fixed-amplitude waveform from the beginning.

Should aw8695_play_sine() program a hardware gain register based on
haptics->level?

[ ... ]

> +static int aw8695_suspend(struct device *dev)
> +{
> +	struct aw8695_data *haptics =3D dev_get_drvdata(dev);
> +
> +	if (haptics->suspend)
> +		return 0;
> +
> +	disable_work_sync(&haptics->play_work);
> +	aw8695_stop(haptics);
> +	haptics->suspend =3D true;
> +	return 0;
> +}
> +
> +static int aw8695_resume(struct device *dev)
> +{
> +	struct aw8695_data *haptics =3D dev_get_drvdata(dev);
> +
> +	if (!haptics->suspend)
> +		return 0;
> +
> +	enable_work(&haptics->play_work);
> +	aw8695_haptic_set_active(haptics);
> +	haptics->suspend =3D false;
> +	return 0;
> +}

[Severity: Medium]
There seem to be a few issues in aw8695_suspend() and aw8695_resume():

First, during normal operation aw8695_init() and aw8695_stop() leave the
device in AW8695_STANDBY_MODE when idle, only entering AW8695_SYSCTRL_ACTIVE
via aw8695_play_mode() when aw8695_play_sine() starts playback. However,
aw8695_resume() unconditionally calls aw8695_haptic_set_active(), which puts
the chip into active mode and clears AW8695_SYSINTM_UVLO_OFF even when no
effect is playing.

Second, aw8695_resume() calls enable_work(&haptics->play_work) before the
blocking regmap accesses in aw8695_haptic_set_active() and before clearing
haptics->suspend. If play_work is scheduled and runs during that window,
aw8695_haptics_play_work() will see haptics->suspend set to true and return
early, dropping the playback request.

Third, both aw8695_suspend() and aw8695_resume() ignore the error values
returned by aw8695_stop() and aw8695_haptic_set_active().

Could aw8695_resume() avoid forcing the chip active when idle, clear
haptics->suspend before calling enable_work(), and propagate errors from the
hardware helper calls?

[ ... ]

> +}
> +
> +module_i2c_driver(aw8695_driver);
> +
> +MODULE_AUTHOR("Luca Weiss <luca.weiss@fairphone.com>");
> +MODULE_DESCRIPTION("AW8695 LRA Haptic Driver");
> +MODULE_LICENSE("GPL");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-aw8695_hap=
tic_fp4_driver-v3-0-ac8c14377e82@fairphone.com?part=3D2
