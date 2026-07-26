Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBE35676B
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047786; cv=none; b=cb3qXTYCRRmEWohFZVTM1svZAVGlU6+TWRsrr/jHk2gTBH+sEFslmrKZoN5QG876tLFWIpnR7k6ZQ5s/2GYbmj9lPYJQ039fpRdlczcV+STp00PpFaAmCgJW4Qy4BWcicorLFOlkG6Qhr60sa38PBWY1I2AmbOPOnDPdkUaAFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047786; c=relaxed/simple;
	bh=nqyLanCoIwXCRtFQd1fjyeAeml3koVyMvJA8V2RM3RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZvjUE4Du5A6ivdvZFfyBiJZFcwMJ+c94/ex//VUxwXD0txBNSf3ZsobDGI7IqBYAoKD8T4+DUYfMDWtI0tsOeiCy4N3HrZcc+5vTacVATIXztKAZlgrVp0TnqDlIsZNQ32n7paztNvQaqtJP8ZbQneW7nBkRYzFhcCzy+GQ85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imsbL6cL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imsbL6cL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BDB1F000E9;
	Sun, 26 Jul 2026 06:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785047785;
	bh=El/dDND4nwDgiZ5o3YeAF+v4NqjSuPnm66MgMczLm1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imsbL6cL9yOsoSMgiOFVv9jm/eFMLj0gTT5SVBDjkylOKF0dyhh6OL/ot3ZFQc85O
	 5Lm0wFW0FaYnM+VAQoXlyFu/KtMJTtCMgnbPf0ZqoZuW22cHatbuQdu6eCvUYZKGF4
	 zeZIcVGitKfQPj3KLSpN956N2L/gM2wrQILg6xUtu9LX/LxhpX5o8vH+Up11dzfuHN
	 8AgfkDRSXxtDLX2lHYfkh6mTWQCJC0pGySJjTx91WT0Oo+m720PuT7o76RtppupxP0
	 larR4/1xSBNAePhen50PDZcHTYjSINbd3PDNkrB5aRRD7bm73KQBgogM63AjzCSoH7
	 dCXugzWUcSKbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: pidff: fix OOB write when hid->inputs is empty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baul Lee" <baul.lee@xbow.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260726062503.43717-1-baul.lee@xbow.com>
References: <20260726062503.43717-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 06:36:24 +0000
Message-Id: <20260726063625.26BDB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The probe function `universal_pidff_probe()` fails to call `hid_hw=
_stop()` when `hid_pidff_init_with_quirks()` returns an error, leading to l=
eaked HID resources and an exploitable Use-After-Free.
- [High] Race condition in `hid_pidff_init_with_quirks` leading to a NULL p=
ointer dereference when a malicious userspace process calls the `EVIOCSFF` =
ioctl between `input_ff_create()` and callback assignment.
--

--- Patch [1]: [PATCH] HID: pidff: fix OOB write when hid->inputs is empty =
---
commit 3acaf40e184c8c11b91d10a3096b1beb8e9b142b
Author: Baul Lee <baul.lee@xbow.com>

HID: pidff: fix OOB write when hid->inputs is empty

This commit fixes an out-of-bounds write in hid_pidff_init_with_quirks()
by ensuring that the hid->inputs list is not empty before accessing it.
If the list is empty, the function now returns -ENODEV.

> Check for an empty list before deriving dev and return -ENODEV, as the
> other HID force-feedback drivers already do.  universal_pidff_probe()
> propagates the error and unwinds.

[Severity: High]
This isn't a bug introduced by this patch, but does universal_pidff_probe()
actually fully unwind here?

Looking at universal_pidff_probe() in drivers/hid/hid-universal-pidff.c:

	error =3D init_function(hdev, id->driver_data);
	if (error) {
		hid_warn(hdev, "Error initialising force feedback\n");
		goto err;
	}
...
err:
	return error;

This error path propagates the initialization error but misses the necessary
hid_hw_stop() call to unwind hid_hw_start(). If universal_pidff_probe()
fails during force feedback initialization, it returns an error without
unwinding hid_hw_start().

This leaves the hidraw and hidinput structures registered but pointing to a
soon-to-be-driverless hid_device. When the physical device is unplugged,
the core skips calling hid_hw_stop() because hdev->driver is NULL.

Could this lead to an exploitable use-after-free condition if a local user
plugs in an untrusted USB device to trigger this -ENODEV return, and then
accesses the lingering /dev/hidrawX node?


> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 5f4395f7c6458..22951b7ecd174 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -1539,13 +1539,20 @@ static int pidff_check_autocenter(struct pidff_de=
vice *pidff,
>  int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirk=
s)
>  {
>  	struct pidff_device *pidff;
> -	struct hid_input *hidinput =3D
> -		list_entry(hid->inputs.next, struct hid_input, list);
> -	struct input_dev *dev =3D hidinput->input;
> +	struct hid_input *hidinput;
> +	struct input_dev *dev;
>  	struct ff_device *ff;
>  	int max_effects;
>  	int error;
> =20
> +	if (list_empty(&hid->inputs)) {
> +		hid_err(hid, "no inputs found\n");
> +		return -ENODEV;
> +	}
> +
> +	hidinput =3D list_first_entry(&hid->inputs, struct hid_input, list);
> +	dev =3D hidinput->input;
> +

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
further down in this function during force feedback initialization?

The input device is already fully registered and visible to userspace (via
hidinput_connect()) before hid_pidff_init_with_quirks() is called. When
input_ff_create() is invoked later in this function, it sets the EV_FF bit
on the device and assigns dev->ff.

Immediately after it returns, but before ff->upload and other callbacks are
initialized, a userspace process can open the input node and issue an
EVIOCSFF ioctl:

	error =3D input_ff_create(dev, max_effects);
	if (error)
		goto fail;

	ff =3D dev->ff;
	ff->private =3D pidff;
	ff->upload =3D pidff_upload_effect;

Could a local unprivileged user trigger a null pointer dereference by
rapidly issuing ioctls on the newly created /dev/input/eventX node, causing
input_ff_upload() to invoke a null ff->upload function pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726062503.4371=
7-1-baul.lee@xbow.com?part=3D1
