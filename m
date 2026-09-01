Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2D36A35A
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245300; cv=none; b=m6ymssrDgMzGcX+oVdp3ABgEYGs6M6PymdBjEY6k6Jr+5HCWEbWb5sN3Jua4tN0FDiuUyYcIXXBNwLu8yxovvRn4CK3eGRvHxt7zoqwUnvTjZx2Lxgk7LacfEvYUqkSZyFZK58ePnn7qdaPTdp/Ue5Apk73ivwheo0TrLz1wBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245300; c=relaxed/simple;
	bh=TomoGvogkfxcc4s97PpUzzqn00Ha4reQqWX893S0pdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ULkxoDXjJfCJ4htxLHNz/zxZ3l42SXlHRl/1GsUCN/9slihX7gPeOYpLHTN8gGpm6jGhXe2NLEDAqc454h7x4eZUTdirWAbEGqoWgDF4E421O1lBF9JaLchZ0QmX/lMY6TaC/M+MoVX7/c18PFqBsEVEdMiuMwquqO1zw6IuqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyFKz0Oh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyFKz0Oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC741F000E9;
	Tue,  1 Sep 2026 06:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245298;
	bh=6oaImtSeZMp6Ygo9so5TrK7znE14Jmx/1vSKkEpY5Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FyFKz0OhHHEXGU+x521nvrfJhU6qF2t4BeGUm/x3tM4fsZzPP7xMVloyD6MG6xns5
	 GnHdG7MUsusCt3Wg5Ylh+El6WykTt9w1Pam4vqUi1DHEUk7Oo7ASduKJjkYtraareT
	 00ERMC5KIqLI0gCLDLp9D0I7q0NL1D4HrhHFxK+OfGd5qXmfBByGZGzFYEhbxXC/DI
	 mQROsfCd3HwqTCr5zoOVdmUSqqg5c1/yvBmnLu+/mi7KxF+e1pyJX7PWoRuqlCZNcR
	 JiM2QbfRaWitGIt6YZNDlTaFrh906cHjoiq9dojfcDHiITFgrXN7zNGVJ80d2RevfN
	 HOFMNc7Uv01LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] HID: hid-lenovo-go: initialize command
 completion before hardware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <2421c0ebbe4a487acb20317d03e581b3438e4471.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
 <2421c0ebbe4a487acb20317d03e581b3438e4471.1788222001.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:48:18 +0000
Message-Id: <20260901064818.9EC741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Global state singleton causes severe concurrency issues, state cor=
ruption, and waitqueue destruction when multiple devices or interfaces are =
probed.
- [High] Missing hardware cleanup and sysfs rollback in the `hid_go_probe()=
` error paths.
- [High] AB-BA deadlock between `cfg_mutex` and kernfs active protection du=
ring device removal.
- [High] Bypassed hardware stop in `hid_go_remove()` for invalid endpoints =
leads to severe UAF.
- [High] Devres LIFO ordering trap leaves the LED classdev active after the=
 hardware is stopped.
--

commit 16e38723509d50d9bcf65a4f08049990d12d0c0f
Author: Aditya Dash <mradityadash@gmail.com>

    HID: hid-lenovo-go: initialize command completion before hardware
   =20
    The configuration interface initializes its command completion in
    cfg_probe(). The hardware starts and opens before this call. Keep the
    completion ready before hardware I/O becomes available.
   =20
    Identify the interface after parsing it. Initialize the completion for =
the
    configuration interface before starting and opening HID hardware. Keep =
the
    remaining configuration setup in cfg_probe().

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index b937d11dd6f6a..51e3112780e18 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c

[ ... ]

> @@ -2436,6 +2434,10 @@ static int hid_go_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  		return ret;
>  	}
> =20
> +	ep =3D get_endpoint_address(hdev);
> +	if (ep =3D=3D GO_GP_INTF_IN)
> +		init_completion(&drvdata.send_cmd_complete);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does blindly calling
init_completion() here destroy the active waitqueue if a thread is already
waiting from a concurrent device?

The global drvdata structure is overwritten when multiple devices bind,
causing all sysfs and workqueue operations to operate on the last connected
device's hdev. Registering the same static go_cdev_rgb multiple times
corrupts the LED core linked lists.

>  	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  	if (ret) {
>  		hid_err(hdev, "Failed to start HID device\n");
> @@ -2449,7 +2451,6 @@ static int hid_go_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  		return ret;
>  	}
> =20
> -	ep =3D get_endpoint_address(hdev);
>  	if (ep !=3D GO_GP_INTF_IN) {
>  		dev_dbg(&hdev->dev, "Started interface %x as generic HID device\n", ep=
);
>  		return 0;

[Severity: High]
This is a pre-existing issue, but if hid_go_cfg_probe() fails right after
this check, does the driver return an error code from probe() without calli=
ng
hid_hw_stop()?

The HID core will free driver devres resources, but the hardware is left
active, violating HID lifecycle guidelines and leading to potential
use-after-free.

Also, if devm_led_classdev_multicolor_register() fails in hid_go_cfg_probe(=
),
does it return without removing the previously created sysfs groups, leaking
them?

[ ... ]

A few other pre-existing issues were noticed in this driver:

[Severity: High]
This isn't a bug introduced by this patch, but does the driver have an AB-BA
deadlock between cfg_mutex and kernfs active protection during device remov=
al?

In hid_go_cfg_remove():

	guard(mutex)(&drvdata.cfg_mutex);
	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

The mutex is acquired before calling sysfs_remove_groups, initiating the
deadlock condition. Meanwhile, a sysfs writer in mcu_property_out() attempts
to acquire the mutex while holding the sysfs active refcount, completing the
deadlock cycle.

[Severity: High]
This is a pre-existing issue, but does hid_go_remove() bypass the required
hid_hw_close() and hid_hw_stop() cleanup phase for invalid endpoints?

In hid_go_remove():

	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;

If get_endpoint_address() fails in hid_go_probe(), the driver still starts
the hardware and returns 0. During unbind, the early return in
hid_go_remove() bypasses the cleanup, leaving the transport layer active
and unstopped, causing an immediate use-after-free vulnerability.

[Severity: High]
This isn't a bug introduced by this patch, but does the devres LIFO ordering
trap leave the LED classdev active after the hardware is stopped?

In hid_go_cfg_remove():

	hid_hw_close(hdev);
	hid_hw_stop(hdev);

This manually stops the hardware before devres unregisters the LED.
Userspace interacting with the LED brightness via hid_go_brightness_set()
can trigger a hardware report which assumes the device is still active,
leaving a window for a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222001.gi=
t.mradityadash@gmail.com?part=3D3
