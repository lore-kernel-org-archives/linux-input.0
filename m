Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328903C3BF3
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085092; cv=none; b=QUL0EwoCWfUOGYUqz9l0sGwVCuyTt5AEsX+1UC7nPwEnZ904XBvanUwlVy/RZDWal3KCLrhxKRHFwupbJpYSm5eqchPHD5AxC+n1NIuwQSreHUe6anb2ezqBTE7/0PLAqnUjrPNFRyYAv7Rb0n7LVJ+P5oTIfCWvFy+RjnLSCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085092; c=relaxed/simple;
	bh=JTFUZFIPrXdwMFJtGHRG8gj8cpgzYXkkfnB5Kd371Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoJVtK8j1xgpAWVszA0vx/fmkLj1lUas40xpubunqzkeML3B0vC2NuhN4tvJefUwZEEneouDNxI/5Qs5++kVn1SwCpHemb7wSY1wY3P8hybhmVtJd5MJYuRnDPh3beOc7UyCxnZqU/z/NEQ3VtbAlcrXrwDqFAYv/2KOBiljvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgRQzokA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgRQzokA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d560ede296so506680585a.0
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776085090; x=1776689890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prygOw5MQF8VYP/DVqBRTTRsdHJckSNwnl28zfvOaGE=;
        b=lgRQzokAy4VwcvDKG2BVvBq7uvJmmp7Qz0YOnSKkjMgTdmdna8sya8cbUfK+mdpjha
         10mGrrx6ramAuMk1VzDxNjL8/2gOPCJGB8Ilo55YU4vHTYnqL8KV3jLS0Vrw6JvLyQB8
         inj4yyDW9sk6+r3RVpcHQHat9g08V2bX05EPMJzMdWO+mgL84PmVuY/LX7njo/9EEBDn
         GeW5wRPLw1zP9d2hF482+L4yLtPcJpbCiCGfGiPztdbOWYsD9LsthHyO37sCOwWo7E9U
         V9srufP2yyFkRvCsm0TIZEDfE+iegoff+zBt9Fdx4NDk/+LAkmGA/2WNPy+DfgEmBRnp
         936A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776085090; x=1776689890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prygOw5MQF8VYP/DVqBRTTRsdHJckSNwnl28zfvOaGE=;
        b=mRqBk6RJsilXPzLi4DOlYWGmjjhqAZnWR+HbYrTMoRIuWVMcpcsi23uMZx9mhAbHq9
         VCJY4sNcEqH4fnLbkRHlLtEovlIIcu6KNaHCXKOtA4NlTPz72/yg+4Stuxxiq8/nf2Q+
         g/NSKsIhxcCpQ/Hq8KA7lpY3Ew5kLqkfnUMpnnZ9mYqNtFndg3MFzo8as3Y1bUSs7tlD
         9jYh6mffS+inUxmbt/c0XS6FLdZ1ex0Gy1lMiYas3R/msm+YFgiLpcgc7vWLsQVpE4qq
         W8XjLqm+D7Kan5tJyOm7d+cCwNta/9PqAO+OmLgP/MTP2Nn9Bc3brnVNAfxVfZYBTGpa
         csZw==
X-Gm-Message-State: AOJu0Ywu0qordXurofsBnwMJgmySMd6Ivt9FJ1V/F9a8UTXS1sU1fFNo
	iF5ONzbiPLYL5KkXsm0OJd8nvJlnCGUxfWLJooePDph8ipoKU0VlHFleDn21GLii
X-Gm-Gg: AeBDiet6uMKFHrQBlQj6ta6CWl3mXWHohefLF4vMZnaLKmet3IqUnpLEbH57r7tXbD3
	gpxo4+GziZAsFoSNnIZJWqzHBgMslofUJ2qKmsgKCiUuWLP82fAs5YxgQ8Px37uQL+Q0/9UUtyE
	3QpVxFYkGNP6yrVlfWmTKqZY1XG2grZhCVgDSTzJpoVRK3A3x8w3Mm4mcdIe/HUTKDfhgUOGFVq
	Ox6mh03XU595YAS+1/4EU/BapfE7j0ZNx7lC2R57HisagDfmrERdfVbEOpm0hhfv//0BooEWh/Q
	KRWjwmjHbWRWHZn9SPLwow3xgu24/UdWz7s4qViXv7/eddDK6yQ4Ur36kQh4gHuqQb585ExO+aF
	fXxDZ3kM9cnmC28j0aIaUHGdtv1feiygdERXaclNcBsaEpdh0MopEmKZ99wR7mAGMwKAHqncZX8
	CQPFwoSJmqJg9GTx7KoC9UnDyW3a7GMKHjxmCi756qU9/mKDakWmebkGr0g8vwn0HcN0UP
X-Received: by 2002:a05:620a:4146:b0:8d7:e7f4:7e9d with SMTP id af79cd13be357-8ddd0694ac5mr1808593085a.59.1776085089649;
        Mon, 13 Apr 2026 05:58:09 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb963d7edsm846965885a.39.2026.04.13.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:58:09 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v2] HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen misclassification
Date: Mon, 13 Apr 2026 08:58:03 -0400
Message-ID: <20260413125803.46792-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402182937.388847-1-carvsdriver@gmail.com>
References: <20260402182937.388847-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Book 9 14IAH10 (83KJ) (17EF:6161) firmware includes a
HID_DG_TOUCHPAD application collection designed for the Windows inbox HID
driver's Win8 PTP touchpad mode.  On Linux the HID_DG_TOUCHSCREEN
collections provide the correct direct-touch interface.  The presence of
the touchpad collection causes hid-multitouch to misclassify the
touchscreen nodes as indirect buttonpads, leaving them non-functional.

Within the touchpad collection:
- HID_UP_BUTTON usages trigger the touchscreen-with-buttons heuristic
  that sets INPUT_MT_POINTER on the touchscreen applications.
- The HID_DG_TOUCHPAD application itself sets INPUT_MT_POINTER via
  mt_allocate_application(), propagating to all touchscreen nodes.
- A HID_DG_BUTTONTYPE feature (report 0x51) returns MT_BUTTONTYPE_CLICKPAD,
  setting td->is_buttonpad = true for the entire device.

Additionally, the firmware resets if any USB control request arrives while
the CDC-ACM interface is initialising (~1.18 s after enumeration).
The Win8 compliance blob (0xff00:0xc5) and Contact Count Max feature
reports in the touchscreen collections trigger GET_REPORT calls at probe
that hit this window.  Surface Switch (0x57) and Button Switch (0x58)
feature reports are sent by mt_set_modes() on every input-device open and
close, repeatedly hitting this window throughout device lifetime.

The firmware also leaves a persistent ghost contact in its contact buffer
(contact ID 2, fixed coordinates, tip always asserted) on every enumeration.
This ghost occupies a multitouch slot and prevents KWin from seeing a clean
finger-lift, causing stuck touch state.  The ghost is cleared when Input
Mode is set via HID_REQ_SET_REPORT at probe.

Fix using a report descriptor fixup in mt_report_fixup() and a class
definition update:

1. Remove the entire HID_DG_TOUCHPAD application collection.  Parsing
   HID short items from its header to the matching End Collection and
   closing the gap with memmove eliminates all three BUTTONPAD
   heuristics and the feature reports within the collection.

2. Neutralize the Win8 compliance blob feature reports remaining in the
   touchscreen collections by changing Usage Page 0xff00 to 0x0f00,
   preventing the case 0xff0000c5 branch in mt_feature_mapping() from
   issuing GET_REPORT.

3. Neutralize the Contact Count Max feature reports by changing usage
   0x55 to 0x00; set maxcontacts = 10 in the class definition so the
   driver uses the correct contact limit without querying the device.

4. Neutralize Surface Switch (0x57) and Button Switch (0x58) feature
   report usages in the Device Configuration collection so mt_set_modes()
   does not issue HID_REQ_SET_REPORT for these on every input-device
   open/close.  Input Mode (0x52) is intentionally left intact: the single
   HID_REQ_SET_REPORT at probe flushes the firmware's contact buffer and
   clears the persistent ghost contact.  By probe time the cdc-acm driver
   has already satisfied the CDC-ACM init watchdog (~130 ms), so this
   request arrives safely after the reset window has closed.

5. Add MT_QUIRK_NOT_SEEN_MEANS_UP to the MT_CLS_YOGABOOK9I class so that
   contacts not present in a frame are released via INPUT_MT_DROP_UNUSED,
   preventing stale multitouch slots from lingering if the firmware omits
   a contact from a report.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
Tested-by: Dave Carey <carvsdriver@gmail.com>
---
Re: Benjamin's question about the Windows driver — the device uses
Windows' generic inbox drivers: usbser.sys binds interface 0 (CDC ACM)
and the generic HID class driver handles the HID interfaces.  The
HID_DG_TOUCHPAD collection is in the descriptor for Windows' PTP inbox
touchpad path, not for a custom driver.  On Windows the system routes
input through the touchpad application; on Linux hid-multitouch sees
both the touchscreen and touchpad applications and gets confused by the
touchpad one.  The descriptor fixup removes it from Linux's view.

Changes in v2:
  - Replace per-callsite MT_QUIRK_YOGABOOK9I guards with a single
    mt_yogabook9_fixup() function called from mt_report_fixup().
  - Drop the HID_DG_TOUCHPAD application collection entirely via memmove,
    eliminating all three BUTTONPAD heuristics at source rather than
    suppressing their effects at each callsite.
  - Neutralize Win8 compliance blob GET_REPORT triggers by changing
    Usage Page 0xff00 to 0x0f00 in the descriptor.
  - Neutralize Contact Count Max GET_REPORT trigger (usage 0x55 -> 0x00);
    set maxcontacts = 10 in the class definition.
  - Neutralize Surface Switch (0x57) and Button Switch (0x58) SET_REPORT
    triggers; retain Input Mode (0x52) so the single probe-time SET_REPORT
    flushes the firmware contact buffer and clears a persistent ghost contact.
  - Add MT_QUIRK_NOT_SEEN_MEANS_UP to the MT_CLS_YOGABOOK9I class.

 drivers/hid/hid-multitouch.c | 146 ++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e82a3c4e5..ec04dbafb 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -443,11 +443,13 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
 	},
 		{ .name = MT_CLS_YOGABOOK9I,
-		.quirks = MT_QUIRK_ALWAYS_VALID |
+		.quirks = MT_QUIRK_NOT_SEEN_MEANS_UP |
+			MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_FORCE_MULTI_INPUT |
 			MT_QUIRK_SEPARATE_APP_REPORT |
 			MT_QUIRK_HOVERING |
 			MT_QUIRK_YOGABOOK9I,
+		.maxcontacts = 10,
 		.export_all_inputs = true
 	},
 	{ .name = MT_CLS_EGALAX_P80H84,
@@ -1566,6 +1568,144 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 	return 0;
 }
 
+/*
+ * Yoga Book 9 14IAH10 descriptor fixup.
+ *
+ * The device includes a HID_DG_TOUCHPAD application collection designed for
+ * the Windows inbox HID driver's Win8 PTP touchpad mode.  On Linux we want
+ * only the HID_DG_TOUCHSCREEN collections.  The touchpad collection (and the
+ * HID_DG_BUTTONTYPE and Win8 compliance blob features it contains) must be
+ * removed so hid-multitouch does not misclassify the touchscreen nodes as
+ * indirect buttonpads.
+ *
+ * The firmware also resets if any USB control request is received while the
+ * CDC-ACM interface is initialising (~1.18 s after enumeration).  Dropping
+ * the Win8 blob and Contact Count Max feature reports prevents the
+ * GET_REPORT calls that hid-multitouch issues at probe.
+ */
+static void mt_yogabook9_fixup(struct hid_device *hdev, __u8 *rdesc,
+			       unsigned int *size)
+{
+	/* Usage Page (Digitizer), Usage (Touch Pad), Collection (Application) */
+	static const __u8 tp_app_hdr[] = { 0x05, 0x0d, 0x09, 0x05, 0xa1, 0x01 };
+	/* Vendor Usage Page 0xff00 (Win8 compliance blob header) */
+	static const __u8 win8_page[] = { 0x06, 0x00, 0xff };
+	/* Usage (Contact Count Max = 0x55) */
+	static const __u8 ccmax_usage[] = { 0x09, 0x55 };
+	unsigned int i;
+
+	/*
+	 * Step 1: find and remove the Touch Pad application collection.
+	 * Walk HID short items from the collection header to its matching
+	 * End Collection, then close the gap with memmove.
+	 */
+	for (i = 0; i + sizeof(tp_app_hdr) <= *size; i++) {
+		if (memcmp(rdesc + i, tp_app_hdr, sizeof(tp_app_hdr)) == 0) {
+			__u8 *start = rdesc + i;
+			__u8 *coll_end = NULL;
+			__u8 *p = start;
+			unsigned int drop;
+			int depth = 0;
+
+			while (p < rdesc + *size) {
+				__u8 b = *p;
+				int ds = b & 3;
+				int item_len;
+
+				if (b == 0xfe) { /* long item */
+					if (p + 2 >= rdesc + *size)
+						break;
+					item_len = p[1] + 3;
+				} else {
+					item_len = (ds == 3) ? 5 : ds + 1;
+				}
+				if (p + item_len > rdesc + *size)
+					break;
+
+				if ((b & 0xfc) == 0xa0)
+					depth++; /* Collection */
+				else if (b == 0xc0) {
+					depth--; /* End Collection */
+					if (depth == 0) {
+						coll_end = p;
+						break;
+					}
+				}
+				p += item_len;
+			}
+
+			if (!coll_end) {
+				hid_err(hdev,
+					"Yoga Book 9: Touch Pad End Collection not found\n");
+				break;
+			}
+
+			drop = coll_end - start + 1;
+			memmove(start, coll_end + 1, rdesc + *size - coll_end - 1);
+			*size -= drop;
+			hid_dbg(hdev,
+				"Yoga Book 9: dropped Touch Pad collection (%u bytes)\n",
+				drop);
+			break;
+		}
+	}
+
+	/*
+	 * Step 2: neutralize Win8 compliance blob feature reports remaining
+	 * in the touchscreen collections.  Change Usage Page 0xff00 to 0x0f00
+	 * so the case 0xff0000c5 branch in mt_feature_mapping() is not reached
+	 * and no GET_REPORT is issued.
+	 */
+	for (i = 0; i + sizeof(win8_page) <= *size; i++) {
+		if (memcmp(rdesc + i, win8_page, sizeof(win8_page)) == 0) {
+			rdesc[i + 2] = 0x0f; /* 0xff00 -> 0x0f00 */
+			hid_dbg(hdev,
+				"Yoga Book 9: neutralized Win8 blob at offset %u\n",
+				i);
+		}
+	}
+
+	/*
+	 * Step 3: neutralize Contact Count Max feature reports.  Change usage
+	 * 0x55 (HID_DG_CONTACTMAX) to 0x00 so mt_feature_mapping() does not
+	 * issue GET_REPORT.  The class maxcontacts field provides the value.
+	 */
+	for (i = 0; i + sizeof(ccmax_usage) <= *size; i++) {
+		if (memcmp(rdesc + i, ccmax_usage, sizeof(ccmax_usage)) == 0) {
+			rdesc[i + 1] = 0x00;
+			hid_dbg(hdev,
+				"Yoga Book 9: neutralized ContactMax at offset %u\n",
+				i);
+		}
+	}
+
+	/*
+	 * Step 4: neutralize Surface Switch (0x57) and Button Switch (0x58)
+	 * feature report usages in the Device Configuration collection.
+	 * mt_set_modes() issues HID_REQ_SET_REPORT for these on every
+	 * input-device open/close; those repeated control requests hit the
+	 * firmware's CDC-ACM init window and trigger resets.
+	 *
+	 * Input Mode (0x52) is intentionally left intact.  mt_set_modes()
+	 * sends it once at probe to set the device into touchscreen mode,
+	 * which flushes the firmware's contact buffer and clears a persistent
+	 * ghost contact (cid 2, fixed coordinates) that otherwise appears on
+	 * every enumeration.  By probe time cdc_acm has already satisfied the
+	 * CDC-ACM init watchdog (~130 ms), so the single SET_REPORT for Input
+	 * Mode arrives safely after the reset window has closed.
+	 */
+	for (i = 0; i + 2 <= *size; i++) {
+		if (rdesc[i] == 0x09 &&
+		    (rdesc[i + 1] == 0x57 ||
+		     rdesc[i + 1] == 0x58)) {
+			hid_dbg(hdev,
+				"Yoga Book 9: neutralized set-modes usage 0x%02x at offset %u\n",
+				rdesc[i + 1], i);
+			rdesc[i + 1] = 0x00;
+		}
+	}
+}
+
 static const __u8 *mt_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *size)
 {
@@ -1595,6 +1735,10 @@ got: %x\n",
 		}
 	}
 
+	if (hdev->vendor == USB_VENDOR_ID_LENOVO &&
+	    hdev->product == USB_DEVICE_ID_LENOVO_YOGABOOK9I)
+		mt_yogabook9_fixup(hdev, rdesc, size);
+
 	return rdesc;
 }
 

base-commit: 705c735d0ef7701cf9ded290545345a8c9b8bd7e
-- 
2.53.0

