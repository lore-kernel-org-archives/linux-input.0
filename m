Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B373E95A0;
	Mon,  1 Jun 2026 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337776; cv=none; b=ZMGjt7qFLEXP92Ip/S8eGNDnwI6BBMztwM18eo3zSrWvrgDsk/SNOqH9vYgScfYJMwcwA1MbU1s/PXOmWOEI7kOtBe/dhPiIWBoXbmK8lCEEpdKrqReqO+fQFJ8Q+lbZA24iduM5dbjYbLaZDyRQcFtxAwG8VZ09lOM0gdyTE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337776; c=relaxed/simple;
	bh=qWlgzOi2blkfo6m1jeqRjDii4BIuK/BSetwYdeKPBQ8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fe0i4j9iquLeFY41rVnpa/MM3eBkKaLAiLELbyhzHMBfGusm33qmX1rkoBi+1gsNxzUIETtZn+iWg58gi4XQSmZgJ6x+MZVNvIVNJEcPHOUAmdfP2WGYg2Me+6D9A9UVznIMM3n2EUPe9GBEJo2eeIERSIdT55VX1tqm5jPF3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GdQgxRNh; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GdQgxRNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780337764; bh=l0z22jOi4C5VYZvDk/2A1YgMqb9WwIF9AFjlfAtrcFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdQgxRNhmvht6d7nMNJF3/1XGjO84gG47cYk0E+CuwoGsEzb2XLXbqR7UKJ1IikvN
	 tetC1PVtadh4o/nAl7erQbUN1tbTaBe2vmr26Zxx+mUQyIkcPNcky1PktoVtLpygqZ
	 6O//pjSckA0p7udpNjA2wUWP2gVC4Q5I6LHfZHsc=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3D41C48B; Tue, 02 Jun 2026 02:15:20 +0800
X-QQ-mid: xmsmtpt1780337749ta9q2nnj8
Message-ID: <tencent_71AA07C8BAF64FE0F9B0FDFC072BB08B3605@qq.com>
X-QQ-XMAILINFO: M9nJR7l2xhOGzf/aOQymkhShv9RTYx0yX1VZYXv/7AQqZxTs6LZeJ6sYc5+zyM
	 wAJ+m0LDpJRBnX/Pg3f/E/fukzbHRYHfcdktBvOeMMjtwiNCNpi/9B8725tULE1vIDGEcertEj85
	 MSKedEY2wK/oSWHManoRm7MqE5bK/og6IaHM1xcYC1mrXGBNEFn5pZtPCCoV8MWPXzGtaolAYpL0
	 dy93k7S1WZ2WjJG0xhywaZvt/rO2BnsqySRBxZXf79hlQYBDw8qLxl+F58ppIDCK12gybE6e1+EE
	 1A2Pv4EFxz1nlcpb+dsQhWC4RkBbIYqHUdlbIgfeCot0wSQtLkao+aofIRdm/J9iD7YDZNZPHk5q
	 jvfDYM499p+YzmqVznwX0AVEAhT9ELjBAV30x5ryKuTLO5o3uF7EM6LEuNxpISCEsB46iuyfcqsi
	 49vG+gkCzFvcYw/HmlzUdhs5R7IP1T/hOeNPBvbLWsqWInjVhw8wB+6GJR0n1Vqx/UTwoUR9GLYl
	 mXYPwQEdMRmSY6BwWjMnBCdT8vzitRusfxL1Sulv6tAh/eur9GUELcJ1GCOqlUjlOni7AWXmafeW
	 WgkPn/fxTCpvEFr6rVWB96iV1RJJtNkXwqLZQWL+4yIrZTEvDhx0pR+r/VamSvAyMFHmKt1LVrLq
	 deX7Y23oAybWd9QVOoS+TVz0kU1oZunEJMn4Fa59mMRseCOos7sW5GkfkTsBxstC+t9UqQvh+I9J
	 HXStnguUGT/DyNutSY9Iv6QJJTz81pB/8qRlg5CclVjZPmEtHFuvLDKWvO9N8ZouvueSB/QB4vHX
	 Ywqg0C52FjSCUyuSt2LulNhS+y0MZRpF2iKreuJ+w6rDhGTWpcWD6BlrsCkKHLnIGb3YNRHufaLf
	 aLvIWTgaBAuZUtDZxEUXO1Ae8vwgeEmkq7aX20km0baXPVpCEOQfK0A6xeZNq8/tMShY8Pgci5qS
	 s6YJLFkQu1v6wYTyAr5ufOSw2NhHCb88qyX121uXFSKwdhzlBixgUuQ0I1xYkBcXrJ03mMHDH0tw
	 pXLYetdk6bRlLZVvMXAwa2whJdntHeNxRkOIscP2Mw8olkGLclVC8JsrvGoR4N5V1RP9QMmq3Mll
	 gY6GehTZI5gny5Ihr6a9eClHafmF/l8xp/Blv6CD8UMW4CDNeinU8it9kgHcizYIiy4eAjdcXR27
	 REeek=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com
Cc: Yeking@red54.com,
	bentiss@kernel.org,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	superm1@kernel.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 2/3] HID: i2c-hid: Move common ACPI _DSM helper into core
Date: Mon,  1 Jun 2026 18:15:09 +0000
X-OQ-MSGID: <20260601181510.38705-3-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601181510.38705-1-Yeking@Red54.com>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601181510.38705-1-Yeking@Red54.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the _DSM call that gets the HID descriptor address from
i2c-hid-acpi.c to a shared helper in i2c-hid-core.c so both
i2c-hid-acpi.c and i2c-hid-of.c can use it.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 32 ++++-----------------------
 drivers/hid/i2c-hid/i2c-hid-core.c | 35 ++++++++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h      | 11 ++++++++++
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index f65fb6396b69..234789a07047 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -25,12 +25,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <linux/uuid.h>
 
 #include "i2c-hid.h"
 
 struct i2c_hid_acpi {
 	struct i2chid_ops ops;
+	struct i2c_client *client;
 	struct acpi_device *adev;
 };
 
@@ -48,36 +48,11 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
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
+	i2c_hid_core_acpi_get_descriptor(&ihid_acpi->client->dev);
 }
 
 static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
@@ -102,11 +77,12 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 	if (!ihid_acpi)
 		return -ENOMEM;
 
+	ihid_acpi->client = client;
 	ihid_acpi->adev = adev;
 	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
 	ihid_acpi->ops.restore_sequence = i2c_hid_acpi_restore_sequence;
 
-	ret = i2c_hid_acpi_get_descriptor(ihid_acpi);
+	ret = i2c_hid_core_acpi_get_descriptor(dev);
 	if (ret < 0)
 		return ret;
 	hid_descriptor_address = ret;
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 3adb16366e93..1e1a8df5686d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1405,6 +1405,41 @@ const struct dev_pm_ops i2c_hid_core_pm = {
 };
 EXPORT_SYMBOL_GPL(i2c_hid_core_pm);
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+
+/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
+static guid_t i2c_hid_guid =
+	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
+		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
+
+int i2c_hid_core_acpi_get_descriptor(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_handle handle;
+	union acpi_object *obj;
+	u16 hid_descriptor_address;
+
+	if (!adev)
+		return -ENODEV;
+
+	handle = acpi_device_handle(adev);
+	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID descriptor address failed\n");
+		return -ENODEV;
+	}
+
+	hid_descriptor_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	return hid_descriptor_address;
+}
+EXPORT_SYMBOL_GPL(i2c_hid_core_acpi_get_descriptor);
+#endif
+
 MODULE_DESCRIPTION("HID over I2C core driver");
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/i2c-hid/i2c-hid.h b/drivers/hid/i2c-hid/i2c-hid.h
index 1724a435c783..bc8661c65b1a 100644
--- a/drivers/hid/i2c-hid/i2c-hid.h
+++ b/drivers/hid/i2c-hid/i2c-hid.h
@@ -44,4 +44,15 @@ void i2c_hid_core_shutdown(struct i2c_client *client);
 
 extern const struct dev_pm_ops i2c_hid_core_pm;
 
+#ifdef CONFIG_ACPI
+struct device;
+int i2c_hid_core_acpi_get_descriptor(struct device *dev);
+#else
+struct device;
+static inline int i2c_hid_core_acpi_get_descriptor(struct device *dev)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.54.0

