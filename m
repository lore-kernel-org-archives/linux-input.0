Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E8330644;
	Wed,  5 Aug 2026 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911340; cv=none; b=bv6KQtlo7uJ3pYVEhwGUSwfTxwKAada0MJ7b5+9QsASR91VfGz4WN2FCwnMdk4BOrKE8ip0Ypa2QZRbr8IXybamx0R7xX5oYwUj6fcM4YowVTsMFi6UpinQymTLm5/Vc/suLR6e33mAelLjq83BYFzJ6eRxjM2T//SCHCSINI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911340; c=relaxed/simple;
	bh=UHMeJq21ZbBaAswiLP7bkwL+ckE7PxI2FDz+FIB8ouY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fUt0JaQvLx6xhyDKUXwFfW4yyVZxIh3Cug0maNpvmZjFmXsFP6OFHE6HdDW2t/66I32cKHVir8OkOsXHqXROO3QdT0HO4irVtL3HWHt9M7YWxpXp9w4hNF0fOfq0O8bikDAmt9ZNa/o4Ef45+9kG+/++HuybDpHHAVgBOgg8QQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVXBUdOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVXBUdOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D3B1F000E9;
	Wed,  5 Aug 2026 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785911339;
	bh=V0PWAFjHSkuZpPlaijwmUxmk82R1zOUw4XNv2WYpmyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVXBUdOB4dZXVnMLHLpGetYKmaldQ3dyaNtkgpXNQoj4WE2aJC7N+3t4GGB29A+o/
	 ZWZfAfIKPZwQT2olYP/2ClwGgU5NntbVSuJULSi1ZyyhgCacZQM1q7JA0nCIoHpwfb
	 bgkdUMM+UxSs+WA39PYiLBKkR0qT3zan7CflHZqolJcxmx0tuVreDOj4iiq88QfKkx
	 3TZmhd4WYxy6HE62VEjtIxW4Mk7bY0oqco6ZaK5JaVUmSuNAiaLwK1wZwNNt9gOC17
	 fntcSGg71HK8HobW9D6oGFwUaMlA0qkAKl47W5JhjtYaRwIKJbPnZen9IUGZc0YkxA
	 /dyVW7yt4qcew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] input: misc: Add Qualcomm SPMI PMIC haptics
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260804-qcom-spmi-haptics-v5-3-77128ebbdd2d@oss.qualcomm.com>
References: <20260804-qcom-spmi-haptics-v5-0-77128ebbdd2d@oss.qualcomm.com>
 <20260804-qcom-spmi-haptics-v5-3-77128ebbdd2d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:28:57 +0000
Message-Id: <20260805062858.67D3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Multiplexing play_work for both playback requests and duration tim=
ers causes race conditions where active effect duration timers are overwrit=
ten, leading to indefinite playback.
- [High] The driver permanently disables the playback workqueue in `qcom_ha=
ptics_close()` but lacks an `open` callback to re-enable it, rendering the =
device inoperable after the first close.
- [High] Manually disabling the hardware module in `close()` desynchronizes=
 the runtime PM state, causing subsequent playbacks to silently fail if sta=
rted quickly.
--

--- Patch [3]: [PATCH v5 3/3] input: misc: Add Qualcomm SPMI PMIC haptics d=
river ---
commit 64b23ca2ca86ee295bdc5ad669c51fb6d603b0fc
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

    input: misc: Add Qualcomm SPMI PMIC haptics driver
   =20
    Add an initial driver for the Qualcomm PMIH0108 PMIC haptics module,
    named as HAP530_HV. This module supports several play modes, including
    DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
    and hardware data handling logic. Currently, the driver provides support
    for two play modes using the input force-feedback framework: FF_CONSTANT
    effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
    waveform for FIFO mode.

diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/qc=
om-spmi-haptics.c
--- /dev/null
+++ b/drivers/input/misc/qcom-spmi-haptics.c
[ ... ]
> +static void haptics_play_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h =3D container_of(to_delayed_work(work),
> +					      struct qcom_haptics, play_work);
> +	struct haptics_play_req *req =3D haptics_dequeue_play_req(h);
> +	bool rearmed =3D false;
> +	u32 length_us;
> +	int ret;
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	if (!req) {
> +		/*
> +		 * Not a new request: the play-duration re-arm timer fired
> +		 * so stop the play
> +		 */
> +		if (h->active_effect_id !=3D -1)
> +			haptics_stop(h, false);
> +	} else if (req->play) {
> +		ret =3D haptics_start(h, req->effect_id);
> +		if (ret) {
> +			dev_err(h->dev, "play haptics failed, ret=3D%d\n", ret);
> +		} else {
> +			/*
> +			 * Re-arm the work to stop the play or advance
> +			 * to next play after the play duration
> +			 */
> +			length_us =3D h->effects[req->effect_id].length_us;
> +			if (length_us) {
> +				schedule_delayed_work(&h->play_work,
> +						      usecs_to_jiffies(length_us));
> +				rearmed =3D true;
> +			}
> +		}
> +	} else {
> +		if (req->effect_id =3D=3D h->active_effect_id)
> +			haptics_stop(h, false);
> +	}
> +
> +	kfree(req);
> +
> +	/* Wait for the re-arm to stop the play */
> +	if (rearmed)
> +		return;
> +
> +	/* Handle the remaining requests if the queue is not empty */
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +	if (!list_empty(&h->play_queue))
> +		schedule_delayed_work(&h->play_work, 0);
> +}

[Severity: High]
Does this code handle the active effect's stop timer correctly when a STOP
request for a different effect arrives?

If an effect is currently playing with a scheduled stop timer, and userspace
sends a STOP request for a different inactive effect, the worker sees that =
the
STOP request is for an inactive effect and drops it.

However, it appears it fails to re-arm the duration timer for the active
effect, which could result in the active effect vibrating indefinitely.

[ ... ]
> +static int haptics_playback(struct input_dev *dev, int effect_id, int va=
l)
> +{
> +	struct qcom_haptics *h =3D input_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D haptics_enqueue_play_req(h, effect_id, val > 0);
> +	if (ret)
> +		return ret;
> +
> +	if (val > 0)
> +		/*
> +		 * Queue the play.  If a duration re-arm is already pending this
> +		 * is a no-op, so the new play waits for the current effect to
> +		 * finish before the worker dequeues it.
> +		 */
> +		schedule_delayed_work(&h->play_work, 0);
> +	else
> +		/*
> +		 * Run the worker now, cancelling any pending duration re-arm,
> +		 * so an explicit stop takes effect immediately.
> +		 */
> +		mod_delayed_work(system_percpu_wq, &h->play_work, 0);
> +
> +	return 0;
> +}

[Severity: High]
Can calling mod_delayed_work() here overwrite an active duration timer?

If userspace sends a STOP request for a different inactive effect,
mod_delayed_work() is called unconditionally, cancelling the active effect's
duration timer before the worker gets a chance to process the inactive STOP
request.

[ ... ]
> +static void qcom_haptics_close(struct input_dev *input)
> +{
> +	struct qcom_haptics *h =3D input_get_drvdata(input);
> +
> +	cancel_work_sync(&h->gain_work);
> +	haptics_enable_play_work(h, false);
> +	scoped_guard(mutex, &h->play_lock) {
> +		haptics_queue_flush(h);
> +		haptics_stop(h, false);
> +	}
> +
> +	haptics_enable_module(h, false);
> +}

[Severity: High]
Does disabling play_work here permanently render the device inoperable?

When the input device is closed, haptics_enable_play_work() uses
disable_delayed_work_sync() which sets the WORK_STRUCT_DISABLE bit on the
play_work item.

Because there is no corresponding open() callback registered to re-enable i=
t,
subsequent playback requests will fail to schedule the work after the device
is opened again.

[Severity: High]
Can manually disabling the hardware module here desynchronize the runtime PM
state?

Calling haptics_enable_module() directly bypasses the PM runtime framework.
Earlier in the close sequence, haptics_stop() calls
pm_runtime_put_autosuspend() which leaves the PM state as RPM_ACTIVE for the
1000ms autosuspend delay.

If userspace reopens the device and requests playback within this window,
haptics_start() will see the device as already active and skip calling
qcom_haptics_runtime_resume(). The hardware module will remain disabled,
causing subsequent register writes to be silently ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-qcom-spmi-=
haptics-v5-0-77128ebbdd2d@oss.qualcomm.com?part=3D3
