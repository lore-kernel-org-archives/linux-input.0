Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2D44C668
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837981; cv=none; b=lBCktEPNK/kn/lb2aG3yFFODuxT4cdWJZlh1A7EqhVEgXNX6yf4amSjC9Oj17bs4qxJrlVbpypJIeSmQTOa+lnBKRAWpEN+jiqWiZbrSlXoU4bwSClveiHJpbnDfbsZ6G7wJ7lB1NqKAVAyuN2IvrkKGr7V8+oyJSmYBZRPTcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837981; c=relaxed/simple;
	bh=u4+R3Es+ORg2XyjwhucbSb+7/QjgctwVOAj9OZGrwBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMXh7FbJgJEOTEzgLV04x2gbaVCOVyh0jazjc/A1lct8nqqN6BPIZV+GeDpmoFCJUKpAr5geg/My1mcu/k1rRKgBrnaouLwUnFKy7lDU8K7ET3/tNESw/nCDKAJhABgwqebhab1Aa47wHyIXc/e90QSL+S2iVnCkctWKERFFbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRthOORI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRthOORI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A541F00A3D;
	Tue,  4 Aug 2026 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785837979;
	bh=9ywo0QH30FZzZ7zZVkcs+vi26grNT0EvPy9kQMS29pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HRthOORIaPksXHWajcogTKOcCI5P+/sOZkiGHVourwWiahOnhl9Xp2akrN4lrHh8O
	 2Cc2W/A0D9BheKdYzYZHZJR7aEW3lSXofhCCVyrGS+mmw4g+tYyrGbJkRcYmzQtpiU
	 6oYEc/xpN+mdHWErByVItPODXRo4rH0MDvltE4axvTqr2u3C6ahMktQ8wd92mLnruG
	 d8IHlqYAWphYWlFDnrcTMIxAgcPxCM/roOSEScqgw1ZrBKG7iYkV2x/aFFIpR47uNW
	 qNEFn2yxBJnJKkZYZnInbk1LYX9Eg8rxPwGGRmcbAn9BS7hSI7vhBMEuMWfwMGsEo9
	 4O2ctMOIkWVxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc>
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:06:18 +0000
Message-Id: <20260804100619.59A541F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Global workqueues permanently disabled on inert interface removal

Pre-existing issues:
- [High] Use-After-Free on devres-managed led_classdev in probe error path
- [High] Uninitialized work struct access during early raw events
- [High] State corruption and Use-After-Free due to static global drvdata
- [High] NULL Pointer Dereference in early raw event handling
- [Medium] Out-of-Bounds Read in raw event handler
--

--- Patch [1]: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()=
 ---
commit 3701229efb152cb11ba2c2b9567116728fd2754a
Author: Shengzhuo Wei <me@cherr.cc>

HID: hid-oxp: fix UAF on pending work in remove()

The patch updates the hid-oxp driver to use disable_delayed_work_sync()
instead of cancel_delayed_work() in the remove path to prevent workers from
firing after device teardown. It also delays the initialization and arming
of the oxp_mcu_init worker in probe to prevent it from pending during a pro=
be
failure.

Link: https://lore.kernel.org/r/20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -1501,14 +1501,14 @@ static int oxp_cfg_probe(struct hid_device *hdev,=
 u16 up)
>  	drvdata.gamepad_mode =3D OXP_GP_MODE_XINPUT;
>  	drvdata.rumble_intensity =3D 5;
> =20
> -	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> -	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50)=
);
> -
>  	ret =3D devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
>  	if (ret)
>  		return dev_err_probe(&hdev->dev, ret,
>  				     "Failed to attach configuration attributes\n");
> =20
> +	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> +	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50)=
);
> +

[Severity: High]
This is a pre-existing issue, but does moving the initialization to the end
of probe widen a race window with raw events?

Since hid_hw_start() and hid_hw_open() are called earlier in oxp_hid_probe(=
),
the hardware is active and raw events can arrive before probe completes. If=
 a
device sends a status report early, oxp_hid_raw_event_gen_2() calls
mod_delayed_work() on drvdata.oxp_mcu_init.

Because the delayed work is now initialized at the very end of oxp_cfg_prob=
e(),
could an early event queue an uninitialized work item with a null function
pointer, leading to a kernel panic when the timer fires?

[Severity: High]
This is a pre-existing issue, but does the probe error path leak the pending
work if we fail earlier?

If oxp_cfg_probe() fails after devm_led_classdev_multicolor_register(), for
example during devm_device_add_group(), it returns without canceling
drvdata.oxp_rgb_queue:

oxp_cfg_probe() {
    ...
    ret =3D devm_device_add_group(drvdata.led_mc->led_cdev.dev,
                                &oxp_rgb_attr_group);
    if (ret)
        return dev_err_probe(...);
}

Since the LED class device is briefly registered, userspace or udev can
trigger oxp_rgb_brightness_set(), queueing the delayed work. When probe
returns an error, devres frees the led_classdev. Could the pending work
execute and dereference the freed device pointer?

[Severity: High]
This is a pre-existing issue, but does the driver support multiple devices
safely?

The driver uses a single static global drvdata struct to store per-device
state:

static struct oxp_hid_cfg drvdata;

In oxp_cfg_probe(), this global state is overwritten for each probed device:

oxp_cfg_probe() {
    hid_set_drvdata(hdev, &drvdata);
    mutex_init(&drvdata.cfg_mutex);
    drvdata.hdev =3D hdev;
    ...
}

If multiple OneXPlayer devices are connected, the second call will overwrite
drvdata.hdev and reinitialize cfg_mutex, destroying the mutex state for the
first device. Could unplugging one device then leave dangling pointers and
corrupted work structures for the remaining device?

[Severity: High]
This is a pre-existing issue, but could early raw events trigger a null
pointer dereference?

Because hid_hw_start() and hid_hw_open() are called before
oxp_cfg_probe(), raw events can be routed to oxp_hid_raw_event_gen_2()
before drvdata.led_mc is initialized.

Since drvdata is zero-initialized, an early event matching
OXP_FID_GEN2_STATUS_EVENT and OXP_GET_PROPERTY would access
drvdata.led_mc:

oxp_hid_raw_event_gen_2() {
    ...
    led_mc->led_cdev.brightness =3D rgb_rep->brightness / 4 *
                                  led_mc->led_cdev.max_brightness;
}

Will this dereference a null pointer if probe hasn't completed?

[Severity: Medium]
This is a pre-existing issue, but does the raw event handler verify the
report size?

The HID core passes the actual report size to the raw event handler, but
oxp_hid_raw_event() formats OXP_PACKET_SIZE bytes:

oxp_hid_raw_event() {
    ...
    dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", OXP_PACKET_SIZE, data);
}

oxp_hid_raw_event_gen_2() also accesses specific offsets like data[3] witho=
ut
checking the boundaries.

If a malicious USB device sends a short HID report, could these handlers
read beyond the allocated buffer and leak uninitialized memory to dmesg?

>  	return 0;
>  }

[ ... ]

> @@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
> =20
>  static void oxp_hid_remove(struct hid_device *hdev)
>  {
> -	cancel_delayed_work(&drvdata.oxp_rgb_queue);
> -	cancel_delayed_work(&drvdata.oxp_btn_queue);
> -	cancel_delayed_work(&drvdata.oxp_mcu_init);
> +	disable_delayed_work_sync(&drvdata.oxp_rgb_queue);
> +	disable_delayed_work_sync(&drvdata.oxp_btn_queue);
> +	disable_delayed_work_sync(&drvdata.oxp_mcu_init);

[Severity: High]
Do these calls to disable_delayed_work_sync() permanently break the workers?

Because the driver successfully binds to all interfaces of the USB device
and uses a single global drvdata structure, unbinding any inert interface
will trigger oxp_hid_remove().

Since disable_delayed_work_sync() is used, the works are disabled. However,
enable_delayed_work() is never called anywhere in the driver. Could
removing an inert interface permanently break RGB updates, button mappings,
and MCU initialization for the active gamepad interface until it is rebound?

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-oxp-fix-v2=
-1-b2d56e4c8a2c@cherr.cc?part=3D1
