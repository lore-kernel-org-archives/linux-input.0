Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DB8635D;
	Thu, 25 Jun 2026 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353596; cv=none; b=i5dKb0wccJNQ4PgvHJJN9T14mxmuYd/PLX5G7HHXalDBoc7HNe7nHI6bt0Km1VLm0Px2qmW+ul0DmyVWFXd7N9B/I2xgWLQ2/FQyeTf4UUQ7zvd6bORX1K4vgG8mfl+WisY9HKQAknqORcjprXCPtz1CFnVwoRAtCe61l1B0Soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353596; c=relaxed/simple;
	bh=A/bk+BmVPxTlTnVBMX3+8zkaoz6NSLxYPhgt8RIiixg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o0QmQkhPjikpV4KimcW0POovnPCAleCyuvfL//YXUi6VWBASCWK6ITA9/deVIV6n3DXNK1DIuxPwcgM5wr2XfWpPuXEdJzH78HrLmzXsKQhqpR3xJKupfP/5zmlXurbDxEcgQlS37XvvW70uYifoY9aqMg4+WLj/hyxT8oW1NsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em99h2x9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em99h2x9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630C71F000E9;
	Thu, 25 Jun 2026 02:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782353594;
	bh=kuFblr0RxLHi4JE/kUad6uvBVgCfZrXmoX6TXIKPO9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=em99h2x9McR6cNazQV9jBWeZF8SzXuTHkZrr+OXcv6X70zIw+zC5WmLwxkhrShi1G
	 wdpER6W0Nvu+/fRF4xGSOXm6QD4uXCCb/Hl3rt+R2JPnTDbCVj/X/fKHeRR3VsrpnT
	 teHfQeyFHpGdBVxezSteCnLEIUP3ZRH55vnnEFpiREeULRAvFZ7nrYOuZjYB9msxX5
	 fOd2iP+ggtbY/ueDS+sBDGsirGq9Lsm6IzJPlzqzPyZ81UfLa+ptTKLOhMWhiA0j7+
	 CpNo+Px/ynMLLQT2OM55XsvXIFbRlw7KFhmjjUNjqQGmhkDWL9VKtJdu6SaKSg82ZC
	 zjavziGR3Z1Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] input: misc: Add Qualcomm SPMI PMIC haptics
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260624-qcom-spmi-haptics-v2-3-b9118e60f3e3@oss.qualcomm.com>
References: <20260624-qcom-spmi-haptics-v2-0-b9118e60f3e3@oss.qualcomm.com>
 <20260624-qcom-spmi-haptics-v2-3-b9118e60f3e3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 02:13:14 +0000
Message-Id: <20260625021314.630C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Concurrent effect uploads or erasures free `fifo_data` while it is=
 actively used by the playback worker or IRQ handler, leading to a Use-Afte=
r-Free.
- [High] System suspend races with the asynchronous playback worker, leavin=
g the hardware active during sleep and leaking a PM runtime reference.
- [High] Incorrect teardown ordering allows userspace to trigger Use-After-=
Free of driver structures after removal.
- [High] The driver fails to terminate FIFO playback when finished, permane=
ntly leaking a PM runtime reference.
- [Medium] Unbounded user-controlled kmalloc size allows memory exhaustion.
- [Medium] Missing signedness check on the custom play rate allows negative=
 values to bypass boundary checks.
- [Medium] Lockless, non-atomic accesses to `play_request` and `cur_effect_=
id` cause new play requests to be lost.
- [Medium] The runtime PM usage counter is leaked during device removal if =
playback is active.
--

commit 06679c85ddc3489b6ff4ed3aec7d938287e570cd
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

input: misc: Add Qualcomm SPMI PMIC haptics driver

Add an initial driver for the Qualcomm PMIH0108 PMIC haptics module,
named as HAP530_HV. This module supports several play modes, including
DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
and hardware data handling logic. Currently, the driver provides support
for two play modes using the input force-feedback framework: FF_CONSTANT
effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
waveform for FIFO mode.

> diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/=
qcom-spmi-haptics.c
> new file mode 100644
> index 0000000000000..4b27638df9605
> --- /dev/null
> +++ b/drivers/input/misc/qcom-spmi-haptics.c

[ ... ]

> +static irqreturn_t haptics_fifo_empty_irq(int irq, void *dev_id)
> +{
> +	struct qcom_haptics *h =3D dev_id;
> +	u32 sts, to_write;
> +	int ret;
> +
> +	ret =3D regmap_read(h->regmap,
> +			  h->cfg_base + HAP_CFG_INT_RT_STS_REG, &sts);
> +	if (ret || !(sts & FIFO_EMPTY_BIT))
> +		return IRQ_HANDLED;
> +
> +	mutex_lock(&h->fifo_lock);
> +
> +	if (!h->fifo_data) {
> +		mutex_unlock(&h->fifo_lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (h->data_done) {
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +		h->fifo_data =3D NULL;
> +		h->play_request =3D false;
> +		schedule_work(&h->play_work);
> +		mutex_unlock(&h->fifo_lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Refill: write the next chunk, conservatively sized to the threshold =
*/
> +	to_write =3D min_t(u32, h->data_len - h->data_written,
> +			 h->fifo_len - FIFO_EMPTY_THRESH);
> +	haptics_write_fifo_chunk(h, &h->fifo_data[h->data_written], to_write);

[Severity: High]
Does this code dereference a freed pointer?

A userspace process can start a FIFO effect, then concurrently call=20
EVIOCSFF (to re-upload) or EVIOCRMFF (to erase) the effect.

The input core calls haptics_erase() or haptics_upload_effect(), which=20
immediately execute kfree(priv->fifo_data).

Since the IRQ handler or worker continues to use h->fifo_data under=20
h->fifo_lock, it appears it will dereference the freed memory.

> +	h->data_written +=3D to_write;
> +
> +	if (h->data_written >=3D h->data_len) {
> +		/* Last chunk enqueued; disable threshold to stop further IRQs */
> +		h->data_done =3D true;
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);

[Severity: High]
Does this fail to terminate FIFO playback when finished?

When the final chunk is written, the code sets FIFO_EMPTY_CFG_REG to 0,
disabling the empty interrupt.

Because the interrupt is disabled, the handler will never fire again to
process the h->data_done block at the start of the function. This leaves
the hardware active indefinitely and leaks the PM runtime usage counter.

> +	}
> +
> +	mutex_unlock(&h->fifo_lock);
> +	return IRQ_HANDLED;
> +}

[ ... ]

> +static int haptics_upload_effect(struct input_dev *dev,
> +				 struct ff_effect *effect,
> +				 struct ff_effect *old)
> +{
> +	struct qcom_haptics *h =3D input_get_drvdata(dev);
> +	struct qcom_haptics_effect *priv;
> +	int id =3D effect->id;
> +	u32 data_len;
> +	s16 *buf;
> +	s8 *fifo;
> +
> +	if (id < 0 || id >=3D HAPTICS_MAX_EFFECTS)
> +		return -EINVAL;
> +
> +	priv =3D &h->effects[id];
> +
> +	switch (effect->type) {
> +	case FF_CONSTANT:
> +		kfree(priv->fifo_data);
> +		priv->fifo_data =3D NULL;
> +		priv->data_len  =3D 0;
> +		priv->mode =3D HAPTICS_DIRECT_PLAY;
> +		return 0;
> +
> +	case FF_PERIODIC:
> +		if (effect->u.periodic.waveform !=3D FF_CUSTOM)
> +			return -EINVAL;
> +		/*
> +		 * Minimum 3 elements: play-rate code + vmax + at least one sample.
> +		 * No upper bound: the FIFO is refilled continuously from the IRQ
> +		 * handler, so any length of PCM data is supported.
> +		 */
> +		if (effect->u.periodic.custom_len < 3)
> +			return -EINVAL;
> +
> +		buf =3D memdup_array_user(effect->u.periodic.custom_data,
> +					effect->u.periodic.custom_len,
> +					sizeof(s16));

[Severity: Medium]
Is there a missing upper bound check on custom_len?

A local user with write access to the input device can provide a very
large custom_len, and this directly allocates kernel memory without an
upper bound, which could lead to memory exhaustion.

> +		if (IS_ERR(buf))
> +			return PTR_ERR(buf);
> +
> +		if (buf[CUSTOM_DATA_RATE_IDX] > PLAY_RATE_MAX) {

[Severity: Medium]
Can negative values bypass this boundary check?

buf is an array of signed 16-bit integers. A user passing a negative value=
=20
would bypass this check, get cast to u8 later, and be written to the
hardware registers as an out-of-bounds unsigned value.

> +			kfree(buf);
> +			return -EINVAL;
> +		}

[ ... ]

> +static int haptics_playback(struct input_dev *dev, int effect_id, int va=
l)
> +{
> +	struct qcom_haptics *h =3D input_get_drvdata(dev);
> +
> +	h->cur_effect_id =3D effect_id;
> +	h->play_request  =3D (val > 0);

[Severity: Medium]
Are play requests occasionally lost due to lockless accesses?

If the IRQ handler overwrites h->play_request to false immediately after a
new play event from userspace sets it to true here, the new request seems
to be lost. The worker will see play_request =3D=3D false and stop the
hardware instead of starting the new effect.

> +	schedule_work(&h->play_work);
> +
> +	return 0;
> +}

[ ... ]

> +static void qcom_haptics_remove(struct platform_device *pdev)
> +{
> +	struct qcom_haptics *h =3D platform_get_drvdata(pdev);
> +	int i;
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +
> +	mutex_lock(&h->play_lock);
> +	haptics_stop_locked(h);
> +	mutex_unlock(&h->play_lock);

[Severity: Medium]
Does this leak the runtime PM usage counter?

If remove is invoked while a haptics effect is actively playing,=20
h->pm_ref_held is true. This stops the hardware but does not call
pm_runtime_put_noidle(dev) to release the reference, leaving the PM
state unbalanced.

> +
> +	haptics_enable_module(h, false);
> +	cancel_work_sync(&h->play_work);
> +	for (i =3D 0; i < HAPTICS_MAX_EFFECTS; i++) {
> +		kfree(h->effects[i].fifo_data);
> +		h->effects[i].fifo_data =3D NULL;
> +	}
> +
> +	input_unregister_device(h->input);

[Severity: High]
Is it safe to tear down resources before unregistering the input device?

Because the input device is still registered and active, an unprivileged
user can concurrently issue an ioctl (like EVIOCSFF or EVIOCRMFF) on the
open event node. This could access the freed effect structures or schedule=
=20
h->play_work after they have been destroyed.

> +}

[ ... ]

> +static int qcom_haptics_suspend(struct device *dev)
> +{
> +	struct qcom_haptics *h =3D dev_get_drvdata(dev);
> +
> +	mutex_lock(&h->play_lock);
> +	haptics_stop_locked(h);
> +	if (h->pm_ref_held) {
> +		pm_runtime_put_noidle(dev);
> +		h->pm_ref_held =3D false;
> +	}
> +	mutex_unlock(&h->play_lock);

[Severity: High]
Does this system suspend race with the asynchronous playback worker?

If userspace requests playback right before system suspend, h->play_request=
=20
is set to true and play_work is scheduled.

This suspend function stops the hardware but forgets to clear
h->play_request.

When this drops the lock, play_work can execute, see play_request is still=
=20
true, and re-enable the hardware just before the system suspends.

> +
> +	cancel_work_sync(&h->play_work);
> +	return pm_runtime_force_suspend(dev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-qcom-spmi-=
haptics-v2-0-b9118e60f3e3@oss.qualcomm.com?part=3D3
