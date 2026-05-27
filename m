Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF637C90B
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897654; cv=none; b=uVguGZuuZPfYfbu4RuIhqRP/nYQ+KTaqlun9jFSy21wWf2mijKV0bU98ETYiRmbblHqbBf+fiX7cpd4Y0ck3FzDKosQvWYZDTj5mD76CY2M0Gek3vOS1YRC98IYoPSuneAJ7XGI/SoqVq+d6f3EU3YrVHCSivXCg2Y2tvo8puGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897654; c=relaxed/simple;
	bh=PtIBU+jnFqgk6gzLaONAhmvjU34umljFIYhfoCJp0Hs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KXWXj5CDSkuE6bWyse7pVIESOO2RWpTlHGo0obsl4w5/5yPsIel3UiRPDINt7t+xYaFgKhlKIv7R7ROAPX/PZ0YhHZihpBOmt8WDbCiLJdvOKNq4p0hkFBhTLs5J/rFwUgTVbpJDBCIa3qUQxFsfHggB/xTcX9FqYa01bzuaHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUyGtNGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUyGtNGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5EF1F000E9;
	Wed, 27 May 2026 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779897653;
	bh=tmS/TQjF7YQaIa1Gk740eqdNWZe23G4O+ACWiLAGjek=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YUyGtNGC7aWuGWfCqwv263QIU4rTEJrkCbkji+Clok+VITui0t5KEPSSQdLu0qy1X
	 FoIJLBaZYtoqf/h+NwD1jWl0trOIjyl0r7MdgLaFuqaYk7rGF3TlXzf5BQLQsHLi5f
	 Os2O0d39/4BddwKB+cZH2AzJN7CjBAisWkEyuJLgVenZF5i3VF5dwnSdM00v/2L3Sr
	 +nE6nKrTl9ENAzRl0bHjktzmrBdNSDmIzq/cC2pLLpGYmMUGd5v8Snj9i6ed0aGl51
	 Jm8loYHMOUULN24+ilDGW1fPAexCn0FqzxzD1WQlKy61U5rfvKZ4SyEv28wJBpW8n3
	 EEAZWuPUH3XiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid-acpi: Add PRP0001 to match table and OF
 alias
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_61698D7A14AC9BFE6C9F3FDB797FCA02E309@qq.com>
References: <tencent_61698D7A14AC9BFE6C9F3FDB797FCA02E309@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 16:00:52 +0000
Message-Id: <20260527160052.DB5EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Adding `PRP0001` directly to the ACPI match table incorrectly by=
passes `compatible` string matching, causing the driver to intercept all PR=
P0001 I2C devices and spam the kernel log.
--

commit 7d0ee8c935eaadd4f5e66e197d5712a960fd31f5
Author: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.com>

HID: i2c-hid-acpi: Add PRP0001 to match table and OF alias

This commit adds the PRP0001 ACPI ID to the i2c-hid-acpi driver's match
table and manually defines an OF module alias. This is intended to allow the
driver to probe devices that declare themselves as PRP0001 with a "hid-over=
-i2c"
compatible string in their _DSD.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c=
-hid-acpi.c
> index abd700a101f46..515ced22c978d 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> @@ -119,10 +119,30 @@ static int i2c_hid_acpi_probe(struct i2c_client *cl=
ient)
>  static const struct acpi_device_id i2c_hid_acpi_match[] =3D {
>  	{ "ACPI0C50" },
>  	{ "PNP0C50" },
> +	/*
> +	 * Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
> +	 * declare their I2C HID ACPI touchpad in the DSDT as _HID "PRP0001"
> +	 * with _DSD compatible "hid-over-i2c" instead of the standard
> +	 * "PNP0C50". This worked before i2c-hid was split into i2c-hid-acpi
> +	 * and i2c-hid-of, but PRP0001 devices on the ACPI bus are no longer
> +	 * probed after the split. The _DSM call in probe() naturally rejects
> +	 * PRP0001 devices that are not actually I2C HID, so matching PRP0001
> +	 * here is safe.
> +	 */
> +	{ "PRP0001" },

[Severity: Medium]
Does adding PRP0001 directly to the ACPI match table bypass the OF compatib=
le
string check in __acpi_match_device()?

PRP0001 is a special identifier used by the ACPI subsystem to defer matching
to the OF compatible string within the device's _DSD. When PRP0001 is
explicitly added here, the match returns true immediately without checking =
the
compatible string.

If a system has other unrelated I2C devices using PRP0001 (like temperature
sensors or RTCs utilizing compatible strings), won't the driver core attempt
to bind i2c-hid-acpi to all of them?

Because i2c_hid_acpi_probe() unconditionally evaluates the HID _DSM which w=
ill
fail for these unrelated devices, does this introduce boot delays and pollu=
te
the kernel log with false-positive "Error _DSM call to get HID descriptor
address failed" messages for every non-HID PRP0001 device?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, i2c_hid_acpi_match);
> =20
> +	/*
> +	 * When an ACPI device has a _DSD "compatible" property, the uevent
> +	 * modalias uses the OF format (of:N<name>T<compatible>) instead of
> +	 * the ACPI format (acpi:<HID>). Add an OF alias so udev can autoload
> +	 * this module for such devices. probe() will reject pure DT devices
> +	 * via the _DSM HID descriptor call.
> +	 */
> +MODULE_ALIAS("of:N*TChid-over-i2c");

[Severity: Medium]
Instead of manually defining this MODULE_ALIAS, could we define an
of_device_id match table containing { .compatible =3D "hid-over-i2c" }?

Using an of_device_id table would naturally solve the matching logic by
allowing the ACPI core to correctly evaluate the _DSD compatible string.
This prevents intercepting unrelated PRP0001 devices, and the driver core
would automatically generate the correct, robust module alias for autoloadi=
ng.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_61698D7A14A=
C9BFE6C9F3FDB797FCA02E309@qq.com?part=3D1
