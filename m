Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1762566F5
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236249; cv=none; b=pGAOpaERuMUYJwlQTzmc8VTCnXPQh6sINpNE8eugvsGnjoybtmrkLii+mbg9wMN7Y6t8aFyAGeIoU3EjGDgl+GaetbieEgXh24C6GYZCYZh7mb8hpIdBih5lDc+rJk2MxgTya6viVyhtuXgkeN6++CN1V5+Oj2LprIkdyCZoEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236249; c=relaxed/simple;
	bh=s+WidDgBLF9kLXXn8dGwBA9EPQ87Q1ovYlZ6tuz3ICQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjkrNcHAJANCp73udL3xG9/hnbveoAtFJUixSgkPBtLHidR+i+aJPviJo9c1sRD6L7VG5OfhQQ0R0UBxol7Cz5lQwPpJ8Pvmh8eJHerQ9/ReeUsaIIZp0QxtTUcim0U0hyWPY/L9vXWBkQhBcUtuShRpJRIo+TuI0YHKiQ8DZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXdZFnwK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXdZFnwK"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899ab9d13d0so21240176d6.0
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236247; x=1772841047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQdREBEObX79yVzADeo7mQ1BiSM/IKbQDs531YvSTqg=;
        b=IXdZFnwKEli79HVncv59WxVX03TgXUvz6Y0hgmiv6DAMKRg4/TOQ8XNw9JW7QZ9QQ9
         39XxO8LSaPlzrfqxvU8OJTlwDayqT1ZTZga0Llox4NsvFh0L+xe5b8t75QrLBoGelkeJ
         MOgjADTh5/ABprRcFJf9wkISIdroF2ujUe7nFzId0TMjylBDMZALom2jw+PFEz8eeRP2
         H68LgE+C0VvMFp4mRXOWiboWve3w79mceX2jjOSoYdz9umCmGpeenpvs/dGoRB9ElrQk
         JAMw5NwQ3lSQWerAJnhAEvolo3yJX5yN80HfhJm4+K9YoU4KAyYdfrTXV7rLjLroUURP
         tp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236247; x=1772841047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQdREBEObX79yVzADeo7mQ1BiSM/IKbQDs531YvSTqg=;
        b=NviPWfU9tk+XSYVaQVQ360RAfCCLcMMz6xcbvLHW4OQbNl/F66hZhwHSpHo1+Z1Uwj
         1S28CAk9Uptp00SqfVNQgPrcFbb8jCquNUUhw0ua7KVODnbosJ6bCwJ409NBolUtvZ2a
         EOfGvu2ioKX6o4ZBE28+LolpoiVkox9whO0Eb5B3G7TYPp9q8SXgQIKm6ueCAOWwa37P
         kN9xFP68zaQ2EOu7Hjho2tdtdio69jA3vzJTy5pzxE1o7+sqJgR1MR75t/MQyGNhpDtn
         MoBBuYcHSRWcfjRM5FTe291EFvdSh05gG7lAGfEIub0pzyTvjmxUNLTgpdqu25wFDXEf
         H2XA==
X-Gm-Message-State: AOJu0YxeO8DRzz/j4X+78iPcGIYFFnFuv7VDnhQknp5iF+WPnzRbTFJO
	whnmLhIJaS0Vl+FwTxA1adbw4hgHHltSTGjHn7WFqZX5VQYXbLPlxw3hV8yIrI5c
X-Gm-Gg: ATEYQzzb8WmLII2wMpYMhMb6jqhdAF4hu59JMkFJb2isZ/F6J94VEP16dVx5kErZKF6
	P2qTEMFiu+g28PI3epPDSirDTaxgV2JPb+jTEyQqF92RqKJtCjJdoUMCmI08evmTnVraa5bc7t+
	dqMbDjZRvX0ZCKjh3ExJmUR1aOVSE2HFpsrMiLxstf93WSD9Cc5WMI9jv1662+KRiT7nwXm5LeO
	R+0UzmiH6yWoTMaB8nzSBJYLJSbGLNVdBmZDTPJ24O7Yxd7Q61lGDWjtR/yKl6Lo3h4ghzyaSw0
	e+Weivyjunx1p6EoelxhSab2d33eCSu4tM0r2asDRwCMF15mPs6o97cQlqJWKzo45TRus33uSBi
	XMvCEfJcgcZs0NiGAyidVLUwKrRAGDNII9SFXRysM1EOUR3bGNDeggvgqvjxPb1pA/3AH/M52hJ
	k/rFyPqiF99TU373vO9vrQeDnjrB7KVYMDPEzHkc0Ft7t6VPWQDw==
X-Received: by 2002:a05:6214:f2b:b0:899:b383:5200 with SMTP id 6a1803df08f44-899d1dc0fb9mr71386296d6.25.1772236246684;
        Fri, 27 Feb 2026 15:50:46 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:46 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 01/18] HID: steelseries: Fix ARCTIS_1_X device mislabeling
Date: Fri, 27 Feb 2026 18:50:25 -0500
Message-ID: <20260227235042.410062-2-srimanachanta@gmail.com>
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

The SteelSeries Arctis 1 Wireless for Xbox (device ID 0x12b6) was
previously mislabeled as the regular Arctis 1 Wireless (device ID
0x12b3). This commit corrects the labeling by introducing a new
STEELSERIES_ARCTIS_1_X quirk flag and device table entry.

Both the Arctis 1 and Arctis 1 Wireless for Xbox share the same battery
reporting protocol, so they are handled identically in the battery fetch
and raw event processing functions.

Changes:
- Add STEELSERIES_ARCTIS_1_X quirk flag definition
- Shift STEELSERIES_ARCTIS_9 quirk flag bit accordingly
- Add device table entry for USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X
- Update steelseries_headset_fetch_battery() to handle both Arctis 1
  variants
- Update steelseries_headset_raw_event() to handle both Arctis 1
  variants
- Update device comment to clarify Arctis 1 vs Arctis 1 Wireless for
  Xbox

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-ids.h         |  5 +++--
 drivers/hid/hid-quirks.c      |  1 +
 drivers/hid/hid-steelseries.c | 19 +++++++++++++------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3e299a30dcde..b01704f37142 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1329,8 +1329,9 @@
 
 #define USB_VENDOR_ID_STEELSERIES	0x1038
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1  0x12b6
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9  0x12c2
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1	0x12b3
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X	0x12b6
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9	0x12c2
 
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index edc4339adb50..17349eac5c3e 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -713,6 +713,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_STEELSERIES)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SUNPLUS)
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index f98435631aa1..d3711022bf86 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -19,7 +19,8 @@
 
 #define STEELSERIES_SRWS1		BIT(0)
 #define STEELSERIES_ARCTIS_1		BIT(1)
-#define STEELSERIES_ARCTIS_9		BIT(2)
+#define STEELSERIES_ARCTIS_1_X		BIT(2)
+#define STEELSERIES_ARCTIS_9		BIT(3)
 
 struct steelseries_device {
 	struct hid_device *hdev;
@@ -97,7 +98,7 @@ static const __u8 steelseries_srws1_rdesc_fixed[] = {
 0x29, 0x11,         /*          Usage Maximum (11h),        */
 0x95, 0x11,         /*          Report Count (17),          */
 0x81, 0x02,         /*          Input (Variable),           */
-                    /*   ---- Dial patch starts here ----   */
+		    /*   ---- Dial patch starts here ----   */
 0x05, 0x01,         /*          Usage Page (Desktop),       */
 0x09, 0x33,         /*          Usage (RX),                 */
 0x75, 0x04,         /*          Report Size (4),            */
@@ -110,7 +111,7 @@ static const __u8 steelseries_srws1_rdesc_fixed[] = {
 0x95, 0x01,         /*          Report Count (1),           */
 0x25, 0x03,         /*          Logical Maximum (3),        */
 0x81, 0x02,         /*          Input (Variable),           */
-                    /*    ---- Dial patch ends here ----    */
+		    /*    ---- Dial patch ends here ----    */
 0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
 0x09, 0x01,         /*          Usage (01h),                */
 0x75, 0x04,         /* Changed  Report Size (4),            */
@@ -374,7 +375,8 @@ static void steelseries_headset_fetch_battery(struct hid_device *hdev)
 {
 	int ret = 0;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1)
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
+	    hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X)
 		ret = steelseries_headset_request_battery(hdev,
 			arctis_1_battery_request, sizeof(arctis_1_battery_request));
 	else if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
@@ -638,7 +640,8 @@ static int steelseries_headset_raw_event(struct hid_device *hdev,
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
 		return 0;
 
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1) {
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
+	    hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
 		hid_dbg(sd->hdev,
 			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
 		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
@@ -724,10 +727,14 @@ static const struct hid_device_id steelseries_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
 	  .driver_data = STEELSERIES_SRWS1 },
 
-	{ /* SteelSeries Arctis 1 Wireless for XBox */
+	{ /* SteelSeries Arctis 1 Wireless */
 	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1),
 	  .driver_data = STEELSERIES_ARCTIS_1 },
 
+	{ /* SteelSeries Arctis 1 Wireless for XBox */
+	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
+	  .driver_data = STEELSERIES_ARCTIS_1_X },
+
 	{ /* SteelSeries Arctis 9 Wireless for XBox */
 	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
 	  .driver_data = STEELSERIES_ARCTIS_9 },
-- 
2.53.0

