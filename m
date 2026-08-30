Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3532690EC
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102572; cv=none; b=Z0Si8IZOBeppOo5o3NNTExXTgJnOKlf9+j3JaCVoKA0qIaDFy9Zh4qZ71ApW0VOuf+8uDu23UZqLlQnCpH2xJDy0EooP/SBsohubYZR2dGu8uYPvMuI+YyzqHoa4qxIB2ZKjR073dTklMOA0xR7BDMjmxCdqGonNndkMiyothWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102572; c=relaxed/simple;
	bh=MkaPx3YarRCWcZp937VoRXNBEliqb31L6NkEbQaIGUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=okJgfZNQ1J94gSq479TgcFeBqcFxMSvOv35adf25rzSvSy56HDMRDKjgNwXjRirNTdoRSdNwTXZjGr3bHzNpXvasR5QNUUg9w7iKZ+P+ZxBXChXt33Y2LN2fDcanS5glxzvM86bn7TaHJAqHkOlxmZCbwfgBk6GKnzLdZ42afQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX8U7m5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX8U7m5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6241F000E9;
	Sun, 30 Aug 2026 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102571;
	bh=mRn9I+KUHM962yr03cFWG1ROGAtHeg96pQGO3VGRm6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QX8U7m5loAAUBeivfkEfuQDDS6NucaRYH2ukp+Mp8XeCxG0DZbBMUXXAynZmnX2fj
	 C+yzpvcC/xyjkJfih/XFkQELyiV3BVlbkN9EpJ6P5XQZv5+AKryIyC7AkIJOYd3ghd
	 M11/9soYZI33TzF24v6u/QzqbOWzKEYIk61GF0mUlNSFLwzHlRcC6HU8GpKvlUWCmn
	 QI3FznywD7mOZVH77fnru3fHJVGaYlGLF/bdZRQ/51b9zHAzmtgLv1QES6Zb7AKe6g
	 SkqVX5I00IzogXn5TT80y32XxTAhAbDckAqrytrMQvx4gA2J9CtLEqoPWBl/isXU9Q
	 lkkOQUcQJJQxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] HID: hid-lenovo-go: use the correct calibration
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <e6874a99a824050b89c61878b960c292ed790d3a.1788096667.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
 <e6874a99a824050b89c61878b960c292ed790d3a.1788096667.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:09:30 +0000
Message-Id: <20260830150931.3C6241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Early return in remove() skips hid_hw_stop(), leading to Use-A=
fter-Free.
- [Critical] Singleton global state prevents multi-device support and cause=
s data corruption.
- [High] Missing hid_hw_stop() and hid_hw_close() on probe error path.
- [High] Sysfs attribute groups are leaked on probe error paths.
- [High] ABBA deadlock between sysfs active references and cfg_mutex during=
 removal.
--

commit 087e7a307d94a2ccdf00bf5d59ce9cddc609d002
Author: Aditya Dash <mradityadash@gmail.com>

    HID: hid-lenovo-go: use the correct calibration commands
   =20
    The calibration attributes pass the calibration operation as the command
    and the configuration command as the sub-command. This sends each reque=
st
    with the two fields reversed.
   =20
    Swap the command and sub-command values for all six calibration attribu=
tes.
    For example, the malformed left joystick Start request is:
   =20
      05 00 04 0c 03 01 ...
   =20
    The corrected request is:
   =20
      05 00 0c 04 03 01 ...

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 318b1152ff8ba..b8248bf8965c6 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
[ ... ]
> 	ret =3D hid_go_cfg_probe(hdev, id);
> 	if (ret)
> 		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface=
\n");
>=20
> 	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);
>=20
> 	return ret;
> }

[Severity: High]
This is a pre-existing issue, but does this error path in hid_go_probe() le=
ak
hardware resources?

If hid_go_cfg_probe() fails, the function logs the error and returns the
negative error code directly.

Does this bypass the mandatory hid_hw_close() and hid_hw_stop() teardown ca=
lls,
leaving the device in an active state despite a failed probe?

> static void hid_go_remove(struct hid_device *hdev)
> {
> 	int ep =3D get_endpoint_address(hdev);
>=20
> 	if (ep <=3D 0)
> 		return;

[Severity: Critical]
This isn't a bug introduced by this patch, but does this early return in
hid_go_remove() skip driver teardown steps?

If a malformed USB device without endpoints is probed, get_endpoint_address=
()
returns an error. If hid_go_probe() successfully binds the device as a gene=
ric
HID device, then during driver unbind, get_endpoint_address() again returns=
 an
error.

Does this cause hid_go_remove() to hit the early return and exit immediatel=
y,
skipping hid_hw_stop() and leaving dangling input interfaces active while
devres releases the driver's underlying memory?

> 	ret =3D sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
> 	if (ret) {
> 		dev_err_probe(&hdev->dev, ret,
> 			      "Failed to create gamepad configuration attributes\n");
> 		return ret;
> 	}
>=20
> 	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
> 	if (ret) {
> 		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
> 		return ret;
> 	}

[Severity: High]
This is a pre-existing issue, but does this error path in hid_go_cfg_probe()
leak sysfs attributes?

If a subsequent initialization step like devm_led_classdev_multicolor_regis=
ter()
fails, the function returns immediately without calling sysfs_remove_groups=
().

Could accessing these dangling sysfs nodes after module unload result in a
Use-After-Free panic?

> 	u32 tx_dongle_version_hardware;
> 	u32 tx_dongle_version_product;
> 	u32 tx_dongle_version_protocol;
> } drvdata;
[ ... ]
> 	hid_set_drvdata(hdev, &drvdata);
> 	drvdata.hdev =3D hdev;
> 	mutex_init(&drvdata.cfg_mutex);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this static global
structure prevent multi-device support and corrupt state on concurrent prob=
es?

The driver stores all per-device state, including the hdev pointer and
cfg_mutex, in a single static global struct named drvdata.

If a second Lenovo Legion Go device is plugged in, its probe sequence in
hid_go_cfg_probe() overwrites the global hdev pointer and calls
mutex_init(&drvdata.cfg_mutex) on an active lock.

Does this lead to memory corruption and unpredictable driver behavior for a=
ll
connected devices?

> static void hid_go_cfg_remove(struct hid_device *hdev)
> {
[ ... ]
> 	cancel_delayed_work_sync(&drvdata.go_cfg_setup);
>=20
> 	guard(mutex)(&drvdata.cfg_mutex);
> 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
> 	hid_hw_close(hdev);
> 	hid_hw_stop(hdev);

[Severity: High]
This is a pre-existing issue, but does this create an ABBA deadlock between
sysfs active references and cfg_mutex?

hid_go_cfg_remove() first acquires cfg_mutex and then calls
sysfs_remove_groups(), which internally blocks until all active sysfs read
and write operations complete.

Concurrently, a sysfs read first takes the kernfs active reference and then
calls mcu_property_out(), which attempts to lock cfg_mutex.

Does this establish a circular locking dependency that freezes the driver
unbind process and indefinitely hangs any tasks attempting to interact with
the device's sysfs files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788096666.gi=
t.mradityadash@gmail.com?part=3D1
