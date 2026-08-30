Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92522690EC
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102562; cv=none; b=LXE7rXwXU5oKbdtmfVCcotKI/v76B7KzvmX7t/O09D9D941HT2n7s0i31svRfHFlWttft71jydpYweGRE46s023ViTOyYmhomMAvtX7sw9q1XWmezfRSTqHDsTsbz5FzG4oAFWeEyHpDA/JopiBu377EKu6VzfHG3wObHw+X2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102562; c=relaxed/simple;
	bh=aV8ZXc6Ra4gGeHXIC+gy4QQOycKKN1nL3bDjZ0Cb9rU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aOI/hSJJLTv8GRsmLaznu7HA64fX1alRaxbsDFRK3Qv+9XtdtyDehvfw5L7wmgZ2+H5OVRs/vkx2GKbYUwv7DrW7tzRGHVtNh1TL4dNtX26RVg5wQ1gVx9B/xTWvsL7SYhqeYfKQ0tjscssxYZJFyvqKrhR8z5GRi3DO/6Lrb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCGvqCnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCGvqCnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793551F000E9;
	Sun, 30 Aug 2026 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102560;
	bh=3eVPELHG7gWg0VP5PWYjlcx2rlGyBFiEOww7C9pQD5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCGvqCnv7FK3bAotnIcpxGeoh7sp0mKyqOcwB+e33SkOoIkbbDOdhqSPvBu9p3jhR
	 HMCJmHaguy4PAJnGCaSuv4QNDefnsVlY02F3bus7H+iEJVdh4HDwwKN+fSjVmWR7yx
	 5UCHH8nibMdKuJVaJyUIfvZmS3C3s7tHgXk28dAaksfVEnYVA/WGOH1vPyX0hWd2S1
	 HxFJJcoCjdqv3WYqIazwYG+AanjC+vph+kb+agfxli7uR6wXbtK939fKtejqPpWiZa
	 q21WxID/r0LAF5AjJCffSoR4xNq8A/kUwJHTEN7Fegq/ABKmr1oUGWGzH08IQxZoq9
	 Sv2QbsMVONEqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] HID: hid-lenovo-go: clear calibration status on
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <931a17ea1ce972af018252681a253a21465ad494.1788096668.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
 <931a17ea1ce972af018252681a253a21465ad494.1788096668.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:09:19 +0000
Message-Id: <20260830150920.793551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing hid_hw_stop() and hid_hw_close() in hid_go_probe() error p=
aths.
- [High] Missing hid_hw_stop() in hid_go_remove() on early return.
- [High] Sysfs attribute groups are leaked if hid_go_cfg_probe() fails midw=
ay.
- [High] Singleton driver state (`drvdata`) causes state corruption, lock r=
e-initialization, and UAF when multiple devices are probed.
- [High] Deadlock in driver removal path between sysfs_remove_groups and mc=
u_property_out.
- [High] UAF vulnerability due to devm-managed LED class device unregistrat=
ion ordering.
--

commit 6b546e272fefac54ad5bf113ee4d2d91e487fb03
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: clear calibration status on start
   =20
A completed calibration leaves success or failure in its status file. If
the next calibration has the same result, userspace sees no change and
cannot tell when the new attempt starts or finishes.

Link each calibration action attribute to its status field. Set only that
field to unknown before submitting Start. Stop leaves the status unchanged,
and the next firmware result replaces unknown with success or failure.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index a4231d188b7af..2ed367abd4ccc 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c

[ ... ]

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
This isn't a bug introduced by this patch, but does this error path cause a
use-after-free?

If hid_go_cfg_probe() fails, hid_go_probe() returns the error code without
cleaning up. By omitting hid_hw_close() and hid_hw_stop(), the input and hi=
draw
interfaces remain registered and active while the driver binding fails and
devres resources are freed. Userspace interaction can then trigger a UAF.

drivers/hid/hid-lenovo-go.c:hid_go_remove() {
	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;
    ...
}

[Severity: High]
This is a pre-existing issue, but can this early return cause a use-after-f=
ree
if a malicious device with no endpoints is unplugged?

When a device is unplugged or unbound and get_endpoint_address() returns
-ENODEV, this early return completely bypasses the hid_hw_stop() call, leav=
ing
input interfaces registered while driver devres resources are freed.

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
	ret =3D sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
	if (ret) {
		dev_err_probe(&hdev->dev, ret,
			      "Failed to create gamepad configuration attributes\n");
		return ret;
	}

	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
	if (ret) {
		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
		return ret;
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but do the sysfs attribute groups get leaked
here?

If devm_led_classdev_multicolor_register() fails, the manually created sysfs
groups are never removed because sysfs_remove_groups() is missing in the er=
ror
path. This leaves dangling sysfs files that can be accessed by userspace af=
ter
the driver fails to bind.

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
	mutex_init(&drvdata.cfg_mutex);
	init_completion(&drvdata.cmd.done);
	spin_lock_init(&drvdata.cmd.lock);
	drvdata.cmd.pending =3D false;
	hid_set_drvdata(hdev, &drvdata);
	drvdata.hdev =3D hdev;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does the use of a single glo=
bal
static drvdata struct cause state corruption if multiple physical devices a=
re
connected?

Probing a second device unconditionally overwrites drvdata.hdev and
re-initializes cfg_mutex and cmd.lock while they might be held, which could
lead to deadlocks or a use-after-free.

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
    ...
	guard(mutex)(&drvdata.cfg_mutex);
	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
    ...
}

[Severity: High]
This is a pre-existing issue, but could this lock ordering cause an AB-BA
deadlock during device removal?

hid_go_cfg_remove() acquires drvdata.cfg_mutex and calls sysfs_remove_group=
s(),
which waits to drain active kernfs references. Meanwhile, an active sysfs
callback holds a kernfs reference and attempts to acquire drvdata.cfg_mutex
inside mcu_property_out(), which would cause a deadlock.

drivers/hid/hid-lenovo-go.c:hid_go_brightness_set() {
    ...
	ret =3D rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
    ...
}

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
    ...
	hid_hw_stop(hdev);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free wi=
ndow
here during device removal?

Devres cleans up resources (unregistering the LED class device) after the
driver's remove() callback returns. Inside hid_go_cfg_remove(), hid_hw_stop=
()
is called.

During the window before devres runs, userspace can still invoke
hid_go_brightness_set(), which accesses drvdata.hdev and calls
hid_hw_output_report() on a stopped hardware device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788096666.gi=
t.mradityadash@gmail.com?part=3D6
