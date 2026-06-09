Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D13FB042;
	Tue,  9 Jun 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002479; cv=none; b=aWYLQx9oHO3qvouuPI2ShAhoyo2IGghNw9C17nmJPXgAJ1KqG+UJ17QenxrJLrMC2qnpVeohyPbW7NCgkikhp6fiVH+erqjnfGedHhafmCdZtVCU4LShy5ON3GCm4SGUnNMWVPG+HoeV0q+33GA3qhvGMiFV9/UJLZfwfeUWWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002479; c=relaxed/simple;
	bh=r6LRI9qPRLy7uY3CGPYPCXsGeV7mzgKW3iLXInQIIlU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC84TNpjHEQAbVYkrDfGito8NIkxKZIAqDh5zNAAVNBakA1nhcfyTSO2bzwf2vUA9rKAdXDYvi2+kuGb4X7Dz0+jTOWjnZGincQWFuu2q7GE3viPxBTLkMW2sClApaCgr+vRmbomA5omPyUkKXbxVs/sUVsZE8LsQAoF43BoTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FgRe/7HP; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FgRe/7HP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781002472; bh=0oWOJORl5spXUwlh+rxt8bwANn3BkzN3M6RyuZPujzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FgRe/7HPrOByjtp83PAUNCzUf0TlP0EU5D8rI4KreMuSFn/gWQFPH6g6IqvWhcdaK
	 PFWdE17ZQ4buwgSxjP1WOeZc0E0x9PFefnRI7WqowAK3zPp/0uA+3gPZ8N7LglcxOS
	 agSQHUVqLwfvwAIdmj8feIr+ABzu6SP5E/lFhEnM=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id D8F110F3; Tue, 09 Jun 2026 18:54:15 +0800
X-QQ-mid: xmsmtpt1781002455tz9y5w3nr
Message-ID: <tencent_6169D37BDAAD7FFEEC9E41DA197FE6028309@qq.com>
X-QQ-XMAILINFO: OakVxA/3u/8RudSBiuZjNtPvBcnkKAPHpL2l1vqKYakmYSl88n4feKO88SPnfK
	 yLYxFRNGS9rJOmWcCuzFOEsNrdID60hgguDihReYH+ZPJcnQwttVOoI4nvN0ajkBRYnRe/KnYn1+
	 HJhFm4es8Pt+R1QYGiEhfRzwMUBBkM4c8+1gloumuOgcOxtXNZdkHeRVlbBkIde8lT4TehRWVHfV
	 co1HHbXjDFEoZfHo8EcHy3fE3yuTu1joWex+9m5KkQlr0/3bqm9CNZ4IHYhS+d/KH+GE4B2usKsz
	 kIYjIc6n/NgwR1DlgS5YF2rJHOFmIjSOfQ0evCqR5Cj6s6qKCgjWFVR1UO4j4Pdb4LSeXIrsbd2o
	 GhdA1uGJxBeJQs/vqHXSAm26vUu2s1e0Vv+/ohC+an2Igb/AsKwFp2NUkzMuBRBbkK5YaUre9MRV
	 0bAs9YlXwAL66bq8Bd6qHLTN1MLJqgvzUVoHZhyw/JQ7XumJOKA2TjozvOIQRhRPnHKIUIhXU0dC
	 0KgSlToAqZaT4YrAA2o29o1gBfogSinygHFOuxOd6vfkZXR1jbCJ8vSAd+QD8xz+7P0Svz202ZWR
	 1L1nYJ3fKfO70tIQKJ0aMTOPgxLknhh/BXzkSfn1cE5IcSRFn1YToewFweoTxspUXoRG9o6/4mcG
	 mk9LpZ22Q7escdI9huWNSay2kwq7HCmvBywA2Dw+8AQT7p3pM+RSosUJ4DGHbKwVpoifAXm8DVJF
	 P6tMrkUC6BW9N2MmS+qVz7fe8CEIVVwi0of/09WpFYYe8eGgeAd2wpDQPdarmXZYxGhyn8J4lERG
	 5iylB7zHeZAb07zESw+AVP8n16KSwBHoOKlOMj88qOXj2536E9dEIiB9jkZeLcO4SFk1dpvtM7Ih
	 +GiCyZm76hMnYclviDPRAcrax1NTEVnJ9tGnuoMtQ8/Ci3eZMBe9YNOht/ihuRS5vhg4nUaT9tr/
	 Y+jVs9R2h8civiJ+2KxxYz1eXxpDnqvsvrTjy6vKeCz5k3G2PfoTHQvEZ3b2NMsH1xvhKVer83gV
	 ZKfLlxkwxNdsz04RZxE7bmAs12NOjR0yLD5zrbIKDuYRO5Gl6R3vO0vU6gvptkM+OaOSaV94NiMH
	 hb5ttM7axHisNztHT9mJMG/9UnwEbvad7Y2etdUW8q35tclq8xtWvD4MryjQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	yeking@red54.com
Cc: dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	superm1@kernel.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
Subject: [PATCH v4] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Tue,  9 Jun 2026 10:54:09 +0000
X-OQ-MSGID: <20260609105409.106830-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_45D6247F04CF37ED6A3F858178B4303D6808@qq.com>
References: <tencent_45D6247F04CF37ED6A3F858178B4303D6808@qq.com>
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
v2: Name the unused parameter and document why
acpi_device_fix_up_power() is skipped.
v3: Add a dev_warn() asking users to contact vendors for firmware
updates, and use existing locals in devm_kzalloc() and
acpi_device_fix_up_power().
v4: Double the power-up delay from 250ms to 500ms.

 drivers/hid/i2c-hid/Kconfig                | 18 ++++
 drivers/hid/i2c-hid/Makefile               |  1 +
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c | 98 ++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-acpi.c         | 52 ++++--------
 drivers/hid/i2c-hid/i2c-hid-acpi.h         | 32 +++++++
 5 files changed, 163 insertions(+), 38 deletions(-)
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
index 000000000000..a65830279f63
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
@@ -0,0 +1,98 @@
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
+static int i2c_hid_acpi_prp0001_power_up(struct i2chid_ops *ops)
+{
+	/* give the device time to power up */
+	msleep(500);
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
+	dev_warn(dev,
+		 "hid-descr-addr device property NOT found, using ACPI _DSM fallback. Contact vendor for firmware update!\n");
+	hid_descriptor_address = ret;
+
+	/*
+	 * No acpi_device_fix_up_power() needed: TPD0 has no _PS0, _PS3, _PSC
+	 * or _PRx methods and follows I2C bus power.
+	 */
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
index abd700a101f4..13f977d6aab6 100644
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
@@ -93,24 +65,28 @@ static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
 static int i2c_hid_acpi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct i2c_hid_acpi *ihid_acpi;
 	u16 hid_descriptor_address;
 	int ret;
 
-	ihid_acpi = devm_kzalloc(&client->dev, sizeof(*ihid_acpi), GFP_KERNEL);
+	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
+		return -ENODEV;
+
+	ret = i2c_hid_acpi_get_descriptor(adev);
+	if (ret < 0)
+		return ret;
+	hid_descriptor_address = ret;
+
+	ihid_acpi = devm_kzalloc(dev, sizeof(*ihid_acpi), GFP_KERNEL);
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
-	acpi_device_fix_up_power(ihid_acpi->adev);
+	acpi_device_fix_up_power(adev);
 
 	return i2c_hid_core_probe(client, &ihid_acpi->ops,
 				  hid_descriptor_address, 0);
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
2.52.0

