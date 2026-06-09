Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3232BEC3F
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003169; cv=none; b=DVufLA42cbotuXkBdneEZdyrlj6o9cKdKgehsX2J44lmfJBl6uyws7fSvsLGI3YWFq/pdyK7VhIb0I5dWK8QbWazTzAjEmI12doMTw7/ZW55I9OKVu7mDCoTukASL4aiZz5QqvPPjwDoB93+wspCa36GL6Xi6EOSWVqM4DpWWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003169; c=relaxed/simple;
	bh=j0ELgHyz5GCCJ2/QFPdF1Ogxb2pTHqIT/mHSk5FE0WE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hnZYoDu/WmedrEUnBmnTcqDXXAUm+MGU4ppyjW2TcD8zj3dawZWHENNkBMQe9ZVgpHNlf4MTiO/D7Fz4VWst0XBRPS0xsRGBWF2YatVg11GGp7pxEfRwmJ7HX7vxaswk9k1R08f/ciRyUMrgRSpqoIgwPjMlVzGlsa2sK2JtVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAA7u/LG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAA7u/LG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C21F00898;
	Tue,  9 Jun 2026 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781003168;
	bh=Kmw0RXpvrzbF4OkQ1wYw7kgvdcMrAF03nVdYVSJfI14=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HAA7u/LGRX0wq6WZKncqXBAL14NM9OzkKuTv4W5GysapCzp594ehfHua5oLhgZEE8
	 jonskPYQVlvnUbs1dWPy6Pl8OxsXdkOQfPIV1lKO/CmDKomrEUPcMhF8D4JTXd3Ayf
	 ojcgsNkaVDjA8OOtpSgDK4SwEfOTOipQj4N8riSJUTRfYBQmnl5Qm8FWbv8zlgr/y0
	 prm8YRBYw2wkCy8vBbcefZ0yLNh38T1K0nswz7zlNjDi6mAXb+pcmsULof39hVwx8Q
	 MY/s3iardtSHPMTHCwpqvddt8XiXnGB/kzu1KY9XH9P/5L347JRZBvBQYUwTWDq45v
	 7zoHXcpSomHKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: i2c-hid: Refactor _DSM helper and add
 i2c-hid-acpi-prp0001 driver
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_6169D37BDAAD7FFEEC9E41DA197FE6028309@qq.com>
References: <tencent_6169D37BDAAD7FFEEC9E41DA197FE6028309@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 11:06:07 +0000
Message-Id: <20260609110608.3F4C21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `of_match_ptr()` on the `of_match_table` prevents native ACP=
I PRP0001 matching when `CONFIG_OF` is disabled.
--

commit fdffe866c804a579c14dbd7b1c8529b20466017b
Author: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.com>

HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver

This commit moves the _DSM call that retrieves the HID descriptor address i=
nto
a shared header. It also introduces the i2c-hid-acpi-prp0001 driver to hand=
le
devices with _HID "PRP0001" and _DSD compatible "hid-over-i2c" that are mis=
sing
the "hid-descr-addr" property.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c b/drivers/hid/i2c=
-hid/i2c-hid-acpi-prp0001.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c

[ ... ]

> +static const struct of_device_id i2c_hid_acpi_prp0001_of_match[] =3D {
> +	{ .compatible =3D "hid-over-i2c" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, i2c_hid_acpi_prp0001_of_match);
> +

[ ... ]

> +static struct i2c_driver i2c_hid_acpi_prp0001_driver =3D {
> +	.driver =3D {
> +		.name	=3D "i2c_hid_acpi_prp0001",
> +		.pm	=3D &i2c_hid_core_pm,
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table =3D of_match_ptr(i2c_hid_acpi_prp0001_of_match),

[Severity: High]
Will this prevent the driver from probing on ACPI systems that do not enable
CONFIG_OF?

The driver relies on ACPI PRP0001 matching to match the _DSD compatible
property against the of_match_table. However, if CONFIG_OF is disabled
(which is standard for x86 ACPI platforms where this hardware exists),
of_match_ptr() evaluates to NULL.

When of_match_table is NULL, the ACPI driver core will silently fail to
match the device, leaving the touchpad non-functional. Should we drop the
of_match_ptr() wrapper here to ensure the table is always available for
PRP0001 matching?

> +	},
> +
> +	.probe		=3D i2c_hid_acpi_prp0001_probe,
> +	.remove		=3D i2c_hid_core_remove,
> +	.shutdown	=3D i2c_hid_core_shutdown,
> +	.id_table	=3D i2c_hid_acpi_prp0001_id,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_6169D37BDAA=
D7FFEEC9E41DA197FE6028309@qq.com?part=3D1
