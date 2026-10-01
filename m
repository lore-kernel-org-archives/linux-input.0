Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA084779BC
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893429; cv=none; b=qUhqrZyIGMYIbMXiJ8NybBDI5XrYYUr6Ky84hlH/iUVTirsSkxJqDyFbARbcA+aeWkxtqKMg5M9IHX6y5fqjSNZ8eUotbjPIXyTjlatT+8sxfVd07tDefdk9oZI0s08M/6Ky15NnSJR4PSUqD0CCIGLaXrF0za6IT+Ws4ZGvwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893429; c=relaxed/simple;
	bh=EApQxXc5dbW5RjUDZcAqxqTjvKPO05LDpgDUyURUDbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIXh7/xqC6AkTwacXJ9IVlxFYe415G8aJonr1ynZoGXM4BQyPK9PTdIxvQJXKGdWuZpxq6KAQ3/8Vfd7yrWqfKLTEO0nTgqBY3I6kLgTFuEijqFC+Ket0GvCdGrzaGAwrIIOoegkMumQ0qbAg/lu7rFDGv6wxaScf8gJJBEO8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtIAFyXX; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtIAFyXX"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6af7d702c76so1946475a12.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790893425; x=1791498225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfS2cfWmds0Y11TiQVtwStV3lengQMkN7F/hQmnyrAA=;
        b=GtIAFyXX6RnABYkOmORFQhK/sOgiCPjsD3P1Lk3jv+o4EaDOjhecMjUUAxEf+DKO8j
         QQjdEi09vhIuuHspdXtr1fgBFuEwp9SIs9ZGa9ROEeXT3wy9rc4BGhIW9YN4CMXGGDQH
         TgYZXCdHgLxss7GS7/TB5iKn1eS5u6Dpx1hXKRbimDwbWYLQpv+Hdk9q2ahVbvk0QiXN
         eravX9W94XleCB0EvqqNFDkb2mpjUKiF4E7aycCN9VyRhp3D6M2IDcMm47ZRDPssU9zD
         pPROWVFiY/NagTxqZ2i148Mk0lBVEIsoZxq7ZZQFING4zl+ukmXbtc8hl1/lzD+Ul90v
         Slqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790893425; x=1791498225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfS2cfWmds0Y11TiQVtwStV3lengQMkN7F/hQmnyrAA=;
        b=U6QsdKcSMs5ELJfNPzbF1fj8DM/jYOByMgf7DzcRLbUOOWx/z1hrky3IwIhPDLiTuF
         ihfnsxFxX5/mOqsfcH5+U3qSKG7N93XCgp4a54PpO8MJ+4TpnYJqDkm7CuPM/ra0hYWo
         /q57jRCnfCvD2/LADM4KeIlWJeJtRWhe4qyI/40yWm/nhcnF1Wh5EVEGGxQGT27ksc8y
         D43MGnbJfpIIP8k5BY8PnU9M25K5DuhRebKtIb0dYrxFdBX3lwdGsOjgtbjQNXtLHdd6
         y2s9SZVIML04PWmD8hUYl7qIlk97GT81a3XnGk2kXykbw2ULL5OMfEGZUWnK8eIGS/lj
         5FaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw94eN5b/oYCnVlc+vOZQfujnXLMtRQIbnkX0nApsegzfummDT9UDEbqmcJrFt+iSS5yLTFTpx/9KJ5iw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJO22qQooMEWDKAQKALKBpzALGCPL2qSvcwUwzh+MsQxfeHOa01
	yU+MlSCeGNZm+tSTgZxkOmVa0XpDfQf84rdY9lNSKSlwZEa8nRW0MVZv
X-Gm-Gg: AYBFou0eMWLdWnQ9lqc8Z0X5IM/TsKoX/LjgpxkxpAo0c013kh0xwfrimebVOJ2gjch
	g3fRY94E4mobdLWSeKVokst6/fAOuM1d63tH84qodibJsg/s+kVTmreEuHxAVKjdMVyK/mOLNQW
	RCRJrnqiuACcdP5TFTj/N+xEpEQK0BG1R2pTSmeXFE4Wu7l1EPQFx2RUr45webGrfoinyCKXooE
	sdP22uaxeqH/8P8JyNlR1Zl8NwETF4OSEP142OiWjxf1NS+oWx/goReV3Pb7hUqPqesB6ulgeV5
	gENfbTnJ+SSu2rm/Kx5y0QhPc4pwO9AYBMjNHyHFOUs3tRnuaCcfFsQzwCgStR/GutuHCH+MGm/
	StIipoSEjVKD1Fi2llUIuTKICCCThIy41WOrBFpk8Q/Tgxq8NonEbVNpGDHP3ZJ7fiXPT4gGeC1
	9IGHPKcIOy+3eNwIRM1+BogYN/OaMg82yo+13JhNUrUjgB/hW4bU2IGZ0VVze//WQ55cW7JXfbA
	X1uU3mczGfeZu+wys0T6JG+jePszyKkCS3ziDYQJw7SraFcoTCrJg==
X-Received: by 2002:a05:6402:4019:b0:6aa:f260:b851 with SMTP id 4fb4d7f45d1cf-6af9e30ec5dmr417794a12.33.1790893425261;
        Thu, 01 Oct 2026 15:23:45 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d87399esm238935a12.9.2026.10.01.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:23:44 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Date: Fri, 02 Oct 2026 00:23:35 +0200
Subject: [PATCH RFC 1/4] HID: logitech: add Bolt receiver support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-bolt-input-rfc-v1-1-333e1f350586@gmail.com>
References: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
In-Reply-To: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bastien Nocera <hadess@hadess.net>
Cc: Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790893419; l=14084;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=EApQxXc5dbW5RjUDZcAqxqTjvKPO05LDpgDUyURUDbU=;
 b=nIzoNV7V9FaDvLch6tTy3rSAX4JITwNl/r3onn9nasIdOUEqOlYMCCuvWxYBFI+pIWAqk7cHI
 FQJJzgPclIyCYB/JERxoa3ZMpjET/MbBH0Whup+ewYXmYq94jzhcLi4
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

Add Logitech Bolt receiver support to the Logitech HID receiver and HID++
drivers.

This allows Bolt-connected HID++ devices to expose battery information
through the kernel power_supply path, so userspace tools can report their
battery status with the correct device model.

Have hid-logitech-dj claim Bolt interfaces 0-2 and use the
mse_high_res_descriptor for virtual mice, instead of the default
mse_descriptor, to properly handle reports as 16-bit instead of 12-bit.

Since Bolt receivers do not support DJ mode, reroute supported reports for
Bolt devices over HID++, so device identification is possible through the
HID++ device index. Ordinary mouse and keyboard reports still use native
HID, and are not possible to divert to HID++, and since native HID reports
lack device index, it will still not be possible to identify which device
sent them.
Extend 0x2121 high resolution scroll to work over HID++, including software
inversion for inverted scrolling, and make Bolt devices default to HID++
diversion for 0x2121 reports.

Also, treat HIDPP_ERROR_CONNECT_FAIL like other disconnected-device errors
when retrieving protocol version to avoid protocol error messages when a
Bolt device powers off.

Tested with:
- Logitech MX Keys for Business via Bolt receiver

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
 drivers/hid/hid-logitech-dj.c    |  33 +++++++-
 drivers/hid/hid-logitech-hidpp.c | 160 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 173 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 390d106d5dc1..8a53e631f476 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -121,6 +121,7 @@ enum recvr_type {
 	recvr_type_27mhz,
 	recvr_type_bluetooth,
 	recvr_type_dinovo,
+	recvr_type_bolt,
 };
 
 struct dj_report {
@@ -637,8 +638,6 @@ static const u8 hid_reportid_size_map[NUMBER_OF_HID_REPORTS] = {
 };
 
 
-#define LOGITECH_DJ_INTERFACE_NUMBER 0x02
-
 static const struct hid_ll_driver logi_dj_ll_driver;
 
 static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev);
@@ -1156,6 +1155,10 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		workitem.reports_supported |= STD_KEYBOARD;
 		break;
+	case 0x10:
+		device_type = "Bolt";
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
+		break;
 	}
 
 	/* custom receiver device (eg. powerplay) */
@@ -1540,7 +1543,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 	if (djdev->reports_supported & STD_MOUSE) {
 		dbg_hid("%s: sending a mouse descriptor, reports_supported: %llx\n",
 			__func__, djdev->reports_supported);
-		if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp ||
+		if (djdev->dj_receiver_dev->type == recvr_type_bolt ||
+		    djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp ||
 		    djdev->dj_receiver_dev->type == recvr_type_mouse_only)
 			rdcat(rdesc, &rsize, mse_high_res_descriptor,
 			      sizeof(mse_high_res_descriptor));
@@ -1745,6 +1749,24 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 
 	dj_dev = djrcv_dev->paired_dj_devices[device_index];
 
+	/*
+	 * Bolt receivers send explicit unpair notifications as HID++ events;
+	 * queue device removal when we receive one.
+	 */
+	if (djrcv_dev->type == recvr_type_bolt &&
+	    hidpp_report->report_id == REPORT_ID_HIDPP_SHORT &&
+	    hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_UNPAIRED) {
+		struct dj_workitem workitem = {
+			.device_index = device_index,
+			.type = WORKITEM_TYPE_UNPAIRED,
+		};
+
+		kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
+		schedule_work(&djrcv_dev->work);
+		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
+		return false;
+	}
+
 	/*
 	 * With 27 MHz receivers, we do not get an explicit unpair event,
 	 * remove the old device if the user has paired a *different* device.
@@ -1894,6 +1916,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	case recvr_type_27mhz:		no_dj_interfaces = 2; break;
 	case recvr_type_bluetooth:	no_dj_interfaces = 2; break;
 	case recvr_type_dinovo:		no_dj_interfaces = 2; break;
+	case recvr_type_bolt:		no_dj_interfaces = 3; break;
 	}
 	if (hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
@@ -2103,6 +2126,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3),
 	 .driver_data = recvr_type_gaming_hidpp_ls_1_3},
+	{ /* Logitech Bolt receiver (0xc548) */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
+	 .driver_data = recvr_type_bolt},
 	{ /* Logitech lightspeed receiver (0xc54d) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9646380febac..ff6a1095e7ba 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -213,6 +213,8 @@ struct hidpp_device {
 
 	int hires_wheel_multiplier;
 	u8 hires_wheel_feature_index;
+	bool hires_wheel_has_invert;
+	bool hires_wheel_invert;
 
 	bool connected_once;
 };
@@ -988,7 +990,8 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 	}
 
 	/* the device might not be connected */
-	if (ret == HIDPP_ERROR_RESOURCE_ERROR ||
+	if (ret == HIDPP_ERROR_CONNECT_FAIL ||
+	    ret == HIDPP_ERROR_RESOURCE_ERROR ||
 	    ret == HIDPP_ERROR_UNKNOWN_DEVICE)
 		return -EIO;
 
@@ -2044,9 +2047,15 @@ static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
 
 #define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
 #define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
+#define EVENT_HIRES_WHEEL_MOVEMENT		0x00
+#define HIRES_WHEEL_CAPABILITY_HAS_INVERT	BIT(3)
+#define HIRES_WHEEL_MODE_USE_HIDPP		BIT(0)
+#define HIRES_WHEEL_MODE_HIGH_RESOLUTION	BIT(1)
+#define HIRES_WHEEL_MODE_INVERT			BIT(2)
+#define HIRES_WHEEL_EVENT_HIGH_RESOLUTION	BIT(4)
 
 static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
-	u8 *multiplier)
+	u8 *multiplier, bool *has_invert)
 {
 	u8 feature_index;
 	int ret;
@@ -2064,6 +2073,8 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 		goto return_default;
 
 	*multiplier = response.fap.params[0];
+	*has_invert = response.fap.params[1] &
+		HIRES_WHEEL_CAPABILITY_HAS_INVERT;
 	return 0;
 return_default:
 	hid_warn(hidpp->hid_dev,
@@ -2084,9 +2095,9 @@ static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
 	if (ret)
 		return ret;
 
-	params[0] = (invert          ? BIT(2) : 0) |
-		    (high_resolution ? BIT(1) : 0) |
-		    (use_hidpp       ? BIT(0) : 0);
+	params[0] = (invert          ? HIRES_WHEEL_MODE_INVERT : 0) |
+		    (high_resolution ? HIRES_WHEEL_MODE_HIGH_RESOLUTION : 0) |
+		    (use_hidpp       ? HIRES_WHEEL_MODE_USE_HIDPP : 0);
 
 	return hidpp_send_fap_command_sync(hidpp, feature_index,
 					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
@@ -3903,15 +3914,58 @@ static int hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
 /* High-resolution scroll wheels                                              */
 /* -------------------------------------------------------------------------- */
 
+static bool hidpp_is_bolt_child(struct hid_device *hdev)
+{
+	struct device *parent = hdev->dev.parent;
+	struct hid_device *receiver_hdev;
+
+	if (hdev->group != HID_GROUP_LOGITECH_DJ_DEVICE || !parent)
+		return false;
+
+	receiver_hdev = to_hid_device(parent);
+	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
+	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
+}
+
+static void hidpp_hrw_update_wheel_mode(struct hidpp_device *hidpp,
+	bool invert, bool high_resolution)
+{
+	hidpp->hires_wheel_invert = invert;
+	hidpp->vertical_wheel_counter.wheel_multiplier =
+		(high_resolution && hidpp->hires_wheel_multiplier > 0) ?
+		hidpp->hires_wheel_multiplier : 1;
+}
+
 static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
-	int ret;
+	int ret, fallback_ret;
 	u8 multiplier = 1;
+	bool has_invert = false;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
-		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
-		if (ret == 0)
-			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
+		/* Check capabilities before setting mode, to guard against
+		 * enabling high res and then failing to read multiplier.
+		 */
+		ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier,
+						     &has_invert);
+		if (ret) {
+			/* Avoid diverting wheel reports without a known
+			 * multiplier.
+			 */
+			fallback_ret = hidpp_hrw_set_wheel_mode(hidpp, false,
+							 false, false);
+			if (fallback_ret)
+				hid_dbg(hidpp->hid_dev,
+					"Could not restore native wheel reporting: %d\n",
+					fallback_ret);
+			hidpp->hires_wheel_multiplier = 1;
+			hidpp->hires_wheel_has_invert = false;
+			hidpp_hrw_update_wheel_mode(hidpp, false, false);
+			return ret;
+		}
+		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true,
+					      hidpp_is_bolt_child(
+					       hidpp->hid_dev));
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
 		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
 							   &multiplier);
@@ -3933,6 +3987,10 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 
 	hidpp->hires_wheel_multiplier = multiplier;
 	hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
+		hidpp->hires_wheel_has_invert = has_invert;
+		hidpp_hrw_update_wheel_mode(hidpp, false, true);
+	}
 	hid_dbg(hidpp->hid_dev, "wheel multiplier = %d\n", multiplier);
 	return 0;
 }
@@ -3975,6 +4033,10 @@ static int hidpp_initialize_hires_scroll(struct hidpp_device *hidpp)
 	return 0;
 }
 
+/*
+ * The low nibble of data[3] is the software ID: 0 for wheel
+ * notifications, nonzero and echoed from the request for replies.
+ */
 static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
 						u8 *data, int size)
 {
@@ -3988,12 +4050,47 @@ static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
 	    data[2] != hidpp->hires_wheel_feature_index)
 		return 0;
 
+	/* This checks only the function nibble, not software ID, so in theory
+	 * an event with ID 0x20 would also apply here, but there is none in
+	 * the 0x2121 specification.
+	 */
 	if ((data[3] & 0xf0) == CMD_HIRES_WHEEL_SET_WHEEL_MODE) {
 		u8 mode = data[4];
-		bool hires = (mode & 0x02) != 0;
-		int new_multiplier = (hires && hidpp->hires_wheel_multiplier > 0)
-			? hidpp->hires_wheel_multiplier : 1;
-		hidpp->vertical_wheel_counter.wheel_multiplier = new_multiplier;
+
+		hidpp_hrw_update_wheel_mode(hidpp,
+			mode & HIRES_WHEEL_MODE_INVERT,
+			mode & HIRES_WHEEL_MODE_HIGH_RESOLUTION);
+		return 1;
+	}
+
+	/* Match wheelMovement (function 0, software ID 0). */
+	if (data[3] == EVENT_HIRES_WHEEL_MOVEMENT) {
+		int delta;
+
+		if (size < 7 || !hidpp->input ||
+		    hidpp->hires_wheel_multiplier <= 0)
+			return 1;
+
+		/* The event flag describes whether the event is high resolution
+		 * or not.
+		 */
+		hidpp->vertical_wheel_counter.wheel_multiplier =
+			(data[4] & HIRES_WHEEL_EVENT_HIGH_RESOLUTION) ?
+			hidpp->hires_wheel_multiplier : 1;
+
+		delta = (s16)get_unaligned_be16(&data[5]);
+		if (!delta)
+			return 1;
+
+		/* HID++ 2.0 does not invert scroll regardless of setting,
+		 * hence do so in driver
+		 */
+		if (hidpp->hires_wheel_has_invert && hidpp->hires_wheel_invert)
+			delta = -delta;
+
+		hidpp_scroll_counter_handle_scroll(hidpp->input,
+			&hidpp->vertical_wheel_counter, delta);
+		input_sync(hidpp->input);
 		return 1;
 	}
 
@@ -4295,7 +4392,7 @@ static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
 	/* A scroll event may occur before the multiplier has been retrieved or
 	 * the input device set, or high-res scroll enabling may fail. In such
 	 * cases we must return early (falling back to default behaviour) to
-	 * avoid a crash in hidpp_scroll_counter_handle_scroll.
+	 * avoid consuming an event that we cannot scale.
 	 */
 	if (!(hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 	    || value == 0 || hidpp->input == NULL
@@ -4404,8 +4501,37 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	return ret;
 }
 
+static int hidpp_bolt_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	char *name;
+	int ret;
+
+	ret = hidpp_serial_init(hidpp);
+	if (ret)
+		return ret;
+
+	name = hidpp_get_device_name(hidpp);
+	if (!name)
+		return -EIO;
+
+	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
+	dbg_hid("HID++ Bolt: Got name: %s\n", name);
+
+	kfree(name);
+	return 0;
+}
+
+static int hidpp_receiver_init(struct hidpp_device *hidpp)
+{
+	if (hidpp_is_bolt_child(hidpp->hid_dev))
+		return hidpp_bolt_init(hidpp);
+
+	return hidpp_unifying_init(hidpp);
+}
+
 /* Get name + serial for USB and Bluetooth HID++ devices */
-static void hidpp_non_unifying_init(struct hidpp_device *hidpp)
+static void hidpp_non_receiver_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
 	char *name;
@@ -4757,9 +4883,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/* Get name + serial, store in hdev->name + hdev->uniq */
 	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
-		hidpp_unifying_init(hidpp);
+		hidpp_receiver_init(hidpp);
 	else
-		hidpp_non_unifying_init(hidpp);
+		hidpp_non_receiver_init(hidpp);
 
 	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;

-- 
2.55.0

