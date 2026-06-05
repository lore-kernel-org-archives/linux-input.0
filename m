Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D53B6366;
	Fri,  5 Jun 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623041; cv=none; b=k6k8dv/2sKlqB1QCW0rKAs2H5/YA3Spn1NogJYa8Me7wqW+G1Z2nzS2iC9B30jYrg6jhqnt2amc6HMjh1ftXrr9eSMfkEiKISkGzzDCYLo60C/X+2qbnbzONRIwHW7+BzUIeMYDDNQbGG3RLYLnYqPRiZrq+0bIhS+aQ5ZTvkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623041; c=relaxed/simple;
	bh=FJFMmh5cUr5bEu2i4rCbyeVU/VAQXMqIf8Hwix3chFQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjIaMsIKueqmuMoD/esjMHnhJLwGIFb5kSLLX/lv7H+BnGTgJoBjQR5D9rnirIjydGMbPhiyydeg0+stklNxQrKXsQIAhPiR40abEkZ6WS8y43d0Q2B/LEt1mfasBQCWct/z+IUmJKaBdCK13q1Qbp/5Qifvx8vDYhjIkUtBRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GJvvF5VZ; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GJvvF5VZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780623030; bh=ezkyX25GDh8Q4JzBYlkMGsBnpaN/xENB2KJZBPecxpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJvvF5VZLiMWKq5WxBnH5cH6ko+DFcH4FsRkLgv2/89vrd7PS39tUTHgmgqGZSf5N
	 vVjAMXkOiY5nVfOv/HwN2aB3jtdPnq3av1S6Nn8g3ar3+AQv8o+bgkecT2k9VsJOQM
	 ivU78gAJZzMmAERvWCgA7xUmfewQFJTbRU6oW2do=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 788A202B; Fri, 05 Jun 2026 09:30:08 +0800
X-QQ-mid: xmsmtpt1780623008tjxoa48u1
Message-ID: <tencent_9F8936ABE7C35AED6FF779A83DFF2729D005@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuEdwMDeJkwBaad7MKFcI1L9qld9eqbzeREY5rFYrUMD3Tw00Aok
	 8jnp/94fOs6FCEzM35ATeAVi6/2CQx6KLJ5KrbFvMiE3ZhpM6oXzDj/adsd8EipF7+as0Ri+Xtvz
	 oca1ENLkFixQqN/GDcmePJ0nSe/w9CJ1npzQZ8Oo+zVnm4UeqxlzcGkJjmZHxc4HndXWhHmiNSqJ
	 FNy01YLz6GC0ErwZOQ1iIYhkhZXI0P6NUhJ171+drEHsclGDsiFjYJrl9MymyEcZ1sD+FPZMlpeK
	 chWV42FtaUkig4ry7BPl/KK6mD36rQu7RZ9Gi2ZDFVy6D2LQ4F7mQkC5C3RV2E9OFYaqg/EA/tco
	 a4HbiQBzAeAQTxsTOUq8X4GsaS40nAVvYHhXN5j8n+xhKXoijA+B2b5R2Z2oP6pRZX8HjjSRwFV5
	 INWBhpo+25QB96pVPvzsoWs22o6kRj3KKb35eV9mFC3mCJ1aHVW3TNerM7AbS+ROThztUKXezG+l
	 Uu+0AGLmqorRL87vB/UtuNMSNnNLc+20g2F67suMlmwKrKx9danBXKBAf7DYeMva0Wov13FE9VAa
	 a8wuPPVaQpFZJazS+XvAQMEB2fI4qzYEMcWfDvtznuAKwoKbQbipEtTzADqPemtIwnXgyfXSkzPH
	 ye+uOALifeBuEvY9MdwZ61I9a0LX0tk4F6oZyeNxJj6hztWHAOt0HgbKOuXsT2UXNiMmwf1/lNwY
	 XLmYNexyJ2QgMztMb92A4vJnw/XUzEtPWMVYYgzG6l3qDl5Rh0V/HHiDwl2XIbs2uPI5s0BLYgSJ
	 rWHetoJVsgSHf5mN14OfYpCB0+ANXurC2Y+X42x/4xB7J9tuYL0B+XtD9FGmtKwwuF3eBZAHpZwd
	 tAseBXoKeBezEMvZ7E190+IzQN/DP/cxq4qQCtO2Ma/0ZNmCW7uy4+imi2MPUEu3cGQhite7/O24
	 X14IN1gEWhR9uFMhmEMsqZ3EwldHfwsD+vLaqpG2VL5npWoNM6T4E2jAKDePn2GH3g9raCqh6AVw
	 TM1aZXFusaY+dU6tTxA1P10MKHqwXp27yrDtVZ12/Qz7R8JNzUnkxN81OJTZuwKbicsa07Gg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	yeking@red54.com
Cc: dianders@chromium.org,
	error27@gmail.com,
	jikos@kernel.org,
	kenkinming2002@gmail.com,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	superm1@kernel.org,
	treapking@chromium.org,
	u.kleine-koenig@baylibre.com,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
Subject: [PATCH] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Fri,  5 Jun 2026 01:29:59 +0000
X-OQ-MSGID: <20260605012959.48448-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_F6FC553D1BB737FC00062AD0FEF43C580F0A@qq.com>
References: <tencent_F6FC553D1BB737FC00062AD0FEF43C580F0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the _DSM call that gets the HID descriptor address from
i2c-hid-acpi.c into i2c-hid-acpi.h as a static inline so both the ACPI
and the new PRP0001 driver can use it. While refactoring, move the
blacklist check and the _DSM call to the top of probe() to avoid a
pointless alloc when the device is blacklisted or does not implement the
_DSM.

Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
are declared with _HID "PRP0001" and _DSD compatible "hid-over-i2c" but
lack "hid-descr-addr" from the _DSD and provide the HID descriptor
address only through an ACPI _DSM. The OF driver fails to probe them
because it requires hid-descr-addr. Add a new driver that handles these
devices by calling the shared _DSM helper.

Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/hid/i2c-hid/Kconfig                | 18 +++++
 drivers/hid/i2c-hid/Makefile               |  1 +
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c | 92 ++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-acpi.c         | 48 +++--------
 drivers/hid/i2c-hid/i2c-hid-acpi.h         | 32 ++++++++
 5 files changed, 155 insertions(+), 36 deletions(-)
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.h

diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index e8d51f410cc1..7db8b2abff78 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -22,6 +22,24 @@ config I2C_HID_ACPI
 	  will be called i2c-hid-acpi.  It will also build/depend on the
 	  module i2c-hid.
 
+config I2C_HID_ACPI_PRP0001
+	tristate "Driver for PRP0001 devices missing hid-descr-addr"
+	depends on ACPI
+	depends on DRM || !DRM
+	select I2C_HID_CORE
+	help
+	  Say Y here if you want support for I2C HID touchpads that
+	  are declared with _HID "PRP0001" and _DSD compatible
+	  "hid-over-i2c" but lack the "hid-descr-addr" property from
+	  the _DSD. The HID descriptor address is instead provided
+	  through an ACPI _DSM. Known affected devices include the
+	  Lenovo KaiTian N60d and Inspur CP300L3.
+
+	  If unsure, say N.
+
+	  This support is also available as a module. If so, the
+	  module will be called i2c-hid-acpi-prp0001.
+
 config I2C_HID_OF
 	tristate "HID over I2C transport layer Open Firmware driver"
 	# No "depends on OF" because this can also be used for manually
diff --git a/drivers/hid/i2c-hid/Makefile b/drivers/hid/i2c-hid/Makefile
index 55bd5e0f35af..da420c1a8ec6 100644
--- a/drivers/hid/i2c-hid/Makefile
+++ b/drivers/hid/i2c-hid/Makefile
@@ -9,6 +9,7 @@ i2c-hid-objs					=  i2c-hid-core.o
 i2c-hid-$(CONFIG_DMI)				+= i2c-hid-dmi-quirks.o
 
 obj-$(CONFIG_I2C_HID_ACPI)			+= i2c-hid-acpi.o
+obj-$(CONFIG_I2C_HID_ACPI_PRP0001)		+= i2c-hid-acpi-prp0001.o
 obj-$(CONFIG_I2C_HID_OF)			+= i2c-hid-of.o
 obj-$(CONFIG_I2C_HID_OF_ELAN)			+= i2c-hid-of-elan.o
 obj-$(CONFIG_I2C_HID_OF_GOODIX)			+= i2c-hid-of-goodix.o
diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
new file mode 100644
index 000000000000..35cbbab347ac
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HID over I2C driver for PRP0001 devices missing hid-descr-addr
+ *
+ * Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3, use
+ * _HID "PRP0001" with _DSD compatible "hid-over-i2c" but lack "hid-descr-addr"
+ * from the _DSD. The HID descriptor address is provided only through an ACPI
+ * _DSM. The TPD0 node in the DSDT shows _DSM Function 1 returning 0x20.
+ *
+ * Copyright (C) 2026 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "i2c-hid.h"
+#include "i2c-hid-acpi.h"
+
+static int i2c_hid_acpi_prp0001_power_up(struct i2chid_ops *)
+{
+	/* give the device time to power up */
+	msleep(250);
+	return 0;
+}
+
+static struct i2chid_ops i2c_hid_acpi_prp0001_ops = {
+	.power_up = i2c_hid_acpi_prp0001_power_up,
+	/*
+	 * No .restore_sequence needed: the _DSM on these devices returns a
+	 * constant (0x20) with no side effects, unlike some PNP0C50 _DSM
+	 * implementations that switch the hardware between PS/2 and I2C modes.
+	 */
+};
+
+static int i2c_hid_acpi_prp0001_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct acpi_device *adev;
+	u16 hid_descriptor_address;
+	int ret;
+
+	/* If hid-descr-addr is present, let i2c-hid-of handle it */
+	if (device_property_present(dev, "hid-descr-addr"))
+		return -ENODEV;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	ret = i2c_hid_acpi_get_descriptor(adev);
+	if (ret < 0)
+		return ret;
+	hid_descriptor_address = ret;
+
+	return i2c_hid_core_probe(client, &i2c_hid_acpi_prp0001_ops,
+				  hid_descriptor_address, 0);
+}
+
+static const struct of_device_id i2c_hid_acpi_prp0001_of_match[] = {
+	{ .compatible = "hid-over-i2c" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, i2c_hid_acpi_prp0001_of_match);
+
+static const struct i2c_device_id i2c_hid_acpi_prp0001_id[] = {
+	{ .name = "hid-over-i2c" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, i2c_hid_acpi_prp0001_id);
+
+static struct i2c_driver i2c_hid_acpi_prp0001_driver = {
+	.driver = {
+		.name	= "i2c_hid_acpi_prp0001",
+		.pm	= &i2c_hid_core_pm,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = of_match_ptr(i2c_hid_acpi_prp0001_of_match),
+	},
+
+	.probe		= i2c_hid_acpi_prp0001_probe,
+	.remove		= i2c_hid_core_remove,
+	.shutdown	= i2c_hid_core_shutdown,
+	.id_table	= i2c_hid_acpi_prp0001_id,
+};
+
+module_i2c_driver(i2c_hid_acpi_prp0001_driver);
+
+MODULE_DESCRIPTION("HID over I2C driver for PRP0001 devices missing hid-descr-addr");
+MODULE_AUTHOR("谢致邦 (XIE Zhibang) <Yeking@Red54.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index abd700a101f4..f0bcfb2663ef 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -25,9 +25,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <linux/uuid.h>
 
 #include "i2c-hid.h"
+#include "i2c-hid-acpi.h"
 
 struct i2c_hid_acpi {
 	struct i2chid_ops ops;
@@ -48,39 +48,11 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
 	{ }
 };
 
-/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
-static guid_t i2c_hid_guid =
-	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
-		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
-
-static int i2c_hid_acpi_get_descriptor(struct i2c_hid_acpi *ihid_acpi)
-{
-	struct acpi_device *adev = ihid_acpi->adev;
-	acpi_handle handle = acpi_device_handle(adev);
-	union acpi_object *obj;
-	u16 hid_descriptor_address;
-
-	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
-		return -ENODEV;
-
-	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
-				      ACPI_TYPE_INTEGER);
-	if (!obj) {
-		acpi_handle_err(handle, "Error _DSM call to get HID descriptor address failed\n");
-		return -ENODEV;
-	}
-
-	hid_descriptor_address = obj->integer.value;
-	ACPI_FREE(obj);
-
-	return hid_descriptor_address;
-}
-
 static void i2c_hid_acpi_restore_sequence(struct i2chid_ops *ops)
 {
 	struct i2c_hid_acpi *ihid_acpi = container_of(ops, struct i2c_hid_acpi, ops);
 
-	i2c_hid_acpi_get_descriptor(ihid_acpi);
+	i2c_hid_acpi_get_descriptor(ihid_acpi->adev);
 }
 
 static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
@@ -93,23 +65,27 @@ static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
 static int i2c_hid_acpi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct i2c_hid_acpi *ihid_acpi;
 	u16 hid_descriptor_address;
 	int ret;
 
+	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
+		return -ENODEV;
+
+	ret = i2c_hid_acpi_get_descriptor(adev);
+	if (ret < 0)
+		return ret;
+	hid_descriptor_address = ret;
+
 	ihid_acpi = devm_kzalloc(&client->dev, sizeof(*ihid_acpi), GFP_KERNEL);
 	if (!ihid_acpi)
 		return -ENOMEM;
 
-	ihid_acpi->adev = ACPI_COMPANION(dev);
+	ihid_acpi->adev = adev;
 	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
 	ihid_acpi->ops.restore_sequence = i2c_hid_acpi_restore_sequence;
 
-	ret = i2c_hid_acpi_get_descriptor(ihid_acpi);
-	if (ret < 0)
-		return ret;
-	hid_descriptor_address = ret;
-
 	acpi_device_fix_up_power(ihid_acpi->adev);
 
 	return i2c_hid_core_probe(client, &ihid_acpi->ops,
diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.h b/drivers/hid/i2c-hid/i2c-hid-acpi.h
new file mode 100644
index 000000000000..8cebbeebcc23
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _I2C_HID_ACPI_H
+#define _I2C_HID_ACPI_H
+
+#include <linux/acpi.h>
+#include <linux/uuid.h>
+
+static inline int i2c_hid_acpi_get_descriptor(struct acpi_device *adev)
+{
+	/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
+	static const guid_t i2c_hid_guid =
+		GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
+			  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
+
+	acpi_handle handle = acpi_device_handle(adev);
+	union acpi_object *obj;
+	u16 addr;
+
+	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid,
+				      1, 1, NULL, ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle, "Error _DSM call to get HID descriptor address failed\n");
+		return -ENODEV;
+	}
+
+	addr = obj->integer.value;
+	ACPI_FREE(obj);
+	return addr;
+}
+
+#endif
-- 
2.54.0

