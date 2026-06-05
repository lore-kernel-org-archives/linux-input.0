Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151A267AF2
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623670; cv=none; b=rkyLObd3n9DyQwEX92pxT1yEnF5f2n5MuRMHLuQTRPURKPXPZey0f8XfJP4C8fyyYje2BrxdGTm49bWaFbwJgzftoQZPrFli90IP2KfY6NREUs0jld8fzLjG8mno64J+i9lOgLdfA7ckMDYzkZTwiuwyvSMEm/KpYTVONMiS4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623670; c=relaxed/simple;
	bh=9gnfspOJQGNgD6KmnkG7FELJTcOgJ65O0O0ybd4o7/4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NvY23g7BMe3eSRpTJq4inZG36hG9MRhSVr0CL8fRSRgiGoigZgnb27sfL5wQUMevHqHz1ABd2EpG1nrL80yoiS1++nXbwiqBKPz5xelwBAmU+kUTynZMsMkhEdjkMiSyl4aoOZJTfyR3QUchEDhDj5H/IjFcdFCp/xEWucGrmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XehC6W80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XehC6W80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1889E1F00893;
	Fri,  5 Jun 2026 01:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623661;
	bh=12lF9zfASr2p7gJ1DlJAvtck182RvHNmZOWrsw2Jglw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XehC6W80vGE2tRkEiEBSFcv64Hbk25cGVZavfiN7hH9mm701K+93oW0N1YcsPMmmc
	 dTMkiTP/ScdbHt7fwrBHd9vlAwNwiZ3w+B8azl3SyRBBkq/SjBWeWCkUZiyWkK3zZm
	 Sde54ZpXA3YG+xEa23Bwl3BWtacXXDWzqhP5kzPdLcKraP250NUv0xIRUSmElzgNf+
	 fZmmW+rasc4yBR1kq7V1lohllfOrb6XFcIgLLKQVgcY0uhI+fTF4j8E1YCF+eO7eam
	 9WMxgF2xfK7+L8TNm03spiDWrATV4tlVH+Q5ObIKjBdLdvcQSZBclUvcWU/tCJVozS
	 TXb/L1of49iGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Refactor _DSM helper and add
 i2c-hid-acpi-prp0001 driver
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_9F8936ABE7C35AED6FF779A83DFF2729D005@qq.com>
References: <tencent_9F8936ABE7C35AED6FF779A83DFF2729D005@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:41:00 +0000
Message-Id: <20260605014101.1889E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `acpi_device_fix_up_power()` before device probe may leave=
 the touchpad unpowered.
- [Low] Compilation error due to omitted parameter name in C function defin=
ition.
--

commit a6cad016330e4f17120f69020be7c1d0cb8f3e5d
Author: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.com>

HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver

This patch adds a new i2c-hid-acpi-prp0001 driver to support devices with
_HID "PRP0001" that lack the "hid-descr-addr" property but provide the HID
descriptor address via an ACPI _DSM. It also refactors the _DSM helper out
of i2c-hid-acpi.c into a shared header.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c b/drivers/hid/i2c=
-hid/i2c-hid-acpi-prp0001.c
> new file mode 100644
> index 0000000000000..35cbbab347acf
> --- /dev/null
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
[ ... ]
> +static int i2c_hid_acpi_prp0001_power_up(struct i2chid_ops *)
> +{

[Severity: Low]
Does omitting the parameter name here cause a compilation error?=20

Standard C requires parameter names in function definitions, and omitting
them generally results in a build failure.

> +	/* give the device time to power up */
> +	msleep(250);
> +	return 0;
> +}
[ ... ]
> +	adev =3D ACPI_COMPANION(dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret =3D i2c_hid_acpi_get_descriptor(adev);
> +	if (ret < 0)
> +		return ret;
> +	hid_descriptor_address =3D ret;
> +

[Severity: High]
Should acpi_device_fix_up_power() be called on the ACPI companion device
before calling i2c_hid_core_probe()?

ACPI I2C HID devices frequently lack the _PSC (Power State Current) object.=
=20
For such devices, standard ACPI PM attach assumes the device is already in
D0 and skips executing the _PS0 method, leaving the device unpowered.

The core i2c-hid-acpi driver explicitly works around this by calling
acpi_device_fix_up_power().=20

Without it here, will affected touchpads remain unpowered and result in I2C
timeouts during probe?

> +	return i2c_hid_core_probe(client, &i2c_hid_acpi_prp0001_ops,
> +				  hid_descriptor_address, 0);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_9F8936ABE7C=
35AED6FF779A83DFF2729D005@qq.com?part=3D1
