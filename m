Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CE3E9C3B;
	Wed, 27 May 2026 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896658; cv=none; b=eOfUfEYnfvdR01yaxxcBxJALa8il3/Dgio3HWLAKB6Qgbu9YCpHzC8TbRUyqwkiv4A08H+ZvbCaybaembvXFq4lk+r+r7qpBJXEx7M0SrdbaG1nzdWw1qrEi+MkRxFzo6qvxuT2EYClY7nTgjyPJj4y7kKiGCT+igU+T8AfLUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896658; c=relaxed/simple;
	bh=JnF4/weZhOgIuXmbvqtbNf0Kb1woraVRoUsEeRdJNOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfCZrK28ndCVm7aLtzYT+T6/nMmdGPJtajfQQjDKsikpylbZVR89Uoo/uKgcUe46Wipt6Ja104IIIky+okr97f82fVH5fWzgIiEtQgrjpkK9eaAAuJsa0Y/d1AuUqL7vOXKRQn/nItaO+AXLPSHleq/kaWIWyQzIZZU2gaiSRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m10hRevu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m10hRevu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FF71F000E9;
	Wed, 27 May 2026 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896656;
	bh=dqXPAnKCiFNWb1oo85y0KguEv6Y0dIwX6RxLpACYkDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m10hRevuErz73InoBSvhWIA1kXEgVBa2cvXYj8vV8yCwi8/tHD2QkCgx8RtOA5Peg
	 G63CJCLe6lUex2PpO8LXGWx7zfESLUuulKOTXxD23SLPPA7jkiCwraM0e+evvTsYi9
	 0vgqj/4d8IxOAP34xm/HwEulOjTHED0D+3Zfd7F6+YSS59t88PEU9mo581ndS6u991
	 VFg/OCBvoVjkGBT5KW5OesHd3RNd6U/EO52jKB+ebxMiKWMkn3RxtbTy9DZq/dUcLG
	 iXICbvI+tF+A5665fY4Ov9Q5Q8IVjDKuJ3vUZpGAfXA/nfAVi7ogXnVwoDze759iQc
	 aCVdhE/rAoP/A==
Message-ID: <9e5232a7-5b8b-4025-8a31-108eb164861e@kernel.org>
Date: Wed, 27 May 2026 17:44:13 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: i2c-hid-acpi: Add PRP0001 to match table and OF
 alias
To: =?UTF-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>,
 linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
References: <tencent_61698D7A14AC9BFE6C9F3FDB797FCA02E309@qq.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <tencent_61698D7A14AC9BFE6C9F3FDB797FCA02E309@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 27-May-26 17:17, 谢致邦 (XIE Zhibang) wrote:
> Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
> declare their I2C HID ACPI touchpad in the DSDT as _HID "PRP0001" with
> _DSD compatible "hid-over-i2c" instead of the standard "PNP0C50". This
> worked before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and
> OF are separate modules"), but after the split, PRP0001 devices on the
> ACPI bus are no longer probed by either driver.
> 
> Fix this by adding PRP0001 to i2c_hid_acpi_match so the driver probes
> these devices. The existing _DSM HID descriptor call in probe()
> naturally rejects any PRP0001 device that does not implement the
> protocol.
> 
> A MODULE_ALIAS is also needed for autoloading: when an ACPI device has a
> _DSD "compatible" property, the uevent modalias uses the OF format
> (of:N<name>T<compatible>) instead of the ACPI format (acpi:<HID>), so
> udev would otherwise load only i2c-hid-of, which fails to probe because
> these devices lack the "hid-descr-addr" property.

Ok, so first of all please contact the vendors of these devices to fix
their firmware.

Either a _HID "PRP0001" value should be used with a *full* of description
matching the binding from Documentation/devicetree/bindings/input/hid-over-i2c.yaml
including hid-descr-addr. Or the firmware should use PNP0C50 + the _DSM
method to get the hid-desc-addr. Mixing and matching these 2 is bad,
very very bad.

IMHO the fix here as is is not acceptable this will make the i2c_hid_acpi
module load and worse *probe* every ACPI device with a "PRP0001" HID.

You claim the existing _DSM HID descriptor call will save the driver from
actually doing much of anything but IMHO that should not be relied on.

Currently the i2c_hid_of driver will get automatically loaded + try
to probe the device, but as you say this will fail due to lacking
hid-desc-addr. Have you tried adding DMI quirks to i2c_hid_of to
provide the hid-desc-addr through a quirk?  (I wonder if the IRQ will
get picked up ok)

That seems a better solution than making 2 drivers probe the same
"hid-over-i2c" compatible and let one fail (with an ugly error msg
in the logs), while also making i2c_hid_acpi probe all PRP0001 devices
and make that fail (with more err logging) on all other devices.

I see the 2 laptops here are both using a Loongson architecture,
so any fix for this should IMHO also be wrapped in
#ifdef CONFIG_LOONGARCH ... #endif

Regards,

Hans





> 
> Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-acpi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> index abd700a101f4..515ced22c978 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> @@ -119,10 +119,30 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
>  static const struct acpi_device_id i2c_hid_acpi_match[] = {
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
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, i2c_hid_acpi_match);
>  
> +	/*
> +	 * When an ACPI device has a _DSD "compatible" property, the uevent
> +	 * modalias uses the OF format (of:N<name>T<compatible>) instead of
> +	 * the ACPI format (acpi:<HID>). Add an OF alias so udev can autoload
> +	 * this module for such devices. probe() will reject pure DT devices
> +	 * via the _DSM HID descriptor call.
> +	 */
> +MODULE_ALIAS("of:N*TChid-over-i2c");
> +
>  static struct i2c_driver i2c_hid_acpi_driver = {
>  	.driver = {
>  		.name	= "i2c_hid_acpi",

