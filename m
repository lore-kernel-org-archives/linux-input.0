Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DF39D3EB
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246036; cv=none; b=F0msOsQgfrH1HQDU9wwSJafEySMCDAOf6eVNwexv/2IWHneKUbKeTMwgRrgdv2fBGYA1Gp85MoPHw+nasSGVx4MMCXjvL3em81sDX0i6tzACa/LmKHd8lYKm8Ek+X1i7SaNS6RXNb9w4QsMRfiW36IaMxp5UxeXJ3S44buZCYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246036; c=relaxed/simple;
	bh=rS5mkcRA8dL2KORMAS2xQ/2jI7uXDazDXb6dJJTcfps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XIQhcsGp230RQRvVhAi54gbLiEUBJzwlkqPrNXlq54Wd5wWyykM2hbbwFVp+U/dxl1on7c+kZ/CUqXevAGcGdxd2r5Ax++sGjUXi2/opEzj1OL0zB/BvrD3+s0/Fr1AsAQ/t7eDHWV3FLJNi6BmykLV4vwQeqQopCDcDhCGWVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv8wutXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv8wutXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A036C1F000E9;
	Tue,  1 Sep 2026 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788246032;
	bh=kf7WIJPTd7i8UHoUP5a7pjrVoo5PCcjfxavQowGOL1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mv8wutXhsPvGh/YzlxFzYFVD76Fq8HJGeJ7L1iniKOzpQgcsWhSluSi/J1W9rLwaF
	 TffzlxsCP9yI5IJPPgYjcEVCruLQLxCTpx60vegHwHlqVwlCCaH9YZ3XC9xIS60BJe
	 Ol3N4ybaDt9mQDuZN/Gp5yH8sMx3VHyhX/VrsIr2rcESXWnRoalSnOb/WRaaz7XFRF
	 kWMv/soZhXehAaQevHRwpOiPKtFmi5YV/y5yRJ74IuWy5AXkbeGefo2qwpydtxLgcs
	 oMq9Sc48kV6YqAjZJkae8fCZSfJvTDxnhDwCeqEk0oFYrFpRC16rpTHUkH7XrGZo3r
	 I/02m+4UNWSsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] HID: hid-lenovo-go: clear calibration status on
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <7d100dad9edf6fd6b161e361053372a732b32eb4.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
 <7d100dad9edf6fd6b161e361053372a732b32eb4.1788222001.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:00:32 +0000
Message-Id: <20260901070032.A036C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Medium] Lockless modification of calibration status causes a logical rac=
e condition and potential overwrite.

Pre-existing issues:
- [Critical] The driver uses statically allocated global structures (`drvda=
ta` and `go_cdev_rgb`) to store device state and subclass registration, inh=
erently breaking multi-device support and causing memory corruption.
- [High] Missing `hid_hw_stop()` and `hid_hw_close()` on the error path of =
`hid_go_probe()` leads to hardware state leakage and use-after-free vulnera=
bilities.
- [High] `hid_go_remove` executes an early return without calling `hid_hw_s=
top()`, violating unbind safety rules.
- [High] LED `brightness_set` callback performs sleeping operations, violat=
ing non-blocking requirements.
- [High] ABBA deadlock between `hid_go_cfg_remove()` and sysfs store/show o=
perations.
- [High] Devm-managed LED sysfs attributes race with `hid_hw_stop()` during=
 device removal (Devres LIFO Trap).
--

commit 0371c5177dfd5c9bc7267bfd295b860d0d5ae30d
Author: Aditya Dash <mradityadash@gmail.com>

    HID: hid-lenovo-go: clear calibration status on start
   =20
    A completed calibration leaves success or failure in its status file. If
    the next calibration has the same result, userspace sees no change and
    cannot tell when the new attempt starts or finishes.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index a6dec5490d179..749536e19d2d2 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c

[ ... ]

> @@ -1422,6 +1428,9 @@ static ssize_t calibrate_config_store(struct device=
 *dev,
>  		return -EINVAL;
> =20
>  	val =3D ret;
> +	if (val =3D=3D CAL_START)
> +		*cal_status =3D CAL_STAT_UNKNOWN;

[Severity: Medium]
Since this locklessly sets the calibration status to UNKNOWN in process
context, can an incoming raw HID event in interrupt context concurrently
trigger hid_go_device_status_event() and overwrite the same location?

If a status report is slightly delayed, could it overwrite the UNKNOWN state
before the new command completes?

[ ... ]

> @@ -1978,17 +1988,23 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "ru=
mble_notification",
>  static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
>  			    "rumble_notification_index");
> =20
> -static struct go_cfg_attr cal_trigg_left =3D { SET_TRIGGER_CFG };
> +static struct go_cal_cfg_attr cal_trigg_left =3D {
> +	SET_TRIGGER_CFG, &drvdata.gp_left_trigg_cal_status
> +};

[Severity: Critical]
This is a pre-existing issue, but does using a statically allocated global
structure (drvdata and go_cdev_rgb) inherently break multi-device support?

If a second compatible Lenovo Legion Go device is plugged in, won't
hid_go_cfg_probe() unconditionally overwrite the global drvdata pointer and
attempt to re-register the same static go_cdev_rgb struct into the LED
subsystem using devm, causing memory and linked list corruption?


While reviewing this code, I noticed a few pre-existing issues in functions=
 not
modified by this patch:

drivers/hid/hid-lenovo-go.c:hid_go_probe() {
    ...
	ret =3D hid_go_cfg_probe(hdev, id);
	if (ret)
		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface\n=
");

	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

	return ret;
}

[Severity: High]
This is a pre-existing issue, but does this error path propagate the failure
from hid_go_cfg_probe() without tearing down the started HID hardware?

If hid_go_cfg_probe() fails, the function propagates the error code directl=
y.
Because hid_hw_start() previously succeeded, failing to call hid_hw_stop()
and hid_hw_close() leaves the hardware active and input nodes registered wi=
th
the core while the driver's devres context is freed, leading to a resource
leak and use-after-free.

drivers/hid/hid-lenovo-go.c:hid_go_remove() {
	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;
    ...
}

[Severity: High]
This is a pre-existing issue, but does this early return skip the teardown
logic for the device, leaking the hardware state?

If get_endpoint_address() fails during device removal, it executes an early
return. However, the driver allows fallback initialization as a generic HID
device during probe even if the endpoint is not found, meaning hid_hw_start=
()
was called. Skipping hid_hw_stop() leaves the hardware and input nodes runn=
ing
after unbind.

drivers/hid/hid-lenovo-go.c:go_cdev_rgb {
    ...
	.led_cdev =3D {
		.name =3D "go:rgb:joystick_rings",
		.color =3D LED_COLOR_ID_RGB,
		.brightness =3D 0x50,
		.max_brightness =3D 0x64,
		.brightness_set =3D hid_go_brightness_set,
	},
    ...
}

[Severity: High]
This is a pre-existing issue, but does this assign a sleeping function to a
callback that must remain non-blocking?

The LED core invokes .brightness_set from atomic contexts (e.g., holding
spinlocks or from a softirq). The assigned callback invokes
mcu_property_out(), which acquires a mutex and calls
wait_for_completion_interruptible_timeout(). Should it use
brightness_set_blocking instead to avoid a kernel panic?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
    ...
	guard(mutex)(&drvdata.cfg_mutex);
	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
    ...
}

[Severity: High]
This is a pre-existing issue, but does holding the driver's main mutex while
calling sysfs_remove_groups() introduce an ABBA deadlock condition?

During device unbind, hid_go_cfg_remove() acquires drvdata.cfg_mutex and th=
en
calls sysfs_remove_groups(), which blocks waiting for any active sysfs file
operations to finish. Concurrently, a sysfs operation acquires the sysfs
active reference and calls mcu_property_out(), which blocks waiting for
drvdata.cfg_mutex.

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
    ...
}

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
    ...
	hid_hw_stop(hdev);
    ...
}

[Severity: High]
This is a pre-existing issue, but do the devm-managed LED sysfs attributes
race with hid_hw_stop() during device removal?

The driver registers the LED via devm_led_classdev_multicolor_register(),
meaning it gets unregistered strictly after the custom remove() callback
completes. However, hid_go_cfg_remove() manually executes hid_hw_stop().

This creates a window where the LED sysfs interfaces remain accessible to
userspace while the underlying hardware endpoints have been torn down. A
concurrent sysfs write could trigger an output report to a stopped hardware
device, causing a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222001.gi=
t.mradityadash@gmail.com?part=3D7
