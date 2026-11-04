Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798485;
	b=WkcIstPLpc44cnL/CfuK7SRRII+shlZnj8HJjVRUQ+zz8mDQifwsOdNK1b5tyw4aquC6
	 m4jmfJ20Z6u4cOpWGRc3szxDy5jQGKJp6K6RJywSWtlIl0nKIH+oW+AetV/mTyLJM3Wgx
	 GPQw+3HyXrWCWcB5hLYGFmbryUjptUws6Y0d9mNjjDMn7XpCfcFpNCIXFGmuxMcpTWWGx
	 TBCaMbhB6M3clHW7gbi3kdc3/Oakwb8WoNO7QxCL1nrdqtq2jcpRD2HXhE3v3NJNrv5+m
	 SFoc+N82PP2gUA5bV+Nx+EG0Eo/efSbVyOYGin5QfqxuO6xFAu9Kzfi04ydLe4AUkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y+vNIXZ2savNDMBxcGYhMFEaZrz2V9RzEBPejtxKbZQ=;
	b=cSJDKm9SeMJyuDrdr+UNqy4m0/X1iAaCraV8u/VY1HA11z48ilANgSLeuTha5xPEZmN4
	 adJjniTWg4yby56Gk0IEjIyjhccrY1jZjlbX2qYRn2txYZ/nGLWKJWv4Cp2jrkg3FMDbB
	 PKsB3Sav+n3nlkeJIAMyl9cJQyLgWJ6CtoLueq2pqA1tYQFr3AF4Q340n4ftnyOYlA7W5
	 nl+qpgFVz1YOJulZ7FTIjqe/1ubttw8MDiXUG0EzxMknNmsR54bt2ZI0Wpeh/Zg5aOSZy
	 sSTFyskSyMtG7CqXtbaCPA9X5JZWbbyQNFvbgkmC/dj5H+L4rE31wyvS5OGyQI4KuzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gqQ9W/6O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09227606D807;
	Wed,  4 Nov 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqQ9W/6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FCC1F00A17;
	Wed,  4 Nov 2026 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798484;
	bh=Y+vNIXZ2savNDMBxcGYhMFEaZrz2V9RzEBPejtxKbZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqQ9W/6OpPi2zdgcn6iSsaTEKioOUKVrpPTUG9PkCMJhk9xWPxHBcjRIECCoZjrQ2
	 I6+HKsz76dNuJmRdjdIt23SFwQM+bWwZ8Lv1QfzLMVgIkHzn45P8pcGAV8pEudUKcC
	 yRz0Q6kgBP2fKFTxH3IDsBEsB2CGoNj11+/IrkkuEgDIZP5J6KjnOrQPQhNafIp9Dv
	 HgUatauUBVde+zeT6s1lhSnyMPmwALpsy2sk9RjYToa13krvwkWCUDJ5CBDg1jPFtp
	 H4K8BMdpHpU+alk07AsVS2LiV9cF/14KaVd/acG4NtvkAY0TelNfYlmP8VBhF3VU1y
	 er5XwPDNDj6iA==
Message-ID: <sashiko-outbox-197333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: sdm845-shift-axolotl: Wake
 the system on a touchscreen double tap
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104-ft5x06-double-tap-v1-3-5a1bd80449cc@ixit.cz>
References: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
 <20261104-ft5x06-double-tap-v1-3-5a1bd80449cc@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:21:23 +0000
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
- [High] arm64: dts: qcom: sdm845-shift-axolotl: touchscreen wakeup gesture=
 fails with -EACCES
- [Medium] Input: edt-ft5x06: stale in_gesture_mode across non-wakeup suspe=
nd/resume
--

commit b6f2bc4fb2c1b25270ce05595064b9f93a030624
Author: David Heidelberg <david@ixit.cz>

arm64: dts: qcom: sdm845-shift-axolotl: Wake the system on a touchscreen do=
uble tap

This commit enables wakeup-source and configures the double-tap gesture to
report KEY_WAKEUP on the FocalTech FT5452 touchscreen controller in
sdm845-shift-axolotl.dts.

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm=
64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 1b0eaeafbd517..e4eef60271c55 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -509,6 +509,12 @@ touchscreen@38 {
> =20
>  		touchscreen-size-x =3D <1080>;
>  		touchscreen-size-y =3D <2160>;
> +
> +		wakeup-source;

[Severity: Medium]
Can tsdata->in_gesture_mode in drivers/input/touchscreen/edt-ft5x06.c get
out of sync with the hardware state across a non-wakeup suspend and resume
cycle when wakeup-source is enabled here?

When the touchscreen input device is closed (or inhibited) while
device_may_wakeup(dev) is true, edt_ft5x06_ts_close() calls
edt_ft5x06_ts_set_gesture_mode(tsdata, true), which programs
GESTURE_REGISTER_MASK and GESTURE_REGISTER_EN and sets
tsdata->in_gesture_mode =3D true:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_close() {
	...
	err =3D edt_ft5x06_ts_set_gesture_mode(tsdata, true);
	...
}

If userspace then disables wakeup via power/wakeup before system suspend,
edt_ft5x06_ts_suspend() sees device_may_wakeup(dev) is false and falls
through to hibernate or power off the controller (asserting reset_gpio and
disabling the vcc and iovcc regulators in EDT_PMODE_POWEROFF mode) without
clearing tsdata->in_gesture_mode:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_suspend() {
	if (device_may_wakeup(dev)) {
		/* the IRQ stays enabled, the PM core arms it as the wake source */
		if (!tsdata->gesture_input || tsdata->in_gesture_mode)
			return 0;

		return edt_ft5x06_ts_set_gesture_mode(tsdata, true);
	}
	...
}

On resume, edt_ft5x06_ts_resume() also takes the !device_may_wakeup(dev)
path, powering the controller back on and resetting it into normal touch
mode while leaving tsdata->in_gesture_mode set to true:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_resume() {
	if (device_may_wakeup(dev)) {
		if (!tsdata->in_gesture_mode)
			return 0;
		...
	}
	...
}

While the input device remains closed, wouldn't any touch interrupt cause
edt_ft5x06_ts_isr() to take the tsdata->in_gesture_mode branch and call
edt_ft5x06_ts_report_gesture() even though GESTURE_REGISTER_EN was reset to
0 in hardware, and wouldn't a subsequent wakeup-enabled suspend skip
re-programming gesture mode because tsdata->in_gesture_mode is still true?

> +
> +		event-tap-double {
> +			linux,code =3D <KEY_WAKEUP>;
> +		};

[Severity: High]
When a double-tap gesture on touchscreen@38 wakes the system from suspend,
does reading GESTURE_REGISTER_OUTPUT in edt_ft5x06_ts_report_gesture() fail
with -EACCES and drop the KEY_WAKEUP event because the parent GENI I2C
controller still has runtime PM disabled when the wakeup IRQ is retriggered?

On sdm845-shift-axolotl.dts, touchscreen@38 is a child of i2c5
(qcom,geni-i2c, handled by drivers/i2c/busses/i2c-qcom-geni.c). During
suspend, edt_ft5x06_ts_suspend() leaves tsdata->client->irq enabled when
device_may_wakeup(dev) is true:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_suspend() {
	if (device_may_wakeup(dev)) {
		/* the IRQ stays enabled, the PM core arms it as the wake source */
		if (!tsdata->gesture_input || tsdata->in_gesture_mode)
			return 0;

		return edt_ft5x06_ts_set_gesture_mode(tsdata, true);
	}
	...
}

In dpm_suspend_late(), device_suspend_late() calls pm_runtime_disable() on
the parent GENI I2C controller (gi2c->se.dev), setting power.disable_depth
to 1. In dpm_suspend_noirq(), suspend_device_irqs() -> suspend_device_irq()
sees the wakeup IRQ is still enabled, so it sets IRQD_WAKEUP_ARMED without
setting IRQD_IRQ_ENABLED_ON_SUSPEND. Next, geni_i2c_suspend_noirq() calls
pm_runtime_force_suspend(gi2c->se.dev), incrementing power.disable_depth to
2 and leaving gi2c->se.dev in RPM_SUSPENDED with power.needs_force_resume =
=3D
false.

When the double-tap gesture fires on GPIO 125 during suspend,
irq_pm_handle_wakeup() clears IRQD_WAKEUP_ARMED, marks the IRQ
IRQS_SUSPENDED | IRQS_PENDING, and increments desc->depth to 1.

During dpm_resume_noirq(), dpm_noirq_resume_devices() runs
geni_i2c_resume_noirq():

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_resume_noirq() {
	ret =3D pm_runtime_force_resume(dev);
	if (ret)
		return ret;

	i2c_mark_adapter_resumed(&gi2c->adap);
	return 0;
}

Because needs_force_resume is false and runtime_status is RPM_SUSPENDED,
pm_runtime_force_resume() does not resume gi2c->se.dev and only decrements
power.disable_depth from 2 to 1.

Still inside dpm_resume_noirq(), before dpm_resume_early() runs
device_resume_early() to re-enable runtime PM on gi2c->se.dev,
resume_device_irqs() -> resume_irq() -> __enable_irq() -> irq_startup() ->
check_irq_resend() runs for tsdata->client->irq, which immediately
retriggers the pending interrupt and wakes the threaded handler
edt_ft5x06_ts_isr() -> edt_ft5x06_ts_report_gesture():

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_report_gesture() {
	...
	err =3D regmap_read(tsdata->regmap, GESTURE_REGISTER_OUTPUT, &id);
	if (err) {
		dev_err_ratelimited(dev, "Unable to fetch gesture, error: %d\n",
				    err);
		return;
	}
	...
}

When regmap_read() -> geni_i2c_xfer() -> pm_runtime_resume_and_get() ->
rpm_resume() runs before device_resume_early() on gi2c->se.dev, doesn't
rpm_resume() fail with -EACCES because gi2c->se.dev is RPM_SUSPENDED with
power.disable_depth =3D=3D 1, causing the wakeup gesture to be lost unless
edt-ft5x06 disables tsdata->client->irq in edt_ft5x06_ts_suspend() and
re-enables it in edt_ft5x06_ts_resume()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-ft5x06-dou=
ble-tap-v1-0-5a1bd80449cc@ixit.cz?part=3D3
