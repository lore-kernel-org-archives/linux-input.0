Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD58352022
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245178; cv=none; b=mep3MjRTszmQejoaHMdvg0mQl/yBBDQfHPqDIKGOUmdEBZPNjNcid1G5toeKo+gfLEL7etRvE+qLTKC9nGNAY+RHUuBT/4dciKVgmisuGRMofpumAfBMme9M3KN39/uTHWctgR9SB26IfsSxcY2dCHAbfka7bDn9tbIP3m8Kk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245178; c=relaxed/simple;
	bh=jPQUPEp5cdNe9FiGkRmGGsx1ShimkkehOJFvlu38Ia0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3HcQB9YCuHjI0/bhQvEcweMZnzfiswHgohq6whCvpOMhLFWCyF+VEjuVic61RRL8P5hyzTlbEyeFVbBCm58RZAYEjYUW6jU+IXK3UfeW85MvNHQ0FHdvoUHseSgo2yVNchfstwW0GmEZPsxT5Oqcm30N7pqowupw6Cv7i4qVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLf1BIED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLf1BIED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB3C1F000E9;
	Tue,  1 Sep 2026 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245176;
	bh=0LPoKeZDuIRo08k8Aqa8M5z7qQ3ju0uBvDVEjtHHs1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLf1BIEDD7MRxcQpEu/KRNEV05Viye3Ka4BL43J4pEnR/hqpRIf+j18g/K/Dq1CUJ
	 4DylD44KJpQrFjX8u/UK/+/kl8w58e0q/U2ESnfZFBafOnsrUxGgJFtuKgmFiKlpnn
	 ntroszjqfamD5nMT0C0c/9kNRJ7Cyl8VsmtZ5YmIcnjL5NrCtsSbOuaMnmK+bT5xCd
	 NrwECtrtfP/30f9XIIrEpasx+xwdhUpiQmXkTjjz+LytZwN7boRK2RSetcnsfvXNQc
	 jVT7Y4kmOg6yIiVdDxIlBLz/J2RIU0ZGG1B2IfJgCiCiIHSbQObvAsXDgxOr14Fk0F
	 M8oF6vpR8fAjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] HID: hid-lenovo-go: use the right controller
 selectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <ec070d00bfb9c9a83b2883ccee62cba7da62028b.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
 <ec070d00bfb9c9a83b2883ccee62cba7da62028b.1788222001.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:46:16 +0000
Message-Id: <20260901064616.BEB3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver relies on static global structures (`drvdata`, `go_cdev=
_rgb`) to maintain per-device state and register LED devices, breaking mult=
i-device support and causing memory corruption.
- [High] Hardware is left in an active, open state if `hid_go_cfg_probe()` =
fails, due to missing `hid_hw_stop()` and `hid_hw_close()` calls in the `hi=
d_go_probe()` error path.
- [High] Hardware cleanup and workcancellation are bypassed in `hid_go_remo=
ve()` for generic endpoints, leaving unmanaged active hardware and risking =
use-after-free.
- [High] Out-of-bounds array read in `get_endpoint_address()` if an interfa=
ce has no endpoints.
--

commit e72b397410199e2e2416cfeb7ba8e9af743302f7
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: use the right controller selectors

This commit corrects the right controller selectors by changing the
imu_enabled attribute to select FEATURE_IMU_ENABLE. It also fixes the right
reset attribute to target the right controller instead of the left.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index b8248bf8965c6..b937d11dd6f6a 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does relying on static global structures
for per-device state break multi-device support and cause memory corruption?

Looking at drivers/hid/hid-lenovo-go.c, the driver defines global structures
rather than allocating per-device structures with devm_kzalloc():

} drvdata;
...
static struct led_classdev_mc go_cdev_rgb =3D {

And in hid_go_cfg_probe(), it forces all probed instances to share this
state by overwriting drvdata.hdev:

	hid_set_drvdata(hdev, &drvdata);
	drvdata.hdev =3D hdev;
	mutex_init(&drvdata.cfg_mutex);

If multiple gamepads are plugged in, will concurrent probes overwrite active
locks and the delayed work struct?

Also, will calling devm_led_classdev_multicolor_register() on the same
global go_cdev_rgb multiple times double-add its embedded list_head node
into the core LED subsystem lists, causing linked-list corruption?

[Severity: High]
This isn't a bug introduced by this patch, but does hid_go_probe() leak
the hardware state if hid_go_cfg_probe() fails?

In hid_go_probe(), after hid_hw_start() and hid_hw_open() are successfully
called, if hid_go_cfg_probe() fails, the error path returns without calling
hid_hw_close() and hid_hw_stop():

	ret =3D hid_go_cfg_probe(hdev, id);
	if (ret)
		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface\n=
");

	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

	return ret;

Could this leave the device unmanaged but actively running, causing resource
leaks and potential use-after-free when devres cleanup frees structures?

[Severity: High]
This is a pre-existing issue, but is hardware cleanup bypassed in
hid_go_remove() for generic endpoints?

In hid_go_remove(), the driver unconditionally returns early for
non-configured generic endpoints:

	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;

Since hid_go_probe() accepts devices even if get_endpoint_address() returns
an error, leaving the generic device bound, started, and opened, does this
early return in hid_go_remove() bypass hid_hw_close() and hid_hw_stop()
entirely?

According to HID subsystem rules, omitting hid_hw_stop() in remove() leaves
the input and hidraw devices registered and active while the driver's devres
memory is freed. Can this lead to a use-after-free if userspace interacts
with the node?

[Severity: High]
This isn't a bug introduced by this patch, but can get_endpoint_address()
cause an out-of-bounds array read if an interface has no endpoints?

The function fetches the endpoint array and checks if ep is NULL, but it
dereferences it without checking if desc.bNumEndpoints > 0:

	ep =3D intf->cur_altsetting->endpoint;
	if (!ep)
		return -ENODEV;

	return ep->desc.bEndpointAddress;

If the interface has bNumEndpoints =3D=3D 0, the USB core allocates a
zero-length array, returning ZERO_SIZE_PTR.

Since if (!ep) evaluates to false for ZERO_SIZE_PTR, will dereferencing it
cause an out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222001.gi=
t.mradityadash@gmail.com?part=3D2
