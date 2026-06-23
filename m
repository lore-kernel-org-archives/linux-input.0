Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E438B7D1
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235396; cv=none; b=UyS9uK8e8AyQKz1Y5quXSjzMrde6ZCrLJ0JRB34ZWYGh96GbUbMdX22Z2nFYEP2StagBlktUL8w4T6+zxR6HA6qo5xF+7nrexmLNcq41TyHQRGyre/is501WCbKI3NaxpCgt6AoXJriMCIbpVVTzB0X5luEJIfN/67SjnIPgI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235396; c=relaxed/simple;
	bh=750kdX5mAH0dO/xXAL2W8bOodx1tyXuBOjz6ae4wKHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR95YPJrI/vpMeyJA3JyF2HP2FmUe66/7Kxj9yzaWCFJ3RpQY1OqYxCfkk78k2ED+Me53IDPJIdr6Z4Nf39eL76K6Z4sCcdD00IahYAp0AA2Kn02rGENFecQXsmRsstIzez6/K3DFdZdl9YOLZTe1YrUPE7Vj0U8NPqPGDphj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sO68ed2K; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO68ed2K"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-519fa6d7a78so140461cf.1
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235394; x=1782840194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4MuavdmCk7lVMwjXvD+T7WNDGym0sHUKRvZvnU6fZw=;
        b=sO68ed2K3cgiu3YjUXWH5MyXOOsXdTYwE5g2XB9BiMLbIA0gmDqOM4X3Fhoe1QSr8L
         N87EoqfBGb/aclWeFS3Mq/lFxZR3p3h0qqdKcx2lC7PZfXTM6OcZdg9j9S4gGUgt0Y6p
         FfwzxEtX7+HcXY3rOmfIw9rIHLlDrXdvUTrLLf0F6D5zrz5Y2LTTXn2izUed7MSfcyYl
         JAdH3lwFSUdPlZUPrz9m4SKL3WrZcwasxXyFALfXL0OfcOF5JJToNL4tTzbhJ3rs3ghD
         s93/wE61KEoqE6F+lQfRb2naHrzubOvuaU//hf0C0NBkLycYd7piavOlkbKLJE53DrOQ
         Nmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235394; x=1782840194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4MuavdmCk7lVMwjXvD+T7WNDGym0sHUKRvZvnU6fZw=;
        b=n5yRcu7ivbGZbOUeYHUu2JzPoxXVOjfd41N6+Jw8FWvrvkIq99thBzxDiE43F5+E7+
         4p4RQM36VwT2jzQyBuvMkh8xwsVwNUCLkN2HUixCrQPHxF0qLjfSApkWsvxT0luqlzMa
         tRUOo8kppkHVu7/6nCXwLxj/vygh63FzmazTXg+fzKL4dmTKfwm7vk3kvsKudGsSaq13
         0+9tB/MuldDEJcgdMfWhlc9WQlOP3DNxT+ZngfhTY6Y1PVcMBRu5I2C84ZfAmUj0fpPX
         4cq/VuK3lqjGdgAKf0Pi1F275sEAv5HCVvgQmhdFocEioOS2ui/g8ENsgcsCN87Xd6La
         cz3A==
X-Gm-Message-State: AOJu0YxvDXc23lg9O9OQtjFtwFXD4BclyM5t4JWoCQ44OrBvIupWtYQO
	1La6RfKnbI69aolBE2igQKlCPTwujTf4SZfXrUdnEaiqrFIgwBEccSCz
X-Gm-Gg: AfdE7ckyVoF4VDxnC6eSz0ydIltxCfAXmHNkctGISPNh9LkA4E1Y6NAhcwCCRX8MsNs
	O7VyF9teVxTcie9qFgzIwT4mpFNwkZCcEUqvxJ6My9ryYBrdljQc6QyZl9OEDxvL3pA0bR1o7IG
	XkSgx8CoFFGcX0aI/DSc9Ke0b8aCQvK7PiuHc8J8B4sRG1GbVlygH/lQ0uzWMfGU8Gowgqd4fTa
	UimH4gW14ybYp4e2EIbVshC85hse8W5p9cHVz2nlrE+RATlHCH2mW5I9L8dRygHrcAIXnIfRWQL
	2FQay7DaLm06QZm2ZZ79Uu/VT5GwZjcKXIgMFi61nrzBWnjgnKls4xd6DHUFnYpZpY21MwLCzgw
	T/GkGFUreh28nSgdCuyXpHoO8Ja+kAdqw3oWDsCeo3QHgfH7H1k/9LgSTOHUwjv1JFoys8xng/U
	tBwfnWDf7H5GMkqHXzvPHRQ+3ys7YHJ4SnuNAYS/vANxpOLB+m
X-Received: by 2002:a05:622a:4d48:b0:517:7406:ccf7 with SMTP id d75a77b69052e-51a54890e52mr53332611cf.49.1782235393890;
        Tue, 23 Jun 2026 10:23:13 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:12 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 02/10] HID: steelseries: Fix whitespace in srws1 report descriptor
Date: Tue, 23 Jun 2026 13:23:02 -0400
Message-ID: <20260623172310.272708-3-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align the SRW-S1 report descriptor so the comment on each line sits in a
single column. No functional change.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 164 +++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index fd38ee3ea6fc..4c97126a4342 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -37,7 +37,7 @@ struct steelseries_device {
 };
 
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
 #define SRWS1_NUMBER_LEDS 15
 struct steelseries_srws1_data {
 	__u16 led_state;
@@ -54,80 +54,80 @@ struct steelseries_srws1_data {
  */
 
 static const __u8 steelseries_srws1_rdesc_fixed[] = {
-0x05, 0x01,         /*  Usage Page (Desktop)                */
-0x09, 0x08,         /*  Usage (MultiAxis), Changed          */
-0xA1, 0x01,         /*  Collection (Application),           */
-0xA1, 0x02,         /*      Collection (Logical),           */
-0x95, 0x01,         /*          Report Count (1),           */
-0x05, 0x01,         /* Changed  Usage Page (Desktop),       */
-0x09, 0x30,         /* Changed  Usage (X),                  */
-0x16, 0xF8, 0xF8,   /*          Logical Minimum (-1800),    */
-0x26, 0x08, 0x07,   /*          Logical Maximum (1800),     */
-0x65, 0x14,         /*          Unit (Degrees),             */
-0x55, 0x0F,         /*          Unit Exponent (15),         */
-0x75, 0x10,         /*          Report Size (16),           */
-0x81, 0x02,         /*          Input (Variable),           */
-0x09, 0x31,         /* Changed  Usage (Y),                  */
-0x15, 0x00,         /*          Logical Minimum (0),        */
-0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
-0x75, 0x0C,         /*          Report Size (12),           */
-0x81, 0x02,         /*          Input (Variable),           */
-0x09, 0x32,         /* Changed  Usage (Z),                  */
-0x15, 0x00,         /*          Logical Minimum (0),        */
-0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
-0x75, 0x0C,         /*          Report Size (12),           */
-0x81, 0x02,         /*          Input (Variable),           */
-0x05, 0x01,         /*          Usage Page (Desktop),       */
-0x09, 0x39,         /*          Usage (Hat Switch),         */
-0x25, 0x07,         /*          Logical Maximum (7),        */
-0x35, 0x00,         /*          Physical Minimum (0),       */
-0x46, 0x3B, 0x01,   /*          Physical Maximum (315),     */
-0x65, 0x14,         /*          Unit (Degrees),             */
-0x75, 0x04,         /*          Report Size (4),            */
-0x95, 0x01,         /*          Report Count (1),           */
-0x81, 0x02,         /*          Input (Variable),           */
-0x25, 0x01,         /*          Logical Maximum (1),        */
-0x45, 0x01,         /*          Physical Maximum (1),       */
-0x65, 0x00,         /*          Unit,                       */
-0x75, 0x01,         /*          Report Size (1),            */
-0x95, 0x03,         /*          Report Count (3),           */
-0x81, 0x01,         /*          Input (Constant),           */
-0x05, 0x09,         /*          Usage Page (Button),        */
-0x19, 0x01,         /*          Usage Minimum (01h),        */
-0x29, 0x11,         /*          Usage Maximum (11h),        */
-0x95, 0x11,         /*          Report Count (17),          */
-0x81, 0x02,         /*          Input (Variable),           */
-                    /*   ---- Dial patch starts here ----   */
-0x05, 0x01,         /*          Usage Page (Desktop),       */
-0x09, 0x33,         /*          Usage (RX),                 */
-0x75, 0x04,         /*          Report Size (4),            */
-0x95, 0x02,         /*          Report Count (2),           */
-0x15, 0x00,         /*          Logical Minimum (0),        */
-0x25, 0x0b,         /*          Logical Maximum (b),        */
-0x81, 0x02,         /*          Input (Variable),           */
-0x09, 0x35,         /*          Usage (RZ),                 */
-0x75, 0x04,         /*          Report Size (4),            */
-0x95, 0x01,         /*          Report Count (1),           */
-0x25, 0x03,         /*          Logical Maximum (3),        */
-0x81, 0x02,         /*          Input (Variable),           */
-                    /*    ---- Dial patch ends here ----    */
-0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
-0x09, 0x01,         /*          Usage (01h),                */
-0x75, 0x04,         /* Changed  Report Size (4),            */
-0x95, 0x0D,         /* Changed  Report Count (13),          */
-0x81, 0x02,         /*          Input (Variable),           */
-0xC0,               /*      End Collection,                 */
-0xA1, 0x02,         /*      Collection (Logical),           */
-0x09, 0x02,         /*          Usage (02h),                */
-0x75, 0x08,         /*          Report Size (8),            */
-0x95, 0x10,         /*          Report Count (16),          */
-0x91, 0x02,         /*          Output (Variable),          */
-0xC0,               /*      End Collection,                 */
-0xC0                /*  End Collection                      */
+0x05, 0x01,					/*  Usage Page (Desktop)                */
+0x09, 0x08,					/*  Usage (MultiAxis), Changed          */
+0xA1, 0x01,					/*  Collection (Application),           */
+0xA1, 0x02,					/*      Collection (Logical),           */
+0x95, 0x01,					/*          Report Count (1),           */
+0x05, 0x01,				/* Changed  Usage Page (Desktop),       */
+0x09, 0x30,				/* Changed  Usage (X),                  */
+0x16, 0xF8, 0xF8,	/*          Logical Minimum (-1800),    */
+0x26, 0x08, 0x07,	/*          Logical Maximum (1800),     */
+0x65, 0x14,				/*          Unit (Degrees),             */
+0x55, 0x0F,				/*          Unit Exponent (15),         */
+0x75, 0x10,				/*          Report Size (16),           */
+0x81, 0x02,				/*          Input (Variable),           */
+0x09, 0x31,				/* Changed  Usage (Y),                  */
+0x15, 0x00,				/*          Logical Minimum (0),        */
+0x26, 0xFF, 0x03,	/*          Logical Maximum (1023),     */
+0x75, 0x0C,				/*          Report Size (12),           */
+0x81, 0x02,				/*          Input (Variable),           */
+0x09, 0x32,				/* Changed  Usage (Z),                  */
+0x15, 0x00,				/*          Logical Minimum (0),        */
+0x26, 0xFF, 0x03,	/*          Logical Maximum (1023),     */
+0x75, 0x0C,				/*          Report Size (12),           */
+0x81, 0x02,				/*          Input (Variable),           */
+0x05, 0x01,				/*          Usage Page (Desktop),       */
+0x09, 0x39,				/*          Usage (Hat Switch),         */
+0x25, 0x07,				/*          Logical Maximum (7),        */
+0x35, 0x00,				/*          Physical Minimum (0),       */
+0x46, 0x3B, 0x01,	/*          Physical Maximum (315),     */
+0x65, 0x14,				/*          Unit (Degrees),             */
+0x75, 0x04,				/*          Report Size (4),            */
+0x95, 0x01,				/*          Report Count (1),           */
+0x81, 0x02,				/*          Input (Variable),           */
+0x25, 0x01,				/*          Logical Maximum (1),        */
+0x45, 0x01,				/*          Physical Maximum (1),       */
+0x65, 0x00,				/*          Unit,                       */
+0x75, 0x01,				/*          Report Size (1),            */
+0x95, 0x03,				/*          Report Count (3),           */
+0x81, 0x01,				/*          Input (Constant),           */
+0x05, 0x09,				/*          Usage Page (Button),        */
+0x19, 0x01,				/*          Usage Minimum (01h),        */
+0x29, 0x11,				/*          Usage Maximum (11h),        */
+0x95, 0x11,				/*          Report Count (17),          */
+0x81, 0x02,				/*          Input (Variable),           */
+									/*   ---- Dial patch starts here ----   */
+0x05, 0x01,				/*          Usage Page (Desktop),       */
+0x09, 0x33,				/*          Usage (RX),                 */
+0x75, 0x04,				/*          Report Size (4),            */
+0x95, 0x02,				/*          Report Count (2),           */
+0x15, 0x00,				/*          Logical Minimum (0),        */
+0x25, 0x0b,				/*          Logical Maximum (b),        */
+0x81, 0x02,				/*          Input (Variable),           */
+0x09, 0x35,				/*          Usage (RZ),                 */
+0x75, 0x04,				/*          Report Size (4),            */
+0x95, 0x01,				/*          Report Count (1),           */
+0x25, 0x03,				/*          Logical Maximum (3),        */
+0x81, 0x02,				/*          Input (Variable),           */
+									/*    ---- Dial patch ends here ----    */
+0x06, 0x00, 0xFF,	/*          Usage Page (FF00h),         */
+0x09, 0x01,				/*          Usage (01h),                */
+0x75, 0x04,				/* Changed  Report Size (4),            */
+0x95, 0x0D,				/* Changed  Report Count (13),          */
+0x81, 0x02,				/*          Input (Variable),           */
+0xC0,							/*      End Collection,                 */
+0xA1, 0x02,				/*      Collection (Logical),           */
+0x09, 0x02,				/*          Usage (02h),                */
+0x75, 0x08,				/*          Report Size (8),            */
+0x95, 0x10,				/*          Report Count (16),          */
+0x91, 0x02,				/*          Output (Variable),          */
+0xC0,							/*      End Collection,                 */
+0xC0							/*  End Collection                      */
 };
 
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
 static void steelseries_srws1_set_leds(struct hid_device *hdev, __u16 leds)
 {
 	struct list_head *report_list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
@@ -489,7 +489,7 @@ static int steelseries_headset_battery_register(struct steelseries_device *sd)
 	sd->battery_desc.use_for_apm = 0;
 	n = atomic_inc_return(&battery_no) - 1;
 	sd->battery_desc.name = devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
-						    "steelseries_headset_battery_%ld", n);
+							"steelseries_headset_battery_%ld", n);
 	if (!sd->battery_desc.name)
 		return -ENOMEM;
 
@@ -535,7 +535,7 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1) {
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
 		return steelseries_srws1_probe(hdev, id);
 #else
 		return -ENODEV;
@@ -581,7 +581,7 @@ static void steelseries_remove(struct hid_device *hdev)
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1) {
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
 		hid_hw_stop(hdev);
 #endif
 		return;
@@ -603,7 +603,7 @@ static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
 		__u8 *rdesc, unsigned int *rsize)
 {
 	if (hdev->vendor != USB_VENDOR_ID_STEELSERIES ||
-	    hdev->product != USB_DEVICE_ID_STEELSERIES_SRWS1)
+		hdev->product != USB_DEVICE_ID_STEELSERIES_SRWS1)
 		return rdesc;
 
 	if (*rsize >= 115 && rdesc[11] == 0x02 && rdesc[13] == 0xc8
@@ -642,7 +642,7 @@ static int steelseries_headset_raw_event(struct hid_device *hdev,
 		hid_dbg(sd->hdev,
 			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
 		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
-		    memcmp(read_buf, arctis_1_battery_request, sizeof(arctis_1_battery_request))) {
+			memcmp(read_buf, arctis_1_battery_request, sizeof(arctis_1_battery_request))) {
 			if (!delayed_work_pending(&sd->battery_work))
 				goto request_battery;
 			return 0;
@@ -722,15 +722,15 @@ static int steelseries_headset_raw_event(struct hid_device *hdev,
 
 static const struct hid_device_id steelseries_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
-	  .driver_data = STEELSERIES_SRWS1 },
+		.driver_data = STEELSERIES_SRWS1 },
 
 	{ /* SteelSeries Arctis 1 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
-	  .driver_data = STEELSERIES_ARCTIS_1_X },
+		HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
+		.driver_data = STEELSERIES_ARCTIS_1_X },
 
 	{ /* SteelSeries Arctis 9 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
-	  .driver_data = STEELSERIES_ARCTIS_9 },
+		HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
+		.driver_data = STEELSERIES_ARCTIS_9 },
 
 	{ }
 };
-- 
2.54.0

