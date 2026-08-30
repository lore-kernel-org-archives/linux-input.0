Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF62C21D8
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102536; cv=none; b=ig3b315Bj/jo0xmPkxOqUHfx6K0+rN11MM/zWq6GdgVR4XrtTmYV4A2qfAH5o1MQ3vtvbg2e5q10yI3E5mG5rlSOcKUHId7BisneTs63A7aCdJRU6PzBtWwjMDFvtN/fkjXinlepwcyLrnf5gHQJ6kv2m8yAE6Vb9AdV0Ru5JLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102536; c=relaxed/simple;
	bh=tgfrDhodZZ+HLEL3dFJehruPJBSur9og+vA6TRgCrn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cCK4YHyyZU1D4Vv1u7iB4U44vpiWj/Vt77pqNyEQfbePGpoLeOv3nuaNFrnkjP0I+wVeoQ8YwNSgtKlmK1NPOjYIEUPI8LlUqsNw8JIDl2Qne99tLVau8OZLo9v/FEzNvZn9KQNmkEwHmvHsgxlTEOFgTZ1+jfjeDUNx8SMG088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aplqk9LL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aplqk9LL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42731F000E9;
	Sun, 30 Aug 2026 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102534;
	bh=+kH1p5bDPim5vzjLrsGKwB+RkO/RttiRxNJKHdsCPR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aplqk9LLr5JHZpVYZ6/5KIjZvT1Qq7T0G95SAoemRWvKk2pvt8I5nKketRfhkcqLg
	 VnEvLK4kRC5Qq+9PhzaqD/MKNsvzuZuDdYVwaKNx1z1nhpFjVE4TmV9yd41EoRm2vm
	 vYfzBy8NcVRwGUUTJz4tL2lBwvQAR5dikPlnmZviCozJiNvS8a1hDQY0hJRif8VmLy
	 aAeoA4AqgHklZ+NNJLZt348TUbfcophhEDWZW2s1Ig6t+VVwTTbYXCd2aYnt++SaQm
	 Lqklk4etTsWg+w7uDX8IqMbA7A4O4A1vvLchcTEuYMaEHaCF9mQmp/5LgXLbUqA2Bj
	 JbDIjWGUAydDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] HID: hid-lenovo-go: reject unknown calibration
 action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <c9b58da2e4247e179647c5eb902b93a33a37488a.1788096668.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
 <c9b58da2e4247e179647c5eb902b93a33a37488a.1788096668.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:08:54 +0000
Message-Id: <20260830150854.A42731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Low] The patch leaves behind dead code (`if (!val) size =3D 0;`) after e=
xplicitly rejecting `CAL_UNKNOWN`.

Pre-existing issues:
- [Critical] The driver incorrectly uses static global structs to store per=
-device state.
- [High] Missing hid_hw_close() and hid_hw_stop() in hid_go_probe() error p=
aths.
- [High] Early return in hid_go_remove() bypasses hid_hw_stop() cleanup.
- [High] Missing sysfs_remove_groups() on the error paths in hid_go_cfg_pro=
be().
- [High] AB-BA deadlock in hid_go_cfg_remove() with sysfs operations.
- [High] LED brightness_set callback performs sleeping operations.
--

commit a78ed68c3272ef95327340abb6446f933e2d3711
Author: Aditya Dash <mradityadash@gmail.com>
HID: hid-lenovo-go: reject unknown calibration action

This patch explicitly rejects CAL_UNKNOWN in the store handler for the
calibration configuration. It prevents requests without an action byte from
being sent by returning -EINVAL before building the request.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index c7a2e621a4ade..a4231d188b7af 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -1419,6 +1419,8 @@ static ssize_t calibrate_config_store(struct device=
 *dev,
>  	ret =3D sysfs_match_string(cal_enabled_text, buf);
>  	if (ret < 0)
>  		return ret;
> +	if (ret =3D=3D CAL_UNKNOWN)
> +		return -EINVAL;
> =20
>  	val =3D ret;
>  	if (!val)
>  		size =3D 0;

[Severity: Low]
Does this change leave behind dead code? Since CAL_UNKNOWN maps to 0 and is=
 now
explicitly rejected above, the subsequent assignment val =3D ret guarantees=
 that
val is non-zero.

Because of this, if (!val) will evaluate to false under all possible
conditions, making size =3D 0 dead code.

[ ... ]

> 	ret =3D hid_go_cfg_probe(hdev, id);
> 	if (ret)
> 		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface=
\n");
>=20
> 	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);
>=20
> 	return ret;

[Severity: High]
This isn't a regression introduced by this patch, but can this error path l=
ead
to a resource leak and potential use-after-free?

In hid_go_probe(), if hid_go_cfg_probe() returns an error, the function
immediately returns the error without rolling back prior successful calls to
hid_hw_start() and hid_hw_open(). This leaves the device in an active hardw=
are
state with input interfaces registered, violating HID subsystem lifecycle r=
ules.

[ ... ]

> 	int ep =3D get_endpoint_address(hdev);
>=20
> 	if (ep <=3D 0)
> 		return;

[Severity: High]
This isn't a regression introduced by this patch, but does this early return
bypass the default case needed to clean up generic HID devices?

If a device without the expected endpoint is unbound, get_endpoint_address()
returns an error (< 0) and this early return in hid_go_remove() triggers.
Omitting hid_hw_stop() here leaves the HID hardware, input devices, and hid=
raw
nodes active and registered after the driver has unbound.

When userspace interacts with these lingering nodes, it will access freed d=
evres
data, causing a use-after-free.

[ ... ]

> static struct hid_go_cfg {
> ...=20
> } drvdata;

[ ... ]

> static struct led_classdev_mc go_cdev_rgb =3D {

[ ... ]

> 	mutex_init(&drvdata.cfg_mutex);
> 	init_completion(&drvdata.cmd.done);
> 	spin_lock_init(&drvdata.cmd.lock);
> 	drvdata.cmd.pending =3D false;
> 	hid_set_drvdata(hdev, &drvdata);
> 	drvdata.hdev =3D hdev;

[Severity: Critical]
This is a pre-existing issue, but does this incorrectly use static global
structs to store per-device state?

If multiple supported devices are plugged in simultaneously, hid_go_cfg_pro=
be()
is called multiple times and unconditionally re-initializes the global
drvdata.cfg_mutex, drvdata.cmd.done, and drvdata.cmd.lock, and overwrites
drvdata.hdev.

Re-initializing active synchronization primitives corrupts lockdep and
waitqueues, leading to kernel panics. Additionally, registering the same st=
atic
global led_classdev_mc multiple times corrupts the LED subsystem's linked
lists, and sharing drvdata.hdev means one device's interrupts or sysfs
operations will randomly operate on the other device.

[ ... ]

> 	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
> 	if (ret) {
> 		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
> 		return ret;
> 	}

[Severity: High]
This isn't a regression introduced by this patch, but does this error path
permanently leak sysfs attributes?

Earlier in hid_go_cfg_probe(), sysfs_create_groups() is called to create
attributes. If devm_led_classdev_multicolor_register() fails here, the
function returns the error directly without calling sysfs_remove_groups().

This leaves orphaned sysfs files on the device's kobject. If accessed, they
will reference uninitialized or invalid driver state, and reloading or re-b=
inding
the driver will fail because the files already exist.

[ ... ]

> 	guard(mutex)(&drvdata.cfg_mutex);
> 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

[Severity: High]
This is a pre-existing issue, but can this cause an AB-BA deadlock?

In hid_go_cfg_remove(), the driver acquires drvdata.cfg_mutex and then calls
sysfs_remove_groups(), which blocks waiting for the kernfs active reference
to drain.

Concurrently, any sysfs read/write handler (like feature_status_show()) fir=
st
acquires the kernfs active reference, and then calls mcu_property_out(), wh=
ich
blocks trying to acquire drvdata.cfg_mutex. This forms an AB-BA deadlock th=
at
will hang driver removal and userspace sysfs access.

[ ... ]

> 		.brightness_set =3D hid_go_brightness_set,

[ ... ]

> 	ret =3D rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);

[Severity: High]
This is a pre-existing issue, but does this callback perform sleeping opera=
tions
in an atomic context?

The driver assigns hid_go_brightness_set to the .brightness_set field. The =
LED
subsystem invokes this callback directly from atomic contexts, such as timer
interrupts for the timer trigger.

However, hid_go_brightness_set() calls mcu_property_out(), which acquires a
mutex, allocates memory with GFP_KERNEL, and sleeps on a completion timeout.
Triggering this callback from an atomic context will cause a panic. The dri=
ver
must use .brightness_set_blocking instead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788096666.gi=
t.mradityadash@gmail.com?part=3D5
