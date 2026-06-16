Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C4423A9A;
	Tue, 16 Jun 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605383; cv=none; b=cpYwMXJ2aarkKmC3FnNSp6jEPx2d87pZGy2Xv5QxaEVZ49snDTcq6g0LCJtPr9UTn8200jXnpU/rmHukSKq4qAwArMqAIPsRP+a+mEajneT1ee9QYEqEkNhrtze93NsCw07MnNXQU6uXUQcJyJfRmVWpESPcrcCc8HUfvtZLsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605383; c=relaxed/simple;
	bh=4OE0EYFNckyz80IS1w5EUqzaIcLDrP9DN85qj8QZTqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MWxa7k7s886Kob77hoYlk3YwQW2e5Qt4ziG/oSQoPYFIwEo0cSiSYyuujsuB1WaUjO5uBX19wvJwet57aH/zXLK0M2sJGKhz5LK807ST+utvgT9BaBKWYUwb+of9HMPxFEXKTaQl5fphkfkL4ecIRfJ5qizSsikfcH0FIfqDhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCNrgFGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCNrgFGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F419C1F000E9;
	Tue, 16 Jun 2026 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781605382;
	bh=Nka0yba8yFCy1A8TFu5y/t/C62LCMJHXg4caaXDfVPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JCNrgFGt03UK/vs8ZWGbEAeNN/MggcLp97CBQwsEND2hxwzFmPWsWHekZMLzkWZxX
	 0utJQkuOPNNhV7mq7ZsiEgZsn306SYCOLNbeCvVovf98ZZQDiszvXTpv9y+NHV2UZT
	 m7gC231bpf0Xs74Gu/Haf/o74a4X5lxO/kOhMn5OcgRLILw9nN/AEgj4AD0ADWi5Rq
	 6vxxrDMK1n7u679dz5hQMEtMSdMtuWXhrHcj9eKRhjJHZHoQdfqn3ZNi89CGtuESKz
	 4gnfsRCMJdvNS8AqZePgWgUK5dCo+NySguec5pV4UzYuLUKybhPF1bpsL+zlnM7Rhl
	 7WZSYWPY4eGcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] input: misc: Add Qualcomm SPMI PMIC haptics driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
References: <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:23:01 +0000
Message-Id: <20260616102301.F419C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Repeated playback requests for an actively playing effect leak run=
time PM usage counters, permanently preventing the device from suspending.
- [High] The threaded IRQ handler sleeps in atomic context by executing sle=
epable regmap operations while holding a spinlock.
- [High] Incorrect teardown ordering in `remove()` and `suspend()` allows a=
 work item to be re-queued and executed on freed memory (Use-After-Free).
- [High] Erasing or updating a force feedback effect frees the effect's dat=
a buffer synchronously, causing a Use-After-Free in the IRQ handler.
- [High] A failed memory allocation during effect upload leaves internal st=
ate corrupted, guaranteeing a NULL pointer dereference upon playback.
- [High] A lockless race condition between the input playback callback and =
the FIFO empty IRQ handler can cause new playback requests to be silently d=
ropped.
- [High] A data race on `h->cur_effect_id` allows userspace to misdirect th=
e stop sequence, leaving hardware IRQs enabled while dropping PM references.
- [Medium] Dynamically allocated custom waveform buffers are permanently le=
aked when the device is unbound.
- [Medium] Missing `abs()` on `s16` magnitude level causes massive arithmet=
ic overflow for negative effects.
- [Medium] Registering the input device before PM runtime is fully configur=
ed creates a race condition for early playback events.
--

commit 84c087855458c41a5a109b1ffb5594db116b5170
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

input: misc: Add Qualcomm SPMI PMIC haptics driver

Add an initial driver for the Qualcomm PMIH010x PMIC haptics module,
named as HAP530_HV. This module supports several play modes, including
DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
and hardware data handling logic. Currently, the driver provides support
for two play modes using the input force-feedback framework: FF_CONSTANT
effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
waveform for FIFO mode.

> diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/=
qcom-spmi-haptics.c
> new file mode 100644
> index 0000000000000..75b3e338b54eb
> --- /dev/null
> +++ b/drivers/input/misc/qcom-spmi-haptics.c
> @@ -0,0 +1,831 @@
[ ... ]
> +static int haptics_start_direct_play(struct qcom_haptics *h, int effect_=
id)
> +{
> +	struct ff_effect *ffe =3D &h->input->ff->effects[effect_id];
> +	u8 amplitude =3D (u8)((u32)ffe->u.constant.level * 255 / 0x7FFF);

[Severity: Medium]
Does this cast cause an arithmetic overflow for negative effect levels?

The ffe->u.constant.level is an s16 which can be negative to represent
opposite-direction effects. Casting a negative s16 directly to u32
sign-extends it, resulting in a large unsigned value. Multiplying this by
255 overflows the 32-bit boundary, producing a garbage amplitude for the
hardware register.

Consider taking the absolute value of the level before casting and scaling.

[ ... ]
> +static irqreturn_t haptics_fifo_empty_irq(int irq, void *dev_id)
> +{
> +	struct qcom_haptics *h =3D dev_id;
> +	unsigned long flags;
> +	u32 sts, to_write;
> +	int ret;
> +
> +	ret =3D regmap_read(h->regmap,
> +			  h->cfg_base + HAP_CFG_INT_RT_STS_REG, &sts);
> +	if (ret || !(sts & FIFO_EMPTY_BIT))
> +		return IRQ_HANDLED;
> +
> +	spin_lock_irqsave(&h->fifo_lock, flags);

[Severity: High]
Is it safe to hold a spinlock while calling sleepable regmap operations?

The haptics_write_fifo_chunk() function maps to regmap_bulk_write(). For an
SPMI PMIC, the regmap operates over a slow bus and takes a mutex to sleep
during transactions. Calling these sleepable functions while holding
fifo_lock results in a scheduling while atomic bug.

[ ... ]
> +	if (h->data_done) {
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +		h->fifo_data =3D NULL;
> +		h->play_request =3D false;
> +		schedule_work(&h->play_work);

[Severity: High]
Can a lockless race condition here cause new playback requests to be silent=
ly
dropped?

When an effect completes, this sets play_request to false. Concurrently, if=
 a
new playback request arrives, haptics_playback() sets it to true. If the IRQ
handler runs immediately after haptics_playback(), it overwrites the new tr=
ue
value with false.

When haptics_play_work() executes, it would observe play_request as false,
stop the hardware, and drop the newly queued playback request.

> +		spin_unlock_irqrestore(&h->fifo_lock, flags);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Refill: write the next chunk, conservatively sized to the threshold =
*/
> +	to_write =3D min_t(u32, h->data_len - h->data_written,
> +			 h->fifo_len - FIFO_EMPTY_THRESH);
> +	haptics_write_fifo_chunk(h, &h->fifo_data[h->data_written], to_write);

[Severity: High]
Is there a risk of a use-after-free here if an effect is erased while playi=
ng?

The input framework allows effect upload or erase to occur concurrently with
playback. In haptics_erase() and haptics_upload_effect(), the driver calls
kfree(priv->fifo_data) synchronously.

However, the stop request only schedules an asynchronous work item to stop
playback. Because the hardware stop is deferred, the hardware may still be
actively playing and asserting the FIFO-empty interrupt. The IRQ handler
will then attempt to read from the freed fifo_data.

[ ... ]
> +static void haptics_play_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h =3D container_of(work, struct qcom_haptics, play=
_work);
> +	int id, ret;
> +
> +	mutex_lock(&h->play_lock);
> +
> +	if (!h->play_request) {
> +		haptics_stop_locked(h);
> +		if (h->pm_ref_held) {
> +			pm_runtime_mark_last_busy(h->dev);
> +			pm_runtime_put_autosuspend(h->dev);
> +			h->pm_ref_held =3D false;
> +		}
> +		goto unlock;
> +	}
> +
> +	ret =3D pm_runtime_resume_and_get(h->dev);
> +	if (ret < 0) {
> +		dev_err(h->dev, "failed to resume device: %d\n", ret);
> +		goto unlock;
> +	}
> +	h->pm_ref_held =3D true;

[Severity: High]
Can this leak runtime PM usage counters?

The pm_ref_held flag is set to true without checking if it is already true.
If userspace issues multiple start events without interleaved stops (for
example, to update parameters), the PM usage counter is incremented multiple
times.

When playback is eventually stopped, the single check drops only one
reference via pm_runtime_put_autosuspend(), permanently leaking all other
references and preventing the device from suspending.

[ ... ]
> +static int haptics_upload_effect(struct input_dev *dev,
> +				 struct ff_effect *effect,
> +				 struct ff_effect *old)
> +{
[ ... ]
> +		priv->play_rate =3D (u8)buf[CUSTOM_DATA_RATE_IDX];
> +		priv->vmax_mv   =3D (u32)clamp_val(buf[CUSTOM_DATA_VMAX_IDX], 0, VMAX_=
MV_MAX);
> +		priv->data_len =3D effect->u.periodic.custom_len - CUSTOM_DATA_SAMPLE_=
START;
> +
> +		kfree(priv->fifo_data);
> +		priv->fifo_data =3D kmalloc(priv->data_len, GFP_KERNEL);
> +		if (!priv->fifo_data) {
> +			kfree(buf);
> +			return -ENOMEM;
> +		}

[Severity: High]
Could a failed memory allocation leave the internal state corrupted?

When updating an existing FF_PERIODIC effect, data_len is updated to a new
size before kmalloc() is called. If kmalloc() fails, the function returns
-ENOMEM, leaving data_len non-zero while fifo_data is NULL.

The input core keeps the existing effect ID valid. If userspace subsequently
requests to play this effect, haptics_start_fifo() computes a non-zero
init_len and passes the NULL pointer to haptics_write_fifo_chunk(), causing
a crash.

[ ... ]
> +static int haptics_playback(struct input_dev *dev, int effect_id, int va=
l)
> +{
> +	struct qcom_haptics *h =3D input_get_drvdata(dev);
> +
> +	h->cur_effect_id =3D effect_id;
> +	h->play_request  =3D (val > 0);

[Severity: High]
Could this lockless update of cur_effect_id misdirect the stop sequence?

If a FIFO effect is actively playing and userspace issues a playback request
for a different DIRECT_PLAY effect, cur_effect_id is updated asynchronously.
When play_work eventually processes the stop/start sequence,
haptics_stop_locked() checks the newly updated mode:

	if (h->effects[h->cur_effect_id].mode =3D=3D HAPTICS_FIFO) {
		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);

Seeing DIRECT_PLAY, it would skip disabling the FIFO IRQ and clearing
fifo_data, while still dropping the PM reference. The device auto-suspends,
but the IRQ remains enabled and fires spuriously.

[ ... ]
> +static int qcom_haptics_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	ff =3D input->ff;
> +	ff->upload   =3D haptics_upload_effect;
> +	ff->playback =3D haptics_playback;
> +	ff->erase    =3D haptics_erase;
> +	ff->set_gain =3D haptics_set_gain;

[Severity: Medium]
Should the ff->destroy callback be implemented to prevent memory leaks?

Custom waveform buffers are allocated using kmalloc() and stored in
fifo_data. This memory is normally freed in haptics_erase(). However, when
the driver is unbound and the input device is unregistered, the input core
destroys the ff device but does not automatically invoke erase() for
surviving effects.

Without a destroy callback to clean up the effects array, the allocated
buffers appear to be permanently leaked.

> +
> +	ret =3D input_register_device(input);
> +	if (ret) {
> +		input_ff_destroy(input);
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register input device\n");
> +	}
> +
> +	platform_set_drvdata(pdev, h);
> +
> +	/*
> +	 * Grab a reference on behalf of probe (usage_count =E2=86=92 1), mark =
the
> +	 * device active, then enable runtime PM.
> +	 */
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, HAPTICS_AUTOSUSPEND_MS);
> +	devm_pm_runtime_set_active_enabled(&pdev->dev);

[Severity: Medium]
Is there a race condition by registering the input device before PM runtime
is fully configured?

This call makes the force-feedback device immediately visible to userspace.
If an application sends a play request before the probe function finishes,
haptics_play_work() will run and call pm_runtime_resume_and_get(). Since PM
runtime is not yet fully enabled, the PM runtime API will return an error
and fail the playback.

[ ... ]
> +static void qcom_haptics_remove(struct platform_device *pdev)
> +{
> +	struct qcom_haptics *h =3D platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +
> +	cancel_work_sync(&h->play_work);
> +	mutex_lock(&h->play_lock);
> +	haptics_stop_locked(h);
> +	haptics_enable_module(h, false);
> +	mutex_unlock(&h->play_lock);
> +
> +	input_unregister_device(h->input);

[Severity: High]
Does this teardown ordering allow a work item to be re-queued and executed
on freed memory?

During driver removal, cancel_work_sync() is called before the input device
is unregistered. This creates a race window where the input device is still
visible to userspace, allowing applications to issue playback events that
call schedule_work().

Once remove() completes, the devres framework frees the qcom_haptics memory.
The mistakenly re-queued background work will then execute, dereferencing
the freed driver context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-qcom-spmi-=
haptics-v1-0-d24e422de6b4@oss.qualcomm.com?part=3D3
