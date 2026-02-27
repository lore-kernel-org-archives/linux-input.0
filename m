Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6447885E
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236261; cv=none; b=NSvS/TmYtjyH/kmFNIB2rPHGXy8XSVwuSqd/4NnPqB7pVpCYUS1jiO0jybRZC2QqWfxAaW84oQ5V8vEvVjHDaMUrrE65/MQXu63a//JW+DptpNlc2GQQPukkLyY8dL7Ix8XDBYt6jTLWtxldd5ewvktVNq6D8h2EMwIRYBoS7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236261; c=relaxed/simple;
	bh=LbujEYa9xoRLHSlUYndNgtlMJuRqK9FWNuK7En9isu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdkJ/DXEDsUSKm+RF4Ie82XCiNZ/hpIoelhGqBZkkxSSQi+lLnIzwpboQcpJN2EKE9iqS0B7XR8xFODIWYg2e5W9xFePKJQoWfL7g7VT9MkaCUwBvYjNCYdCjFrFhDpwb+EpnKHIxy2AKxaxPiPCAHB6+8Ib8Ov1DgKh8alPmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlyqjzGZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlyqjzGZ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8954a050c19so31119216d6.3
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236258; x=1772841058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=payWMY6Loq24vrolvebCCPCb0PjAuPj9S7qipv+bO2Q=;
        b=UlyqjzGZe6W5d5xUy17OZd6lKuDBkaPLheUoyOkFm90UIRPqjbjObiy3Jg993LFNXF
         lZxqcFEu6DfTd0xh8l2wwWbV6AfiqOB3fa4v6ZT+hv/SJPJFtmROVO26iLvmpplOa37L
         rTPpSwUJAw0mmVsSIFXPLsxGtUzuCJe9bYFfNSqjc9KmRiWweRBMrFuVs2lPA+BXNVPq
         slQkJ807fjpr5aMyV47QmjougeIABeXly4K/Uj7aynoO7UD/IcXaB/Ju7K3rqRDpK4T/
         2ROD36Eo2xRe+qLCvm2fAdPfR8JxePn22newNJik0fpTkzb5Pbg0EoG7wzFJKbNXiknf
         3C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236258; x=1772841058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=payWMY6Loq24vrolvebCCPCb0PjAuPj9S7qipv+bO2Q=;
        b=xF6oi60tiP1zyeYBOKTyaD6gQTpL/4SkNg7Q2fV8xTgCadPEA6JGOEUClkEHANMEVz
         NakAvcRot0O0XPxiPwV1Oy/MguvrbxbT3Cv2ydMMq3/Bay6ggB/isW/GWEZLkPWIdK4v
         H+xwtzEmsG8eTjqmUC9+DY0TrIQFiyUPRjcam/vHCLZeOUZanyNdLIdoYcsZRhZOTaLM
         rg0dh8D7C9TZqUT55kjieRVRaaC1iHaCO47S+grM1w1K15gE3Dw8WdkS6HL8jPdQjZUx
         EUfpJYUOhdiiY9lAiVS0FplvaN++n8UxqstsUVgIjekFofomwF/4bjy9zcMdZSzI64rZ
         oNbw==
X-Gm-Message-State: AOJu0YxgKVwb0g/cPn2Ztj6gfhvTiW1XwANTg5FE7whipbdVeYwX01cd
	6NQqPPa3j+ZRB1glJ7KpQwdQiEsadr1ULKi/0QfTTwmP24r+FzetSt/x
X-Gm-Gg: ATEYQzxObSizV7yt+bU6FGerK+B6TwOm/WlkTIEzzsmPz9udWBfI6tm5I1raS4geD7c
	vkj+r2vVcRYjHRSUCr3LBUvi/wr2Q9yLFzoYo7VAXKcZxoUsF1tr28+bEL36VEFXMxqC/XL2dOZ
	vg0F9Xfw9l3eBSKJklaUfnrCb0kGvViCsxsijK6C6xv79rsMFS3YVPX9QQHY+V75QdcfDogCIrI
	UA2g5wV+4VQOZevaT3ho49s03rBWzcfwjXMygX7Xb2gva7xSYz/QcYMit8aKS1N1mmef77KdW2i
	5crhq9qsIyAZ1zdfbTlUW/r6sIKr0h2w2Hx25oUKPbreecW/oMmgB4yFNbgwsVqyg4bQy63Af1M
	Fe2unVnaw2RWOxOsrrfsrAUpqrOBM8gfODRLiBYQXLJ+/qWdC1yAxEHPPTxMoIYTljkRlVCY0MZ
	SkiL2u/6b1y4nvvHTiWO9Np3F7sB1ZSgoa/KpanOc6l4hVe7ztvw==
X-Received: by 2002:ad4:596f:0:b0:896:fe42:e88f with SMTP id 6a1803df08f44-899d1e863e0mr70702846d6.61.1772236258404;
        Fri, 27 Feb 2026 15:50:58 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:58 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 16/18] HID: steelseries: Add Bluetooth auto-enable sysfs attribute
Date: Fri, 27 Feb 2026 18:50:40 -0500
Message-ID: <20260227235042.410062-17-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the Bluetooth auto-enable setting as a read/write sysfs boolean
attribute (bt_auto_enable). When enabled, the headset activates its
Bluetooth radio automatically on power-on. Currently supported on the
Arctis Nova 7, Nova 7P, and Nova 7 Gen2 via write command 0xb2.

On the Nova 7 Gen2, the current value is recovered from the 0xa0 device
settings response alongside inactive timeout and call audio ducking.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 65 ++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index f076a0ef8af1..a794af01e15a 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -32,6 +32,7 @@
 #define SS_CAP_VOLUME_LIMITER		BIT(8)
 #define SS_CAP_BT_CALL_DUCKING		BIT(9)
 #define SS_CAP_INACTIVE_TIME		BIT(10)
+#define SS_CAP_BT_AUTO_ENABLE		BIT(11)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
@@ -40,6 +41,7 @@
 #define SS_SETTING_VOLUME_LIMITER	2
 #define SS_SETTING_BT_CALL_DUCKING	3
 #define SS_SETTING_INACTIVE_TIME	4
+#define SS_SETTING_BT_AUTO_ENABLE	5
 
 struct steelseries_device;
 
@@ -97,6 +99,7 @@ struct steelseries_device {
 	bool bt_enabled;
 	bool bt_device_connected;
 	u8 inactive_timeout;
+	bool bt_auto_enable;
 
 	spinlock_t lock;
 	bool removed;
@@ -644,6 +647,9 @@ static int steelseries_arctis_nova_7_write_setting(struct hid_device *hdev,
 	case SS_SETTING_INACTIVE_TIME:
 		cmd = 0xa3;
 		break;
+	case SS_SETTING_BT_AUTO_ENABLE:
+		cmd = 0xb2;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -999,6 +1005,7 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 		break;
 	case 0xa0:
 		sd->inactive_timeout = data[1];
+		sd->bt_auto_enable = data[3];
 		sd->bt_call_ducking = data[4];
 		break;
 	case 0x37:
@@ -1013,6 +1020,9 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 	case 0xa3:
 		sd->inactive_timeout = data[1];
 		break;
+	case 0xb2:
+		sd->bt_auto_enable = data[1];
+		break;
 	case 0xb3:
 		sd->bt_call_ducking = data[1];
 		break;
@@ -1147,7 +1157,8 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
-			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME,
+			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME |
+			SS_CAP_BT_AUTO_ENABLE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
@@ -1160,7 +1171,8 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 static const struct steelseries_device_info arctis_nova_7p_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
-			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME,
+			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME |
+			SS_CAP_BT_AUTO_ENABLE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.mic_volume_max = 7,
 	.inactive_time_max = 255,
@@ -1176,7 +1188,8 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
 			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
-			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME,
+			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME |
+			SS_CAP_BT_AUTO_ENABLE,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
 	.inactive_time_max = 255,
@@ -1416,14 +1429,53 @@ static ssize_t inactive_time_store(struct device *dev,
 	return count;
 }
 
+static ssize_t bt_auto_enable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+
+	if (!sd->headset_connected)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%d\n", sd->bt_auto_enable);
+}
+
+static ssize_t bt_auto_enable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+	bool value;
+	int ret;
+
+	if (!sd->headset_connected)
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	ret = sd->info->write_setting(sd->hdev, SS_SETTING_BT_AUTO_ENABLE, value);
+	if (ret)
+		return ret;
+
+	sd->bt_auto_enable = value;
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(bt_enabled);
 static DEVICE_ATTR_RO(bt_device_connected);
 static DEVICE_ATTR_RW(inactive_time);
+static DEVICE_ATTR_RW(bt_auto_enable);
 
 static struct attribute *steelseries_headset_attrs[] = {
 	&dev_attr_bt_enabled.attr,
 	&dev_attr_bt_device_connected.attr,
 	&dev_attr_inactive_time.attr,
+	&dev_attr_bt_auto_enable.attr,
 	NULL,
 };
 
@@ -1447,6 +1499,8 @@ static umode_t steelseries_headset_attr_is_visible(struct kobject *kobj,
 		return (caps & SS_CAP_BT_DEVICE_CONNECTED) ? attr->mode : 0;
 	if (attr == &dev_attr_inactive_time.attr)
 		return (caps & SS_CAP_INACTIVE_TIME) ? attr->mode : 0;
+	if (attr == &dev_attr_bt_auto_enable.attr)
+		return (caps & SS_CAP_BT_AUTO_ENABLE) ? attr->mode : 0;
 
 	return 0;
 }
@@ -2106,7 +2160,8 @@ static int steelseries_probe(struct hid_device *hdev,
 		}
 
 		if (info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
-					  SS_CAP_INACTIVE_TIME)) {
+					  SS_CAP_INACTIVE_TIME |
+					  SS_CAP_BT_AUTO_ENABLE)) {
 			ret = sysfs_create_group(&hdev->dev.kobj,
 						 &steelseries_headset_attr_group);
 			if (ret)
@@ -2189,7 +2244,7 @@ static void steelseries_remove(struct hid_device *hdev)
 
 	if (interface_num == sd->info->sync_interface) {
 		if (sd->info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
-					      SS_CAP_INACTIVE_TIME))
+					      SS_CAP_INACTIVE_TIME | SS_CAP_BT_AUTO_ENABLE))
 			sysfs_remove_group(&hdev->dev.kobj,
 					   &steelseries_headset_attr_group);
 
-- 
2.53.0

