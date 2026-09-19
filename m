Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC445FFC7;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814201; cv=none; b=LYG3/zOmcDC5+TNEKx6CM/1ml83gb4qa3FMP2RomupTu+C5qAkkzhxKCOSIt5QqR9wXvyhBqJFk5SCiUPhMfPJPA0ggXH/r/vnPunHeG7pTOcAcuXJhtXB+zjjs0Y5FSoBf2oMxDkhgQp5bqnIc34GHTQBnG/SBCBRLVevT43Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814201; c=relaxed/simple;
	bh=IjMjUWNEXRYY5wqfhnqbc8zWKm02QgkN8rTn6nVz9QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VObveLcv4T2G1Es1GQ6YYAiZsrhfpjFBnP+jACwscAGM8hOdmcs2+3Gbzx33w/HNw519scExbxlJ5W2FgR3f0idKIyTbSUBAvHyLAyEz/oYR5XSb9Qif+oVVNhbdafXUj/E0v8VhSJz7FgJDBGWDXNC8YtPTQlzZUDQyPsCt+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grn/WMT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grn/WMT9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68F04C2BCFB;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789814201;
	bh=IjMjUWNEXRYY5wqfhnqbc8zWKm02QgkN8rTn6nVz9QQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Grn/WMT9aPzecaw+VM3dnAj1M2N6fSkUd5fw40YnkIy/lfEs3OdeXmX8h1sMWLEsk
	 DQQweohySnyXzqxyelfcRp4MmBl0eLdWc/LgkK8MSitQsKfmPRXVfP3n7XGE8l5dut
	 6MyDBTuw2DaOwsrAK/NFahbikv48KvoFM+Lpg4pJQF/IxGK9zTTILeojsOD5Ad9z2I
	 Zox0nU075XHuyNA8erdI3ytZ+y7jvQDy384a6U9qm5tOo0xrXwx8PSXk6rjCBTEQNy
	 PAedGm0eVaELLn11+2RN9Ac+0AmovzmcRlV0/nmvJ788qtIMercqEAvZs09LvLQjVZ
	 E+Q3nLYasIKOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E05FC982E6;
	Sat, 19 Sep 2026 10:36:41 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 19 Sep 2026 16:06:26 +0530
Subject: [PATCH v6 03/14] HID: hid-sensor-hub: introduce device managed API
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-3-d577b2371b3c@gmail.com>
References: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
In-Reply-To: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789814199; l=4401;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=X2I8hMTXE1/MLkTlWKifhsxsUQ6NP23KYfZXkjSBpog=;
 b=ZRinwmoJCRG3gJ5kdyYLdZx5Ac9AWx2SXTQZlP+Zocimt/3x9g7z6i7rH/heYcWUzk+aKvSEv
 d/WJO12XC4jDC/ztCQSZfhJBrSe/CAURBRv9K1LIyL0dGPp8e8sx+H8
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

sensor_hub_register_callback() is common API used for the HID IIO drivers,
prepare devm API devm_sensor_hub_register_callback() to acquire resource
during setup and release using device managed framework during drivers
fail, unbind or remove path.

Store the required callback removal context (hsdev and usage_id) in a
dedicated struct sensor_hub_cb_devres, and register resources with
devres framework and helper API.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v6:
- Add kernel-doc for return statement for the new devm_*() API, as
  suggested by Andy.
- Keep kernel-doc for new devm_*() API in public header file, along
  side where existing API documentation is available.
- With suggestion/input from Jonathan, use devres and cleanup frameworks
  together to implement device managed API support with less complexity.
---
 drivers/hid/hid-sensor-hub.c   | 35 +++++++++++++++++++++++++++++++++++
 include/linux/hid-sensor-hub.h | 26 ++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc..de35e72b4d88 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -4,7 +4,9 @@
  * Copyright (c) 2012, Intel Corporation.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -187,6 +189,39 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 }
 EXPORT_SYMBOL_GPL(sensor_hub_remove_callback);
 
+DEFINE_FREE(devres_free, struct sensor_hub_cb_devres *, if (_T) devres_free(_T))
+
+static void devm_sensor_hub_remove_callback(struct device *dev, void *res)
+{
+	struct sensor_hub_cb_devres *dr = res;
+
+	sensor_hub_remove_callback(dr->hsdev, dr->usage_id);
+}
+
+int devm_sensor_hub_register_callback(struct device *dev,
+				      struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id,
+				      struct hid_sensor_hub_callbacks *usage_callback)
+{
+	struct sensor_hub_cb_devres *dr __free(devres_free) = NULL;
+	int ret;
+
+	dr = devres_alloc(devm_sensor_hub_remove_callback, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = sensor_hub_register_callback(hsdev, usage_id, usage_callback);
+	if (ret)
+		return ret;
+
+	dr->hsdev = hsdev;
+	dr->usage_id = usage_id;
+	devres_add(dev, no_free_ptr(dr));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_sensor_hub_register_callback);
+
 int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 			   u32 field_index, int buffer_size, void *buffer)
 {
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index ab5cc8db3fbb..aa4ff9a95d86 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -79,6 +79,16 @@ struct hid_sensor_hub_device {
 	struct sensor_hub_pending pending;
 };
 
+/**
+ * struct sensor_hub_cb_devres - devres data for sensor hub callbacks
+ * @hsdev:	Hub device instance.
+ * @usage_id:	Usage ID associated with registered callback
+ */
+struct sensor_hub_cb_devres {
+	struct hid_sensor_hub_device *hsdev;
+	u32 usage_id;
+};
+
 /**
  * struct hid_sensor_hub_callbacks - Client callback functions
  * @pdev:		Platform device instance of the client driver.
@@ -143,6 +153,22 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id);
 
+/**
+ * devm_sensor_hub_register_callback() - Managed register client callbacks
+ * @dev: Device for resource management
+ * @hsdev: Hub device instance
+ * @usage_id: Usage id of the client (e.g. 0x200076 for Gyro)
+ * @usage_callback: Callback function storage
+ *
+ * This is the devres (managed) version of sensor_hub_register_callback().
+ * The callback will be automatically unregistered when the device is detached.
+
+ * Return: 0 on success, negative error code on failure.
+ */
+int devm_sensor_hub_register_callback(struct device *dev,
+				      struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id,
+				      struct hid_sensor_hub_callbacks *usage_callback);
 
 /* Hid sensor hub core interfaces */
 

-- 
2.34.1


