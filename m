Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D03B4EA5
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779031530; cv=none; b=QyfZoRCtNUC70Ougevyb+O33SQTOCdNI7MtT7NM3+VkxYt1UuEEcveNYsdhUUyRAipC5A9PjZnh/WSPinNycZnS1OSpeNvvn+CfrlZRUTg3jbptrQ4D8V3sto7hKyuWiaABffymQJ6X5eFf5nUeIflqzHzO+QuVASOiv9VQDmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779031530; c=relaxed/simple;
	bh=oCIh1zOoqxDYtCY9lixgQqNHFrLQyoc4m4zbAhaBRJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cx1juHeXwtqWX3YoRrpyLVcISNAASq0rTp4QDnMdsVAtGwEOHkCUVHFWy7zeiJZXSkJ32KaQCWYwekjaCn6m/mgxr0sXq58KUVR/jC4EVp2BhyJjKBkDZrdGslGR8mAvBJBKelhogyMNtCc43UFvvShN5JPalmrjb28X6PG9sXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcF9jyP/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcF9jyP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EE0C2BCB0;
	Sun, 17 May 2026 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779031529;
	bh=oCIh1zOoqxDYtCY9lixgQqNHFrLQyoc4m4zbAhaBRJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LcF9jyP/+34Tecv4M6uLXbmY4ZmDBuNHTnHcD0Mp/tU2Yas7Vt0JoIvRQj17jaDqN
	 LiG47nBPsTg/FqDSEzUauOa3NR7JzTEk1JdjaEdOdpkfJhYz1ydEAEIMhTFdVIRPA5
	 1revhVPDQn2/ZW9HZwGYFWosU+nDDcqAZ/L3JFTy2t0OWu7g1LuMggfcbq582a65zt
	 6vO3A9oRXVhAmWjSVCITievJpcCE8Pr5LZie+ZLARE9WbsQQbMPSckm/Cr87sbqgiM
	 R87WeGcvAWRI4Ky/lVYWsj3kgspkUBq5FLvcoAdKstCQwn9fP8p9shi65wRe/J2+8n
	 qlTL9gceCqJ2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] platform/x86/lenovo: add Yoga Book 9 keyboard dock
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Carey" <carvsdriver@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260517150224.50191-1-carvsdriver@gmail.com>
References: <20260517150224.50191-1-carvsdriver@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 15:25:29 +0000
Message-Id: <20260517152529.B9EE0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] NULL Pointer Dereference on sysfs read for QUERY device and DM=
I check bypass
- [High] Use-After-Free due to unreferenced QUERY WMI device pointer
- [Medium] Race condition exposing incorrect initial switch state to usersp=
ace
--

commit f26ec3cd843093c54646b94f3331c501f619e886
Author: Dave Carey <carvsdriver@gmail.com>

platform/x86/lenovo: add Yoga Book 9 keyboard dock driver

This commit adds a new driver, lenovo-yb9-kbdock, to support the detachable
keyboard dock on the Lenovo Yoga Book 9 14IAH10. It queries the BKBD state
via WMI to report SW_TABLET_MODE input events and exposes the raw position
to userspace via sysfs.

> diff --git a/drivers/platform/x86/lenovo/yb9-kbdock.c b/drivers/platform/=
x86/lenovo/yb9-kbdock.c
> new file mode 100644
> index 0000000000000..ba0579f7981a3
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
[ ... ]
> +static int yb9_kbdock_probe(struct wmi_device *wdev, const void *ctx)
> +{
> +	enum yb9_guid_type type =3D (enum yb9_guid_type)(uintptr_t)ctx;
> +	struct yb9_kbdock_priv *priv;
> +	struct input_dev *input_dev;
> +	struct wmi_device *qwdev;
> +	int err;
> +
> +	if (type =3D=3D YB9_GUID_QUERY) {
> +		mutex_lock(&yb9_query_lock);
> +		yb9_query_wdev =3D wdev;
> +		mutex_unlock(&yb9_query_lock);
> +		return 0;
> +	}

The wmi_driver struct sets .dev_groups to yb9_kbdock_groups, which means the
keyboard_position sysfs attribute is created for all devices binding to this
driver, including the query WMI device.

If userspace reads this sysfs attribute on the query device, won't
keyboard_position_show() receive a NULL pointer from dev_get_drvdata()
and dereference it when accessing priv->bkbd?

Also, because this returns before dmi_check_system() is called, does this
allow the driver to bind to the query GUID on unsupported hardware?

> +
> +	if (!dmi_check_system(yb9_kbdock_dmi_table))
> +		return -ENODEV;
[ ... ]
> +	input_set_capability(input_dev, EV_SW, SW_TABLET_MODE);
> +
> +	err =3D input_register_device(input_dev);
> +	if (err) {
> +		dev_err(&wdev->dev, "failed to register input device: %d\n", err);
> +		return err;
> +	}
> +
> +	priv->query_wdev =3D qwdev;

Is a device link or reference count via get_device() needed here?

If the query WMI device is unbound or its parent ACPI device is hot-removed,
could priv->query_wdev become a dangling pointer that gets used in
yb9_kbdock_notify() when a WMI event fires?

> +	priv->input_dev =3D input_dev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	yb9_kbdock_update(wdev);

Could this expose an incorrect initial switch state to userspace?

Since input_register_device() makes the device visible before
yb9_kbdock_update() queries the hardware state, userspace might
read the default laptop mode (0) even if the keyboard is detached.

Can the initial hardware state be queried and reported before registering
the input device?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517150224.5019=
1-1-carvsdriver@gmail.com?part=3D1
