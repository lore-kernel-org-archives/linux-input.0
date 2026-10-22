Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661990;
	b=l8CH+DntCG0ciahQKLMWxyKaeK4aRWTNRnft8Z03YPaimoE6Rnsw3ZwJ6Z4Gx1CDSiFl
	 kd6TDFVm2T2Olny3/1WtEd4KNa+axojdKa+uNLICf5oWKhp6vnC1qNRh/Z2DpUVka4lIe
	 kZ9AA3/G8DWZVQCH/gAc7XWuy4o5bJIsTBVg84qnu9P1Nxqarj0MpN7W7veVGT2RqSEst
	 DPMf/TW7apmBz3A9N7jjWTq2s7otI/KQthAMVgxaDFmxdhwVFJPTkHoy2amG9y6TN7aQM
	 uNyVGcID4fKLpr1sEgYDNUsC1389jWaJGiM1z3cXUEH2EOx7MRkFht3YpLk1OPrc8Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661990;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8QPpTh6YuRjV3Ms8l0e6TcQM+oeEhpt6kvwSV24G2IU=;
	b=qOBA/nYAxaKmKCuNidUMo/wG/XJEBekp2guXxhplnSJa7hhtUtiRFAbrMw0E9hkCJojf
	 BKlaGeP79g5qAMtX6W+IhMfCYfdmfas8r4i7EKddzgISUu6i0Dop/YlJb3imFcSET2Zti
	 NGfz0tF6GA0CftAtl/SVpib8KkbXARI7YOsSg5bFwcnYM4jaZZIT5PVaJ94n9anQF4fzV
	 8wYIdJJHcY9pcio7fdYkp9eIJsrve8skQgteolOtazYjOZaCK3fGl93t5eDovM/RoWN4J
	 OujjLJMfhGIndvc3HYsf6plkpIfgjfmzHARVMEt7Ny0WfFlSH75cKY24mWXCxN0uwSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/XHCNPh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE949606A31D;
	Thu, 22 Oct 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/XHCNPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C79C1F000C1;
	Thu, 22 Oct 2026 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661989;
	bh=8QPpTh6YuRjV3Ms8l0e6TcQM+oeEhpt6kvwSV24G2IU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/XHCNPhyHJIRXO6RDtz/kP+Qcx9mh8MHCgvr31OpBMjsgTezm9AcVZ1KDoUtSsWW
	 l39vWe2a2Mxq4NZcj88M2h5Ev7jLCPDtJTS3+1YgkEkTwzhR6DfXSFEXc90WmB8RkI
	 KbcsbAd9VDksr5uD9x6MpVCIkh1RjKhX4Crv4+Y6lcw4VodmlpQq8yHUTNp1oqkpqw
	 JpitdiY//8B3xbpnuj25c5hm6CUkpMeQNle0WfnXEd3/kVKMU5NgBXeqiRvjVxGYWQ
	 6wy4iGH0bv+M+QaeKdqx11y+mCZiU0BivNULQ5OCAhHpPEnZFoHvZ7eDLid9b36e6w
	 LfEXfvrk4Q0og==
Message-ID: <sashiko-outbox-181271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 AW8695 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261022-aw8695_haptic_fp4_driver-v3-3-ac8c14377e82@fairphone.com>
References: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
 <20261022-aw8695_haptic_fp4_driver-v3-3-ac8c14377e82@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 09:39:48 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Input: aw8695: broken mode and work handling in aw8695_resume()
- [Medium] Input: aw8695: unnecessary motor stop/restart on magnitude change
--

commit c2d347c55cb0bb284bc1c38784be67d2387872b0
Author: Luca Weiss <luca.weiss@fairphone.com>

arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695 haptics

This commit adds the device tree node and pinctrl configuration for the
Awinic AW8695 haptics controller on the Fairphone 4.

> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm=
64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 5d20ad93b0c54..19ffd652b0eb8 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -707,7 +707,17 @@ vreg_l7p: ldo7 {
> =20
>  	/* PX8618 @ 26 */
>  	/* SMB1395 PMIC @ 34 */
> -	/* awinic,aw8695 @ 5a */
> +
> +	haptics@5a {
> +		compatible =3D "awinic,aw8695";
> +		reg =3D <0x5a>;
> +
> +		interrupts-extended =3D <&tlmm 85 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios =3D <&tlmm 90 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 =3D <&aw8695_int_default>, <&aw8695_reset_default>;
> +		pinctrl-names =3D "default";
> +	};

[Severity: Medium]
Enabling the haptics@5a node in
arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts binds the driver in
drivers/input/misc/aw8695.c. Could system suspend and resume cycles cause
unnecessary idle power drain and dropped haptic playback in
aw8695_suspend() and aw8695_resume()?

drivers/input/misc/aw8695.c:
static int aw8695_suspend(struct device *dev)
{
	struct aw8695_data *haptics =3D dev_get_drvdata(dev);

	if (haptics->suspend)
		return 0;

	disable_work_sync(&haptics->play_work);
	aw8695_stop(haptics);
	haptics->suspend =3D true;
	return 0;
}

static int aw8695_resume(struct device *dev)
{
	struct aw8695_data *haptics =3D dev_get_drvdata(dev);

	if (!haptics->suspend)
		return 0;

	enable_work(&haptics->play_work);
	aw8695_haptic_set_active(haptics);
	haptics->suspend =3D false;
	return 0;
}

During normal initialization in aw8695_init() and whenever playback stops
in aw8695_stop(), aw8695_play_mode() places the hardware into standby mode
and masks under-voltage lockout interrupts. aw8695_haptic_set_active() is
otherwise only called when entering ram mode right before starting
playback in aw8695_play_sine(). However, aw8695_resume() unconditionally
calls aw8695_haptic_set_active(haptics), which switches the device out of
standby into active mode and unmasks under-voltage lockout interrupts even
when no effect is playing.

In addition, if the system suspends while an effect is playing or queued
(haptics->level !=3D 0), aw8695_suspend() disables play_work and calls
aw8695_stop(haptics) without resetting haptics->level, and
aw8695_haptics_play() can also update haptics->level while play_work is
disabled. Because aw8695_resume() neither restarts playback nor resets
haptics->level to 0, a subsequent aw8695_haptics_play() call with the same
magnitude will hit:

	if (haptics->level =3D=3D level)
		return 0;

and fail to start the motor.

Furthermore, aw8695_resume() calls enable_work(&haptics->play_work) before
the sleeping regmap transfers in aw8695_haptic_set_active(haptics) and
before clearing haptics->suspend. If play_work runs during that window,
aw8695_haptics_play_work() sees haptics->suspend still set:

	if (haptics->suspend)
		return;

and drops the playback request. Both aw8695_suspend() and aw8695_resume()
also ignore the error return values from aw8695_stop() and
aw8695_haptic_set_active(). Should aw8695_suspend() and aw8695_resume()
keep the device in standby when idle, order haptics->suspend updates
around play_work properly, and handle haptics->level and error returns?

[Severity: Medium]
When userspace updates the magnitude of a playing rumble effect on
haptics@5a (for example via periodic envelope updates in
ml_effect_timer() -> ml_play_effects() -> aw8695_haptics_play()), why does
aw8695_play_sine() in drivers/input/misc/aw8695.c stop and restart the
motor without applying the new magnitude?

drivers/input/misc/aw8695.c:
static int aw8695_haptics_play(struct input_dev *dev, void *data,
			       struct ff_effect *effect)
{
	struct aw8695_data *haptics =3D input_get_drvdata(dev);
	int level;

	level =3D effect->u.rumble.strong_magnitude;
	if (!level)
		level =3D effect->u.rumble.weak_magnitude;

	if (haptics->level =3D=3D level)
		return 0;

	haptics->level =3D level;
	schedule_work(&haptics->play_work);

	return 0;
}

aw8695_haptics_play() compares the full 16-bit magnitude against
haptics->level and schedules haptics->play_work on any change between two
non-zero levels. However, aw8695_haptics_play_work() only checks
haptics->level as a boolean:

	if (haptics->level)
		err =3D aw8695_play_sine(haptics);
	else
		err =3D aw8695_stop(haptics);

And aw8695_play_sine() never writes haptics->level to a hardware gain
register, while always beginning with aw8695_stop(haptics):

static int aw8695_play_sine(struct aw8695_data *haptics)
{
	int err;

	err =3D aw8695_stop(haptics);
	if (err)
		return err;

As a result, every change between two non-zero magnitudes halts the motor,
polls up to 200 ms for standby in aw8695_stop(), and restarts the waveform
at the same fixed amplitude. Should aw8695_play_sine() program the hardware
gain from haptics->level, or should aw8695_haptics_play() avoid restarting
the motor when haptics->level is only used as an on/off state?

>  };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-aw8695_hap=
tic_fp4_driver-v3-0-ac8c14377e82@fairphone.com?part=3D3
