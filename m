From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: silead - Add support for setting resolution
 based on dmi data
Date: Sat, 21 Jan 2017 11:04:13 -0800
Message-ID: <20170121190413.GB36944@dtor-ws>
References: <20170102105538.4009-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35180 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdAUTFK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 14:05:10 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so7479749pfa.2
        for <linux-input@vger.kernel.org>; Sat, 21 Jan 2017 11:04:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170102105538.4009-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi Hans,

On Mon, Jan 02, 2017 at 11:55:38AM +0100, Hans de Goede wrote:
> On ACPI based tablets, the ACPI touchscreen node only contains info on
> the gpio and the irq, and is missing any info on the axis. This info is
> expected to be built into the tablet model specific version of the driver
> shipped with the os-image for the device.
> 
> Add support for getting the missing info from a table built into the
> driver, using dmi data to identify which entry of the table to use and
> add info for the CUBE iwork8 Air and Jumper EZpad mini3 tablets on which
> this code was tested / developed.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=187531
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Put the dmi code in a separate silead_dmi.c file
> -Use device_add_properties to add the info

This leaks data (device_add_properties() does deep copy of properties)
you unbind and rebind the driver.

Also I would prefer this all be kept in the swamp that is platform
drivers and I believe we have enough infrastructure to do just that.
Could you please tell me if the following version of the patch works on
your devices?

Note that I guessed the ACPI name for the Cube and EZpad is "FIXME" so
please adjust as needed.

Thanks!.

-- 
Dmitry


platform/x86: add support for devices with Silead touchscreens

From: Hans de Goede <hdegoede@redhat.com>

On ACPI based tablets, the ACPI touchscreen node only contains info on
the gpio and the irq, and is missing any info on the axis. This info is
expected to be built into the tablet model specific version of the driver
shipped with the os-image for the device.

Add support for getting the missing info from a table built into the
driver, using dmi data to identify which entry of the table to use and
add info for the CUBE iwork8 Air and Jumper EZpad mini3 tablets on which
this code was tested / developed.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=187531
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/Kconfig      |   14 +++
 drivers/platform/x86/Makefile     |    1 
 drivers/platform/x86/silead_dmi.c |  153 +++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/platform/x86/silead_dmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b8a21d7b25d4..85c27bc52478 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1027,4 +1027,18 @@ config INTEL_TELEMETRY
 	  used to get various SoC events and parameters
 	  directly via debugfs files. Various tools may use
 	  this interface for SoC state monitoring.
+
+config SILEAD_DMI
+	bool "Tablets with Silead touchscreens"
+	depends on ACPI && DMI && I2C && INPUT
+	---help---
+	  Certain ACPI based tablets with Silead touchscreens do not have
+	  enough data in ACPI tables for the touchscreen driver to handle
+	  the touchscreen properly, as OEMs expected the data to be baked
+	  into the tablet model specific version of the driver shipped
+	  with the os-image for the device. This option supplied the
+	  missing information. Enable it if you have one of the following
+	  tablets:
+	  - CUBE iwork8 Air
+	  - Jumper EZpad mini3
 endif # X86_PLATFORM_DEVICES
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2efa86d2a1a7..192a0a8b9a15 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -71,3 +71,4 @@ obj-$(CONFIG_INTEL_TELEMETRY)	+= intel_telemetry_core.o \
 				   intel_telemetry_pltdrv.o \
 				   intel_telemetry_debugfs.o
 obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
+obj-$(CONFIG_SLIEAD_DMI)	+= silead_dmi.o
diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
new file mode 100644
index 000000000000..28f5d69f707b
--- /dev/null
+++ b/drivers/platform/x86/silead_dmi.c
@@ -0,0 +1,153 @@
+/*
+ * Silead touchscreen driver DMI based configuration code
+ *
+ * Copyright (c) 2017 Red Hat Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Red Hat authors:
+ * Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/i2c.h>
+#include <linux/notifier.h>
+#include <linux/property.h>
+#include <linux/string.h>
+
+struct silead_ts_dmi_data {
+	const char *acpi_name;
+	struct property_entry *properties;
+};
+
+static struct property_entry cube_iwork8_air_props[] __initdata = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 900),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct silead_ts_dmi_data cube_iwork8_air_data __initconst = {
+	.acpi_name	= "GSL3670",
+	.properties	= cube_iwork8_air_props,
+};
+
+static struct property_entry jumper_ezpad_mini3_props[] __initdata = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1700),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-jumper-ezpad-mini3.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct silead_ts_dmi_data jumper_ezpad_mini3_data __initconst = {
+	.acpi_name	= "FIXME",
+	.properties	= jumper_ezpad_mini3_props,
+};
+
+static const struct dmi_system_id silead_ts_dmi_table[] __initconst = {
+	{
+		.ident = "CUBE iwork8 Air",
+		.driver_data = (void *)&cube_iwork8_air_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "cube"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i1-TF"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		},
+	},
+	{
+		.ident = "Jumper EZpad mini3",
+		.driver_data = (void *)&jumper_ezpad_mini3_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			/* jumperx.T87.KFBNEEA02 with the version-nr dropped */
+			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
+		},
+	},
+	{ },
+};
+
+static void __init silead_ts_dmi_add_props(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	const struct dmi_system_id *dmi_id;
+	const struct silead_ts_dmi_data *ts_data;
+	int error;
+
+	dmi_id = dmi_first_match(silead_ts_dmi_table);
+	if (dmi_id) {
+		ts_data = dmi_id->driver_data;
+		if (ACPI_COMPANION(dev) &&
+		    !strncmp(ts_data->acpi_name, client->name, I2C_NAME_SIZE)) {
+			error = device_add_properties(dev, ts_data->properties);
+			if (error)
+				dev_err(dev, "failed to add properties: %d\n",
+					error);
+		}
+	}
+}
+
+static int __init silead_ts_dmi_notifier_call(struct notifier_block *nb,
+					      unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		silead_ts_dmi_add_props(dev);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block silead_ts_dmi_notifier __initdata = {
+	.notifier_call = silead_ts_dmi_notifier_call,
+};
+
+static bool silead_ts_dmi_registered __initdata;
+
+static int __init silead_ts_dmi_init(void)
+{
+	int error;
+
+	error = bus_register_notifier(&i2c_bus_type, &silead_ts_dmi_notifier);
+	if (error) {
+		pr_err("%s: failed to register i2c bus notifier: %d\n",
+			__func__, error);
+		return error;
+	}
+
+	silead_ts_dmi_registered = true;
+	return 0;
+}
+/*
+ * We are registering out notifier after i2c core is initialized and i2c bus
+ * itself is ready (which happens at postcore initcall level), but before
+ * ACPI starts enumerating devices (at sysbsys initcall level).
+ */
+arch_initcall(silead_ts_dmi_init);
+
+static int __init silead_ts_dmi_exit(void)
+{
+	if (silead_ts_dmi_registered)
+		bus_unregister_notifier(&i2c_bus_type, &silead_ts_dmi_notifier);
+
+	return 0;
+}
+/*
+ * We do not expect touchscreen ACPI devices come and go, so we can unregister
+ * and free memory once we get to late initcalls.
+ */
+late_initcall(silead_ts_dmi_exit);
