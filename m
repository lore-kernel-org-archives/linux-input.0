Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936D3890E7;
	Wed,  3 Jun 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479828; cv=none; b=Vqkq9z1xI9WwutvkqOWmSf9qN2jCpSRdxYWvFZSPKDBiJdjQkllEtfFyEvMfRQjgRYPsvTHfPfF5RJm2Be/KFKHtS5NSHeXJiquAvncHpApzbl9gvzECVncdB5dIxXvDvUoImYv+oH+MAh9GGrKm6SuN72A4NnT6SOEdcdEfxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479828; c=relaxed/simple;
	bh=dNLYixGzwusYFKspD+4ExfeSr5L/4Ze3JJQfyIasP8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4h1YSGQtkD34GNtLkJ4RH+7RZ5EnsWB1MygVk9qkPlJPFiemEBIzzZCE5aOSZsc7Q3/HJ+cHY0EvnM2Bn7LKLd/I/sFwVWohfPzsHCsN+XmbWOGpsoOgltXwltfqHAliMXnUEJFqwCk3X5U+LBIWwxUbKgPGUUmxoEpm8HczgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzDC6bPD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzDC6bPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D8D1F00893;
	Wed,  3 Jun 2026 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479825;
	bh=3zCFS97MUzGzOVy5IMRxGryfcQ3lC3oNVG85FUtfzSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZzDC6bPDvHPFxb1Mycd57bCBl6itEAppy27mQcs9g74BETMM4lVnOVKlXAaGq6BL4
	 J/iXfBaKvC2CxRxE25XmmpUGjJ8bRuIBPbuc9bDNB1OTyCPuqjtwpbTwy8IVvSFzJE
	 Mp19OyfiucuA2Ew/f5UkL7KzFyiktlOkWWk6KocBHfqU54x0iXXJOP2z9RD9pkWXJo
	 PnXMNFN3JtlDaKViLA3S4Rnc+wZnC1bzILKs5Ez5xk5lmZ1VJ5Z1BmFFLHJyUf1O04
	 xE4CVlgB3pLGNMYrWvXatly9WtdaWw06kq0iHZ0FCF5kgOhrKFrGn7t4vWGz4gmW12
	 1JEMHdIsXhiNA==
Date: Wed, 3 Jun 2026 11:43:40 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@red54.com>
Cc: linux-input@vger.kernel.org, hansg@kernel.org, 
	dmitry.torokhov@gmail.com, dianders@chromium.org, jikos@kernel.org, 
	linux-kernel@vger.kernel.org, superm1@kernel.org, Pin-yen Lin <treapking@chromium.org>, 
	Xu Rao <raoxu@uniontech.com>, Kwok Kin Ming <kenkinming2002@gmail.com>, 
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 2/3] HID: i2c-hid: Move common ACPI _DSM helper into
 core
Message-ID: <ah_2JXN7AAos4kjM@beelink>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601181510.38705-1-Yeking@Red54.com>
 <tencent_71AA07C8BAF64FE0F9B0FDFC072BB08B3605@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_71AA07C8BAF64FE0F9B0FDFC072BB08B3605@qq.com>

On Jun 01 2026, 谢致邦 (XIE Zhibang) wrote:
> Move the _DSM call that gets the HID descriptor address from
> i2c-hid-acpi.c to a shared helper in i2c-hid-core.c so both
> i2c-hid-acpi.c and i2c-hid-of.c can use it.
> 
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-acpi.c | 32 ++++-----------------------
>  drivers/hid/i2c-hid/i2c-hid-core.c | 35 ++++++++++++++++++++++++++++++

I'm not a big fan of removing 25% of the i2c-hid-acpi.c code and inject
it in i2c-hid-core.c.

There's something I can't really understand in the problem:
- we are talking about non arm architecture, which should not have OF in
	them
- the current compatible hid-over-i2c loads the OF version?
- how can you make the device working without the couple of ACPI
	functions that are in the i2c-hid-acpi.c driver for powering up and
	down the device?

If the platform is indeed ACPI + x86(_64), then shouldn't we tackle the
problem in the i2c-hid-acpi driver, or add a secondary leaf driver for
this particular platform/device? Kind of what we have with
i2c-hid-of-elan.c

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.h      | 11 ++++++++++
>  3 files changed, 50 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> index f65fb6396b69..234789a07047 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> @@ -25,12 +25,12 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
> -#include <linux/uuid.h>
>  
>  #include "i2c-hid.h"
>  
>  struct i2c_hid_acpi {
>  	struct i2chid_ops ops;
> +	struct i2c_client *client;
>  	struct acpi_device *adev;
>  };
>  
> @@ -48,36 +48,11 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
>  	{ }
>  };
>  
> -/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
> -static guid_t i2c_hid_guid =
> -	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
> -		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
> -
> -static int i2c_hid_acpi_get_descriptor(struct i2c_hid_acpi *ihid_acpi)
> -{
> -	struct acpi_device *adev = ihid_acpi->adev;
> -	acpi_handle handle = acpi_device_handle(adev);
> -	union acpi_object *obj;
> -	u16 hid_descriptor_address;
> -
> -	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
> -				      ACPI_TYPE_INTEGER);
> -	if (!obj) {
> -		acpi_handle_err(handle, "Error _DSM call to get HID descriptor address failed\n");
> -		return -ENODEV;
> -	}
> -
> -	hid_descriptor_address = obj->integer.value;
> -	ACPI_FREE(obj);
> -
> -	return hid_descriptor_address;
> -}
> -
>  static void i2c_hid_acpi_restore_sequence(struct i2chid_ops *ops)
>  {
>  	struct i2c_hid_acpi *ihid_acpi = container_of(ops, struct i2c_hid_acpi, ops);
>  
> -	i2c_hid_acpi_get_descriptor(ihid_acpi);
> +	i2c_hid_core_acpi_get_descriptor(&ihid_acpi->client->dev);
>  }
>  
>  static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
> @@ -102,11 +77,12 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
>  	if (!ihid_acpi)
>  		return -ENOMEM;
>  
> +	ihid_acpi->client = client;
>  	ihid_acpi->adev = adev;
>  	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
>  	ihid_acpi->ops.restore_sequence = i2c_hid_acpi_restore_sequence;
>  
> -	ret = i2c_hid_acpi_get_descriptor(ihid_acpi);
> +	ret = i2c_hid_core_acpi_get_descriptor(dev);
>  	if (ret < 0)
>  		return ret;
>  	hid_descriptor_address = ret;
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 3adb16366e93..1e1a8df5686d 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1405,6 +1405,41 @@ const struct dev_pm_ops i2c_hid_core_pm = {
>  };
>  EXPORT_SYMBOL_GPL(i2c_hid_core_pm);
>  
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +
> +/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
> +static guid_t i2c_hid_guid =
> +	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
> +		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
> +
> +int i2c_hid_core_acpi_get_descriptor(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	acpi_handle handle;
> +	union acpi_object *obj;
> +	u16 hid_descriptor_address;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	handle = acpi_device_handle(adev);
> +	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
> +				      ACPI_TYPE_INTEGER);
> +	if (!obj) {
> +		acpi_handle_err(handle,
> +				"Error _DSM call to get HID descriptor address failed\n");
> +		return -ENODEV;
> +	}
> +
> +	hid_descriptor_address = obj->integer.value;
> +	ACPI_FREE(obj);
> +
> +	return hid_descriptor_address;
> +}
> +EXPORT_SYMBOL_GPL(i2c_hid_core_acpi_get_descriptor);
> +#endif
> +
>  MODULE_DESCRIPTION("HID over I2C core driver");
>  MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/i2c-hid/i2c-hid.h b/drivers/hid/i2c-hid/i2c-hid.h
> index 1724a435c783..bc8661c65b1a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.h
> +++ b/drivers/hid/i2c-hid/i2c-hid.h
> @@ -44,4 +44,15 @@ void i2c_hid_core_shutdown(struct i2c_client *client);
>  
>  extern const struct dev_pm_ops i2c_hid_core_pm;
>  
> +#ifdef CONFIG_ACPI
> +struct device;
> +int i2c_hid_core_acpi_get_descriptor(struct device *dev);
> +#else
> +struct device;
> +static inline int i2c_hid_core_acpi_get_descriptor(struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif
> -- 
> 2.54.0
> 
> 
