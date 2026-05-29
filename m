Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CC1514F8;
	Fri, 29 May 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066842; cv=none; b=uOA72/198pEIS1DuHfWFzip4RZyChOPajoo5/+WLoDN/CCl+oHw9KtFrPD9HGloxIelOVOQDWpdeIwVKW6ekTMPMRPgrkIOvx3+ogHmYr42dfajDVSuaZ3XR9XECzUkIdmPXf5ch909PhgEGm7URNjQH4Cwb0f8FTdpX7vAN9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066842; c=relaxed/simple;
	bh=TNZOPFxNEPTrNMie1Ig+gUhpqDwiGChOmaYDvG+sF/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otFIknBqykAYtUsP8gmsgfjwhu7jLlUMV973frXTErBAhPvb0ADAr2pM0hDmtaP9HFvhnr2U+CQt6apnnCl1rHrTzBqZBiYy/XirORcg4VZPti4wZ08WQ/i89JEjUGgcLxScazf5pkDW4LcBCGa9mleRm5pqb2fxNnOqsLlCifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKAiVQ7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKAiVQ7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6741F00893;
	Fri, 29 May 2026 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066841;
	bh=IFwu6gmxF3GUdsVKg8XME4FFJzrHXuIfsczE0sfIeRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MKAiVQ7ITbPmuW2X+nYkwEgwkY2I7+9vG0x3y5VGGDsGhm9J4xT6S13Wta8+5geO8
	 LG5NqOYc18KUrF3dWrdu6OdWD7XVbvPeK2fcC10lQNE5/B0MjdsxsQzLYBy6Ju6vyj
	 CFrbk0OiPOQBR10s57Gp0TVzKZp66s62sCnHrajdHbSBEUNlVei7QCuiAxdGcbdUPr
	 CRBarZaMIavFdngbRMqZVZBOSBORXUhIUKXxLqFQhqDWMHZdQgdA5thGNKRwOHzE3d
	 tf8TV2//OhOAeQYjpvK9NKLQL/8ntB5c0L/5AtPMY54IIJ0q6vAasHu04Lg+Asd8nQ
	 nlrVURL3IuiFw==
Message-ID: <7c2c86d8-be10-4e8e-8e96-d22788ec488f@kernel.org>
Date: Fri, 29 May 2026 17:00:37 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: i2c-hid-of: Fall back to ACPI _DSM when
 hid-descr-addr is missing
To: =?UTF-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>,
 linux-input@vger.kernel.org
Cc: bentiss@kernel.org, dianders@chromium.org, jikos@kernel.org,
 linux-kernel@vger.kernel.org, superm1@kernel.org
References: <9e5232a7-5b8b-4025-8a31-108eb164861e@kernel.org>
 <tencent_ECC71F91403F5AC69E1E6B963FA667ABF607@qq.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <tencent_ECC71F91403F5AC69E1E6B963FA667ABF607@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 29-May-26 14:16, 谢致邦 (XIE Zhibang) wrote:
> Before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are
> separate modules"), the unified i2c-hid driver handled both PNP0C50 ACPI
> devices and hid-over-i2c OF devices. After the split, devices with _HID
> "PRP0001" and _DSD compatible "hid-over-i2c" are only probed by
> i2c_hid_of, which requires "hid-descr-addr" in the _DSD. Some devices,
> for example the Lenovo KaiTian N60d and Inspur CP300L3, provide the HID
> descriptor address only through the _DSM method. Fall back to the _DSM
> call when the property is absent.
> 
> Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

Thank you for the new patch, this is an interesting approach and better
then the modalias magic from the previous version.

Note I'm not the i2c-hid maintainer, with that said I think this should
be acceptable. But currently it duplicates the _DSM handling code and
that should be fixed.

I think this should be changed to a series of 3 patches:

1. Move the i2c_hid_acpi_blacklist handling out of
   i2c_hid_acpi_get_descriptor() into i2c_hid_acpi_probe()
   to above the devm_kzalloc() call.

2. Move i2c_hid_acpi_get_descriptor() to a generic
   int i2c_hid_acpi_get_descriptor(struct device *dev)
   helper in drivers/hid/i2c-hid/i2c-hid-core.c .
   Wrapped in #ifdef CONFIG_ACPI and with a static inline
   stub in drivers/hid/i2c-hid/i2c-hid.h when CONFIG_ACPI
   is not set, e.g. in drivers/hid/i2c-hid/i2c-hid.h add:

#ifdef CONFIG_ACPI
	int i2c_hid_acpi_get_descriptor_address(struct device *dev);
#else
	static inline int i2c_hid_acpi_get_descriptor_address(struct device *dev)
	{
		return -ENODEV;
	}
#endif

3. Modify i2c-hid-of.c to try i2c_hid_acpi_get_descriptor_address() as
fallback for the missing "hid-descr-addr" property.  Please also add
a comment in the code explaining that this fallback is about ACPI I2C-hid
devices which use a "PRP0001" ACPI _HID with an "hid-over-i2c" compatible.

Regards,

Hans



> ---
>  drivers/hid/i2c-hid/i2c-hid-of.c | 44 ++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
> index 57379b77e977..62c089a6455a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
> @@ -19,6 +19,7 @@
>   * more details.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
> @@ -74,6 +75,39 @@ static void i2c_hid_of_power_down(struct i2chid_ops *ops)
>  			       ihid_of->supplies);
>  }
>  
> +#ifdef CONFIG_ACPI
> +/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
> +static guid_t i2c_hid_of_acpi_guid =
> +	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
> +		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
> +
> +/*
> + * Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
> + * declare their I2C HID touchpad with _HID "PRP0001" and _DSD compatible
> + * "hid-over-i2c" but lack the "hid-descr-addr" property. Use the _DSM
> + * method to obtain the HID descriptor address.
> + */
> +static int i2c_hid_of_acpi_get_descriptor(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	union acpi_object *obj;
> +	u16 addr;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	obj = acpi_evaluate_dsm_typed(acpi_device_handle(adev),
> +				      &i2c_hid_of_acpi_guid, 1, 1, NULL,
> +				      ACPI_TYPE_INTEGER);
> +	if (!obj)
> +		return -ENODEV;
> +
> +	addr = obj->integer.value;
> +	ACPI_FREE(obj);
> +	return addr;
> +}
> +#endif
> +
>  static int i2c_hid_of_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -92,6 +126,16 @@ static int i2c_hid_of_probe(struct i2c_client *client)
>  	ihid_of->ops.power_down = i2c_hid_of_power_down;
>  
>  	ret = device_property_read_u32(dev, "hid-descr-addr", &val);
> +#ifdef CONFIG_ACPI
> +	if (ret) {
> +		int dsm_ret = i2c_hid_of_acpi_get_descriptor(dev);
> +
> +		if (dsm_ret >= 0) {
> +			val = dsm_ret;
> +			ret = 0;
> +		}
> +	}
> +#endif
>  	if (ret) {
>  		dev_err(dev, "HID register address not provided\n");
>  		return -ENODEV;

