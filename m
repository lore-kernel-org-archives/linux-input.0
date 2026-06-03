Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843637D11A
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482243; cv=none; b=lcYRyzjGFcwrlTHEqdO/3T5AEubUQXyD0M82p9/PcQmKD82Bw4Qk/6o7aaeBz26WmYoj5dtCxBkcT9G5c0oCGFLY/8ThqoWrBf7NE2CeyfdNZfvO0zaKy4Z06NFVGah12Zgxkwnuq5Q10y8R6drHkQ59Al0qFWUTqelad3glPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482243; c=relaxed/simple;
	bh=y5vpdiIoKruWzLXtYMt/4Iu3nY5IOgtJoexCKD0XE5w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghLZ6DqCeZTfFiicz62hUjbm58OGtOo5UzGbnlUpJFxb7f2MmSH9A5Pk1uk0CJ7rE9e/bzssW8gDcNeH9t70UlDaK4FLkONT1uypu0SY1gS0v9fU/9fXsoy4Sq9uEB5LTi11o3ZpQlTeadXQs/8HDK6msjDpGvnVPfnmmtNzN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=C1px6kD0; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C1px6kD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780482237; bh=on9WU9KsNyffsUGMYHazc8i+mDZ72lfnIPUm3wqVvIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1px6kD0tWwKhZfFNdqmD6ij91RVcKjsIQcb/hyC65t0pqDVEj1VhPvuEehs4m5D+
	 N9fDpWI6xill+e5pp+rlVjv0JsU7ux74t6wM67zXFq4vqhwGS85VliPffp69J3a3cK
	 BJ+RWcH4hTo4/Wj6CRLJ3w0ntZG4YihDIGW/2JIk=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 5C23E0A6; Wed, 03 Jun 2026 18:23:02 +0800
X-QQ-mid: xmsmtpt1780482219t5z7mbn7h
Message-ID: <tencent_EBEDD53F0E819EB4793DB0D6177F2BCFEB08@qq.com>
X-QQ-XMAILINFO: NG7xP+P+sy64h3BH/qydr9TRO42YitWxkR0BeQdFM0KXKUznXkqujgPQewjwRr
	 1j+fHtBBBH6ZaPo5AVapLPqe2gC8jqBAqqqLb3QVhj0cXh36sqb2A+dHLvbZIDq2WR2PDWIcheq+
	 ILUOcErJhLmWNTXg255JM3SV99fFTqEInqrI/J/GBQuCP6JY8A9U6zYoGjeAVc7c55gtP+vI3D1/
	 C9CD1kl+TNMjOufN51PyZK5TwWrGxWzkNMlk9wueW8WwY9hVtxKJflhbUSQRFA6k4x0/BSTg/hSH
	 SRVg85AcJWh4dezY0TXPpSW4WAPLZdA2l+XUG165c8jhxQtYcL3ts9ieIjn6FHLN16opePmuqTjN
	 RGKFhS2SwKsUYX7KlyIXUq+ol3PzX+psSMNMnjDj0EaLcdgIzZSENIJvNar+Pgujv5H/n9y4LoqS
	 DnCn+26v+655f7FDRu/i4qM8vU+oumcSZVyGK8SN68UGoYNK3BOY4pQmAgEPpF9TmMls516NUHp8
	 rrnMjVOm/2cRrbLcvcJXqi4hATPueRxQHR5sVtlDuTrLTv0vMOV7dn2vnXa8/Su04wAZmcWszdM1
	 p+e7EmQw6suc/86JiN1ZLR7l/c4QKe19J8wtlYX/YN8qdDKKladb7TvdYGtaSkslsSnfdE324jf2
	 Bn/to13lp9OMb9FWXPXFpRH0BXnybkzdcQNwOYKvzmXDgH5woYTB1X18gUpghDzqbM9BbzLV3jKQ
	 XtWCAZWX2USgRBS3OpsACOl0mULfLA3r2rbzOCUTH7fFOeRnCw7g5OOykbpCIDZNvZ7UyOt+6eNr
	 PHexWkrZ/ZAAR7vt8ZQ++Tc1RwQx+gCljlbiKOBUlFQhfnB63TVfNlgUBoe5VvUkqymccm7zTRuV
	 wq53Ks/DBP3jyYeUeIMbx/9WHOUcV5s6ifC6xah/VU0xogACZbicyliFBWWhE0kAUiDgAB9MxlZ1
	 27dWXkpfVpe1ZvC6AXxTEFLY5kfkxtWt8et7b4Hz4tQu1eyvZ54CBwvQln7/OIWnVQlvI+Z5t0GN
	 RK+D4Kc7mhfbXA/FS7amFGXh6IJ+GszfKzXbsHi7YdpzqzZ6X1aUDC4jz15FG54iLET3YFALLZWe
	 3d8UYqXzJjniGIuOj5nt4WpLyfFarioq7emA5q
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] HID: i2c-hid: Move common ACPI _DSM helper into core
Date: Wed,  3 Jun 2026 10:22:38 +0000
X-OQ-MSGID: <20260603102239.26491-3-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603102239.26491-1-Yeking@Red54.com>
References: <20260601184747.843DB1F00893@smtp.kernel.org>
 <20260603102239.26491-1-Yeking@Red54.com>
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
2.43.0

