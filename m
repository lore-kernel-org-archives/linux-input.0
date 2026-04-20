Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F23A5E75
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708943; cv=none; b=Un10drXnB+jEOMZu2X/P/CxgSmavVEtda5k+yC4MTTsx0yW1qnEvUL0BXeY68sS8kNmr8sciAzFzCbjwNlKBLK7e94lGVKMxsZYEaXawD24qZSITyh2+3lIcKsl1F9/qu74heyeC9Q3cwZk8qCJprMxjujmKeDQ3eQQvWPEbg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708943; c=relaxed/simple;
	bh=EemnUs5FFrPDECYbiRyH9NCl5jBWOQdZi5WTfKx22KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZkdjXM9GvvOQcu9fuVKsvIQ7aJcxZjz5NmHVdhrZv7dEZrysPVJxntm5FPNht5lIllwuasBcvbE+kpPscxoTt39MEFqrbO6qSfadEnhQ/hY+mOxkCZZqLY2KmgDDlJ8zVuZVODsBZpCKeA2YBQsg/tH086v7bE9sOSr49OVepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uF2ywO0Z; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uF2ywO0Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776708939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CBg+5OvftSflpxhdipcLP0c6mKAJZPXjDUv8bmAFcEA=;
	b=uF2ywO0ZRxf+8kfk61CegeDsRjOTdxFmT+ubuCgV5PJNa8fTFvaUhui7vaktjnbYL1ppj8
	oMI79X0iw/4Y7Uipe+555YXTL9IZtU+F4KRbr0e5yVvqJPMP/D313jEzJxYJvVveUM8IOa
	oU97OsdT8a3Yp5gb0vfZ9xDTFNrrxWM=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: derekjohn.clark@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: mpearson-lenovo@squebb.ca,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle
Date: Mon, 20 Apr 2026 11:15:22 -0700
Message-ID: <20260420181522.521627-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The controller MCU does not persist OS_TYPE across power cycles. During
s2idle resume, the USB device may be power-cycled, causing the OS_TYPE
setting to revert to the default Windows value.

Add a reset_resume callback so that this is correctly restored after
resume.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/hid/hid-lenovo-go-s.c | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 01c7bdd4fbe0..ff1782a75191 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1369,6 +1369,14 @@ static void cfg_setup(struct work_struct *work)
 			"Failed to retrieve IMU Manufacturer: %i\n", ret);
 		return;
 	}
+
+	ret = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, FEATURE_OS_MODE,
+			       NULL, 0);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to retrieve OS Mode: %i\n", ret);
+		return;
+	}
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1427,6 +1435,27 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 	hid_set_drvdata(hdev, NULL);
 }
 
+static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
+{
+	u8 os_mode = drvdata.os_mode;
+	int ret;
+
+	ret = mcu_property_out(drvdata.hdev, SET_GAMEPAD_CFG,
+			       FEATURE_OS_MODE, &os_mode, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG,
+			       FEATURE_OS_MODE, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	if (drvdata.os_mode != os_mode)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int hid_gos_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
@@ -1481,6 +1510,20 @@ static void hid_gos_remove(struct hid_device *hdev)
 	}
 }
 
+static int hid_gos_reset_resume(struct hid_device *hdev)
+{
+	int ep = get_endpoint_address(hdev);
+
+	switch (ep) {
+	case GO_S_CFG_INTF_IN:
+		return hid_gos_cfg_reset_resume(hdev);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct hid_device_id hid_gos_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QHE,
 			 USB_DEVICE_ID_LENOVO_LEGION_GO_S_XINPUT) },
@@ -1496,6 +1539,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.probe = hid_gos_probe,
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
+	.reset_resume = hid_gos_reset_resume,
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.53.0

