Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20522EEE84
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787519152; cv=none; b=HB4Gx0m4clBHRC4cO+fFOozBrn4j/BXEMXHKIeznAnKycyOH6n03iFdszYgnUUlAZOQjtLZfk8E5cUUt+B0Vc0xpSSvLPbaK6XWG54TuH8RsEHxgTtojbFUnJsqHP074ldifyFtCOXDXg+E8auYJ7B3aTX+7jj9bVo033e/G7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787519152; c=relaxed/simple;
	bh=XJ+fL8gxQCSGJlpKKVp8OjwI3zy4vaHLqFq6m8SwYM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iR10XifUt2Hk9O27dHZCYgcggc2uqkGCDJ2PVTsuZMKz6VKYjC3Fe85IBwc0KxmCdYr9EU90iUaqtyZKwukav7ysxoJ5st8gm+JCwMSKTH1qbqcdtJTvyLhK8xfbopRVuIXnTNe9bKw+JG/CKtZ0L7J7pppivQVQV0MnGIa6CMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzKN9veB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzKN9veB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6741F000E9;
	Sun, 23 Aug 2026 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787519150;
	bh=N4k9oigcw+uLktF9qXft0WtG1DNMht7pLVJ0LIYA1M8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzKN9veBP/Q3Uz5AmDZ54S6T6cWbXb3nn60+W0jfqX/SilvPR4UjQx4E3imIKQqXH
	 w6aABHsWgYLSqkWP99T4YjOgfnvz6YjR5b+VXJg4RWGpUxhkciv9MFjFId3GP2JIF7
	 qFNswiFYuNZ73pa6toi+jd3DTDjkN5xRNU+4KBcqiMBJndLXCwu4pUi3qUuqFgS9fo
	 2iNV0sr8HOVTQrlZ+c4xEOuXdC1DlJdarB7UZpfgIS+jtdwnDQmr8BNcWAH0soicvO
	 2ZZ5X+SraqOrImu5rQuXqu4h9FtzrewvUE594f9s2qurbfq1+H/3UjxItd6Py1e/R8
	 F9nfidC7/SDrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: hid-oxp: fix UAF on pending work in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824-oxp-fix-v3-1-599b12c91a77@cherr.cc>
References: <20260824-oxp-fix-v3-1-599b12c91a77@cherr.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 21:05:50 +0000
Message-Id: <20260823210550.BC6741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Calling `cancel_delayed_work_sync()` on uninitialized work structu=
res triggers a kernel `WARN_ON`.

Pre-existing issues:
- [Critical] Global `drvdata` leads to cross-device memory corruption and b=
roken isolation.
- [High] Missing delayed work cancellation in probe error path leads to Use=
-After-Free.
- [High] Re-arming of delayed works during and after `remove()` causes Use-=
After-Free.
- [High] Missing report size validation in raw event handlers leads to out-=
of-bounds memory read.
--

--- Patch [1]: [PATCH v3] HID: hid-oxp: fix UAF on pending work in remove()=
 ---
commit 626193303fb8331bebf2a55e5dc615127fc1f7e7
Author: Shengzhuo Wei <me@cherr.cc>

HID: hid-oxp: fix UAF on pending work in remove()

This commit addresses a use-after-free regression by changing
cancel_delayed_work() to cancel_delayed_work_sync() in oxp_hid_remove().
This ensures workers exit before the device is freed, preventing asleep
workers from waking up and dereferencing a stale hid_device.

Link: https://lore.kernel.org/r/20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc
Link: https://lore.kernel.org/r/20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 20a54f337220d..d8fb6a69d40d4 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,

[Severity: Critical]
This isn't a bug introduced by this patch, but does using a single static g=
lobal
structure for per-device state cause cross-device memory corruption?

When oxp_cfg_probe() runs for a new device, it unconditionally overwrites
drvdata.hdev, drvdata.bmap_1, and drvdata.bmap_2 with its own allocations:

oxp_cfg_probe()
    ...
    hid_set_drvdata(hdev, &drvdata);
    mutex_init(&drvdata.cfg_mutex);
    drvdata.hdev =3D hdev;
    ...
    drvdata.bmap_1 =3D bmap_1;
    drvdata.bmap_2 =3D bmap_2;

If multiple supported interfaces or gamepads are connected, won't they
clobber each other's state, leading to a use-after-free regression if one
is unbound while the other remains active?

[Severity: High]
This isn't a bug introduced by this patch, but could the probe error path l=
eak
a running delayed work?

In oxp_cfg_probe(), drvdata.oxp_mcu_init is armed via mod_delayed_work().
If subsequent initialization like devm_device_add_group() fails, it
returns an error.

The error handler in oxp_hid_probe() cleans up hardware state but doesn't
cancel the pending delayed work before returning.

Could this allow the work to run after devres frees the device memory,
causing a use-after-free regression when oxp_mcu_init_fn() dereferences
the freed pointers?

[Severity: High]
This isn't a bug introduced by this patch, but do the raw event handlers
validate the incoming report size?

In both oxp_hid_raw_event_gen_1() and oxp_hid_raw_event_gen_2(), the code
casts the buffer and reads fields like rgb_rep->effect or checks indices
like data[3] without checking the size of the incoming HID report buffer.

If a device sends a truncated report, could this result in an out-of-bounds
memory read regression?

>  static void oxp_hid_remove(struct hid_device *hdev)
>  {
> -	cancel_delayed_work(&drvdata.oxp_rgb_queue);
> -	cancel_delayed_work(&drvdata.oxp_btn_queue);
> -	cancel_delayed_work(&drvdata.oxp_mcu_init);
> +	cancel_delayed_work_sync(&drvdata.oxp_rgb_queue);
> +	cancel_delayed_work_sync(&drvdata.oxp_btn_queue);
> +	cancel_delayed_work_sync(&drvdata.oxp_mcu_init);

[Severity: High]
If a device connects and exposes a standard HID interface, oxp_hid_probe()
can return success without calling oxp_cfg_probe(), leaving the work
structures uninitialized.

When the device is disconnected, oxp_hid_remove() will unconditionally
call cancel_delayed_work_sync() on these zero-initialized structures.

Could this trigger a WARN_ON(!work->func) inside __flush_work()?

[Severity: High]
This is a pre-existing issue, but modifying these lines highlights a
regression where cancellation happens before hid_hw_stop().

Because the hardware is not stopped, incoming USB reports can still invoke
oxp_hid_raw_event_gen_2(), which unconditionally calls mod_delayed_work().

Furthermore, sysfs attributes managed by devres remain accessible to
userspace until devres cleanup occurs after remove().

Can an unprivileged user writing to sysfs (like map_button_store) or
incoming hardware events re-arm the works after this synchronization,
causing a use-after-free regression when devres frees the memory?

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-oxp-fix-v3=
-1-599b12c91a77@cherr.cc?part=3D1
