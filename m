Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1542252E
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520282; cv=none; b=H3KG2a4gDvnj587EotYq91JGGBM9JUK8mjpa4upEOyi6yi5p4n2FcajK9o8bAkatzwSoVSEIeSl4crX+qeyAeme8S7LtlUfXRiupXARTc6ydHLGL8Mw974iTjNQUCu7LrB1uI6UkOQKvqmadMq1dv5gJ9O2TOtUXgbE//kqj4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520282; c=relaxed/simple;
	bh=eJtek3yq7BIBxa2eXGoRCpt7LlJKn21iuQ27mYKZlAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tiCVylZ4DFKtx5mfIU/ajZ18CoWtcdnG0jQAjevinn9f+aswHZqDEdFGe1Q74upyXvvqMO4Mkk+rf6ZB/+gboFfypi/P4o7lu8j2nA8ACN4AogZUKMFACiSOrDSj2k99gYDo/w4Z+ZyDngKa1m9S7v0hQTR4IQbXW0ph2Bi34As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+qSY5FA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+qSY5FA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB621F00A3D;
	Fri,  4 Sep 2026 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520280;
	bh=ndejirZsp3d0DZFh/3vX5++YBsBDTGE5i3abMRmlg4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+qSY5FAhHX19i8ocHwZHiJiAFOG3muEuoAA2XhYM2Ublllsfh++sZgzUNRgF7f1W
	 JTQauI7dNmV/YMlpyJK+P+f+zX10zZwzAGOtFEBhtkoDkoeseG0dxcSNIf5b8BvxAu
	 vGYVhP9byH9lpp/mfSwqnrS5sB1zGlv6PBPXZ4D5Yw1wRv89ucCpT2FR2xSZIPB3tO
	 eg+jTu3j1sqtG/9Z38X0s8HijCwcTzP06uVYz0zN1iJNIRHLA3AUPDMT5tc/MDP1K8
	 NZe7lZBKS4+GQn/2A8MoZzKnX9ZxVbihMtswmyj7ZSxMu09V3pRDj4VDAbhlRCCb3u
	 psO0pyoQjdtGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904105800.3923987-1-tristmd@gmail.com>
References: <20260904105800.3923987-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:11:19 +0000
Message-Id: <20260904111120.2CB621F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The patch replaces `cancel_delayed_work()` with `cancel_delayed_wo=
rk_sync()`, which triggers a kernel warning dump when unbinding devices wit=
h unhandled usage pages.

Pre-existing issues:
- [High] The `probe()` error path fails to cancel scheduled delayed work it=
ems, leading to a Use-After-Free when they execute after device cleanup.
- [High] Improper teardown order in `remove()` allows cancelled delayed wor=
ks to be immediately re-armed by active hardware or devm-managed interfaces=
, causing Use-After-Free.
- [High] The driver stores per-device private data in a single static globa=
l struct, preventing support for multiple devices and causing cross-device =
memory corruption.
- [High] Raw event handlers unconditionally dereference `led_mc`, which can=
 be NULL due to early events or being explicitly bypassed for hybrid MCU de=
vices.
- [High] Raw event handlers blindly access report data without validating t=
he payload size, leading to out-of-bounds reads.
--

commit 950755ef4b37410fb2c6c0a59c421a32eadb69c4
Author: Tristan Madani <tristan@talencesecurity.com>

HID: hid-oxp: use cancel_delayed_work_sync() in remove
   =20
oxp_hid_remove() uses cancel_delayed_work() for all three delayed work
items.  cancel_delayed_work() only dequeues a pending work item without
waiting for a currently executing callback to finish.  If any of the
work callbacks (oxp_rgb_queue_fn, oxp_btn_queue_fn, oxp_mcu_init_fn) is
running at the time of removal, the callback continues executing
concurrently with hid_hw_close() and hid_hw_stop(), accessing the HID
device after it has been closed and stopped.
   =20
Use cancel_delayed_work_sync() instead to ensure that any in-progress
work callback completes before device teardown proceeds.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index d2ded6b08ce9e..1e691ebc1199e 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
> =20
>  static void oxp_hid_remove(struct hid_device *hdev)
>  {
> -	cancel_delayed_work(&drvdata.oxp_rgb_queue);
> -	cancel_delayed_work(&drvdata.oxp_btn_queue);
> -	cancel_delayed_work(&drvdata.oxp_mcu_init);
> +	cancel_delayed_work_sync(&drvdata.oxp_rgb_queue);
> +	cancel_delayed_work_sync(&drvdata.oxp_btn_queue);
> +	cancel_delayed_work_sync(&drvdata.oxp_mcu_init);

[Severity: High]
Will this trigger a warning if oxp_hid_probe() returns early without
initializing these work items?

If oxp_hid_probe() encounters an unknown usage page, it returns 0 without
calling oxp_cfg_probe():

drivers/hid/hid-oxp.c:oxp_hid_probe() {
    ...
    default:
        return 0;
    }
}

This leaves the global drvdata structure zero-filled and the delayed works
uninitialized. When the device is unbound, oxp_hid_remove() unconditionally
calls cancel_delayed_work_sync() on these uninitialized items.=20

Since __flush_work() triggers WARN_ON(!work->func) for zero-filled work ite=
ms,
could this cause kernel warning dumps during device removal?

[Severity: High]
This is a pre-existing issue, but does cancelling the work items before
stopping the hardware allow them to be re-armed?

Because the work items are cancelled before calling hid_hw_stop() and
before devm-managed sysfs interfaces are torn down, active hardware can
send a report to oxp_hid_raw_event_gen_2() and re-queue oxp_mcu_init.

Similarly, userspace can write to the map_button_store sysfs attribute
and re-arm oxp_btn_queue:

drivers/hid/hid-oxp.c:map_button_store() {
    ...
    mod_delayed_work(system_dfl_wq, &drvdata.oxp_btn_queue,
                     msecs_to_jiffies(50));
}

Since devres will free the backing memory after oxp_hid_remove() returns,
if a work item is re-armed during this window, could it execute after the
memory is freed and cause a use-after-free?

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the oxp_hid_probe()
error path leak scheduled workers?

During initialization in oxp_cfg_probe(), the delayed work is armed:

drivers/hid/hid-oxp.c:oxp_cfg_probe() {
    ...
    mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init,
                     msecs_to_jiffies(50));
    ...
}

If a failure occurs, the error path in oxp_hid_probe() stops the hardware
but does not cancel the work items:

drivers/hid/hid-oxp.c:oxp_hid_probe() {
    ...
    ret =3D oxp_cfg_probe(hdev, up);
    if (ret) {
        hid_hw_close(hdev);
        hid_hw_stop(hdev);
    }
    ...
}

When probe() returns the error, devres releases memory like drvdata.bmap_1.
When the delayed work executes later, will it access the freed devres
memory and cause a use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but does using a single static
global structure for driver data break support for multiple devices?

The driver stores state globally instead of allocating it per-device:

drivers/hid/hid-oxp.c:
static struct oxp_hid_cfg {
    struct delayed_work oxp_rgb_queue;
    ...
} drvdata;

Since oxp_cfg_probe() writes device-specific pointers like hdev directly to
this global structure, if multiple supported devices are connected, will
they overwrite each other's state?=20

Furthermore, if one device is removed, will its cleanup cancel the workqueu=
es
and destroy the global state used by other active devices?

[Severity: High]
This is a pre-existing issue, but can led_mc be unconditionally dereferenced
in raw event handlers before it is initialized?

In oxp_hid_probe(), the hardware is started via hid_hw_start() before
oxp_cfg_probe() initializes drvdata.led_mc. Additionally, if the device is a
hybrid MCU, initialization is explicitly bypassed:

drivers/hid/hid-oxp.c:oxp_cfg_probe() {
    ...
    if (up =3D=3D GEN2_USAGE_PAGE && oxp_hybrid_mcu_device())
        goto skip_rgb;
    ...
}

If an early event arrives, or if a hybrid MCU device sends a status event,
oxp_hid_raw_event_gen_2() accesses the pointer directly:

drivers/hid/hid-oxp.c:oxp_hid_raw_event_gen_2() {
    ...
    led_mc->led_cdev.brightness =3D rgb_rep->brightness / 4 *
                                  led_mc->led_cdev.max_brightness;
    ...
}

Will this lead to a NULL pointer dereference?

[Severity: High]
This is a pre-existing issue, but do the raw event handlers blindly access
report data without validating the size?

The raw event handler receives a data buffer and its size, but uses a
hardcoded length for debug printing:

drivers/hid/hid-oxp.c:oxp_hid_raw_event() {
    ...
    dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", OXP_PACKET_SIZE, data);
    ...
}

Then, oxp_hid_raw_event_gen_2() accesses array indices without verifying
the incoming size:

drivers/hid/hid-oxp.c:oxp_hid_raw_event_gen_2() {
    ...
    if (data[3] =3D=3D OXP_EFFECT_MONO_TRUE) {
    ...
}

If a malicious or malfunctioning device sends a short report, will this
cause an out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904105800.3923=
987-1-tristmd@gmail.com?part=3D1
