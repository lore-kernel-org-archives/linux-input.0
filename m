Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B43AE1BD
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003693; cv=none; b=fBUVlqHvl0OM8T6LStmw+92YWfPQkJl16qVFQeyKU/xPJfRk0S4BH2+88hgdR4adboIu1UF9AHr//+ZRw73rYDkfjT2ZT03AGaENKtfP8CLqfIlHJor8YuFuWo+2k7gsLDNNrlt9fqaNTmezYz/j1cKM81uH3WN0HJsN1XHKAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003693; c=relaxed/simple;
	bh=XuDxUd54e7S1gzDUcLlMbBWYKM7Ap4ly8FFMsDkz1Hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n3lTz9gY3MBhb9+P5fEqNrP5+ePf5QoGaLLrn+AiJUQG7WGD2XwYROgFgr3NcuA2/MTfWK9QX0iWv21hQdXnE8R4PUKibloTt0SOVbdAjWuZckl/1fG33CIyWUeAw6uBtXcYQ6KwzgSUFWBMCaYXs7Xa8EITm2WfG9AGonY33dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbpvIzan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbpvIzan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E5F1F000E9;
	Mon, 17 Aug 2026 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787003691;
	bh=xMnk2wrOFk8FWss0REAVlFuLBsoZt4EOh13ujiPumYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JbpvIzan1+i8/5aABjLb2WiZiW1s/+pR8+yhMzi+K61RwNV7k3dpOq4/8daXEDPMx
	 vbwthfjISMVXT1JVK8VFAulIVRaUBvmbvAczwge81ioejriYQxEZWFr+ZWBVYl7snM
	 zfV+bpZ7IIUoQgrL0d+fXOzUdDqrtr3punbE4YoC3LD0tiBK4AkbSaWPOGOfYS8XTI
	 0kJjV5yUngKpo1GBXaYYrq9rwKX8FxBf4WtBcq2o9aiUmKN/nJSpUwLUzaBloJu651
	 jFcxBxDtpL9TKD/jInp3bbxtBrlUYG878E1AssiX6EXjGh6Irh+aLf4fH2285iO9G8
	 VmWVKn4GUT66Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] HID: wiimote: wiimote_probe with scoped cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260817213840.1053216-5-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-5-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 21:54:51 +0000
Message-Id: <20260817215451.78E5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Skipping cancellation of `init_worker` and `timer` on probe er=
ror paths due to a conditional check leads to a Use-After-Free.
- [High] Non-atomic bitwise updates to `wdata->init_state` across concurren=
t threads cause a data race, leading to lost state flags and resource leaks.

Pre-existing issues:
- [Critical] Incorrect teardown ordering in `wiimote_destroy()` cancels `qu=
eue.worker` before stopping hardware, allowing the worker to be re-queued a=
fter cancellation.
--

--- Patch [4]: [PATCH v4 4/4] HID: wiimote: wiimote_probe with scoped clean=
up ---
commit b9fae511d83189a3adfc0824b46530dbaab4dda2
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: wiimote_probe with scoped cleanup

This commit introduces scoped cleanup to the wiimote driver, adding a
new bitmask to track the probing state. It updates the probe and destroy
functions to conditionally clean up resources based on this state.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c

[ ... ]

> @@ -1751,39 +1757,56 @@ static DEFINE_IDA(wiimote_ida);
> =20
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
[ ... ]
>  	/* prevent init_worker from being scheduled again */
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock)
>  		wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
> =20
> -	cancel_work_sync(&wdata->init_worker);
> -	timer_shutdown_sync(&wdata->timer);
> +	if (wdata->init_state & WIIMOTE_PROBE_READY) {
> +		cancel_work_sync(&wdata->init_worker);
> +		timer_shutdown_sync(&wdata->timer);
> +	}

[Severity: Critical]
If probe fails after creating the sysfs nodes but before setting
WIIMOTE_PROBE_READY, can this lead to a use-after-free?

In wiimote_hid_probe(), the sysfs node for extension is created before
initialization finishes:

wiimote_hid_probe() {
        ...
        ret =3D device_create_file(&hdev->dev, &dev_attr_extension);
        ...
}

If userspace writes to this node, it can trigger wiimote_schedule(), placing
init_worker on the workqueue. If a subsequent step in probe fails,
wiimote_destroy() is called. Since WIIMOTE_PROBE_READY is not yet set, the
worker and timer cancellations are skipped, and wdata is freed while the
worker is still queued.

[ ... ]

> +	if (wdata->init_state & WIIMOTE_MODULES_LOADED)
> +		wiimote_modules_unload(wdata);
> +
>  	cancel_work_sync(&wdata->queue.worker);
> -	hid_hw_close(wdata->hdev);
> -	hid_hw_stop(wdata->hdev);
> +
> +	if (wdata->init_state & WIIMOTE_PROBE_HW_OPENED)
> +		hid_hw_close(wdata->hdev);
> +	if (wdata->init_state & WIIMOTE_PROBE_HW_STARTED)
> +		hid_hw_stop(wdata->hdev);
> =20
>  	kfree(wdata);
>  }

[Severity: Critical]
This is a pre-existing issue, but does this teardown order allow
queue.worker to be re-queued after it is cancelled?

Here, cancel_work_sync(&wdata->queue.worker) is called before hid_hw_stop().
Because the hardware is still active, incoming HID reports can trigger
wiimote_hid_event(). Event handlers can queue output commands via
wiimote_queue(), which calls schedule_work(&wdata->queue.worker).

This could place the worker back on the system workqueue just before wdata
is freed, leading to a use-after-free when the worker executes.

[ ... ]

> @@ -1834,24 +1859,10 @@ static int wiimote_hid_probe(struct hid_device *h=
dev,
> =20
>  	/* schedule device detection */
>  	wiimote_schedule(wdata);
> +	wdata->init_state |=3D WIIMOTE_PROBE_READY;
> =20
> +	retain_and_null_ptr(wdata);
>  	return 0;

[Severity: High]
Can these non-atomic bitwise updates to wdata->init_state cause data races?

Here, wiimote_schedule(wdata) queues init_worker. Immediately after, this
thread updates wdata->init_state |=3D WIIMOTE_PROBE_READY.

Concurrently, init_worker executes on another CPU and calls functions like
wiimote_modules_load(), which perform their own non-atomic updates:

wiimote_modules_load() {
        ...
        wdata->init_state |=3D WIIMOTE_MODULES_LOADED;
}

Since init_state is a u8, these non-atomic read-modify-write operations can
race. If the worker's update overwrites the probe thread's update,
WIIMOTE_PROBE_READY is lost, skipping worker cancellation during teardown.
If the probe thread overwrites the worker's update, WIIMOTE_MODULES_LOADED
is lost, potentially leaking devices on unbind.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817213840.1053=
216-1-rafael@rcpassos.me?part=3D4
