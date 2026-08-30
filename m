Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D52690EC
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102419; cv=none; b=l6K7gTqwH3ISb6xhzWJ1RSeGZ3CX9J2rlPmiJbmXpFiyDSPkBBQl/tyJ/99oci6NcmKlVjJENXSfN6nkS3oiWCaPA7EsNPVrYnQZSea7a3Q1utwKedkq4ClHqlB1G8AXxKhhBt1XlakoX0BrKHYOrXTF/kDEpWJ9EN5+Eoqphgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102419; c=relaxed/simple;
	bh=qNEc9LSO4UD32a54mc/df3Utlw+SGuenoqQxb8EPkLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pCYRTZLml/MBc/HH2Vy3qyVElJtYKtVGbVDfofVcEDA3+X+aemmVu7osjltsO/N3yoy3Kbt80si/1YXJlUMwqQSkJSZGazhbPvFDPLhGazYVPkFWI3GcSRG7sVAOhgdjRqvBC6wpn/nCVW+uLSLcWrLSnMYnr75pTzNAmsJiG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2EyR0OI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2EyR0OI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DFF1F000E9;
	Sun, 30 Aug 2026 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102418;
	bh=Azcf4oDxrGoOEsX7aKn790Q5IVB6WRNQlhstj/Sv7R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W2EyR0OIlwDTSEEUU7HXar9lm7RKvAm4M0CZKizANaBHnZ9dj2rzobulYI5YmRNqB
	 bKECjV4/HQ6r4R1n78M1Woimh6KRPHNQdK+kPRpm5lQvbMImGrCiEuLXilxnVBDY6E
	 NsErq3NoZlKsXZcXY/vxehY00rEUPbS8ahoiiHmcBmVHm9kZHPj2B9AA1VziOniuWz
	 nlUdjVlkG7D39/H2FGvnzEFT2JO9Yw/67NNhmDQzidGUbmmkxzv3mJUpuBSxojJmc6
	 eNh3oKnYaoGOpJSI81rHuN0KGJSxxG+7S1Bwxgv2PwZHnuX47RjuzM+msvbFzqf+Js
	 X4BT1VWRZprOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] HID: hid-lenovo-go: use the right controller
 selectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <876cc33bede49d8ed2437278f0696010df98643c.1788096667.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
 <876cc33bede49d8ed2437278f0696010df98643c.1788096667.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:06:57 +0000
Message-Id: <20260830150658.00DFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing hid_hw_stop() and hid_hw_close() in probe error paths.
- [High] Missing hardware cleanup in remove() due to early return.
- [High] Global singleton used for per-device state, causing corruption and=
 Use-After-Free with multiple devices.
- [High] Leaked sysfs attribute groups on probe failure.
- [High] Deadlock during device unbind due to lock ordering with sysfs_remo=
ve_groups.
--

commit c2d6b2210c5ca6d1fa356349f3cbde71b00ce595
Author: Aditya Dash <mradityadash@gmail.com>
Subject: HID: hid-lenovo-go: use the right controller selectors

This commit fixes the attribute selectors for the right controller on Lenovo
Go gamepads. It updates the imu_enabled_right attribute to select
FEATURE_IMU_ENABLE and ensures the reset_right attribute targets the right
controller.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index b8248bf8965c6..b937d11dd6f6a 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -1999,13 +1999,13 @@ LEGO_DEVICE_ATTR_RW(imu_bypass_right, "imu_bypass=
_enabled", RIGHT_CONTROLLER,

[ ... ]

> static int hid_go_cfg_probe(struct hid_device *hdev,
> 			    const struct hid_device_id *_id)
> {
> 	unsigned char *buf;
> 	int ret;
>=20
> 	buf =3D devm_kzalloc(&hdev->dev, GO_PACKET_SIZE, GFP_KERNEL);
> 	if (!buf)
> 		return -ENOMEM;
>=20
> 	hid_set_drvdata(hdev, &drvdata);
> 	drvdata.hdev =3D hdev;
> 	mutex_init(&drvdata.cfg_mutex);

[Severity: High]
This is a pre-existing issue, but does using a global singleton for instanc=
e-
specific state break the driver model if multiple devices are plugged in?

Since drvdata is globally allocated in drivers/hid/hid-lenovo-go.c, setting
drvdata.hdev here in hid_go_cfg_probe() will clobber the pointer from any
previously probed device.

>=20
> 	ret =3D sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
> 	if (ret) {
> 		dev_err_probe(&hdev->dev, ret,
> 			      "Failed to create gamepad configuration attributes\n");
> 		return ret;
> 	}
>=20
> 	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);

[Severity: High]
This isn't a bug introduced by this patch, but does this corrupt the LED
subsystem lists?

Since go_cdev_rgb is a statically allocated global struct, registering the
same object in hid_go_cfg_probe() for every device instance could corrupt
the lists if multiple devices are present.

> 	if (ret) {
> 		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
> 		return ret;

[Severity: High]
This is a pre-existing issue, but does this error path in hid_go_cfg_probe()
leave sysfs attributes behind?

If devm_led_classdev_multicolor_register() fails, this returns immediately
without calling sysfs_remove_groups(). While devres will free the driver's
memory, the sysfs attributes remain active and reference freed memory,
which could cause a use-after-free if userspace interacts with them.

> 	}

[ ... ]

> static void hid_go_cfg_remove(struct hid_device *hdev)
> {
> 	/*
> 	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay
> 	 * and dereferences drvdata.hdev.  Drain it here before tearing
> 	 * down so the workqueue cannot run after hid_destroy_device()'s
> 	 * put_device() has released the underlying hdev and dereference
> 	 * a stale drvdata.hdev pointer.
> 	 */
> 	cancel_delayed_work_sync(&drvdata.go_cfg_setup);
>=20
> 	guard(mutex)(&drvdata.cfg_mutex);
> 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

[Severity: High]
This isn't a bug introduced by this patch, but can this lock ordering in
hid_go_cfg_remove() cause a deadlock during device unbind?

This holds drvdata.cfg_mutex while synchronously waiting for
sysfs_remove_groups() to finish. If userspace is concurrently writing to a
sysfs attribute, that write path (e.g., mcu_property_out()) will attempt
to acquire drvdata.cfg_mutex, leading to an ABBA deadlock that freezes the
kernel thread.

> 	hid_hw_close(hdev);
> 	hid_hw_stop(hdev);
> }

[ ... ]

> 	ep =3D get_endpoint_address(hdev);
> 	if (ep !=3D GO_GP_INTF_IN) {
> 		dev_dbg(&hdev->dev, "Started interface %x as generic HID device\n", ep);
> 		return 0;
> 	}
>=20
> 	ret =3D hid_go_cfg_probe(hdev, id);
> 	if (ret)
> 		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface=
\n");
>=20
> 	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);
>=20
> 	return ret;

[Severity: High]
This is a pre-existing issue, but does this error path in hid_go_probe()
fail to tear down the hardware?

If hid_go_cfg_probe() fails, the error code is immediately returned without
calling hid_hw_stop() or hid_hw_close(). The hardware is left running while
driver private data is freed by devres, which will trigger a use-after-free
when subsequent input events arrive.

> }
>=20
> static void hid_go_remove(struct hid_device *hdev)
> {
> 	int ep =3D get_endpoint_address(hdev);
>=20
> 	if (ep <=3D 0)
> 		return;

[Severity: High]
This isn't a bug introduced by this patch, but does this early return in
hid_go_remove() skip mandatory hardware cleanup?

If get_endpoint_address() fails during device unplug, it hits this early
return and bypasses hid_hw_close() and hid_hw_stop(). Input interrupts
will keep firing into freed driver structures.

>=20
> 	switch (ep) {
> 	case GO_GP_INTF_IN:
> 		hid_go_cfg_remove(hdev);
> 		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788096666.gi=
t.mradityadash@gmail.com?part=3D2
