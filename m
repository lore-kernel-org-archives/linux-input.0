Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F362FE071;
	Fri,  5 Jun 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662083; cv=none; b=JdjKGgaSlSl7GMam8AtZzPWharBCZT58xG5h0N/hjfkikTjMHrL2+oprFxGDFYPOQ41OVAl89MNfKGP3wFRDeTsLHM7yDIgc2ZI/TjkIa9Zl55ughExZnhtDrP2BZEFu9SQp75EktvrAF4IY15jy5oIBHnPEonGDXhNjFco+Yng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662083; c=relaxed/simple;
	bh=bOV5TRQo+9JjUAKV6onNxZ1oJuNumU0Oz2tAPHtE7Qg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2STijnPncS08Mg3vGhK18WUxYXQkMGwcnaBqUePRly11Bp/S8+9iDm+ysExNvORcXmyyQOYmLMI1c+rTIcQ3OsS2fQrWp99QcBD82cWgednqAiy58bZY9mIcrVCkmAN0FKmlyidZWvN7EKoeuVN46T5VGqhyuZtUuc02kp6K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dFQ1Oxfm; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dFQ1Oxfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780662071; bh=VvcTIIICLW2CoKU0ueeLuYvNlghlhupW0ZVJ9ZaqoQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFQ1OxfmudekIDab0/ooBOxkli+ntmllqRBSSzAh7hpDL3Kpr8U52WLGbVUhyzWgj
	 BVjxq3XMhXdVfOmefU8zgPIp38DsHBnKHrT3rQ+fphn2FVP1uWlTqZ3+3NDCovk+Rx
	 ECf78ocrTDC6SXzM3Q6Xm/mLMQkNc+mFgpTaU7IU=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 53502241; Fri, 05 Jun 2026 20:20:53 +0800
X-QQ-mid: xmsmtpt1780662053tx9d12pgo
Message-ID: <tencent_3310584FFECD3CBBB563FC8C079ED072F40A@qq.com>
X-QQ-XMAILINFO: N7orI5eWepzGkR89KWsfQrW1jTxcX0bA75vmWUirsjbqE9+SNuUoAtOFM0csde
	 ioP/GnbJgSdyxKPygYfFyuk1z4cQO7JDEVh2kEOSieKQqeDtcBzCfXYfECmPMK8dXdqH2L9z8si7
	 NaYBoUUDkbLtakR647XAeN5NEaLN2yUwm2kgEWedk0uN2Cq+Ccl6SNPSCHotXEW5r1kf+MtkCvtJ
	 sdUn88LuYxN7e0PMaV8sQw6MCxhnqi4me45LQwrFo8a44Es/U2QNHTlkShheQqffimvS0PU81FtH
	 dHrb/TB2VWd8vkl1wDc7hxgxhi5mS8tAQaSEcVCj159VL6e7/tixvB62a2SoSQIMkexB8+p8ngC8
	 Af8pWFni6vqwJadu5y+T6MYI0c90kmDpsdmCEtpc6ngsWCdYCcRDIHOycuU3qjIklrj0gfeRmpR+
	 bMeL014cVGbq34q8yBGbgIKk7i014qlb1J239cdYH69qWM5GhJeCMS7t1xrtDMHXmSWJpDbrpdRf
	 102dOk8jAOufxfjEYa1gEjTiqma0qXeLCJYohJ0IeYVopUiggKFx03kE8ZFnV0V2CojthSlbo1je
	 mGV+QowaODX/Rps2t4Y9437yMi+wtNQrrzfVa7cM8m60AzyTekMCrxSd8fJlxwnap4CMy/hy4onP
	 bgoPfad9vi9CS83sE7ij0SgOAo51Fy4gAcnmcyzw/zVvdPPPVvrQOMTId3a9cuqJ/qh1IWF88SZ8
	 N+RksTTu1Lzj3clNyqT49B6TvY4IGlQwQsKB5hFjZukSedu+TYmlTAjGHvE413jNC9BsKadukzW8
	 E+zCMrNSplXQ9psGUBpi1vj3PS0cKNmC8zmpARxrHZO9+Ad3MFsLgX8pW61TjA5vTkGCjsV8ixqi
	 C7x5zAUl2oKDDW12Nd8/NrEsJIAurYaIhzLUV1YNwSDiY6Uz9sFA4ywlQBZIWLb/ldmV12ihQq8t
	 ZBsqZcdBF0qpWYi549SrzlmYiO+1g6S7Oqgz1lBYwKC7iVLVa6lMlbCRFzZzPQHfO6ABg4Uqad0+
	 D1lqPbqXnJCiRzwKam0nfMD3Ne4SaZUhCUtUDBQK6RIwFuorYVD5XHxm0nGu1OVLHuqidNmvrkdR
	 zXQ/ray6hAq2D2Yju0tc+huLoXin5uSPkxlTHEv5l6r69rFe8=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Subject: [PATCH v2] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Fri,  5 Jun 2026 12:20:37 +0000
X-OQ-MSGID: <20260605122037.53250-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605014101.1889E1F00893@smtp.kernel.org>
References: <20260605014101.1889E1F00893@smtp.kernel.org>
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

 drivers/hid/i2c-hid/Kconfig                | 18 ++++
 drivers/hid/i2c-hid/Makefile               |  1 +
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c | 96 ++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-acpi.c         | 48 +++--------
 drivers/hid/i2c-hid/i2c-hid-acpi.h         | 32 ++++++++
 5 files changed, 159 insertions(+), 36 deletions(-)
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
index 000000000000..b6b64e868f36
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
@@ -0,0 +1,96 @@
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

