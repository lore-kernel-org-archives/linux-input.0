From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4] platform/x86: add support for devices with Silead
 touchscreens
Date: Mon, 23 Jan 2017 18:23:00 +0100
Message-ID: <ff85dff5-7b4b-ffd2-b524-d1a289c47a5d@redhat.com>
References: <20170122201230.31681-1-hdegoede@redhat.com>
 <20170122222903.GD31009@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdAWRXE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Jan 2017 12:23:04 -0500
In-Reply-To: <20170122222903.GD31009@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi,

On 22-01-17 23:29, Dmitry Torokhov wrote:
> On Sun, Jan 22, 2017 at 09:12:30PM +0100, Hans de Goede wrote:
>> On ACPI based tablets, the ACPI touchscreen node only contains info on
>> the gpio and the irq, and is missing any info on the axis. This info is
>> expected to be built into the tablet model specific version of the driver
>> shipped with the os-image for the device.
>>
>> Add support for getting the missing info from a table built into the
>> driver, using dmi data to identify which entry of the table to use and
>> add info for the CUBE iwork8 Air and Jumper EZpad mini3 tablets on which
>> this code was tested / developed.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=187531
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> [dmitry.torokhov@gmail.com: Move to platform/x86]
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>> Changes in v2:
>> -Put the dmi code in a separate silead_dmi.c file
>> -Use device_add_properties to add the info
>> Changes in v3 (Dmitry Torokhov):
>> -Move the silead_dmi code to drivers/platform/x86
>> Changes in v4:
>> -Minor spelling and code-style fixes based on review from
>>  Andy Shevchenko
>> ---
>>  MAINTAINERS                       |   8 +++
>>  drivers/platform/x86/Kconfig      |  11 +++
>>  drivers/platform/x86/Makefile     |   1 +
>>  drivers/platform/x86/silead_dmi.c | 136 ++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 156 insertions(+)
>>  create mode 100644 drivers/platform/x86/silead_dmi.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bdc4843..5591ac3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11255,6 +11255,14 @@ F:	drivers/media/usb/siano/
>>  F:	drivers/media/usb/siano/
>>  F:	drivers/media/mmc/siano/
>>
>> +SILEAD TOUCHSCREEN DRIVER
>> +M:	Hans de Goede <hdegoede@redhat.com>
>> +L:	linux-input@vger.kernel.org
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/input/touchscreen/silead.c
>> +F:	drivers/platform/x86/silead_dmi.c
>> +
>>  SIMPLEFB FB DRIVER
>>  M:	Hans de Goede <hdegoede@redhat.com>
>>  L:	linux-fbdev@vger.kernel.org
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 59aa8e3..03e5347 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1076,4 +1076,15 @@ config MLX_CPLD_PLATFORM
>>  	  This driver handles hot-plug events for the power suppliers, power
>>  	  cables and fans on the wide range Mellanox IB and Ethernet systems.
>>
>> +config SILEAD_DMI
>> +	bool "Tablets with Silead touchscreens"
>> +	depends on ACPI && DMI && I2C && INPUT
>> +	---help---
>> +	  Certain ACPI based tablets with Silead touchscreens do not have
>> +	  enough data in ACPI tables for the touchscreen driver to handle
>> +	  the touchscreen properly, as OEMs expected the data to be baked
>> +	  into the tablet model specific version of the driver shipped
>> +	  with the OS-image for the device. This option supplies the missing
>> +	  information. Enable this for x86 tablets with Silead touchscreens.
>> +
>>  endif # X86_PLATFORM_DEVICES
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index d4111f0..840b07b 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -76,3 +76,4 @@ obj-$(CONFIG_INTEL_TELEMETRY)	+= intel_telemetry_core.o \
>>  obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
>>  obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
>>  obj-$(CONFIG_MLX_CPLD_PLATFORM)	+= mlxcpld-hotplug.o
>> +obj-$(CONFIG_SILEAD_DMI)	+= silead_dmi.o
>> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
>> new file mode 100644
>> index 0000000..2dd7671
>> --- /dev/null
>> +++ b/drivers/platform/x86/silead_dmi.c
>> @@ -0,0 +1,136 @@
>> +/*
>> + * Silead touchscreen driver DMI based configuration code
>> + *
>> + * Copyright (c) 2017 Red Hat Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * Red Hat authors:
>> + * Hans de Goede <hdegoede@redhat.com>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/dmi.h>
>> +#include <linux/i2c.h>
>> +#include <linux/notifier.h>
>> +#include <linux/property.h>
>> +#include <linux/string.h>
>> +
>> +struct silead_ts_dmi_data {
>> +	const char *acpi_name;
>> +	struct property_entry *properties;
>> +};
>> +
>> +static struct property_entry cube_iwork8_air_props[] = {
>> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
>> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 900),
>> +	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
>> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +	{ }
>> +};
>> +
>> +static const struct silead_ts_dmi_data cube_iwork8_air_data = {
>> +	.acpi_name	= "MSSL1680:00",
>> +	.properties	= cube_iwork8_air_props,
>> +};
>> +
>> +static struct property_entry jumper_ezpad_mini3_props[] = {
>> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1700),
>> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
>> +	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-jumper-ezpad-mini3.fw"),
>> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +	{ }
>> +};
>> +
>> +static const struct silead_ts_dmi_data jumper_ezpad_mini3_data = {
>> +	.acpi_name	= "MSSL1680:00",
>> +	.properties	= jumper_ezpad_mini3_props,
>> +};
>> +
>> +static const struct dmi_system_id silead_ts_dmi_table[] = {
>> +	{
>> +		.ident = "CUBE iwork8 Air",
>
> We are not actually using ident data so I'd suggest dropping it as it
> just wastes space.

Good point, since the info is useful for humans I've changed this to comments.

>
>> +		.driver_data = (void *)&cube_iwork8_air_data,
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "cube"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "i1-TF"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>> +		},
>> +	},
>> +	{
>> +		.ident = "Jumper EZpad mini3",
>> +		.driver_data = (void *)&jumper_ezpad_mini3_data,
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
>> +			/* jumperx.T87.KFBNEEA02 with the version-nr dropped */
>> +			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
>> +		},
>> +	},
>> +	{ },
>> +};
>> +
>> +static void silead_ts_dmi_add_props(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	const struct dmi_system_id *dmi_id;
>> +	const struct silead_ts_dmi_data *ts_data;
>> +	int error;
>> +
>> +	dmi_id = dmi_first_match(silead_ts_dmi_table);
>> +	if (!dmi_id)
>> +		return;
>> +
>> +	ts_data = dmi_id->driver_data;
>> +	if (ACPI_COMPANION(dev) &&
>> +	    !strncmp(ts_data->acpi_name, client->name, I2C_NAME_SIZE)) {
>> +		error = device_add_properties(dev, ts_data->properties);
>> +		if (error)
>> +			dev_err(dev, "failed to add properties: %d\n", error);
>> +	}
>> +}
>> +
>> +static int silead_ts_dmi_notifier_call(struct notifier_block *nb,
>> +				       unsigned long action, void *data)
>> +{
>> +	struct device *dev = data;
>> +
>> +	switch (action) {
>> +	case BUS_NOTIFY_ADD_DEVICE:
>> +		silead_ts_dmi_add_props(dev);
>> +		break;
>> +
>> +	default:
>> +		break;
>
> Given that we have to keep the notifier around I think you need to
> handle BUS_NOTIFY_DEL_DEVICE as well and remove properties that you
> added.

There is no way to remove a specific set of added properties, only
all properties can be removed by calling device_remove_properties(dev)
which is already called from drivers/base/core.c by device_del()
which is also the function doing the BUS_NOTIFY_DEL_DEVICE notification.

So this is taken care of by the device model core.

> For that I think you need to keep track if you actually successfully
> added the properties in the first place.
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct notifier_block silead_ts_dmi_notifier = {
>> +	.notifier_call = silead_ts_dmi_notifier_call,
>> +};
>> +
>> +static int __init silead_ts_dmi_init(void)
>> +{
>> +	int error;
>> +
>> +	error = bus_register_notifier(&i2c_bus_type, &silead_ts_dmi_notifier);
>> +	if (error)
>> +		pr_err("%s: failed to register i2c bus notifier: %d\n",
>> +			__func__, error);
>
> Given that notifier code sticks around I wonder if it would be worth it
> to do DMI check upfront. If we do not find it then do not register
> anything, and if we do find our device then do a deep copy of
> silead_ts_dmi_data and save it. This will allow us to mark all data
> structures as __initdata and probably save some memory, especially if we
> need to add more devices to the DMI tables.

Good idea, I will send a follow up patch implementing this when your
device_property patches adding helpers for this have been merged.

Regards,

Hans



>
>> +
>> +	return error;
>> +}
>> +
>> +/*
>> + * We are registering out notifier after i2c core is initialized and i2c bus
>> + * itself is ready (which happens at postcore initcall level), but before
>> + * ACPI starts enumerating devices (at subsys initcall level).
>> + */
>> +arch_initcall(silead_ts_dmi_init);
>> --
>> 2.9.3
>>
>
>
> Thanks.
>
