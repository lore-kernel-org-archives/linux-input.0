Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99B3DEAE4;
	Mon,  1 Jun 2026 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335575; cv=none; b=t+S5flqNU3HbvIZCe2XRfFGXKJQpDSGX5G0r7cmDzW4wqskDywcBQ7r4K1mamXOxJe5FbJRxf6u0FNmjw7SUr3gDTcRjEcXTfgS+g0lirSC+YLGV+8igmPnXzOZWVOpt5OZ+OgVvQb808L6Tf1uDMaD9cix33o8110rb5Vl+3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335575; c=relaxed/simple;
	bh=RT5BxBqotu8QIoaxL99HedWfXf7ZkgWsKdaPhEKhCiY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxV5HoodrIKsoBsEDaXDuZO0d2JGXoxlbSnahXqGABOo15XhtB6Ru5TW5NJeoj9wFkVjjifTZ4JOT3FKr8yIIignNslbUhWUQ9n1y0ZIWyy0cndTcwpETxTqaVNAYjiX+nz/5KhJfRw34hS0ay0D98j9sQr6+D7x+fYokGCKQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bEs1CpHX; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bEs1CpHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780335570; bh=532g92EE4ZIok8ld1fWoR+bZgHmKAUJ2pFsX9r1dgL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bEs1CpHXhspW8PbVfRUqvt1PbYkZac24CtULhXNN81Zab4Kk98XNMJnAQLfHhRUHg
	 WIZaRTIk/xG7ma+3u7TRGcN8CSDc1ul0CwQs6d+VhfPmIrkFRqM9JwiadT8F2v7SrQ
	 9UFjHRKMVcuDD7DJ7OcXnfmWZFuWZNB0zRJMW65M=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 979A8A6F; Tue, 02 Jun 2026 01:37:57 +0800
X-QQ-mid: xmsmtpt1780335555temxhwloo
Message-ID: <tencent_AC6BFF38046AD21AF4305967FD0D3F73B50A@qq.com>
X-QQ-XMAILINFO: N8W06kCOZCa5PunP4nIxj0cZbc7HrsfmodMxLd7gvFY0bL1h8y2ezKjOs1qXUy
	 +tts6cC+t8xAXtlSYMY+wR+0xJ/u+rMNfzfv2VrcsvBP7Z/xUV9f4RiMrMWCPBsck+DrLiJJb6jQ
	 3MUcQSpMKuaM9+fR8uTTAE9INz2++p4XA/U7VhFCJP1IPoTJURCY0qwhw6u+fRN2khhha5TBeHHE
	 oXPOl3hz86loQkP19qf13hyXINUPq7w4G/0jtlOAATVUvLBbJXtcUR+H0GLTtoUd6tEtN0E8HEVL
	 ipJsqVuhi0Kv7uLAPFAN705KE1snKDFtWN8IGGQC0US+q6cLN9FnV3iylHmFweUT7Uiv8Mx1qDeg
	 tRHzmKsgw4dsYu/+Ja5WhYyTbGcarx1sVDeX0VAtmE9WRhDhpSicYJa3RSkkW725B5q+EUmPcrJw
	 x9wHRcV8Jgrfagskud2ZjNq5c9oPblpXMlkPEg5JqEY2kioKJGzyv9kmdt5DCdwA4UNDTjpFk4kt
	 MmYuZQLZHLOJChgXNEqadQbF2ZV5usr0SwGzylR4YH15i+3Tz8syHlwlP/60qT6owD6lJq83jJyK
	 q17Mi9skuQMWwN0AiiP+hHdiMvCRocevl372viDEpcoN4j1pFRHLRgZPMlurrKRfGwNDQUi2pXgP
	 4+IDvfJXXLdJv/GwFi6JYcy4Gje28V6lK3fsDzmMCmbxViNAZuEeeuxQcPleTOyBq/m5eeWfPqoy
	 MGnE0u252t9rXxbOCRNxu2cYlkYhpogSeXfT9uysNaVzhUMAbD+sA+jRsGObPpj9fBCNXVBmQVY2
	 0lzrSv2Cm/+1dRa6bZZ9BaC9BC8bcGGUmBneeGbPBcycm45J6DDf9HwDFD7t61XfSVofCfTaQL/q
	 o731Fik4jIr+W1eDup5w2eYvW7bPEKixN4MlhD/uUdcWeIOBBXwj02jbvljemL+oLf52/VbXWldd
	 ++7b0guyqTmb6HwHD9LnoHHSSjURVe4JwTewdpFqZnXcQrUKy2TVi+EcWe4PLb4AM3QlkywLzs06
	 QZnHqc56shejcfQfrlro4dXdKL+YW19XZThpnuk90Sh/7B7mfBPqXJm9Z0MR4Dha7RcMgFJOjDua
	 OPD0sUniyWhTtSbw4k4QSEuqF2sQ+mI0zQCMYZsv9zCZ/ue7k=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
Subject: [PATCH 2/3] HID: i2c-hid: Move common ACPI _DSM helper into core
Date: Mon,  1 Jun 2026 17:37:21 +0000
X-OQ-MSGID: <20260601173722.38151-3-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601173722.38151-1-Yeking@Red54.com>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601173722.38151-1-Yeking@Red54.com>
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
index acfe0fb9e99a..bd888134f4cd 100644
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
@@ -103,11 +78,12 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
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

