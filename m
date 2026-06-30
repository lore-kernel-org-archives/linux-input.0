Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A43DE421
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840586; cv=none; b=c6/x5d4dvwMplVh8dS+OcHS7L3ykL4YUhf/KB0flhjv/dbD3Ab+kBHwbsAyQtwI7iLiWj2tpPUcJwaGrV6CbVwj4Yuo23mcLlslYf84Fx2B7j1H2AZ7Xg0JB4rqjgas2/tRSWbWAZUuVvM0TdXH92e4DoO99e0GmhPKbhiXLMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840586; c=relaxed/simple;
	bh=zf4mUAONvYD4hylcty9i91kDb5LFGJ3CePVpCmeajTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqHdLuDWBy4eFnRdx7+fOws24r0j4ckASGYRkIqdhg2gk7EU9Q0KL5BbXeQK1zIDxT8c+Kxz0/rtH5VlLFnHgugmRioXetq6zCTOBR0AF3CKzalHAzcsF6YC6WFW2pslCP+ykWWVC+QHZs8WvobyrhWZc89+k0UPUaRcf9P65n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9CzhG+0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9CzhG+0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e4fd65b2bso199570985a.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840582; x=1783445382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nXcBA8Nk5+g7fWtI9YYtW9MFiuuO1b/+UE2edb4PQ0=;
        b=W9CzhG+0WFXE7QbsVmTTyyrOrFMfUVq2qcPUfLpKZqEzYPVrbG17FSh8O3eZDb3uAj
         yHNVfo25PnaLKKwkwi1q5OtVhP9tRMXTaQ6ebr1GEvvqRFpklJEqhERElDaq/2ij3YYQ
         C8HvnJJw4pzHjNxXS4g4UaoUXRV27EKtRz16re0zliNVT4phII1SM3VPGex4uXqaF4Jy
         HUFNJXElrWYoCoRrv51W3HzNdA334pghlGFkqrYUZsUHPtQUuSc2fsQC2Hmw2UqP7iqL
         KthcAqTLKziSDXXGbXNdaq0CCdA8q9oVB9C3XRIg0eHJ13OX0z8mBoycgntNtgs4qv/l
         2skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840582; x=1783445382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nXcBA8Nk5+g7fWtI9YYtW9MFiuuO1b/+UE2edb4PQ0=;
        b=ooYwwvfmtgk/zorLTa8R6FthYLOFldQ3+u7K8+samyYhnMpk5nuAEChbVs/d9pSdt2
         Md01/NuDwuySmyNJbqx6YZNYPvLt5pa6zsfziOdpdn4Izy1P0Hv/N6w2o9iFUkL4xrxs
         wWL1qfkg7q3JhXWUy2tcr9onGSdJYYUqbjYlYxyb0BdKzXZL6TrP6ROz83vUJPosCEjV
         VdSgT5YeeQ4eRU1L2/GhxwHKG1r8eaq5Qahf5gE9LLWJ6gXtAAm8J1Dufrf2fvX+IhdU
         fR8jm+/LIYoEc1JZKberGw+BwdGJaV1IF7LLLRkKIMSKnrOVPc/1IjOChBhr/ZhkXSqL
         /xtA==
X-Gm-Message-State: AOJu0Yw79cE7KmvhEqvcJQhRgzimpaH01yrwMfCpHW0PM+YqqfcuIh0x
	DNZH504g+FroCTo1IwlyVjzryKsaxxMliSbHTJMXFMqmTnXRcFOpAdiC
X-Gm-Gg: AfdE7cl4G6ruveyEC7d97Q632Y4RI91Cs4HF0nZT9yXNyt9Ll83GCjZcsKMVBKSazqI
	h+FJCRlo4yUmXw3QjOY2E3N+5XZeY5+IwSS9lvu99bI/42FAL2koeLde2Pnwkeo7GibLj8h5/JD
	P9H7kqgriTlcxLGG5+ggC/CjNes2bNuL5A/AuggY1NIpip17KwEbyfnFO8UsyC6tWs/RVpumPHJ
	iTWl7MpZbs63s0Dc0YaHjksNynEw2K6PG4UEW60kvKsdafJ03W6kW9EaeIWkl+SZwmoKGl8Kj+v
	0GPdem00KTn0vYMPQtPF3ujZSdgE1ulkBWxHFcfRSu7OSsQ97l0bxUxr54CV4ytKHis1wUKLjHU
	/fRDOUsZF5JYhvg1SzkbsPCl6BSUmcEoMiCVmaJCqLDom4WC5WaeaZDKNCVbfKhU3yBVAJ08VmH
	vvfWHcCVf6NbidDDVIzXyFOyYF/gg846D5GQHVlw+fdkzly6A4
X-Received: by 2002:a05:620a:25d4:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-92e6249fe64mr778116885a.12.1782840581948;
        Tue, 30 Jun 2026 10:29:41 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:41 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 4/9] HID: steelseries: Refactor Arctis driver to use device_info framework
Date: Tue, 30 Jun 2026 13:29:25 -0400
Message-ID: <70c4070d7d5684e86905339c69b8bc80eacec3a1.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the per-product if/else quirk bitmap with a
steelseries_device_info struct. Each model provides its capabilities,
sync_interface, and request_status/parse_status callbacks. Report
sending is folded into steelseries_send_report() and the feature and
output wrappers, and the battery identifiers lose their per-model names.

This is mostly a refactor, but it changes two things:

  - Battery status is polled from a periodic delayed work (status_work)
    instead of being requested from raw_event(). The interval stays at
    3s.
  - Arctis 1 no longer clamps the reported capacity to 100% while
    disconnected. The connection state already controls how this is
    shown to userspace.

ARCTIS_1_X and ARCTIS_9 keep working. No new devices are added.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 468 +++++++++++++++------------
 1 file changed, 267 insertions(+), 201 deletions(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 079504e6932a..c54c56db9ddd 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -3,6 +3,7 @@
  *  HID driver for Steelseries arctis headsets
  *
  *  Copyright (c) 2023 Bastien Nocera
+ *  Copyright (c) 2026 Sriman Achanta
  */
 
 #include <linux/device.h>
@@ -15,70 +16,89 @@
 
 #include "hid-ids.h"
 
-#define STEELSERIES_ARCTIS_1_X		BIT(0)
-#define STEELSERIES_ARCTIS_9		BIT(1)
+#define SS_CAP_BATTERY			BIT(0)
+
+struct steelseries_device;
+
+struct steelseries_device_info {
+	unsigned long capabilities;
+
+	u8 sync_interface;
+
+	int (*request_status)(struct hid_device *hdev);
+	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
+};
 
 struct steelseries_device {
 	struct hid_device *hdev;
-	unsigned long quirks;
+	const struct steelseries_device_info *info;
 
-	struct delayed_work battery_work;
-	spinlock_t lock;
-	bool removed;
+	struct delayed_work status_work;
 
 	struct power_supply_desc battery_desc;
 	struct power_supply *battery;
-	uint8_t battery_capacity;
 	bool headset_connected;
+	u8 battery_capacity;
 	bool battery_charging;
-};
 
-#define STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS	3000
+	spinlock_t lock;
+	bool removed;
+};
 
-#define ARCTIS_1_BATTERY_RESPONSE_LEN		8
-#define ARCTIS_9_BATTERY_RESPONSE_LEN		64
-static const char arctis_1_battery_request[] = { 0x06, 0x12 };
-static const char arctis_9_battery_request[] = { 0x00, 0x20 };
+/*
+ * Headset report helpers
+ */
 
-static int steelseries_headset_request_battery(struct hid_device *hdev,
-	const char *request, size_t len)
+static int steelseries_send_report(struct hid_device *hdev, const u8 *data,
+				    int len, enum hid_report_type type)
 {
-	u8 *write_buf;
+	u8 *buf;
 	int ret;
 
-	/* Request battery information */
-	write_buf = kmemdup(request, len, GFP_KERNEL);
-	if (!write_buf)
+	buf = kmemdup(data, len, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	hid_dbg(hdev, "Sending battery request report");
-	ret = hid_hw_raw_request(hdev, request[0], write_buf, len,
-				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
-	if (ret < (int)len) {
-		hid_err(hdev, "hid_hw_raw_request() failed with %d\n", ret);
-		ret = -ENODATA;
-	}
+	ret = hid_hw_raw_request(hdev, data[0], buf, len, type,
+				 HID_REQ_SET_REPORT);
+	kfree(buf);
 
-	kfree(write_buf);
-	return ret;
+	if (ret < 0)
+		return ret;
+	if (ret < len)
+		return -EIO;
+
+	return 0;
 }
 
-static void steelseries_headset_fetch_battery(struct hid_device *hdev)
+static inline int steelseries_send_output_report(struct hid_device *hdev,
+						  const u8 *data, int len)
 {
-	int ret = 0;
+	return steelseries_send_report(hdev, data, len, HID_OUTPUT_REPORT);
+}
+
+/*
+ * Headset status request functions
+ */
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X)
-		ret = steelseries_headset_request_battery(hdev,
-			arctis_1_battery_request, sizeof(arctis_1_battery_request));
-	else if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
-		ret = steelseries_headset_request_battery(hdev,
-			arctis_9_battery_request, sizeof(arctis_9_battery_request));
+static int steelseries_arctis_1_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x06, 0x12 };
 
-	if (ret < 0)
-		hid_dbg(hdev,
-			"Battery query failed (err: %d)\n", ret);
+	return steelseries_send_output_report(hdev, data, sizeof(data));
 }
 
+static int steelseries_arctis_9_request_status(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x00, 0x20 };
+
+	return steelseries_send_output_report(hdev, data, sizeof(data));
+}
+
+/*
+ * Headset battery helpers
+ */
+
 static int battery_capacity_to_level(int capacity)
 {
 	if (capacity >= 50)
@@ -88,30 +108,101 @@ static int battery_capacity_to_level(int capacity)
 	return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 }
 
-static void steelseries_headset_battery_timer_tick(struct work_struct *work)
+static u8 steelseries_map_capacity(u8 capacity, u8 min_in, u8 max_in)
 {
-	struct steelseries_device *sd = container_of(work,
-		struct steelseries_device, battery_work.work);
-	struct hid_device *hdev = sd->hdev;
+	if (capacity >= max_in)
+		return 100;
+	if (capacity <= min_in)
+		return 0;
+	return (capacity - min_in) * 100 / (max_in - min_in);
+}
 
-	steelseries_headset_fetch_battery(hdev);
+/*
+ * Headset status parse functions
+ */
+
+static void steelseries_arctis_1_parse_status(struct steelseries_device *sd,
+					      u8 *data, int size)
+{
+	/* Only the battery status report echoes the request header. */
+	if (size < 8 || data[0] != 0x06 || data[1] != 0x12)
+		return;
+
+	sd->headset_connected = (data[2] != 0x01);
+	sd->battery_capacity = data[3];
+}
+
+static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
+					      u8 *data, int size)
+{
+	if (size < 5)
+		return;
+
+	if (data[0] == 0xaa && data[1] == 0x01) {
+		sd->headset_connected = true;
+		sd->battery_charging = (data[4] == 0x01);
+		sd->battery_capacity = steelseries_map_capacity(data[3], 0x68, 0x9d);
+	} else {
+		/* Device off: 0x55 (no status) or 0x03 (stale status). */
+		sd->headset_connected = false;
+		sd->battery_charging = false;
+	}
+}
+
+/*
+ * Device info definitions
+ */
+
+static const struct steelseries_device_info arctis_1_info = {
+	.sync_interface = 3,
+	.capabilities = SS_CAP_BATTERY,
+	.request_status = steelseries_arctis_1_request_status,
+	.parse_status = steelseries_arctis_1_parse_status,
+};
+
+static const struct steelseries_device_info arctis_9_info = {
+	.sync_interface = 0,
+	.capabilities = SS_CAP_BATTERY,
+	.request_status = steelseries_arctis_9_request_status,
+	.parse_status = steelseries_arctis_9_parse_status,
+};
+
+/*
+ * Headset wireless status and battery infrastructure
+ */
+
+#define STEELSERIES_HEADSET_STATUS_TIMEOUT_MS	3000
+
+static void
+steelseries_headset_set_wireless_status(struct hid_device *hdev,
+					bool connected)
+{
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	usb_set_wireless_status(intf, connected ?
+				USB_WIRELESS_STATUS_CONNECTED :
+				USB_WIRELESS_STATUS_DISCONNECTED);
 }
 
 #define STEELSERIES_PREFIX "SteelSeries "
-#define STEELSERIES_PREFIX_LEN strlen(STEELSERIES_PREFIX)
 
-static int steelseries_headset_battery_get_property(struct power_supply *psy,
+static int steelseries_battery_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
 	struct steelseries_device *sd = power_supply_get_drvdata(psy);
+	size_t prefix_len;
 	int ret = 0;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = sd->hdev->name;
-		while (!strncmp(val->strval, STEELSERIES_PREFIX, STEELSERIES_PREFIX_LEN))
-			val->strval += STEELSERIES_PREFIX_LEN;
+		while ((prefix_len = str_has_prefix(val->strval, STEELSERIES_PREFIX)))
+			val->strval += prefix_len;
 		break;
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = "SteelSeries";
@@ -120,12 +211,12 @@ static int steelseries_headset_battery_get_property(struct power_supply *psy,
 		val->intval = 1;
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
-		if (sd->headset_connected) {
-			val->intval = sd->battery_charging ?
-				POWER_SUPPLY_STATUS_CHARGING :
-				POWER_SUPPLY_STATUS_DISCHARGING;
-		} else
+		if (!sd->headset_connected)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (sd->battery_charging)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
@@ -143,22 +234,7 @@ static int steelseries_headset_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static void
-steelseries_headset_set_wireless_status(struct hid_device *hdev,
-					bool connected)
-{
-	struct usb_interface *intf;
-
-	if (!hid_is_usb(hdev))
-		return;
-
-	intf = to_usb_interface(hdev->dev.parent);
-	usb_set_wireless_status(intf, connected ?
-				USB_WIRELESS_STATUS_CONNECTED :
-				USB_WIRELESS_STATUS_DISCONNECTED);
-}
-
-static enum power_supply_property steelseries_headset_battery_props[] = {
+static enum power_supply_property steelseries_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -168,7 +244,26 @@ static enum power_supply_property steelseries_headset_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 };
 
-static int steelseries_headset_battery_register(struct steelseries_device *sd)
+/*
+ * Delayed work handlers for status polling
+ */
+
+static void steelseries_status_timer_work_handler(struct work_struct *work)
+{
+	struct steelseries_device *sd = container_of(
+		work, struct steelseries_device, status_work.work);
+	unsigned long flags;
+
+	sd->info->request_status(sd->hdev);
+
+	spin_lock_irqsave(&sd->lock, flags);
+	if (!sd->removed)
+		schedule_delayed_work(&sd->status_work,
+				msecs_to_jiffies(STEELSERIES_HEADSET_STATUS_TIMEOUT_MS));
+	spin_unlock_irqrestore(&sd->lock, flags);
+}
+
+static int steelseries_battery_register(struct steelseries_device *sd)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
 	struct power_supply_config battery_cfg = { .drv_data = sd, };
@@ -176,25 +271,27 @@ static int steelseries_headset_battery_register(struct steelseries_device *sd)
 	int ret;
 
 	sd->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
-	sd->battery_desc.properties = steelseries_headset_battery_props;
-	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_headset_battery_props);
-	sd->battery_desc.get_property = steelseries_headset_battery_get_property;
+	sd->battery_desc.properties = steelseries_battery_props;
+	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_battery_props);
+	sd->battery_desc.get_property = steelseries_battery_get_property;
 	sd->battery_desc.use_for_apm = 0;
 	n = atomic_inc_return(&battery_no) - 1;
 	sd->battery_desc.name = devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
-							"steelseries_headset_battery_%ld", n);
+						"steelseries_headset_battery_%ld", n);
 	if (!sd->battery_desc.name)
 		return -ENOMEM;
 
 	/* avoid the warning of 0% battery while waiting for the first info */
-	steelseries_headset_set_wireless_status(sd->hdev, false);
 	sd->battery_capacity = 100;
 	sd->battery_charging = false;
+	sd->headset_connected = false;
+	steelseries_headset_set_wireless_status(sd->hdev, false);
 
 	sd->battery = devm_power_supply_register(&sd->hdev->dev,
 			&sd->battery_desc, &battery_cfg);
 	if (IS_ERR(sd->battery)) {
 		ret = PTR_ERR(sd->battery);
+		sd->battery = NULL;
 		hid_err(sd->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
@@ -202,59 +299,65 @@ static int steelseries_headset_battery_register(struct steelseries_device *sd)
 	}
 	power_supply_powers(sd->battery, &sd->hdev->dev);
 
-	INIT_DELAYED_WORK(&sd->battery_work, steelseries_headset_battery_timer_tick);
-	steelseries_headset_fetch_battery(sd->hdev);
-
-	if (sd->quirks & STEELSERIES_ARCTIS_9) {
-		/* The first fetch_battery request can remain unanswered in some cases */
-		schedule_delayed_work(&sd->battery_work,
-				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
-	}
-
 	return 0;
 }
 
-static bool steelseries_is_vendor_usage_page(struct hid_device *hdev, uint8_t usage_page)
-{
-	return hdev->rdesc[0] == 0x06 &&
-		hdev->rdesc[1] == usage_page &&
-		hdev->rdesc[2] == 0xff;
-}
-
-static int steelseries_arctis_probe(struct hid_device *hdev, const struct hid_device_id *id)
+static int steelseries_arctis_probe(struct hid_device *hdev,
+				    const struct hid_device_id *id)
 {
+	const struct steelseries_device_info *info =
+		(const struct steelseries_device_info *)id->driver_data;
 	struct steelseries_device *sd;
+	struct usb_interface *intf;
+	u8 interface_num;
 	int ret;
 
-	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
-	if (!sd)
-		return -ENOMEM;
-	hid_set_drvdata(hdev, sd);
-	sd->hdev = hdev;
-	sd->quirks = id->driver_data;
+	if (hid_is_usb(hdev)) {
+		intf = to_usb_interface(hdev->dev.parent);
+		interface_num = intf->cur_altsetting->desc.bInterfaceNumber;
+	} else {
+		return -ENODEV;
+	}
 
 	ret = hid_parse(hdev);
 	if (ret)
 		return ret;
 
-	if (sd->quirks & STEELSERIES_ARCTIS_9 &&
-			!steelseries_is_vendor_usage_page(hdev, 0xc0))
-		return -ENODEV;
+	/* Let hid-generic handle non-sync interfaces */
+	if (interface_num != info->sync_interface)
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
+	if (!sd)
+		return -ENOMEM;
 
+	sd->hdev = hdev;
+	sd->info = info;
 	spin_lock_init(&sd->lock);
 
+	hid_set_drvdata(hdev, sd);
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
 		return ret;
 
 	ret = hid_hw_open(hdev);
 	if (ret)
-		return ret;
+		goto err_stop;
 
-	if (steelseries_headset_battery_register(sd) < 0)
-		hid_err(sd->hdev,
-			"Failed to register battery for headset\n");
+	if (info->capabilities & SS_CAP_BATTERY) {
+		ret = steelseries_battery_register(sd);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to register battery: %d\n", ret);
+	}
+
+	INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
+	schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
 
+	return 0;
+
+err_stop:
+	hid_hw_stop(hdev);
 	return ret;
 }
 
@@ -262,130 +365,92 @@ static void steelseries_arctis_remove(struct hid_device *hdev)
 {
 	struct steelseries_device *sd;
 	unsigned long flags;
+	struct usb_interface *intf;
+	u8 interface_num;
+
+	if (hid_is_usb(hdev)) {
+		intf = to_usb_interface(hdev->dev.parent);
+		interface_num = intf->cur_altsetting->desc.bInterfaceNumber;
+	} else {
+		return;
+	}
 
 	sd = hid_get_drvdata(hdev);
 
-	spin_lock_irqsave(&sd->lock, flags);
-	sd->removed = true;
-	spin_unlock_irqrestore(&sd->lock, flags);
+	if (!sd) {
+		hid_hw_stop(hdev);
+		return;
+	}
 
-	cancel_delayed_work_sync(&sd->battery_work);
+	if (interface_num == sd->info->sync_interface) {
+		spin_lock_irqsave(&sd->lock, flags);
+		sd->removed = true;
+		spin_unlock_irqrestore(&sd->lock, flags);
+
+		cancel_delayed_work_sync(&sd->status_work);
+	}
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
 
-static uint8_t steelseries_headset_map_capacity(uint8_t capacity, uint8_t min_in, uint8_t max_in)
-{
-	if (capacity >= max_in)
-		return 100;
-	if (capacity <= min_in)
-		return 0;
-	return (capacity - min_in) * 100 / (max_in - min_in);
-}
-
 static int steelseries_arctis_raw_event(struct hid_device *hdev,
-					struct hid_report *report, u8 *read_buf,
-					int size)
+				 struct hid_report *report, u8 *data, int size)
 {
 	struct steelseries_device *sd = hid_get_drvdata(hdev);
-	int capacity = sd->battery_capacity;
-	bool connected = sd->headset_connected;
-	bool charging = sd->battery_charging;
-	unsigned long flags;
+	u8 old_capacity;
+	bool old_connected;
+	bool old_charging;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
-		hid_dbg(sd->hdev,
-			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
-		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
-			memcmp(read_buf, arctis_1_battery_request, sizeof(arctis_1_battery_request))) {
-			if (!delayed_work_pending(&sd->battery_work))
-				goto request_battery;
-			return 0;
-		}
-		if (read_buf[2] == 0x01) {
-			connected = false;
-			capacity = 100;
-		} else {
-			connected = true;
-			capacity = read_buf[3];
-		}
-	}
+	if (!sd)
+		return 0;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9) {
-		hid_dbg(sd->hdev,
-			"Parsing raw event for Arctis 9 headset (%*ph)\n", size, read_buf);
-		if (size < ARCTIS_9_BATTERY_RESPONSE_LEN) {
-			if (!delayed_work_pending(&sd->battery_work))
-				goto request_battery;
-			return 0;
-		}
+	old_capacity = sd->battery_capacity;
+	old_connected = sd->headset_connected;
+	old_charging = sd->battery_charging;
 
-		if (read_buf[0] == 0xaa && read_buf[1] == 0x01) {
-			connected = true;
-			charging = read_buf[4] == 0x01;
-
-			/*
-			 * Found no official documentation about min and max.
-			 * Values defined by testing.
-			 */
-			capacity = steelseries_headset_map_capacity(read_buf[3], 0x68, 0x9d);
-		} else {
-			/*
-			 * Device is off and sends the last known status read_buf[1] == 0x03 or
-			 * there is no known status of the device read_buf[0] == 0x55
-			 */
-			connected = false;
-			charging = false;
-		}
-	}
+	sd->info->parse_status(sd, data, size);
 
-	if (connected != sd->headset_connected) {
-		hid_dbg(sd->hdev,
+	if (sd->headset_connected != old_connected) {
+		hid_dbg(hdev,
 			"Connected status changed from %sconnected to %sconnected\n",
-			sd->headset_connected ? "" : "not ",
-			connected ? "" : "not ");
-		sd->headset_connected = connected;
-		steelseries_headset_set_wireless_status(hdev, connected);
+			old_connected ? "" : "not ",
+			sd->headset_connected ? "" : "not ");
+
+		if (sd->battery) {
+			steelseries_headset_set_wireless_status(sd->hdev,
+							       sd->headset_connected);
+			power_supply_changed(sd->battery);
+		}
 	}
 
-	if (capacity != sd->battery_capacity) {
-		hid_dbg(sd->hdev,
-			"Battery capacity changed from %d%% to %d%%\n",
-			sd->battery_capacity, capacity);
-		sd->battery_capacity = capacity;
-		power_supply_changed(sd->battery);
+	if (sd->battery_capacity != old_capacity) {
+		hid_dbg(hdev, "Battery capacity changed from %d%% to %d%%\n",
+			old_capacity, sd->battery_capacity);
+		if (sd->battery)
+			power_supply_changed(sd->battery);
 	}
 
-	if (charging != sd->battery_charging) {
-		hid_dbg(sd->hdev,
+	if (sd->battery_charging != old_charging) {
+		hid_dbg(hdev,
 			"Battery charging status changed from %scharging to %scharging\n",
-			sd->battery_charging ? "" : "not ",
-			charging ? "" : "not ");
-		sd->battery_charging = charging;
-		power_supply_changed(sd->battery);
+			old_charging ? "" : "not ",
+			sd->battery_charging ? "" : "not ");
+		if (sd->battery)
+			power_supply_changed(sd->battery);
 	}
 
-request_battery:
-	spin_lock_irqsave(&sd->lock, flags);
-	if (!sd->removed)
-		schedule_delayed_work(&sd->battery_work,
-				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
-	spin_unlock_irqrestore(&sd->lock, flags);
-
 	return 0;
 }
 
 static const struct hid_device_id steelseries_arctis_devices[] = {
-	{ /* SteelSeries Arctis 1 Wireless for XBox */
-		HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
-		.driver_data = STEELSERIES_ARCTIS_1_X },
-
-	{ /* SteelSeries Arctis 9 Wireless for XBox */
-		HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
-		.driver_data = STEELSERIES_ARCTIS_9 },
-
-	{ }
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
+	  .driver_data = (unsigned long)&arctis_1_info },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+			 USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
+	  .driver_data = (unsigned long)&arctis_9_info },
+	{}
 };
 MODULE_DEVICE_TABLE(hid, steelseries_arctis_devices);
 
@@ -402,3 +467,4 @@ MODULE_DESCRIPTION("HID driver for Steelseries arctis headsets");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Mayer <git@mayer-bgk.de>");
 MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
+MODULE_AUTHOR("Sriman Achanta <srimanachanta@gmail.com>");
-- 
2.54.0

