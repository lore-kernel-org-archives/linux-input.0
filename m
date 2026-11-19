Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097449;
	b=f76RXcJ5JRmr6gPWXXR1C2MKaFs+64ZY02uGenyyYMFlfGq7HdwEJurVOrTM6C672MO4
	 1yUawzoIHSjp/RV110pFKYNZi3flv+FOU6jBq79nK8AUcccYcERKXUCjtfdLaCxWiJZlC
	 xo1UWTXH3msLlurYq0vEozuuaCiV4FiY6uzD4w2dlbk+C27fE7CUKbaESYWCvX2TeEr4Y
	 ozPLzyAS37hZ79y/RBRYiPrObfycnjpFK4kwKS2Dw7/r4EfKqTOyQ3vGTQMSZj1+ahM94
	 6d7l/HjHX1wsUWgNPvfFKw/Ri50WcTD+bTcbcXXizsKbnDqbWO1GycnSTRG1rtEq6ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xtJZAwXujOkJCZHYCDZbAg3+R15iJgmLMb/QAUi1IRo=;
	b=3JbmuQExSotkO/l4JWqFNnPGOYJWEaEkX8d8jkCuSYIRzvUnCX0VpH9BvBTu3Jym5VbP
	 gC/DMm/3AKU6pti6llgbjXHJDFRl3DAULAEgnbGyHNNnm52G6kABncJmdOJDlPXzQYJt9
	 LPxpiDRvWsQULNb+jrQvP6ITThTORwhlFgDi2ICWmbpJ8MaTaoCWoLBCq7OHtZvzwte4J
	 OUzYHqK8yFtKzhqDRS93TdhKbu/EU38J5Qbe3jHcDuTd0jyBI4mU0tolrv+DUyggOVkOi
	 N3os/oiklLFbmgnHRpe5yKkYM2QanuQEmFzcYemGl91wIUyx4rH0mmc+3X70Ao8HXDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMkgH7fP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0185606A324;
	Thu, 19 Nov 2026 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMkgH7fP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D9B1F000CC;
	Thu, 19 Nov 2026 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795097449;
	bh=xtJZAwXujOkJCZHYCDZbAg3+R15iJgmLMb/QAUi1IRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZMkgH7fPtrnT3xs5c7I1omIpy9yjmCImpzRtIEwu+8ybi9TLGfT7mHgBjNyixIFD1
	 XEC4mY3JQQX7NdYx4fUjqJgP+jNqAuvxmOpbzTOq7w7UBmlQWirsd0a1/CQ/gwSdkW
	 v6KcMNO7b89l9+6kYcMFpwzffqHY9ihUW3wroPjiHdmphrzDGW6TwtYY0eREC9ERpc
	 mb9hNWcG6+Tcpr6rWv/Yj1nYU3rx9OPoeY+eTX3MpVEi5t0oqC2uW/HA3Lr9mn+zJx
	 vFMGPQlVwbC3iudJJNA5J9SdNJ8yBCIKaKUJZVCfjZq3+GTh5cZZnPA333awioLcJm
	 /eCIHHHjJcSYg==
Message-ID: <sashiko-outbox-223265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] Input - aw8695: Add driver for AW8695 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261119-aw8695_haptic_fp4_driver-v4-2-9d107334bdb2@fairphone.com>
References: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
 <20261119-aw8695_haptic_fp4_driver-v4-2-9d107334bdb2@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:10:48 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] Input: aw8695: stale haptics->level after aw8695_close() and
  suspend
- [Medium] Input: aw8695: premature enable_work() and unchecked errors
  in PM callbacks
- [Medium] Input: aw8695: uncanceled play_work on unbind causes
  use-after-free
- [Low] Input: aw8695: unlocked double-read of haptics->level in
  aw8695_play_sine()
- [Low] Input: aw8695: redundant standby call in aw8695_stop() and style
  issues
--

commit 7f7a93d83cad192aaa964a8d15cf7b36fce9d8d3
Author: Luca Weiss <luca.weiss@fairphone.com>

Input - aw8695: Add driver for AW8695 haptics

This commit adds an input force-feedback driver for the I2C-connected
Awinic AW8695 LRA haptic controller, supporting sine wave playback in RAM
mode.

> diff --git a/drivers/input/misc/aw8695.c b/drivers/input/misc/aw8695.c
> new file mode 100644
> index 0000000000000..e83bdf029def8
> --- /dev/null
> +++ b/drivers/input/misc/aw8695.c
[ ... ]
> +#define AW8695_R_SPARE_REG			0x5d
> +#define Aw8695_R_SPARE_DEFAULT			0x68
[ ... ]
> +static int aw8695_play_mode(struct aw8695_data *haptics,
> +				 enum aw8695_work_mode mode)
> +{
> +	struct device *dev =3D &haptics->client->dev;
> +	int err;
> +
> +	switch (mode) {
> +	case AW8695_STANDBY_MODE:
> +		err =3D regmap_update_bits(haptics->regmap, AW8695_SYSINTM_REG,
> +					 AW8695_SYSINTM_UVLO_OFF, AW8695_SYSINTM_UVLO_OFF);
> +		if (err)
> +			return err;
> +
> +		return regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
> +					  AW8695_SYSCTRL_WORK_MODE_MASK,
> +					  FIELD_PREP(AW8695_SYSCTRL_WORK_MODE_MASK,
> +						     AW8695_SYSCTRL_STANDBY));
> +	case AW8695_RAM_MODE:
> +		err =3D regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
> +					 AW8695_SYSCTRL_PLAY_MODE_MASK,
> +					 FIELD_PREP(AW8695_SYSCTRL_PLAY_MODE_MASK,
> +						    AW8695_SYSCTRL_PLAY_MODE_RAM));
> +		if (err)
> +			return err;
> +
> +		err =3D regmap_update_bits(haptics->regmap, AW8695_SYSCTRL_REG,
> +					 AW8695_SYSCTRL_BST_MODE_MASK,
> +					 FIELD_PREP(AW8695_SYSCTRL_BST_MODE_MASK,
> +						    AW8695_SYSCTRL_BST_MODE_BYPASS));
> +		if (err)
> +			return err;
> +
> +		return aw8695_haptic_set_active(haptics);
> +	default:
> +		dev_err(dev, "Unhandled mode: %d\n", mode);
> +		return -EINVAL;
> +	}
> +}
> +
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
> +	err =3D aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

[Severity: Low]
This isn't a bug, but in aw8695_stop(), the error branch after
regmap_read_poll_timeout() calls aw8695_play_mode(haptics,
AW8695_STANDBY_MODE) and returns err, duplicating the code right after the
if block.

Also, aw8695_play_mode() has multiple failure points and returns the
results of regmap_update_bits() and aw8695_haptic_set_active() directly
instead of checking err and returning 0 on the success path, and
Aw8695_R_SPARE_DEFAULT has a lowercase 'w'.

> +
> +static int aw8695_play_sine(struct aw8695_data *haptics)
> +{
> +	int err;
> +
> +	err =3D aw8695_stop(haptics);
> +	if (err)
> +		return err;
[ ... ]
> +	err =3D regmap_write(haptics->regmap, AW8695_DATDBG, haptics->level * 0=
x80 / 0xffff);
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
Can haptics->level remain non-zero after the hardware is stopped in
aw8695_close() or during system suspend?

aw8695_close() stops the actuator without resetting haptics->level to 0.
If the device is closed while haptics->level is non-zero (for example,
when inhibited via sysfs, or when cancel_work_sync() cancels a pending
start request), the chip enters standby while haptics->level keeps its old
magnitude.  Similarly, the ff-memless timer can still fire while suspended
and call aw8695_haptics_play(), which updates haptics->level even though
play_work is disabled.  In either case, a later request at the same
magnitude hits the haptics->level =3D=3D level check in aw8695_haptics_play=
()
and returns early without vibrating.

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

[Severity: Low]
What happens if aw8695_haptics_play() sets haptics->level to 0 while
aw8695_play_sine() is sleeping in aw8695_stop()?

aw8695_haptics_play_work() checks haptics->level without taking a local
snapshot, and aw8695_play_sine() reads haptics->level again when writing
AW8695_DATDBG.  If haptics->level becomes 0 in between, aw8695_play_sine()
writes a zero gain to AW8695_DATDBG and still enables AW8695_RAM_MODE and
AW8695_GO_ENABLE.

[ ... ]
> +static int aw8695_probe(struct i2c_client *client)
> +{
[ ... ]
> +	haptics->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(haptics->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(haptics->reset_gpio),
> +				     "Failed to get reset gpio\n");
> +
> +	INIT_WORK(&haptics->play_work, aw8695_haptics_play_work);

[Severity: Medium]
Can haptics->play_work remain pending when the driver is unbound, causing
a use-after-free in aw8695_haptics_play_work()?

haptics->play_work is initialized with INIT_WORK() rather than
devm_work_autocancel(), and the driver has no remove callback, so only
aw8695_close() cancels the work.  If an open device with an active effect
is inhibited via sysfs, input_inhibit_device() calls aw8695_close(), which
leaves haptics->level non-zero.  Unbinding the driver while inhibited runs
the following sequence:

CPU0                                  kworker
__input_unregister_device()
  ...
    input_ff_flush()
      ...
        aw8695_haptics_play()
          haptics->level =3D 0
          schedule_work(&play_work)
    input_close_device()
      /* skipped: dev->inhibited */
devres_release_all()
  kfree(haptics)
                                      aw8695_haptics_play_work()
                                        aw8695_stop(haptics)
                                          <-- use-after-free

Using devm_work_autocancel() would ensure play_work is canceled on unbind.

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
> +	haptics->level =3D 0;
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
> +	aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
> +	haptics->suspend =3D false;
> +	return 0;
> +}

[Severity: Medium]
Does calling enable_work() at the start of aw8695_resume() allow
aw8695_haptics_play_work() to run while haptics->suspend is still true?

CPU0                                  kworker
aw8695_resume()
  enable_work(&haptics->play_work)
  aw8695_haptic_set_active()
                                      aw8695_haptics_play_work()
                                        if (haptics->suspend)
                                          return;  <-- playback dropped
  aw8695_play_mode(..., STANDBY_MODE)
  haptics->suspend =3D false

Because aw8695_haptic_set_active() and aw8695_play_mode() perform sleeping
I2C transfers before haptics->suspend is cleared, any work scheduled during
resume exits early without programming the hardware and leaves
haptics->level out of sync.

Also, aw8695_resume() wakes the chip with aw8695_haptic_set_active() only
to immediately put it back into AW8695_STANDBY_MODE, and both
aw8695_suspend() and aw8695_resume() ignore the error returns from these
I2C helpers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-aw8695_hap=
tic_fp4_driver-v4-0-9d107334bdb2@fairphone.com?part=3D2
