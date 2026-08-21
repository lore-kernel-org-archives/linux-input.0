Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A92D738F
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349831; cv=none; b=al3PzzDEUYjDPJX7CQoHo55Z2v/qrMzTBN0/3UUP3ZrTluIX3jcrmgk3V/Nz8LsKF12phfzaxUvG0js4uThxTTIfYxepTlcJK3HT2cdnsiEBVA7Oy8F5+6DUDbJ1Hd74/4T8p3z/BpmY8nS41VcbmNx5Ml+N61rDvN5h6TvFeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349831; c=relaxed/simple;
	bh=4Rzxg78X+JqqoN9haAAgn23g3+5Bg/OsdDNT7l1ga3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdU82PgP9drxrqtZpf6oIPPM9Zh8DQGADdSsVPInx96LCnY1QBZYYk3NhuvUnpkq+FiRtrRI6tykiHXXlKwrE3o6NACFOUQ1nsZZu7eSrf3Zb2gaUoVsDHBapEXDL6mKqIwrm0ca360/vahRhtF0KGghx2X3yc6zvQBHiym3JSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzfxLAko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzfxLAko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69081F000E9;
	Fri, 21 Aug 2026 22:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349830;
	bh=5lSctdkRyvok0lHFLbZud8xbeXE1z3aqw+8kEi9bnGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzfxLAkoIA1RiGvTeHafJqYpveugi60m3BO/0UCcU8bTlm95eYBGVezOz1w8Dt5oA
	 j/qWui5+Xxk3WV+2u2Va3ISkqbGkV1C9dKL3wcNfDMF04q3qdkrkU++ik5aJ+4FujU
	 oVPOScEuz4D6C3cMKxCXX+jol3p4zlNLJBbRWQhej6SbvfmHSV0fZR9TjSJGoolg1A
	 +7YgYrD4qODBbXeHRdzuMYIhKZVQw0Im1AhW78uQv5y4syIpQL3tNlujRA8kp/5jAK
	 Y3nq+y1PYtNgKZKPxLYXE306Kh5rL1foTo1glTEIpauSsevGpF2Anmv95NZx4QNVc2
	 AhMfIiCgtpFkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] HID: hid-lenovo-go: use the correct calibration
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260821214810.87826-2-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
 <20260821214810.87826-2-mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 22:03:49 +0000
Message-Id: <20260821220349.D69081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver uses static global structures for device state (`drvdat=
a`) and LED device registration, breaking support for multiple devices.
- [High] Missing `hid_hw_stop()` and `hid_hw_close()` on the `hid_go_probe(=
)` error path.
- [High] Early return in `hid_go_remove()` skips hardware cleanup for inter=
faces without valid endpoints.
- [High] AB-BA deadlock between driver mutex and kernfs active protection d=
uring device removal.
- [High] The LED class device is managed by devres but the hardware is manu=
ally stopped in `remove()`, creating a use-after-free window.
- [High] `get_endpoint_address()` unconditionally reads endpoint descriptor=
s without verifying the number of endpoints.
- [Medium] Sysfs attribute groups leak on error paths in `hid_go_cfg_probe(=
)`.
- [Low] Unused memory allocation in `hid_go_cfg_probe()`.
--

--- Patch [1]: [PATCH 1/5] HID: hid-lenovo-go: use the correct calibration =
commands ---
commit 0cbce56e5fe2f7bb5d9b0dab89495451652240da
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: use the correct calibration commands

This commit fixes malformed calibration requests in the hid-lenovo-go drive=
r by
swapping the command and sub-command values for all six calibration attribu=
tes.
It reverses the previously incorrect ordering of the calibration operation =
and
configuration command.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 318b1152ff8ba..b8248bf8965c6 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -1911,18 +1911,18 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "ru=
mble_notification",
>  static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
>  			    "rumble_notification_index");
> =20
> -static struct go_cfg_attr cal_trigg_left =3D { TRIGGER_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", SET_TRIGGER_CF=
G,
> +static struct go_cfg_attr cal_trigg_left =3D { SET_TRIGGER_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", TRIGGER_CALIBR=
ATE,
>  		     LEFT_CONTROLLER, index);
>  static DEVICE_ATTR_RO_NAMED(cal_trigg_left_index, "calibrate_trigger_ind=
ex");

[Severity: High]
This is a pre-existing issue, but can the global static structure drvdata c=
ause
data corruption and a use-after-free if multiple devices are connected?

drivers/hid/hid-lenovo-go.c:
	static struct hid_go_cfg {
	[ ... ]
	} drvdata;

In hid_go_cfg_probe(), the global state is unconditionally overwritten:

	hid_set_drvdata(hdev, &drvdata);
	drvdata.hdev =3D hdev;

If multiple Lenovo Go controllers are plugged in, or if the device exposes
multiple interfaces that trigger probes, this will overwrite the global
drvdata pointer and attempt to re-register the statically allocated
go_cdev_rgb, leading to corrupted internal state and kernel panic during LED
registration.

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
hid_go_probe() leak resources?

drivers/hid/hid-lenovo-go.c:hid_go_probe() {
	[ ... ]
	ret =3D hid_go_cfg_probe(hdev, id);
	if (ret)
		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface\n=
");

	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

	return ret;
}

If hid_hw_start() and hid_hw_open() succeed but hid_go_cfg_probe() fails,
the driver returns the error immediately without calling hid_hw_stop() and
hid_hw_close(). This leaves the hardware in an active, undefined state.

[Severity: High]
This is a pre-existing issue, but does hid_go_remove() skip hardware cleanup
for interfaces without valid endpoints?

drivers/hid/hid-lenovo-go.c:hid_go_remove() {
	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;
	[ ... ]
}

If a device successfully probes as a generic HID device without specific
endpoints, get_endpoint_address can return an error like -ENODEV. The early
return completely bypasses hid_hw_close() and hid_hw_stop(), leaking hardwa=
re
state.

[Severity: Medium]
This isn't a bug introduced by this patch, but does hid_go_cfg_probe() leak
sysfs attributes on error paths?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
	[ ... ]
	ret =3D sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
	[ ... ]
	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
	if (ret) {
		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
		return ret;
	}
	[ ... ]
}

sysfs_create_groups() is not managed by devres. If subsequent operations
like devm_led_classdev_multicolor_register() fail, the function returns an
error without calling sysfs_remove_groups().

[Severity: High]
This is a pre-existing issue, but can hid_go_cfg_remove() cause an AB-BA
deadlock with sysfs operations?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
	[ ... ]
	guard(mutex)(&drvdata.cfg_mutex);
	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
	[ ... ]
}

The removal function acquires drvdata.cfg_mutex and then blocks in
sysfs_remove_groups() waiting for active sysfs callbacks to finish.
Simultaneously, sysfs callbacks like feature_status_show hold the kernfs
active protection and block attempting to acquire drvdata.cfg_mutex.

[Severity: Low]
This isn't a bug introduced by this patch, but is the buf memory allocation
in hid_go_cfg_probe() unused?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
	unsigned char *buf;
	int ret;

	buf =3D devm_kzalloc(&hdev->dev, GO_PACKET_SIZE, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;
	[ ... ]
}

The buffer buf is statically allocated but never used or passed to any
function.

[Severity: High]
This is a pre-existing issue, but does mixing devres and manual teardown in
hid_go_cfg_remove() create a use-after-free window?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
	[ ... ]
	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
	hid_hw_close(hdev);
	hid_hw_stop(hdev);
	hid_set_drvdata(hdev, NULL);
}

The LED is registered with devm_led_classdev_multicolor_register. In
hid_go_cfg_remove(), the driver manually calls hid_hw_stop(). Since devres
cleans up the LED after the custom remove() callback completes, there is a
race window where the LED is exposed in sysfs but the underlying HID hardwa=
re
is stopped. A sysfs write to the LED brightness during this window will att=
empt
I/O on stopped hardware.

[Severity: High]
This isn't a bug introduced by this patch, but does get_endpoint_address()
perform an out-of-bounds memory read if bNumEndpoints is 0?

drivers/hid/hid-lenovo-go.c:get_endpoint_address() {
	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
	struct usb_host_endpoint *ep;

	ep =3D intf->cur_altsetting->endpoint;
	if (!ep)
		return -ENODEV;

	return ep->desc.bEndpointAddress;
}

If a malicious USB device declares an interface with bNumEndpoints =3D=3D 0=
, the
endpoint array has zero elements. However, the pointer may not be strictly
NULL but point to the adjacent memory block, bypassing the !ep check and
reading ep->desc.bEndpointAddress out of bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214810.8782=
6-1-mradityadash@gmail.com?part=3D1
