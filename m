Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CD3B8BC8
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236256; cv=none; b=nhgA1mztXUs5qwe4XSqEEs77r+1sYQcKWgTTbo0D+kKA4rgMrPQbfYESn3/XsZbluEmgphlZRfcCperipgjvaarBAPj82+ApOxx7Hp7mKl00RBR+Ph69+Lt3hGHDxgL++Nf6ZyqkhMzqk8PskvvCGmQyV+yfPaGKrSEKFZuT2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236256; c=relaxed/simple;
	bh=ApFHIa2OvHLaRNNl97SlTyuVHsFXhVbG+hJD/eSsgL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYK8P9bIK9hZPo8M2OSuV80Qksbx+gUPnt4EIg9R8zJtyoW3+TH0X3+6qkNCu92kLHzXHi7Ym87Gu7CABf6FVrYXLt/gSMJDFX9KdVP0hSytF918gHeUn5duVFJ3DAA/G4NLLEPCt5sBgwz/pr+k1y/Pqab+Bkn7Ob+YkILLrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhXVC0zA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhXVC0zA"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-507373bffd9so23388411cf.2
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236254; x=1772841054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HYWiMRGVYGT7asuCB2h3B0PDkbjhuyxsF7A0cun8+o=;
        b=jhXVC0zAd8ZH8SDkDtRA4MqzZVlGv5Mhx50fTwfvzT2ftGksfkq0Ra6FwczOUZqG4P
         D+zppPsJkmgighAqIvnWCPn1zT7X3CjbgrIR0EXECpAIxXE8Caoa7ZdL4vKBY6mpGnOk
         xi4+PsUAw9DX2GZoAGs22Kr/LJrcz8whWFUygwHLCxUAoA3WRy6U0vmbvp1yIBvIEpQr
         Svq60k6EztFOZom8WSk/ET+P/HQTJRuwe7xyh/yrbuuLca3D/3VQKNvmRMuKf6IoaUtG
         n8ksrFYHiWaYXqvakuXn6Jeyw4LMkanNMB2CNcPjJMfIB6w2BwQU+MNThz3MM5OONvuM
         cwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236254; x=1772841054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HYWiMRGVYGT7asuCB2h3B0PDkbjhuyxsF7A0cun8+o=;
        b=ASgXzXL7grLlzOyzmasOskPCVTMC0bwJrU/sKxN/m1YANqGCzOfcnCGD4c57VZqneO
         wVNQtxgFT7cbeOLDm2PFTYR18w0TCruqDObjMnP08Se5YY9TxVhewct7WgPZ7BYHXsa+
         +GDJnqnMQcAtKm8sYLU/hx0ZVDwWdYojwdkvEDgQ6A7IeQNaOQMlQ2fLieuFUdMc0UW1
         FQ/6W8NneHxGqk6U6ZiCy1pNXZgXojN/5cB1kPdcTmudktinxL8zD3Ln7w4yGx9wGD6x
         3IIH5MFRjThWbuGB9Ir602tVv459mkXVJhy7afXXw7lh3c7Xm5VhgTjbuW2iZ0z40PiO
         UUAw==
X-Gm-Message-State: AOJu0Yx8+8hWZjDDxhctSaKt+M47nfFZW7ttz6X9YngQVoUp5hWozcuY
	bmJX6PCxi4l+YATbE49FY/bOhKgHRWdoaT9kekXMiaARtzWHoxe0hbpT
X-Gm-Gg: ATEYQzz9Cb2qOFvuke7kZHxI0u5Qcewic5W56KnyrYEv8EwsqHgwiZ6PYSS3bkewYDB
	unYup6i9As8qvDUfXirfpK47TdccKS+OOfZhvX0uKsIoPZCUstvSokQtnUGnN44jZWP0jJviP5a
	fzHDdT0zAjQvfK99DTBLtJM0xFupPctpuR8MnpbpERiGkVjwktHt/WmDai+n94Ke43fiCrVzUOZ
	7K+939/vTD50BhNwaMSh0OBNgqOe8jEWTRPmgKmtkHLXfkN7kR1P4lvA8OlluqFzSdDfMHZv6Uy
	hVW9C9efGZ0IA17n2g1mzy7t2Q83nn/U2ds3OAczuzu5umpNmUBY8vrkSr7veLcbhPsCKA2dz6s
	+t9f7vtz/1AgbfvqAgOybgASRzevZ+zPGPSBhrDb7d2bnAgCyrV9zbG+8Y0Txc9iOwjvKk5mCWu
	DgM1jbAdqvJCIHPlaNDRU1AAFDAIVKXbuEXQRZyMaholeGuGJBKQ==
X-Received: by 2002:ac8:7f90:0:b0:506:20bc:f66a with SMTP id d75a77b69052e-5075290ba3dmr62486901cf.34.1772236253671;
        Fri, 27 Feb 2026 15:50:53 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:53 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 09/18] HID: steelseries: Add Bluetooth state sysfs attributes
Date: Fri, 27 Feb 2026 18:50:33 -0500
Message-ID: <20260227235042.410062-10-srimanachanta@gmail.com>
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

Add read-only sysfs attributes bt_enabled and bt_device_connected that
reflect the current Bluetooth radio state for headsets that support it.
Attributes are registered via an attribute group with an is_visible
callback so they only appear on capable devices.

Bluetooth state is decoded from the following HID reports:
- Arctis Nova 7 Gen2: 0xb0 initial status packet and 0xb5 async events
- Arctis Nova Pro: initial 0x06/0x14 status packet

Returns -ENODEV if the headset is not currently connected.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 111 +++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 3de8e1555263..8c6116d02f19 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -24,6 +24,8 @@
 #define SS_CAP_BATTERY			BIT(0)
 #define SS_CAP_CHATMIX			BIT(1)
 #define SS_CAP_MIC_MUTE			BIT(2)
+#define SS_CAP_BT_ENABLED		BIT(3)
+#define SS_CAP_BT_DEVICE_CONNECTED	BIT(4)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
@@ -62,6 +64,9 @@ struct steelseries_device {
 	u8 chatmix_game;
 	bool mic_muted;
 
+	bool bt_enabled;
+	bool bt_device_connected;
+
 	spinlock_t lock;
 	bool removed;
 };
@@ -641,6 +646,20 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 		sd->battery_charging = (data[3] == 0x01);
 		sd->chatmix_game = data[4];
 		sd->chatmix_chat = data[5];
+		switch (data[6]) {
+		case 0x00:
+			sd->bt_enabled = false;
+			sd->bt_device_connected = false;
+			break;
+		case 0x03:
+			sd->bt_enabled = true;
+			sd->bt_device_connected = false;
+			break;
+		case 0x02:
+			sd->bt_enabled = true;
+			sd->bt_device_connected = true;
+			break;
+		}
 		sd->mic_muted = (data[9] == 0x01);
 		break;
 	case 0xb7:
@@ -659,6 +678,15 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 	case 0x52:
 		sd->mic_muted = (data[2] == 0x01);
 		break;
+	case 0xb5:
+		if (data[1] == 0x01) {
+			sd->bt_enabled = false;
+			sd->bt_device_connected = false;
+		} else if (data[1] == 0x04) {
+			sd->bt_enabled = true;
+			sd->bt_device_connected = (data[2] == 0x01);
+		}
+		break;
 	}
 }
 
@@ -673,6 +701,8 @@ static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *
 		sd->battery_capacity = steelseries_map_capacity(data[6], 0x00, 0x08);
 		sd->battery_charging = (data[15] == 0x02);
 		sd->mic_muted = (data[9] == 0x01);
+		sd->bt_enabled = (data[4] == 0x00);
+		sd->bt_device_connected = (data[5] == 0x01);
 	} else if (data[0] == 0x07 && data[1] == 0x45) {
 		sd->chatmix_game = data[2];
 		sd->chatmix_chat = data[3];
@@ -760,14 +790,16 @@ static const struct steelseries_device_info arctis_nova_7p_info = {
 static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.sync_interface = 3,
 	.async_interface = 5,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
+			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_info = {
 	.sync_interface = 4,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
+			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.request_status = steelseries_arctis_nova_pro_request_status,
 	.parse_status = steelseries_arctis_nova_pro_parse_status,
@@ -908,6 +940,70 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	return 0;
 }
 
+/*
+ * Sysfs attributes for device state
+ */
+
+static ssize_t bt_enabled_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+
+	if (!sd->headset_connected)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%d\n", sd->bt_enabled);
+}
+
+static ssize_t bt_device_connected_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+
+	if (!sd->headset_connected)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%d\n", sd->bt_device_connected);
+}
+
+static DEVICE_ATTR_RO(bt_enabled);
+static DEVICE_ATTR_RO(bt_device_connected);
+
+static struct attribute *steelseries_headset_attrs[] = {
+	&dev_attr_bt_enabled.attr,
+	&dev_attr_bt_device_connected.attr,
+	NULL,
+};
+
+static umode_t steelseries_headset_attr_is_visible(struct kobject *kobj,
+						   struct attribute *attr,
+						   int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+	unsigned long caps;
+
+	if (!sd)
+		return 0;
+
+	caps = sd->info->capabilities;
+
+	if (attr == &dev_attr_bt_enabled.attr)
+		return (caps & SS_CAP_BT_ENABLED) ? attr->mode : 0;
+	if (attr == &dev_attr_bt_device_connected.attr)
+		return (caps & SS_CAP_BT_DEVICE_CONNECTED) ? attr->mode : 0;
+
+	return 0;
+}
+
+static const struct attribute_group steelseries_headset_attr_group = {
+	.attrs = steelseries_headset_attrs,
+	.is_visible = steelseries_headset_attr_is_visible,
+};
+
 #if IS_BUILTIN(CONFIG_SND) || \
 	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
 
@@ -1218,6 +1314,13 @@ static int steelseries_probe(struct hid_device *hdev,
 				hid_warn(hdev, "Failed to register battery: %d\n", ret);
 		}
 
+		if (info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED)) {
+			ret = sysfs_create_group(&hdev->dev.kobj,
+						 &steelseries_headset_attr_group);
+			if (ret)
+				hid_warn(hdev, "Failed to create sysfs group: %d\n", ret);
+		}
+
 #if IS_BUILTIN(CONFIG_SND) || \
 	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
 		ret = steelseries_snd_register(sd);
@@ -1289,6 +1392,10 @@ static void steelseries_remove(struct hid_device *hdev)
 	}
 
 	if (interface_num == sd->info->sync_interface) {
+		if (sd->info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED))
+			sysfs_remove_group(&hdev->dev.kobj,
+					   &steelseries_headset_attr_group);
+
 		if (sd->info->async_interface) {
 			struct hid_device *sibling;
 
-- 
2.53.0

