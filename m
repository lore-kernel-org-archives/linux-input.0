Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AA3955CC
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799813; cv=none; b=g4o49tlGfjA0gJ74OGe1HzbucaCYdPQ1FZfqg6UG6Ht/U5x/dDD68SP7Mz47X2sncH3L4fnDhqr9DUAiv5byI6mZjEmlrn6f8O+ayiJezSpoAoSc7QUyXR87JuUbrxhMr9+z0wq9k6HS6+ba+Oe+EypQ3PJ2Jbrt+4C80AZNavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799813; c=relaxed/simple;
	bh=N5JVoLYxxNKAKmH5YHGq1puLiQ5XfANQIJUlTrX3zGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nbgLbvaSuq7jOsBnDL4wvRu2OVdka5atwnpixoe04sa1fw6gmnzNHjLxO/Qgv/IYDxu6pIhUIu6FCwK0C7HatoLv4F3xQ5SVcCwQFTbk4URa2Ps3PuYj+2anpu+mctf7HsLcVmAFYjvsi1bUlHLCTKGCjmJkCSwCsg9WfVuMVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEzxhrZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEzxhrZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534EE1F000E9;
	Mon,  3 Aug 2026 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785799811;
	bh=X6eesYzWFF39cxJTw3ZCUPNaIveWa15GGGjlhXc06bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEzxhrZAyhfvA1GCL2a3d4bQxEHjygOkbWm3QWrpGdyxnZsCy2DRV+ETIUqcmKGfo
	 ARtSkOtmc6bqODSQI3Udquilhu/jvLls0J2vOtxHbjMgEyRMFb5Ql/qwra3cZVnrBh
	 wWvCIIQ/wzPZUWwJyIXMJufEmnnfPqBUBiCUFPsysTmRgeWEGX8Kn36D2UAgdbAojk
	 rXYCOeaFgVqI7xPSd2MKdfWMLB7lic70xS5xEZrUQKOZwfUfTO0ogd1XeFuoipuflU
	 fH6tCUs+ZSMJLU/rDsCSGVndVRY30FdlX8p7XR3N9GFV3OZw88FmV4dapgYun6NQck
	 pW4CK7V0V3/xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-oxp: fix UAF on pending work in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc>
References: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 23:30:10 +0000
Message-Id: <20260803233011.534EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The transition to `cancel_delayed_work_sync()` is ineffective beca=
use the delayed works can be immediately re-queued after cancellation, lead=
ing to the same use-after-free the patch attempts to fix.
- [High] The driver stores per-device state in a single static global `drvd=
ata` structure instead of using per-device contexts, leading to memory corr=
uption, timer list corruption, and Use-After-Free if multiple matching devi=
ces or interfaces are probed.
- [High] Delayed works are leaked and will execute on a freed `hid_device` =
if `oxp_cfg_probe()` encounters an error after arming the work.
--

--- Patch [1]: [PATCH] HID: hid-oxp: fix UAF on pending work in remove() ---
commit 9da1adfd8fd14b4d1b17ae38165e5f4aa4ff44f5
Author: Shengzhuo Wei <me@cherr.cc>

    HID: hid-oxp: fix UAF on pending work in remove()
   =20
    Drain oxp_rgb_queue, oxp_btn_queue, and oxp_mcu_init works with
    cancel_delayed_work_sync() in oxp_hid_remove() so they exit before the
    hid_device is freed.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 20a54f337220d..d8fb6a69d40d4 100644
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
This isn't a bug introduced by this patch, but is it possible for the works
to be re-armed immediately after they are cancelled here?

Since hid_hw_stop() is called after the cancellations, hardware events can
still arrive and trigger oxp_hid_raw_event_gen_2(), which could re-arm
oxp_mcu_init.

Similarly, since devres cleans up sysfs attributes and the LED class device
after remove() returns, userspace could still trigger oxp_rgb_brightness_se=
t()
and re-arm oxp_rgb_queue:

drivers/hid/hid-oxp.c:oxp_rgb_brightness_set() {
    ...
    mod_delayed_work(system_wq, &drvdata.oxp_rgb_queue, msecs_to_jiffies(50=
));
}

Could this lead to the same use-after-free this patch is attempting to fix
by allowing the works to run on a freed hid_device?

[Severity: High]
This is a pre-existing issue, but does using a single static global drvdata
structure cause memory corruption if multiple matching devices are probed?

When oxp_cfg_probe() runs, it unconditionally re-initializes the global sta=
te:

drivers/hid/hid-oxp.c:oxp_cfg_probe() {
    ...
    drvdata.hdev =3D hdev;
    ...
    INIT_DELAYED_WORK(&drvdata.oxp_rgb_queue, oxp_rgb_queue_fn);
}

If a second device (or a composite device with multiple matching interfaces)
is connected, calling INIT_DELAYED_WORK() on an already active work item
could corrupt the workqueue linked lists.

Additionally, removing one device would cancel the workers for the other
while leaving drvdata.hdev pointing to a freed device.

[Severity: High]
This is also a pre-existing issue, but does the probe error path leak the
delayed works?

In oxp_cfg_probe(), the work is armed before all resources are guaranteed to
be initialized:

drivers/hid/hid-oxp.c:oxp_cfg_probe() {
    ...
    mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50)=
);

    ret =3D devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
    if (ret)
        return dev_err_probe(...);
}

If devm_device_add_group() fails, oxp_cfg_probe() returns an error. The cal=
ler
oxp_hid_probe() handles this by calling hid_hw_close() and hid_hw_stop(), b=
ut
it does not appear to cancel the pending delayed works before the HID core
frees the device.

Will the delayed work execute on a freed hid_device when the timer expires =
in
this error scenario?

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-oxp-fix-v1=
-1-51a4fe787167@cherr.cc?part=3D1
