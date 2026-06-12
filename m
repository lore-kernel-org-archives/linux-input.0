Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DC3E8665;
	Fri, 12 Jun 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264727; cv=none; b=Umv9mSdMuLpvClRBv3yjCx9Eo3tFq+MgTrZCabP3ZlSNnpBfbvNpmHE8SPq6hWDsOE1pjnefmhkojG4AQSG9mYdw4fuXSIVpfydoPkM6cdeqSA1huikQ81LFV8H9nqKjsYg3AmSZpB9qBnhkHW6Lz1ci6MC9fJwg2zV8jcxhxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264727; c=relaxed/simple;
	bh=YHCetUFKyTss09xW5VDxuGuLsDko3ogkrYs9ayHWD/A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQvZTP8EOtItYFFdPBBLib0cyIUSFsH461K4xGmF7rZeQth1g2YHgT57RpCHBZkjd/buCD7pXVKiBfd1RPA9iiWz8s52i9243X7bVoQWr6fu0wz6wIfnp37t9CqTdTRzuOqueKIe0l6yyB/NofTEvqbjm3sk0UItG+Jm1PkEuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d4H0tbD6; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d4H0tbD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781264716; bh=UsA8T0fLx08Da1yDKZdimxWsgFqC8YyauanrqJW9xO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d4H0tbD6nA6yNSf4aWPSg85cmJLAKv/wr9YZUtQGM/2tgZ0Oqt//C5CeIyDkVzw7S
	 WV30fPiCTtNCgUjN1GS8xk/R0/xUOZjDEa8fTm5/KgGNbbkTZHGgNHfUkw3qlKkQa0
	 hgZysrDfVbQdvSw2Zs+wsoNhRLMAEC8cO8mWxHE4=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B3A04426; Fri, 12 Jun 2026 19:44:58 +0800
X-QQ-mid: xmsmtpt1781264698tbgo9ri89
Message-ID: <tencent_8AE8ED913FEC8151B4BA3D85D6BB7F3ACF08@qq.com>
X-QQ-XMAILINFO: NCmjBvJFq6XNqJMJwM4KOPxdioVH1gUXui5vwHIq+lk2OTsq/mYftyPxJcoyyP
	 ItKPP+cwM7zUs6KI4+Ni2FPEEw9grUpVCazQf6seZufVcZJd556SSaIKyYVDQ5NeRTj8ZemSNrus
	 FAIDA3G4mkAboTApHGn3Mn+z7lOdwjLL9lW6CikSAwNrKkxklPIWKW4NbY84sm0D0EKqpzZwIrSz
	 YHwd2XSXUA5TKfAzDrK8sqaxE5O25d6KRGMTG3B4Zxr3h/a/xxRE/DOCUx69yJyVR/B/sZsx524/
	 l+bGRb3E8CETq6hc0y/HmZ4etJOEzlYJ4bHhVFddTD2mbJN7nEJRreLZsXHqVuigZEYi/CL5hNr4
	 tWDCaUJsoLxA79A5iU7+Nq18Fkiz00+/hP3h825gvYIhpgpwS22r+XQosJD8J7Z5ko0pTTJb0C2H
	 qpdTSWxjhFzcG84LL2FMY7sGTJ8J1rMXh5C6TgfqOehrzQmAGHqquO8bG/nmSXFQJtEFq+SAMwpX
	 yx8aUIFxeucZ+BE7/L5pY193GKHQ3c8J8FREdQnLhNct+p8nKwtINAkUJ0mxLueCNYtJIk3YnzIJ
	 9tUKqHIM7bxqpMMf9+Esv306OWkXFxC545HFRMYuJSf6BNulhzcZiN0ubUJAsIobPipaEzhYpAsx
	 k2FYwa1r7K4RJPxtbaDjwA1CaRCqm6Q4eeAr5flfBksO33z1BNAQuwIY7llla6rEj4SosipRW+LZ
	 fWw5DboThUOQPK4B6DxoU/LUzYTdowq0km4YAi8YEd64gZ05xwHaPSnMMstPvYzR6Alg9tvtnqnZ
	 nJUalYMSw9yIqzHnjwB8Pl4GuPPwkES/KZ24eiPR/5G9eAoifXdl7fj+hxTL1rU/dLYg/H7AwPEx
	 V8o8/d2b8pl32f10TzcEOE4jiWQLo7oEFvxQAZEWlvVGr16mN7qDz+D6gcvWJFgAg7suDXAOcXJh
	 2Ig5zzbzF/7YLS4sRtNPLb+nS7DFJwNfq1kR47wA2NHKzbUIPnvAuc2dMo6aYB7xIS+zuQTAI52J
	 99WIxCJji0OK3J8M4YzdlZvZcidaKqj6nu2S/gr34Tu88gQZ6MSKN6hXEmdrAz1QZoaCd4tA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Jiri Kosina <jikos@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Fri, 12 Jun 2026 10:38:18 +0000
X-OQ-MSGID: <20260612103818.151060-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609110608.3F4C21F00898@smtp.kernel.org>
References: <20260609110608.3F4C21F00898@smtp.kernel.org>
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
v5: Document why of_match_ptr() on the of_match_table is safe when
CONFIG_OF=n.

 drivers/hid/i2c-hid/Kconfig                |  18 ++++
 drivers/hid/i2c-hid/Makefile               |   1 +
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c | 104 +++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-acpi.c         |  52 +++--------
 drivers/hid/i2c-hid/i2c-hid-acpi.h         |  32 +++++++
 5 files changed, 169 insertions(+), 38 deletions(-)
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
index 000000000000..05469d220c39
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
@@ -0,0 +1,104 @@
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
+		/*
+		 * of_match_ptr() makes this NULL when CONFIG_OF=n, but that's
+		 * fine: the I2C id_table with "hid-over-i2c" handles matching
+		 * via client->name (set by acpi_set_modalias() from the _DSD
+		 * compatible property).
+		 */
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

