Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B736C59A;
	Mon,  8 Jun 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919481; cv=none; b=V8xozsQySXSPVoOKjVKFgHlzsLXUEJTQ3vu2yvt5+nWVj+B4o7eRq8ZBC8qDULT65NN+OKpqDUReVw2kAShUwnLWziDNF94kBpZw5MVzZQHm058N0xhxWp00Cb/eNQQt4wU16uWi0BLVW1HAPX6BUiGTUyAeGpZEFM++GDj+fEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919481; c=relaxed/simple;
	bh=4jYDo5FA6RA1SwQ8QMSez7KuwDHb70Fi/KIk/MnbRZw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=trWtqZryotIXmV3DbAFg+Raws9m3bPvY2dkpnirnuTFJj+9TMqX+ObB7ub1UiZyU4PHl+VKca1ujaxDsiw2hUM3P6uo74u2IlXI2PwPgT+8NwVuU93fmaELKMWxjO72sGYiTixQKXw8yg/wYSiadnEZO/6EXeKuFMSPJ6sme17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCefKW1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCefKW1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E086A1F00893;
	Mon,  8 Jun 2026 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780919479;
	bh=kjUsxyAhs21kKIejldqmzZPTinLop68m+4ytE9p7k8U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SCefKW1zs/+VV9CkxDjH65tWgOgiXoYtuCprDc0LdYpzPXqDPP8sWPPoNjrf7XrpA
	 udl9YopjGKPBAfb2r9VZo6/4+iHUI8csSeTEMTAgQj9u2gS9O9NpC9A3xonnaLtFke
	 XMxz2nW9P/0ZZfQmdFJdVdXrtaYNK2aSRjmFq1ZlADzSouUH/S1IFV/VzfQ0u/N7XA
	 xcT5XWwwpwL6sYW1N0/jUB8rQu1bnKImd6BmpjFy/4NwtNdw3p1Fk1NkaJLGExEp3E
	 rzDzUDXzE8m7msdmSN68jZktG97FSyRe6BuFQ0cmYhvdx+xqXT5wa0WSA0ImHPaap8
	 s/XxbLypSwSfA==
Message-ID: <4243c594-6535-4111-86cb-69784b0a34b7@kernel.org>
Date: Mon, 8 Jun 2026 13:51:16 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] HID: i2c-hid: Refactor _DSM helper and add
 i2c-hid-acpi-prp0001 driver
From: Hans de Goede <hansg@kernel.org>
To: =?UTF-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>,
 linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, bentiss@kernel.org
Cc: dianders@chromium.org, jikos@kernel.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, superm1@kernel.org
References: <tencent_3310584FFECD3CBBB563FC8C079ED072F40A@qq.com>
 <tencent_E0B44D3DB1D67A7F20CF82ED6D3F0881FE08@qq.com>
 <52c113ef-e81e-476a-a62c-3cd09e7fdcbf@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <52c113ef-e81e-476a-a62c-3cd09e7fdcbf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8-Jun-26 1:48 PM, Hans de Goede wrote:
> Hi,
> 
> On 6-Jun-26 6:06 PM, 谢致邦 (XIE Zhibang) wrote:
>> Move the _DSM call that gets the HID descriptor address from
>> i2c-hid-acpi.c into i2c-hid-acpi.h as a static inline so both the ACPI
>> and the new PRP0001 driver can use it. While refactoring, move the
>> blacklist check and the _DSM call to the top of probe() to avoid a
>> pointless alloc when the device is blacklisted or does not implement the
>> _DSM.
>>
>> Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
>> are declared with _HID "PRP0001" and _DSD compatible "hid-over-i2c" but
>> lack "hid-descr-addr" from the _DSD and provide the HID descriptor
>> address only through an ACPI _DSM. The OF driver fails to probe them
>> because it requires hid-descr-addr. Add a new driver that handles these
>> devices by calling the shared _DSM helper.
>>
>> Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
>> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> Thank you for the new version.
> 
>> ---
>> v2: Name the unused parameter and document why
>> acpi_device_fix_up_power() is skipped.
>> v3: Add a dev_warn() asking users to contact vendors for firmware
>> updates, and use existing locals in devm_kzalloc() and
>> acpi_device_fix_up_power().
>>
>>  drivers/hid/i2c-hid/Kconfig                | 18 ++++
>>  drivers/hid/i2c-hid/Makefile               |  1 +
>>  drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c | 98 ++++++++++++++++++++++
>>  drivers/hid/i2c-hid/i2c-hid-acpi.c         | 52 ++++--------
>>  drivers/hid/i2c-hid/i2c-hid-acpi.h         | 32 +++++++
>>  5 files changed, 163 insertions(+), 38 deletions(-)
>>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
>>  create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.h
>>
>> diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
>> index e8d51f410cc1..7db8b2abff78 100644
>> --- a/drivers/hid/i2c-hid/Kconfig
>> +++ b/drivers/hid/i2c-hid/Kconfig
>> @@ -22,6 +22,24 @@ config I2C_HID_ACPI
>>  	  will be called i2c-hid-acpi.  It will also build/depend on the
>>  	  module i2c-hid.
>>  
>> +config I2C_HID_ACPI_PRP0001
>> +	tristate "Driver for PRP0001 devices missing hid-descr-addr"
>> +	depends on ACPI
>> +	depends on DRM || !DRM
>> +	select I2C_HID_CORE
>> +	help
>> +	  Say Y here if you want support for I2C HID touchpads that
>> +	  are declared with _HID "PRP0001" and _DSD compatible
>> +	  "hid-over-i2c" but lack the "hid-descr-addr" property from
>> +	  the _DSD. The HID descriptor address is instead provided
>> +	  through an ACPI _DSM. Known affected devices include the
>> +	  Lenovo KaiTian N60d and Inspur CP300L3.
>> +
>> +	  If unsure, say N.
>> +
>> +	  This support is also available as a module. If so, the
>> +	  module will be called i2c-hid-acpi-prp0001.
>> +
>>  config I2C_HID_OF
>>  	tristate "HID over I2C transport layer Open Firmware driver"
>>  	# No "depends on OF" because this can also be used for manually
>> diff --git a/drivers/hid/i2c-hid/Makefile b/drivers/hid/i2c-hid/Makefile
>> index 55bd5e0f35af..da420c1a8ec6 100644
>> --- a/drivers/hid/i2c-hid/Makefile
>> +++ b/drivers/hid/i2c-hid/Makefile
>> @@ -9,6 +9,7 @@ i2c-hid-objs					=  i2c-hid-core.o
>>  i2c-hid-$(CONFIG_DMI)				+= i2c-hid-dmi-quirks.o
>>  
>>  obj-$(CONFIG_I2C_HID_ACPI)			+= i2c-hid-acpi.o
>> +obj-$(CONFIG_I2C_HID_ACPI_PRP0001)		+= i2c-hid-acpi-prp0001.o
>>  obj-$(CONFIG_I2C_HID_OF)			+= i2c-hid-of.o
>>  obj-$(CONFIG_I2C_HID_OF_ELAN)			+= i2c-hid-of-elan.o
>>  obj-$(CONFIG_I2C_HID_OF_GOODIX)			+= i2c-hid-of-goodix.o
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
>> new file mode 100644
>> index 000000000000..b54370a938ab
>> --- /dev/null
>> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * HID over I2C driver for PRP0001 devices missing hid-descr-addr
>> + *
>> + * Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3, use
>> + * _HID "PRP0001" with _DSD compatible "hid-over-i2c" but lack "hid-descr-addr"
>> + * from the _DSD. The HID descriptor address is provided only through an ACPI
>> + * _DSM. The TPD0 node in the DSDT shows _DSM Function 1 returning 0x20.
>> + *
>> + * Copyright (C) 2026 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +
>> +#include "i2c-hid.h"
>> +#include "i2c-hid-acpi.h"
>> +
>> +static int i2c_hid_acpi_prp0001_power_up(struct i2chid_ops *ops)
>> +{
>> +	/* give the device time to power up */
>> +	msleep(250);
>> +	return 0;
>> +}
>> +
>> +static struct i2chid_ops i2c_hid_acpi_prp0001_ops = {
>> +	.power_up = i2c_hid_acpi_prp0001_power_up,
>> +	/*
>> +	 * No .restore_sequence needed: the _DSM on these devices returns a
>> +	 * constant (0x20) with no side effects, unlike some PNP0C50 _DSM
>> +	 * implementations that switch the hardware between PS/2 and I2C modes.
>> +	 */
>> +};
>> +
>> +static int i2c_hid_acpi_prp0001_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct acpi_device *adev;
>> +	u16 hid_descriptor_address;
>> +	int ret;
>> +
>> +	/* If hid-descr-addr is present, let i2c-hid-of handle it */
>> +	if (device_property_present(dev, "hid-descr-addr"))
>> +		return -ENODEV;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return -ENODEV;
>> +
>> +	ret = i2c_hid_acpi_get_descriptor(adev);
>> +	if (ret < 0)
>> +		return ret;
>> +	dev_warn(dev,
>> +		 "hid-descr-addr device property NOT found, using ACPI _DSM fallback. Contact vendor for firmware update!\n");
>> +	hid_descriptor_address = ret;
>> +
>> +	/*
>> +	 * No acpi_device_fix_up_power() needed: TPD0 has no _PS0, _PS3, _PSC
>> +	 * or _PRx methods and follows I2C bus power.
>> +	 */
>> +	return i2c_hid_core_probe(client, &i2c_hid_acpi_prp0001_ops,
>> +				  hid_descriptor_address, 0);
>> +}
>> +
>> +static const struct of_device_id i2c_hid_acpi_prp0001_of_match[] = {
>> +	{ .compatible = "hid-over-i2c" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, i2c_hid_acpi_prp0001_of_match);
>> +
>> +static const struct i2c_device_id i2c_hid_acpi_prp0001_id[] = {
>> +	{ .name = "hid-over-i2c" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, i2c_hid_acpi_prp0001_id);
>> +
>> +static struct i2c_driver i2c_hid_acpi_prp0001_driver = {
>> +	.driver = {
>> +		.name	= "i2c_hid_acpi_prp0001",
>> +		.pm	= &i2c_hid_core_pm,
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +		.of_match_table = of_match_ptr(i2c_hid_acpi_prp0001_of_match),
>> +	},
>> +
>> +	.probe		= i2c_hid_acpi_prp0001_probe,
>> +	.remove		= i2c_hid_core_remove,
>> +	.shutdown	= i2c_hid_core_shutdown,
>> +	.id_table	= i2c_hid_acpi_prp0001_id,
>> +};
>> +
>> +module_i2c_driver(i2c_hid_acpi_prp0001_driver);
>> +
>> +MODULE_DESCRIPTION("HID over I2C driver for PRP0001 devices missing hid-descr-addr");
>> +MODULE_AUTHOR("谢致邦 (XIE Zhibang) <Yeking@Red54.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
>> index abd700a101f4..13f977d6aab6 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
>> @@ -25,9 +25,9 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/pm.h>
>> -#include <linux/uuid.h>
>>  
>>  #include "i2c-hid.h"
>> +#include "i2c-hid-acpi.h"
>>  
>>  struct i2c_hid_acpi {
>>  	struct i2chid_ops ops;
>> @@ -48,39 +48,11 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
>>  	{ }
>>  };
>>  
>> -/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
>> -static guid_t i2c_hid_guid =
>> -	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
>> -		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
>> -
>> -static int i2c_hid_acpi_get_descriptor(struct i2c_hid_acpi *ihid_acpi)
>> -{
>> -	struct acpi_device *adev = ihid_acpi->adev;
>> -	acpi_handle handle = acpi_device_handle(adev);
>> -	union acpi_object *obj;
>> -	u16 hid_descriptor_address;
>> -
>> -	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
>> -		return -ENODEV;
>> -
>> -	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
>> -				      ACPI_TYPE_INTEGER);
>> -	if (!obj) {
>> -		acpi_handle_err(handle, "Error _DSM call to get HID descriptor address failed\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	hid_descriptor_address = obj->integer.value;
>> -	ACPI_FREE(obj);
>> -
>> -	return hid_descriptor_address;
>> -}
>> -
> 
> Instead of moving this to i2c-hid-acpi.h, please make it non static an
> export it using EXPORT_SYMBOL_GPL() and only put a prototype in i2c-hid-acpi.h .

I just noticed i2c-hid-acpi.h is a whole new file. No need to add that just for
the prototype (I think / IMHO).

So for the next version just export the function from i2c-hid-acpi.c and
add a prototype declaration directly in i2c-hid-acpi-prp0001.c

Regards,
 
Hans



>>  static void i2c_hid_acpi_restore_sequence(struct i2chid_ops *ops)
>>  {
>>  	struct i2c_hid_acpi *ihid_acpi = container_of(ops, struct i2c_hid_acpi, ops);
>>  
>> -	i2c_hid_acpi_get_descriptor(ihid_acpi);
>> +	i2c_hid_acpi_get_descriptor(ihid_acpi->adev);
>>  }
>>  
>>  static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
>> @@ -93,24 +65,28 @@ static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
>>  static int i2c_hid_acpi_probe(struct i2c_client *client)
>>  {
>>  	struct device *dev = &client->dev;
>> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>>  	struct i2c_hid_acpi *ihid_acpi;
>>  	u16 hid_descriptor_address;
>>  	int ret;
>>  
>> -	ihid_acpi = devm_kzalloc(&client->dev, sizeof(*ihid_acpi), GFP_KERNEL);
>> +	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
>> +		return -ENODEV;
>> +
>> +	ret = i2c_hid_acpi_get_descriptor(adev);
>> +	if (ret < 0)
>> +		return ret;
>> +	hid_descriptor_address = ret;
>> +
>> +	ihid_acpi = devm_kzalloc(dev, sizeof(*ihid_acpi), GFP_KERNEL);
>>  	if (!ihid_acpi)
>>  		return -ENOMEM;
>>  
>> -	ihid_acpi->adev = ACPI_COMPANION(dev);
>> +	ihid_acpi->adev = adev;
>>  	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
>>  	ihid_acpi->ops.restore_sequence = i2c_hid_acpi_restore_sequence;
>>  
>> -	ret = i2c_hid_acpi_get_descriptor(ihid_acpi);
>> -	if (ret < 0)
>> -		return ret;
>> -	hid_descriptor_address = ret;
>> -
>> -	acpi_device_fix_up_power(ihid_acpi->adev);
>> +	acpi_device_fix_up_power(adev);
>>  
>>  	return i2c_hid_core_probe(client, &ihid_acpi->ops,
>>  				  hid_descriptor_address, 0);
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.h b/drivers/hid/i2c-hid/i2c-hid-acpi.h
>> new file mode 100644
>> index 000000000000..8cebbeebcc23
>> --- /dev/null
>> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef _I2C_HID_ACPI_H
>> +#define _I2C_HID_ACPI_H
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/uuid.h>
>> +
>> +static inline int i2c_hid_acpi_get_descriptor(struct acpi_device *adev)
>> +{
>> +	/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
>> +	static const guid_t i2c_hid_guid =
>> +		GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
>> +			  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
>> +
>> +	acpi_handle handle = acpi_device_handle(adev);
>> +	union acpi_object *obj;
>> +	u16 addr;
>> +
>> +	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid,
>> +				      1, 1, NULL, ACPI_TYPE_INTEGER);
>> +	if (!obj) {
>> +		acpi_handle_err(handle, "Error _DSM call to get HID descriptor address failed\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	addr = obj->integer.value;
>> +	ACPI_FREE(obj);
>> +	return addr;
>> +}
>> +
>> +#endif
> 
> 
> 
> 

