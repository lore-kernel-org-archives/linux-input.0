Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9B3815D6;
	Tue, 30 Jun 2026 05:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796005; cv=none; b=VkWNaViuwFUvxC0W1O0ChjxJ99rnNNoqu/OkyknlYx+VvFZH1JWW1wwDX7gBjoYO9IO/WboaNL6svVcmZDHcgL/knmc825ZR2/PWx7jJVprr1saCpHPgottbEuWbJhLQlfLkZ4S7x1ia4wXcML4d6AQvr8SZwtOfUM3VYUB2HBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796005; c=relaxed/simple;
	bh=7Gg7DwSR3N/ELf78YGze95NezMxZg6tGkentWvxFXnI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6FcRFkS6E7pB5KBNMcGLG218NOB7PYlCfOCbkPx1zn5vvVPtH67+uPgvfuyLVCouX49xEZmBgCqf5aFkSr56VDmI51uVQHqIV1bxuCN+jHrXpeuNJZJLzCbzlrL4pcTMSSMMsNMn+NCn+rnpvqMWtvrB/YfkSJnPB4Xt/GFl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=urnHItFs; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="urnHItFs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782795993; bh=DuMZ2Zdgsa5L5dfJyMSCTVNg+r6hlY+Of+p6RNsTOT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=urnHItFspEfk66ZAcNDbFPuNMWSDb6mxo/xtDAETovvMb7z3LfbMVyU5MDUomqIUq
	 H1t9jhN8QNEjhF8pzkQ6mMbzUneMn0pYb7BTFTl3fw+lEkrvkqqUXVSRgQD/G/AJZy
	 F4/Hh+5eUchemRab9AagwCxSWZAefLS2/ri32JWI=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 141AACDF; Tue, 30 Jun 2026 13:05:01 +0800
X-QQ-mid: xmsmtpt1782795901tvlsrfhf6
Message-ID: <tencent_76FCB13C1FB6FBFFA004F2D19AF6E458030A@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfG5jR4Zp2XcPC/AqHkhG6dgPFyAgXmPKollbxgbxeVlpXYZZZG2
	 FFWKxOms6kDzVzPe41364ihOCi0kvf8mGm++vF/KnRGsGesSVmnXX+Gu1TiCToBxCxelxpLoFvkK
	 MaFBf4WqrbH2s0vJWGlni3WxMkSXApmJPdgY8AOc+N0luraqLptSXw9cs7qvdBUauiMyKtJIvMhx
	 DgauxEDDD1X5RaeAtN2X2j6gKqc4lqupTtlZRwxDEXLbMnt1QTbvtuRwpICtN1wHGziuYgukQrYJ
	 Qe4xKjfJaEH+co3XV0byY9Ht0pOfZQoSEQSUV7ScyJMjmI1TwAz1zmc5Tx7idHSmo5QcWhOCsF52
	 sWFIPisbdGLZ2wXlL0JrU+Iz7KAA+7jxZCHlnK3aXBrhGDsC8VzMEd8D42xLBYMczw26HfJgBhrv
	 axsbHgAqrPm4qAPBfK2pXkPWb733XXqb4EvSx2oGcBOHHuRN1v+W+KXRgTfZU1L7biME1OfFxlnu
	 v5T+FqO8KqAoZShUtUSvfTUQu/Cfx3gpSQHRgW5A+aHfAMCehAaGjT26159BGBDLE5CTZpL2u4nS
	 fZT68XDFqhTPm/0c6k/zIDpHG7+QwV3qN5RFmnuV2JNTgOhyC4A9x8x42KDDTvLcSUojGUH3Q6hb
	 CRSvWeiMp2Y2zRL/jGXRI9UqJia0L4C3YMCy4c0doUVTceGqOe4K/HdYAd8JpDzlXHx5xASto5WT
	 +xoGMl+BkZoyZgHLLODPWt4D5/zuCBbSgWQAoociN0IXK82vrYkmyXN06jU1HoOvLwzqYtL++ha1
	 zr41ivHORG/ZcxJf3miU3yiWSHc22FOfiIvsjmeM5g48ie+9w1V90FYrT25hV7qPlR6OCvgbiDae
	 ArPQ4jTE0evaUJcPX12l4Jv4moEYgQYucEEune9QCU8wxVhWvtazFpL41YvYDOFjlLy/zOJVx1oV
	 ak/pMoopxL+S/UiFCSZAXksKFojIIIvS1IN975u9H7MHi2nge7C5pkAmtirO7oY+9XodJnE29QYn
	 E/yB0RTpuk51LGY/bWhkxpJmnc0jN/aZFOENGaQvncUQuBtT7Sl+8F/v90nrlXL/0WIYUHHQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Yeking@Red54.com,
	dianders@chromium.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	superm1@kernel.org
Subject: [PATCH v7] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Tue, 30 Jun 2026 05:04:21 +0000
X-OQ-MSGID: <20260630050421.49172-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <360r0r52-n546-s91n-s51p-893o79415s74@xreary.bet>
References: <360r0r52-n546-s91n-s51p-893o79415s74@xreary.bet>
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

Link: https://lore.kernel.org/tencent_F6FC553D1BB737FC00062AD0FEF43C580F0A@qq.com
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
v7: Drop I2C_HID_ACPI_PRP0001 Kconfig entry and build the driver under
CONFIG_I2C_HID_ACPI instead. Also wrap acpi_handle_err parameters across
two lines.

 drivers/hid/i2c-hid/Makefile               |   2 +-
 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c | 104 +++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-acpi.c         |  52 +++--------
 drivers/hid/i2c-hid/i2c-hid-acpi.h         |  33 +++++++
 4 files changed, 152 insertions(+), 39 deletions(-)
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi-prp0001.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-acpi.h

diff --git a/drivers/hid/i2c-hid/Makefile b/drivers/hid/i2c-hid/Makefile
index 55bd5e0f35af..38d5d827f3ce 100644
--- a/drivers/hid/i2c-hid/Makefile
+++ b/drivers/hid/i2c-hid/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_I2C_HID_CORE)			+= i2c-hid.o
 i2c-hid-objs					=  i2c-hid-core.o
 i2c-hid-$(CONFIG_DMI)				+= i2c-hid-dmi-quirks.o
 
-obj-$(CONFIG_I2C_HID_ACPI)			+= i2c-hid-acpi.o
+obj-$(CONFIG_I2C_HID_ACPI)			+= i2c-hid-acpi.o i2c-hid-acpi-prp0001.o
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
index 000000000000..0bbed1853313
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.h
@@ -0,0 +1,33 @@
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
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID descriptor address failed\n");
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

