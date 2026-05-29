Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342135A3A9;
	Fri, 29 May 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057003; cv=none; b=Jpg8+1BtWNmpdT2BCIYGfe6SLjmtz8uGuRF2s+1mNzslur9ydJKqC40lZz0YZvdNkox43oq6PcziPaQ/YwnYOKDYlFlLHvP3JhiG+5mVFaOmJwmftldapKPsUUpAHKDlecZcStxnJJ1+atI5/HjYZkqyIXSaAz5bzGT5YVxPOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057003; c=relaxed/simple;
	bh=rpECjf9g+j8SXY+VkGie2jCIDaHiZlvoW2jAFZYRMUE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7odWh+GvMRdB0XHNwufgprYqjpE4alvTs1g4ULmzN50TFOTrxsaO7XMcbVbUmDbPvEeI6RV1yTL0AwF3NWBRXtK5Vm7VrznXja8s9gZRF3xxUmWaD0uiPR0kpYFLAJmaEU4y0mrO8032VtvUEOrYvlz3o4CI6kdbdWobDkZHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KyhoIudX; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KyhoIudX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780056991; bh=udbVwsqoL1+h/rU4NFiYj2Zyjfi8nfWbFHKNBjrHLh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KyhoIudX1K7r+GtJ6rVZ115OEq2OhY+4BkRNW1+z4hvVQP1pfhw2rrpqbtjnVMSXK
	 S52WGqyr0ybXnn/b8rQvN+1+HoCFotfOzsbMkJc+MEyUNxUcrMpwKrh72YiLiGR6M9
	 vwkKC1DgP5p+/Ld78VRs0EAgzjNcaYvoKggtkrrc=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 4108A259; Fri, 29 May 2026 20:16:16 +0800
X-QQ-mid: xmsmtpt1780056976tsqy7qwd3
Message-ID: <tencent_ECC71F91403F5AC69E1E6B963FA667ABF607@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5Symgcg4A5w94PyhbJ9b9fTDfhERrLRpaxgn5QWLm+gsE5aTG5kr
	 iRdMAPvIV0K8GXetMU6gsgGIDTww1ZZbaLBk7yrLhQtbgAeHwga6E7XP5hKeH/vn0KpS7R+BLwz4
	 h2Qo91ocNwAx1lGyRpX4v/Hm5W2w7F+2vN1o5mO3qE0AL17REpw6PjBcfJ7S95pNoRXx4f/8u3o3
	 o9c4YTzn6Is+SEXH1Imo9uMmUTzB4sqgM1O1RhT939ymLtYHEZO0gDtbnWtzn58QxZ4SexuCgTBY
	 JzenM7Y3bN2W0NO8RSg9PEEzyhWHwiwsyKCTcblIwHNJJkOYg2c/lRM+pzOyHGNk5Y7GVqrs9s//
	 xJeyMSOPgbZri95YL99hEP7/jowwAWgLzuoz5TYUw10+zO9uhPSUwv25jmtXWABilwALjkPZOTRG
	 LfjPKQMz5o+wXsfsaDqNcZYxRx4eQ6gGqpuIbpcpZZk1e4Ndla0T5kNZA5XmARqBlN7EXAjIpyxv
	 QTV6ShuqtYGy6NuDKssfvJGE5l5AqV1284N8XkBYjLYaD1UKCWq9t9aeBXa65CATjdsqG+g2lW+x
	 Q7aLFLC3F79IA/kxxgx032v8hfrV6Z6K3yP9mr2lQFD6iWbHBOalWJa43XmA4oVbvUZgNvhHTHeM
	 yDEL77XkyD9OLQSUg2ziD91HLTSjp+Xt47Onu0JR/r+/yIeJ9MFPodrWXYYEdCt2PMpUjMiLT/VW
	 KB8GBs1EApJoyouN3gF1OheHFJNDc4EYx912uJ/FvAQQ/dLpj/HirSuwf9nXSBfDlE558FfKm8dH
	 lhPAYULoXsL5xnaiPXIladQQJGXcuAFh5d8PYSY0Iuke81gszFq0oLZLNv8/efa6EOg27bKJjlIO
	 NA9dCZVG6T4GA2gtXfR5v9fNT6xsMVakJTAIyngGHyAHLKFHUwX6RzoEVFUtQNGCAfySMZTuys/1
	 OoRaS7dHQ+lIlSId8CYAuyqEAInqgnUYekHaJqeycTE0eVMeWol6pIir0H/h3LSPbOOxz4zct1iO
	 XkiaEWe6SSaAeCEngpqLkH0GRh2PK1uEnl08GBPtifFFHB2F1+GdqQ6FaMKS4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org
Cc: Yeking@Red54.com,
	bentiss@kernel.org,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	superm1@kernel.org
Subject: [PATCH] HID: i2c-hid-of: Fall back to ACPI _DSM when hid-descr-addr is missing
Date: Fri, 29 May 2026 12:16:05 +0000
X-OQ-MSGID: <20260529121605.204453-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9e5232a7-5b8b-4025-8a31-108eb164861e@kernel.org>
References: <9e5232a7-5b8b-4025-8a31-108eb164861e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are
separate modules"), the unified i2c-hid driver handled both PNP0C50 ACPI
devices and hid-over-i2c OF devices. After the split, devices with _HID
"PRP0001" and _DSD compatible "hid-over-i2c" are only probed by
i2c_hid_of, which requires "hid-descr-addr" in the _DSD. Some devices,
for example the Lenovo KaiTian N60d and Inspur CP300L3, provide the HID
descriptor address only through the _DSM method. Fall back to the _DSM
call when the property is absent.

Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 57379b77e977..62c089a6455a 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -19,6 +19,7 @@
  * more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -74,6 +75,39 @@ static void i2c_hid_of_power_down(struct i2chid_ops *ops)
 			       ihid_of->supplies);
 }
 
+#ifdef CONFIG_ACPI
+/* HID I²C Device: 3cdff6f7-4267-4555-ad05-b30a3d8938de */
+static guid_t i2c_hid_of_acpi_guid =
+	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
+		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
+
+/*
+ * Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
+ * declare their I2C HID touchpad with _HID "PRP0001" and _DSD compatible
+ * "hid-over-i2c" but lack the "hid-descr-addr" property. Use the _DSM
+ * method to obtain the HID descriptor address.
+ */
+static int i2c_hid_of_acpi_get_descriptor(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	union acpi_object *obj;
+	u16 addr;
+
+	if (!adev)
+		return -ENODEV;
+
+	obj = acpi_evaluate_dsm_typed(acpi_device_handle(adev),
+				      &i2c_hid_of_acpi_guid, 1, 1, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj)
+		return -ENODEV;
+
+	addr = obj->integer.value;
+	ACPI_FREE(obj);
+	return addr;
+}
+#endif
+
 static int i2c_hid_of_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -92,6 +126,16 @@ static int i2c_hid_of_probe(struct i2c_client *client)
 	ihid_of->ops.power_down = i2c_hid_of_power_down;
 
 	ret = device_property_read_u32(dev, "hid-descr-addr", &val);
+#ifdef CONFIG_ACPI
+	if (ret) {
+		int dsm_ret = i2c_hid_of_acpi_get_descriptor(dev);
+
+		if (dsm_ret >= 0) {
+			val = dsm_ret;
+			ret = 0;
+		}
+	}
+#endif
 	if (ret) {
 		dev_err(dev, "HID register address not provided\n");
 		return -ENODEV;
-- 
2.43.0

