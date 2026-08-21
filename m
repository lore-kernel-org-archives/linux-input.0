Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209A2DE6E6
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349825; cv=none; b=ozG9+tN4ZFUDzwtIGsQw9Ki3SQA1/oFzWIAJzlvBefZz2o64eeBxfzRkoTVQJsFAukIEN5PvQf/yStxx/CLE0mbTBLPjnB3lg243bapsV7kwX6XErA/1saOGqh2fanQMgsG7vBW4V0prGlOkWnZTwS4KvUXpTyvRVeNNH+Kf58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349825; c=relaxed/simple;
	bh=1pfh81+0GSF8oarIGJorbbRLrOphgbizDqAo3mILlow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WY+sDLB1TxcKuhrqle0qDb2xQupYEslP/Mk2rdeVevdt/ZdBU+UbH/JaAnHI7rZjAGV9VKpm8OPtWKyY91ZLhuN+zIaBxCE9d17zkzZkWFg8flPw7rvdHSYXkJCxJQtRgWbl0pwI8nr6OFOGwfefyplaGKySBXes52AeeT3Gu9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4lG/hJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4lG/hJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4491F000E9;
	Fri, 21 Aug 2026 22:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349824;
	bh=ICrrdbb8FD4tTd/3jKI9puU8McEmZSWTfOPJlY0oCu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4lG/hJAdxaB3OBRL8CNuFYuzWOS99QInBjkLBBLgMDKDcoPCYi7DWX004H2oWoTG
	 imHvendvMAA+Ilta/ZPr3raStUuDI5a2J8MvSvC14iMhhg+enNcBFmMV2TqLsgqbA0
	 5BRFLCU2fmyRbEXYVsWZB1Dve70uIIzCFpx/EXIIOXThUuhSxMVpg0t2dB6zGoGcjJ
	 F094067QopU0OXyHQVEPNsRWH4bmllozGQGGN+jTp+BPRu6UoGT4ZlUS5d+M+Fpvq1
	 Jo9N/pWD+BWHYEm82QJLOQQbuylMQITXnx1Kah5ZbxyU5HZCipbSq/OImtwjeXM3dT
	 2DR5Oz1u1Ff/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] HID: hid-lenovo-go: record calibration completion
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260821214810.87826-4-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
 <20260821214810.87826-4-mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 22:03:43 +0000
Message-Id: <20260821220344.1E4491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling pointer read when USB interface has 0 endpoints.
- [Critical] Driver uses a single global struct for device-specific state.
- [High] Missing `hid_hw_stop()` and resource cleanup in `probe()` error pa=
ths.
- [High] Early return in `remove()` omits mandatory `hid_hw_stop()`.
- [High] LED unregistration sends hardware commands after `hid_hw_stop()` h=
as been called.
- [High] Delayed work is not cancelled on probe error path, risking Use-Aft=
er-Free.
- [High] AB-BA deadlock during device removal when cleaning up sysfs groups.
- [High] AB-BA deadlock in `hid_gos_cfg_remove()` due to incorrect mutex lo=
cking order.
--

--- Patch [3]: [PATCH 3/5] HID: hid-lenovo-go: record calibration completio=
n state ---
commit 0c0b87dd6928291724bdcbfc25cdec4b399b857c
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: record calibration completion state

The firmware uses result value 0 for failure and 1 for success. The driver
stores this value directly as a state index, mapping 0 to unknown. Map the
result value to the matching failure or success state.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index a6e9a130ad417..d2d134873dd1f 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -577,17 +577,19 @@ static int hid_go_light_event(struct command_report=
 *cmd_rep)
> =20
>  static int hid_go_device_status_event(struct command_report *cmd_rep)
>  {
> +	u8 status =3D cmd_rep->data[1] ? CAL_STAT_SUCCESS : CAL_STAT_FAILURE;
> +
>  	switch (cmd_rep->device_type) {
>  	case LEFT_CONTROLLER:
>  		switch (cmd_rep->data[0]) {
>  		case CALDEV_GYROSCOPE:
> -			drvdata.gp_left_gyro_cal_status =3D cmd_rep->data[1];
> +			drvdata.gp_left_gyro_cal_status =3D status;

[Severity: Critical]
This is a pre-existing issue, but might using a single global struct for
device-specific state cause cross-device state corruption?

When multiple compatible devices are plugged in, their probes concurrently
overwrite drvdata.hdev, reinitialize the same cfg_mutex, and queue the same
delayed work:

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    hid_set_drvdata(hdev, &drvdata);
    drvdata.hdev =3D hdev;
    mutex_init(&drvdata.cfg_mutex);
    ...
}

Can this be easily triggered by physically connecting two Lenovo Go control=
lers
or via a crafted USB device presenting multiple matching interfaces?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could the probe function be
returning an error code without stopping the hardware if configuration fail=
s?

drivers/hid/hid-lenovo-go.c:hid_go_probe() {
    ...
    ret =3D hid_go_cfg_probe(hdev, id);
    if (ret)
        dev_err_probe(&hdev->dev, ret, "Failed to start configuration inter=
face\n");

    dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

    return ret;
}

If hid_go_cfg_probe() fails to create the RGB device, it returns an error:

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
    if (ret) {
        dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
        return ret;
    }
    ...
}

Does failing to clean up the manually allocated sysfs groups on this error =
path
leak them? Also, does this leave the hardware running without a bound drive=
r,
which could lead to a use-after-free when events are processed?


[Severity: High]
This is a pre-existing issue, but is the mandatory hardware stop and teardo=
wn
bypassed by the early return in the remove function?

drivers/hid/hid-lenovo-go.c:hid_go_remove() {
    ...
    int ep =3D get_endpoint_address(hdev);

    if (ep <=3D 0)
        return;

    switch (ep) {
    ...
}

If get_endpoint_address() returns <=3D 0, the mandatory hardware stop and t=
eardown
are bypassed. Since probe() successfully starts the hardware for such devic=
es,
does this leave the HID device active after unbind, causing a use-after-free
when devres releases memory?


[Severity: Critical]
This is a pre-existing issue, but are we risking an out-of-bounds memory ac=
cess
in get_endpoint_address() if the USB interface has 0 endpoints?

drivers/hid/hid-lenovo-go.c:get_endpoint_address() {
    ...
    ep =3D &intf->cur_altsetting->endpoint[0];
    if (!ep)
        return -EINVAL;
    ...
}

If a USB device declares 0 endpoints, the USB core allocates a 0-length end=
point
array. Does accessing the first endpoint here without validating bNumEndpoi=
nts
lead to an out-of-bounds memory access?


[Severity: High]
This is a pre-existing issue, but will LED unregistration attempt to send
hardware commands after the hardware has been stopped?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
    ...
    hid_hw_close(hdev);
    hid_hw_stop(hdev);
    hid_set_drvdata(hdev, NULL);
    ...
}

Since hid_hw_stop() is called here before devres automatically unregisters =
the
LED, the subsystem will issue a turn-off command via hid_go_brightness_set(=
).
Does this attempt to send an output report to the already-stopped device,
causing transport driver errors or unbind stalls?


[Severity: High]
This isn't a bug introduced by this patch, but are we leaving delayed work
active in the probe error path?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    ret =3D schedule_delayed_work(&drvdata.go_cfg_setup, msecs_to_jiffies(2=
));
    if (!ret) {
        dev_err(&hdev->dev,
                "Failed to schedule startup delayed work\n");
        return -ENODEV;
    }
    ...
}

If schedule_delayed_work() returns 0, the driver treats this as an error and
returns -ENODEV directly. Devres frees the device resources, but the delayed
work is never cancelled. Does this lead to a use-after-free when the dangli=
ng
delayed work handler executes?


[Severity: High]
This is a pre-existing issue, but could a lock inversion deadlock occur dur=
ing
device removal when cleaning up sysfs groups?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
    ...
    guard(mutex)(&drvdata.cfg_mutex);
    sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
    ...
}

hid_go_cfg_remove() acquires cfg_mutex and then waits for sysfs operations =
to
drain. Concurrently, a sysfs write acquires the active kernfs reference fir=
st
and then attempts to acquire the lock:

drivers/hid/hid-lenovo-go.c:mcu_property_out() {
    ...
    guard(mutex)(&drvdata.cfg_mutex);
    ...
}

Could a local user with sysfs write privileges trigger this deadlock during=
 a
device unplug event?


[Severity: High]
This isn't a bug introduced by this patch, but does a similar lock inversion
deadlock exist in the companion driver?

drivers/hid/hid-lenovo-go-s.c:hid_gos_cfg_remove() {
    ...
    guard(mutex)(&drvdata.cfg_mutex);
    cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
    ...
}

The cfg_mutex is acquired before cancel_delayed_work_sync() is called. If t=
he
worker is running, it will attempt to call mcu_property_out(), which blocks=
 on
acquiring the same cfg_mutex. Could this cause a deadlock during device unb=
ind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214810.8782=
6-1-mradityadash@gmail.com?part=3D3
