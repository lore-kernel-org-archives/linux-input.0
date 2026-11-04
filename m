Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769371;
	b=eg1y2oqTG7F4KumOJhlEGEM1UZFnFp9AC41xW91E2fBcO3YA4re/8sDtxL9TD1REKWGN
	 YWC3k967OuMYDKNFLSbeQEZIpQxBPqXWOqJ3X/yedwk10NmtTw5zkQ575zoVbaGZb3wkR
	 LKRlklo+ANTBomzX3r9tKze5A+pXDDsot/fQB50qR66fKWgMtAfgDt0dHlqXvCafwHyi0
	 5/IDKXO75cZqIT7vZ5K5o1Ez/uBIWB/L+G+tNi2g5M+qyGKIWaqk58kFSySFrHqc0cvT5
	 XAWQ2g8ITiUYjsW7aTFdjSdY0STGqqu6ImP51YXV8msrq3HWvFZfGZNeaeL+Zzc+Vbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769371;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Ak9eAsOwO7vFn5aFbQNxGssCD/R19WWBLKGleUljFo=;
	b=wjNB35LZrmtg04YC7aPLl53r0XbDZYQP1I5HzlWYgbdoBduIPDu6O1TGTrNEnDsB+Lk/
	 Q23dWtVKYsjPXY9EBtlsuKY+ng0CfUeQP9S/OVSApR+9Z1hJuQBjgWM74WF4FYoVJkWOV
	 XCbVUurVxktvn+9aYW299ISAxNlrC0KBFFgoxZKsR7jUidLJERPPlUZIuUYr+zNGvMemh
	 NtDz4oVw7JmwuWjD0dd4/zXDebamfK2BJbmxmlL4YWiHID+bad/L6wQJvoumTQnyx4Chp
	 dJbg2lIZb60RQV7qfMeLi3f+KmGXaBK12T4vL+F0KpCAYKpr0tOCWBcta5B+ZLxBm8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvuhvOs9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD9606A31B;
	Wed,  4 Nov 2026 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvuhvOs9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B671F000C1;
	Wed,  4 Nov 2026 05:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793769370;
	bh=0Ak9eAsOwO7vFn5aFbQNxGssCD/R19WWBLKGleUljFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvuhvOs9BWyGoG0RU6AVF8nAgl6JDeXq4fhx6X3gxGyu5LaisJ66o5rb6UEsO5yxx
	 uy7gdOkcH2WUE7YOwki2WGClB6sI2u51jxINUSPNXMSZoPNb66tvN9YwuiBZ9MtJIp
	 mTXyojiA8MDilwwrcrKoj5NrTgzmyjG1ts+dUD6cku8/Qt3dBMVblLhABoIEkKORj+
	 STy/v5M5DVqzUJHe2EmBgYpFfBwyh0zexOSeHgWvO47wQ6rX1E8rneygwnjPMh/9Ym
	 TTKf6bEh/yd08WoC3gUBoeSEOMIAhNDPRJEBRV5wLyMXc7wwbx+yLohR/imWHF+685
	 OorzcU5aXXV4A==
Message-ID: <sashiko-outbox-196672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v7 2/2] input: misc: Add Qualcomm SPMI PMIC
 haptics driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103-qcom-spmi-haptics-v7-2-418de67ef84a@oss.qualcomm.com>
References: <20261103-qcom-spmi-haptics-v7-0-418de67ef84a@oss.qualcomm.com>
 <20261103-qcom-spmi-haptics-v7-2-418de67ef84a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:16:09 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] input: qcom-spmi-haptics: race between haptics_play_work() and hap=
tics_erase()
- [Medium] input: qcom-spmi-haptics: haptics_upload_effect() ignores pendin=
g play_queue
- [Medium] input: qcom-spmi-haptics: haptics_start() stops active effect on=
 0-length play
- [Medium] input: qcom-spmi-haptics: module never enabled when CONFIG_PM is=
 disabled
- [Medium] input: qcom-spmi-haptics: in-place coalescing in haptics_enqueue=
_play_req()
- [Medium] Input: qcom-spmi-haptics: enable works after pm_runtime_force_re=
sume()
- [Medium] Input: qcom-spmi-haptics: clear fifo_data before synchronize_irq=
()
- [Medium] input: qcom-spmi-haptics: premature devres registration and inco=
mplete cleanup in qcom_haptics_cleanup()
- [Low] Input: qcom-spmi-haptics: add struct qcom_haptics kernel-doc descri=
ption
--

commit 9bdc6e8e22b52d3a790e636976b51c47c4d72435
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

input: misc: Add Qualcomm SPMI PMIC haptics driver

This commit adds a driver for the Qualcomm PMIH0108 SPMI PMIC haptics module
(HAP530_HV), supporting DIRECT_PLAY and FIFO streaming play modes through t=
he
input force-feedback framework.

> diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/=
qcom-spmi-haptics.c
> new file mode 100644
> index 0000000000000..f589ac137403a
> --- /dev/null
> +++ b/drivers/input/misc/qcom-spmi-haptics.c
> @@ -0,0 +1,1251 @@

[ ... ]

> +/**
> + * struct qcom_haptics
> + * @dev:          underlying SPMI device

[Severity: Low]
This isn't a bug, but the kernel-doc header for struct qcom_haptics is
missing the hyphen and short description after the struct name, which will
trigger a scripts/kernel-doc warning during W=3D1 builds.

[ ... ]

> +static int haptics_enqueue_play_req(struct qcom_haptics *h, int effect_i=
d, bool play)
> +{
> +	struct haptics_play_req *req;
> +
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +
> +	/*
> +	 * Coalesce with an already queued request for
> +	 * the same effect instead of appending.
> +	 */
> +	list_for_each_entry(req, &h->play_queue, node) {
> +		if (req->effect_id =3D=3D effect_id) {
> +			req->play =3D play;
> +			return 0;
> +		}
> +	}

[Severity: Medium]
When haptics_enqueue_play_req() coalesces a request with an existing entry =
in
h->play_queue, it updates req->play in place without moving the node to the
tail of the list.

If h->play_queue contains requests for two effects, such as effect 0
(play =3D false) followed by effect 1 (play =3D true), and userspace then s=
ubmits
a start request for effect 0 via haptics_playback(), updating effect 0 in
place causes haptics_play_work() to process effect 0 (play =3D true) first =
and
effect 1 (play =3D true) second. That immediately stops effect 0 and plays
effect 1, reversing the chronological order of userspace requests.

Should this call list_move_tail(&req->node, &h->play_queue) when coalescing?

[ ... ]

> +static irqreturn_t haptics_fifo_empty_irq(int irq, void *dev_id)
> +{
> +	struct qcom_haptics *h =3D dev_id;
> +	u32 sts, to_write;
> +	int err;
> +
> +	err =3D regmap_read(h->regmap,
> +			  h->cfg_base + HAP_CFG_INT_RT_STS_REG, &sts);
> +	if (err || !(sts & FIFO_EMPTY_BIT))
> +		return IRQ_NONE;
> +
> +	guard(mutex)(&h->fifo_lock);
> +
> +	if (!h->fifo_data)
> +		return IRQ_HANDLED;
> +
> +	/* Refill: write the next chunk */
> +	to_write =3D min_t(u32, h->data_len - h->data_written,
> +			 h->fifo_len - FIFO_EMPTY_THRESH);
> +	err =3D haptics_write_fifo_chunk(h, &h->fifo_data[h->data_written], to_=
write);

[ ... ]

> +static void haptics_stop(struct qcom_haptics *h, bool put_noidle)
> +{
> +	lockdep_assert_held(&h->play_lock);
> +
> +	cancel_delayed_work(&h->stop_work);
> +
> +	cfg_write(h, HAP_CFG_SPMI_PLAY_REG, 0);
> +
> +	if (h->active_mode =3D=3D HAPTICS_FIFO) {
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +		scoped_guard(mutex, &h->fifo_lock)
> +			haptics_fifo_irq_enable(h, false);
> +
> +		/*
> +		 * Wait for an in-flight FIFO-empty IRQ thread to finish before
> +		 * clearing fifo_data below, so the handler can't touch it
> +		 * after it's freed.
> +		 */
> +		synchronize_irq(h->fifo_empty_irq);
> +
> +		scoped_guard(mutex, &h->fifo_lock)
> +			h->fifo_data =3D NULL;
> +	}

[Severity: Medium]
If haptics_fifo_empty_irq() has already passed the HAP_CFG_INT_RT_STS_REG
check when haptics_stop() runs, haptics_stop() disables the IRQ under
h->fifo_lock, releases h->fifo_lock with h->fifo_data still non-NULL, and
waits in synchronize_irq().

At that point, the in-flight haptics_fifo_empty_irq() thread acquires
h->fifo_lock, sees h->fifo_data is still non-NULL, and writes up to 7936
bytes into the hardware FIFO over SPMI after playback has already been
stopped.

Since haptics_fifo_empty_irq() only accesses h->fifo_data while holding
h->fifo_lock, could h->fifo_data =3D NULL be moved into the first
scoped_guard(mutex, &h->fifo_lock) block before synchronize_irq()?

[ ... ]

> +static int haptics_start(struct qcom_haptics *h, int effect_id)
> +{
> +	struct qcom_haptics_effect *eff =3D &h->effects[effect_id];
> +	unsigned long timeout;
> +	int ret;
> +
> +	lockdep_assert_held(&h->play_lock);
> +
> +	if (h->active_effect_id !=3D -1)
> +		haptics_stop(h, false);
> +
> +	/* Ignore the play if the length is 0 */
> +	if (eff->length_ms =3D=3D 0)
> +		return 0;

[Severity: Medium]
In haptics_start(), if an effect is currently playing (h->active_effect_id =
!=3D
-1) and a start request arrives for an effect whose eff->length_ms is 0,
haptics_stop() is called before checking eff->length_ms =3D=3D 0.

Doesn't this abort the active effect instead of ignoring the zero-length pl=
ay
request?

[ ... ]

> +static void haptics_play_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h =3D container_of(to_delayed_work(work),
> +					      struct qcom_haptics, play_work);
> +	struct haptics_play_req *req =3D haptics_dequeue_play_req(h);
> +	int ret;
> +
> +	if (!req)
> +		return;
> +
> +	scoped_guard(mutex, &h->play_lock) {
> +		if (req->play) {
> +			ret =3D haptics_start(h, req->effect_id);
> +			if (ret)
> +				dev_err(h->dev, "play haptics failed, ret=3D%d\n", ret);
> +		} else if (req->effect_id =3D=3D h->active_effect_id) {
> +			haptics_stop(h, false);
> +		}
> +	}

[Severity: High]
Can haptics_play_work() race with haptics_erase() here?

haptics_play_work() calls haptics_dequeue_play_req(h) before acquiring
h->play_lock. During the window after a start request (req->play =3D=3D tru=
e) is
popped from h->play_queue and before h->play_lock is acquired, that request
is neither in h->play_queue nor reflected in h->active_effect_id.

If userspace concurrently erases the effect (via EVIOCRMFF or closing the
device), erase_effect() in ff-core calls:

  ff->playback(dev, effect_id, 0)
    -> haptics_playback()
      -> haptics_enqueue_play_req(h, effect_id, false)

Because the start request was already dequeued, the stop request cannot
coalesce with it and is appended as a new entry. When erase_effect() then
calls haptics_erase(), if haptics_erase() acquires h->play_lock first:

  haptics_erase()
    haptics_queue_remove_effect(h, effect_id); /* deletes the stop request =
*/
    if (h->active_effect_id =3D=3D effect_id)      /* false */
        haptics_stop(h, false);
    haptics_clear_effect(h, priv);

When haptics_play_work() subsequently acquires h->play_lock, it runs
haptics_start(h, req->effect_id) on the erased effect slot. That will either
stop an unrelated active effect in haptics_start(), or start playing a newly
uploaded effect if the slot was reused in the meantime.

Would dequeuing from h->play_queue inside the h->play_lock critical section
avoid this window?

[ ... ]

> +static int haptics_upload_effect(struct input_dev *dev,
> +				 struct ff_effect *effect,
> +				 struct ff_effect *old)
> +{
> +	struct qcom_haptics *h =3D input_get_drvdata(dev);
> +	struct qcom_haptics_effect *priv;
> +	int id =3D effect->id;
> +	u32 data_len, level;
> +	u64 length_us;
> +	s8 *fifo;
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	if (id < 0 || id >=3D HAPTICS_MAX_EFFECTS)
> +		return -EINVAL;
> +
> +	if (id =3D=3D h->active_effect_id) {
> +		dev_err(h->dev, "effect %d is under playing\n", id);
> +		return -EBUSY;
> +	}

[Severity: Medium]
Because haptics_playback() queues start and stop requests asynchronously to
h->play_work, how does haptics_upload_effect() interact with requests still
pending in h->play_queue?

If userspace stops an active effect via write() (value 0) and immediately
updates it via ioctl(EVIOCSFF) before haptics_play_work() runs, the stop
request is still queued in h->play_queue while h->active_effect_id is still
equal to id, causing haptics_upload_effect() to fail with -EBUSY even though
userspace already stopped the effect.

Conversely, if userspace starts an effect and immediately updates it before
haptics_play_work() runs, h->active_effect_id is not yet id, so
haptics_upload_effect() will overwrite h->effects[id] and free its FIFO
buffer while a start request for id is pending in h->play_queue.

[ ... ]

> +static void qcom_haptics_cleanup(void *data)
> +{
> +	struct qcom_haptics *h =3D data;
> +	int i;
> +
> +	cancel_work_sync(&h->gain_work);
> +	cancel_delayed_work_sync(&h->play_work);
> +	cancel_delayed_work_sync(&h->stop_work);
> +
> +	for (i =3D 0; i < HAPTICS_MAX_EFFECTS; i++)
> +		haptics_clear_effect(h, &h->effects[i]);
> +
> +	haptics_enable_module(h, false);
> +}
> +
> +static int qcom_haptics_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	ret =3D devm_add_action_or_reset(h->dev, qcom_haptics_cleanup, h);
> +	if (ret)
> +		return ret;
> +
> +	irq =3D platform_get_irq_byname(pdev, "fifo-empty");
> +	if (irq < 0)
> +		return dev_err_probe(h->dev, irq, "failed to get fifo-empty IRQ\n");
> +
> +	ret =3D devm_request_threaded_irq(h->dev, irq, NULL,
> +					haptics_fifo_empty_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					"qcom-haptics-fifo-empty", h);
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "failed to request fifo-empty IRQ\n"=
);
> +
> +	h->fifo_empty_irq =3D irq;
> +	platform_set_drvdata(pdev, h);
> +
> +	pm_runtime_use_autosuspend(h->dev);
> +	pm_runtime_set_autosuspend_delay(h->dev, HAPTICS_AUTOSUSPEND_MS);
> +	ret =3D devm_pm_runtime_enable(h->dev);
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "enable runtime PM failed\n");

[Severity: Medium]
In qcom_haptics_probe(), devm_add_action_or_reset(h->dev,
qcom_haptics_cleanup, h) is registered before devm_request_threaded_irq(),
devm_pm_runtime_enable(), and input_register_device(). Because devres unwin=
ds
in reverse order on unbind, devm_input_device_unregister(), runtime PM
disable, and IRQ release will all run before qcom_haptics_cleanup() cancels
h->gain_work, h->play_work, and h->stop_work.

In addition, if an open input device with uploaded effects was inhibited via
sysfs before unbind, devm_input_device_unregister() -> evdev_cleanup() ->
input_flush_device() -> input_ff_flush() -> erase_effect() calls
haptics_playback(dev, effect_id, 0), which queues a request and schedules
h->play_work, and input_close_device() skips calling qcom_haptics_close()
because dev->inhibited is true. When qcom_haptics_cleanup() finally runs, it
does not call haptics_queue_flush() or haptics_stop(), leaking queued
haptics_play_req entries and running work items after runtime PM and the IRQ
have already been torn down.

Should qcom_haptics_cleanup() also flush h->play_queue and stop playback, a=
nd
be ordered so work items are stopped before runtime PM and IRQ teardown?

> +
> +	input =3D devm_input_allocate_device(h->dev);

[ ... ]

> +static int qcom_haptics_runtime_suspend(struct device *dev)
> +{
> +	struct qcom_haptics *h =3D dev_get_drvdata(dev);
> +
> +	return haptics_enable_module(h, false);
> +}
> +
> +static int qcom_haptics_runtime_resume(struct device *dev)
> +{
> +	struct qcom_haptics *h =3D dev_get_drvdata(dev);
> +
> +	return haptics_enable_module(h, true);
> +}

[Severity: Medium]
haptics_enable_module(h, true) is only called from
qcom_haptics_runtime_resume(). If the kernel is built with CONFIG_PM
disabled, devm_pm_runtime_enable() and pm_runtime_resume_and_get() in
haptics_start() become no-ops that return 0 without invoking
qcom_haptics_runtime_resume(), leaving HAPTICS_EN_BIT in HAP_CFG_EN_CTL_REG
cleared and the hardware module disabled.

Should qcom_haptics_probe() enable the module (or set runtime PM active as
appropriate) so the driver works when CONFIG_PM is disabled?

> +
> +static int qcom_haptics_suspend(struct device *dev)
> +{
> +	struct qcom_haptics *h =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	cancel_work_sync(&h->gain_work);
> +	disable_delayed_work_sync(&h->play_work);
> +	disable_delayed_work_sync(&h->stop_work);
> +	scoped_guard(mutex, &h->play_lock) {
> +		haptics_queue_flush(h);
> +		haptics_stop(h, true);
> +	}
> +
> +	ret =3D pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		enable_delayed_work(&h->play_work);
> +		enable_delayed_work(&h->stop_work);
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_haptics_resume(struct device *dev)
> +{
> +	struct qcom_haptics *h =3D dev_get_drvdata(dev);
> +
> +	enable_delayed_work(&h->play_work);
> +	enable_delayed_work(&h->stop_work);
> +
> +	return pm_runtime_force_resume(dev);
> +}

[Severity: Medium]
In qcom_haptics_resume(), h->play_work and h->stop_work are re-enabled befo=
re
pm_runtime_force_resume(dev) is called.

Because pm_runtime_force_suspend() disables runtime PM on the device and
pm_runtime_force_resume() only re-enables it before returning, if
h->play_work is scheduled and runs before pm_runtime_force_resume() finishe=
s,
pm_runtime_resume_and_get() in haptics_start() will fail with -EACCES. Also,
if pm_runtime_force_resume() fails, the delayed works are left enabled on a
suspended device.

Should qcom_haptics_resume() call pm_runtime_force_resume(dev) first and on=
ly
re-enable h->play_work and h->stop_work on success?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-qcom-spmi-=
haptics-v7-0-418de67ef84a@oss.qualcomm.com?part=3D2
