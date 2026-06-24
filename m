Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70493DCDAE;
	Wed, 24 Jun 2026 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323253; cv=none; b=cZLvGrddPV/v5fpEkY6r8NPh9IRYc1PpDDeFPUei88N5duYnYIi51o1X76ARM1vZa5WW7JuXBqqk2A1twq7djEB6wC4ZjUYDB5M1HK1H+mGRL8AH3v36EwZtEf81La5U3QLJZTDTUcwTY0ah6NNq41mZfcVc16l6D+XKMYfwbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323253; c=relaxed/simple;
	bh=M2SHbsRPhW4CFCW5zj2sAOiIjGR9k1qLvoT51zEKyuw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFQJ1dkIt176qXxbQI70+7qKR4SD7bs3/XtsCxmyZax2//4YGz2nhUf6ybbtfeGN/zlB1OmytfbBLO09dMrQ+/s+uKmtDCZAXKSAv73KUhjRq9N1EnQYhjp7jYt9KqxJrFUzboHhWXJm4qkWmfw4dbmfJIAerci/e7iwu5lWBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s5XiEM3k; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s5XiEM3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782323242; bh=uH37LUqGuaybVj563YldgoHmoseaxyL2mhWhpBboRT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s5XiEM3k+7ZvA4x6hWrCb1T/SoT0MXri1IeobsGvGE4PeS8AKosCCnoBy22RYaWF7
	 FQAjEZkEjL+nvcZzwvJzjY9DziLax+8do+eQERRSsHV54kc9cthpZZNVdSdnN43Hq1
	 8V4lzMW7hR5aXCeD4svnj9WNxwN6TqbIjFQ/QmzE=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id BC49A401; Thu, 25 Jun 2026 01:47:04 +0800
X-QQ-mid: xmsmtpt1782323224t4z7huq3a
Message-ID: <tencent_FD772005ED5B8FB435F3DFDF73437BC58F06@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X9kGQCI+fGRdqmQiKhVOk0yS960ow/uFW8K+HyIpOwsY4d8ahvr
	 yfgwKgLa6I5nQSrn6/zHm6y9yo4luLEcFDf5kytnPJ/YuyLn8NxIrP/qCMRQUDc3/+OLpxo7+8LT
	 MWqIoAydwlnY657Z7OkHjBm/Rj0eOfG3R4HdJ+cz4hvj6F+7QtPHad19XHPvV1Zpjd9ETYAboboD
	 l9Vn8hgEjmwcoLYX1eThU5X5AynmiI4oqnVp9aQiCTvI7xR7/WS11WT8wFCF3PDg5dGZ7vAGDJu6
	 F8+cjr0X8Q4Nf13CHqopUxcV7IYdqyV/2s5EUfUP82sa85YGWSTNFFmaBUrZYCucYdo1Vizvhaid
	 0SnZEh9+7HNzVaxS11AgMkmchTGWRAdrUcf4XSvXlm9N7tcu7kU3V4ONmVX13N/Dj3tPln4WB7Ab
	 6JH0Sp7NxYTRnN2zARoTNZWigUaTzA2KeCSPpEV44TBWMalIqTvPIakS50dr6Jxf8aBzMwWHzF0u
	 SqRsEUsbq6FIsHMgMVi90vM4soW4d/Tj1k+TniQXbRPHYxe0Vpgz5TDFMBc0dndh1y77H5Sbc4rn
	 deA/RlpWH9yshWmMWL5lv1xUwNU5UONI/GEPwm0PGLTjz6u43lUuyvJS0LVfm2w95dY5uGPf5YfW
	 /Cv7Y87WCHeTqMJgU3tLq9W3PhPlsiMeszOJJP1H579XPAKaSpMJQGgYZcJkz1Ryoaz6VyFCBaLI
	 JKr6rACI0rG9H0gXVzOkSJD10C+ZQLvWrhWW0gdqQMWDMj2PFKg5b+NI6QtJ2S4OyNEYXfj1gsyy
	 dgKN2+Aw6qlLg7pbp6B1+jyMHVp936XxCOQvGx9tonOdaGqFFZHJIZFDPy9joG3fjSp/tkUpElsr
	 Xrt6qUyR20SMYt83NA2V5liV6X4jW12ZW1LmUf0oC2mRugzevEKkYXORhidy29jnAvAVE3VI2440
	 KxGeyFqjGFPdOesxnE90EBDpU19YnafAU/3376pQ+Ek5Eu76ZoWgPGrrQd5Z7fRu3/l4oAgcO8p1
	 ADEHp9sfNt+B5Pa7z27ZVdu1hpZrX73vvsARU21P22ToEuh/GaF12IV859lF+S+G+hX41+jA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
Subject: [PATCH v6] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Wed, 24 Jun 2026 17:46:53 +0000
X-OQ-MSGID: <20260624174653.320810-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_8AE8ED913FEC8151B4BA3D85D6BB7F3ACF08@qq.com>
References: <tencent_8AE8ED913FEC8151B4BA3D85D6BB7F3ACF08@qq.com>
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
v6: Increase power-up delay from 500ms to 750ms. During cold boot on low
battery, 500ms causes non-fatal I2C transfer errors (-ENXIO). 750ms
fixes them.

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
index 000000000000..d2cf4714ae7f
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
+	msleep(750);
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

