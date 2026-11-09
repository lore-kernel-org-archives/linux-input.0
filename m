Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253859;
	b=hyMGRe/aYkbp4XTNisgU4pHjbyKfEfLLnw5xhakQu0Oggag3v8lRvn4CqIbGXwS0sH6O
	 mUU1mcJgQ2xUXL0+N0+zqHOsL8liHlahkUbjepNjqQIoJoI6TsiZoPXcXcmaNgmmrDgAg
	 Rob4cMcfXQvSPejP+IuGaI+KMVVX4Q5Qwju0oQvEOoF0wPgvkLq3VEqzRS0qthii1gMvl
	 ILCdi6mQezj1ihMTPDfMtuRPfaJD1ljMT2XeJf10lVidnQdrp1SvQOCi12vU6SL78shHt
	 aYCKqT02kJx6bU0hiPM5TXZmmFm1DRDDHKT2obXZxmm9iZKThSMwPQv1Eoojy1TI+rQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253859;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=y6EgIrSuluU6L/+i8NPDVLfl/8RE2vW72GSlwlb0s/U=;
	b=2dkuXpiZZTZiSlEE0iMNH4VZRhQkdBlVsJyEL48gdjUGfqHaDa/+3KnEW2bGKLPDp6Cn
	 guA/CYVL1dlDiIEideEI9yTP0hoQ7JeCJzmCOw2WqCHDURMDA7nQAQH5d2KMnf9Rcag47
	 MTrOoavcN4Q/uip5laf1uOWFqZSERxfRbgSAHGmQX3dyeiv6XpLHasn9xxm7vi3CxYCav
	 MPyGEnRwjneL11GtjW54v6Mht/wIZpmDvTn/M/kVU4+8cv90330mcZ78qQlBfMvYB5F82
	 Y3U9y0E8bNIjyZKlaPzmUYbfwZB+soGRnxaJBo5+YtEBjks3bxGmVO5cu/F5OWjCN4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=m5japC5C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC960A2616;
	Mon,  9 Nov 2026 19:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27DC960A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=m5japC5C
ARC-Seal: i=1; a=rsa-sha256; t=1794253814; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O+/GUuO1+Ff6hwpuzMgVQblvDZa5IY4LYX4pUzsmP4QxlLeU3w0RRJzTSO+MxZQbab2AtXkFggLDxCktjxRL6vvH4WmxKxfjCRIGwciCmiwictfUlqo2RHggD5BBjIoNFIkOewBwdZHDGNBtftj5QgO7DbQVPpY87iJVHOAXPUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253814; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y6EgIrSuluU6L/+i8NPDVLfl/8RE2vW72GSlwlb0s/U=; 
	b=KokArBC1JHiw+c23jcK8+hETVRxiZB0g6ABqWAd7yQ18lkAoifKPsEfUvm0kXGdimH4e9B7r/X0z3nHaQamWAox7J809VUTKy9Ne756ti8U8jK4V2zgwj+b/gFLQykeNs644/yEqodQKVYJAhlLKOd+qlMqg7tIj/Eqc1fBlXsU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=m5japC5CitPDAI5MxfPEaI6uQ6pRLUrozBqt4tFX25QneZKrK1x7mDse3PAZsL9Z/sGGvy6EbDiKC5IgXLGlN0AER1B3PvOQvDwGGeVUEkIVHzocBT0djS7GuxgshmJZVKY5vGQ1fx4hVPubYnXH7o9A3Deqw/xkSLdKPrKR3ijpisKE6yj+LxjzFk8mhxq+HVEMvaI+I17QioVVlncpoXCCch3kGsnAw4eRcZiA2UiuZU/GWEk3IRKCUtfwIVCvPpg9aJFau1lqOlSUF+uJcvyD+YWb9s3j2Fh7DcvY3bdOPBrrVJtZNGxlnbMc6IrPNF0gp32YxFgughvzAcUT9A==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=y6EgIrSuluU6L/+i8NPDVLfl/8RE2vW72GSlwlb0s/U=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794253812410919.2506547672622;
	Mon, 9 Nov 2026 11:50:12 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Tue, 10 Nov 2026 03:49:43 +0800
Subject: [PATCH v2 6/9] HID: haptic: Convert simple methods into static
 inline ones
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-haptic-kmod-v2-6-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
In-Reply-To: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Some methods of hid-haptic are meant to check the prerequisites before
really initializing the haptic device. Most of them are quite simple and
straightforward. To prepare for the following changes that convert
hid-haptic into a loadable plugin module, factor them out of the module
and convert them into static inline functions.

Some unused declarations and stubs in the header are also removed, i.e.,
hid_haptic_handle_press_release(), hid_haptic_reset(),
hid_haptic_handle_input(). They seemed to be remnants from the patch
revisioning process.

No functional change intended.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.c | 110 ---------------------------------------
 drivers/hid/hid-haptic.h | 131 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 104 insertions(+), 137 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 9f2af082d2ea..a6f3ec514504 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -10,103 +10,6 @@
 
 #include "hid-haptic.h"
 
-void hid_haptic_feature_mapping(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_field *field, struct hid_usage *usage)
-{
-	u16 usage_hid;
-
-	if (usage->hid == HID_HP_AUTOTRIGGER) {
-		if (usage->usage_index >= field->report_count) {
-			dev_err(&hdev->dev,
-				"HID_HP_AUTOTRIGGER out of range\n");
-			return;
-		}
-		haptic->auto_trigger_report = field->report;
-	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ORDINAL) {
-		usage_hid = usage->hid & HID_USAGE;
-		switch (field->logical) {
-		case HID_HP_WAVEFORMLIST:
-			if (usage_hid > haptic->max_waveform_id)
-				haptic->max_waveform_id = usage_hid;
-			break;
-		case HID_HP_DURATIONLIST:
-			if (usage_hid > haptic->max_duration_id)
-				haptic->max_duration_id = usage_hid;
-			break;
-		default:
-			break;
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(hid_haptic_feature_mapping);
-
-void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
-				    struct hid_input *hi, struct hid_field *field)
-{
-	if (hi->application != HID_DG_TOUCHPAD)
-		return;
-
-	if (IS_ERR(haptic->input_dev))
-		return;
-
-	if (field->unit != HID_UNIT_GRAM && field->unit != HID_UNIT_NEWTON)
-		goto reject;
-
-	if (!haptic->input_dev) {
-		haptic->input_dev = hi->input;
-		haptic->pressure_field = field;
-		haptic->force_resolution = input_abs_get_res(hi->input, ABS_MT_PRESSURE);
-		return;
-	}
-
-	if (hid_haptic_connected_to_input(haptic, hi->input) &&
-	    haptic->pressure_field->unit == field->unit &&
-	    haptic->pressure_field->logical_minimum == field->logical_minimum &&
-	    haptic->pressure_field->physical_minimum == field->physical_minimum &&
-	    haptic->force_resolution == input_abs_get_res(hi->input, ABS_MT_PRESSURE))
-		return;
-
-reject:
-	/*
-	 * Reject if:
-	 * - there are multiple input devices with pressure sensors
-	 * - there is any touchpad application with a non-force unit
-	 * - pressure annotations mismatch among HID_DG_TIPPRESSURE usages
-	 */
-	haptic->input_dev = ERR_PTR(-EPROTO);
-}
-EXPORT_SYMBOL_GPL(hid_haptic_check_pressure_unit);
-
-int hid_haptic_input_mapping(struct hid_device *hdev,
-			     struct hid_haptic_device *haptic,
-			     struct hid_input *hi,
-			     struct hid_field *field, struct hid_usage *usage,
-			     unsigned long **bit, int *max)
-{
-	if (usage->hid == HID_HP_MANUALTRIGGER) {
-		haptic->manual_trigger_report = field->report;
-		/* we don't really want to map these fields */
-		return -1;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(hid_haptic_input_mapping);
-
-bool hid_haptic_input_configured(struct hid_device *hdev,
-				 struct hid_haptic_device *haptic, struct hid_input *hi)
-{
-	if (IS_ERR_OR_NULL(haptic->input_dev) || haptic->input_dev != hi->input ||
-	    !haptic->auto_trigger_report || !haptic->manual_trigger_report)
-		return false;
-
-	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
-
-	return hid_haptic_init(hdev, haptic, hi->input) == 0;
-}
-EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
-
 static void parse_auto_trigger_field(struct hid_haptic_device *haptic,
 				     struct hid_field *field)
 {
@@ -555,16 +458,3 @@ int hid_haptic_init(struct hid_device *hdev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_init);
-
-void hid_haptic_pressure_reset(struct hid_haptic_device *haptic)
-{
-	haptic->pressure_sum = 0;
-}
-EXPORT_SYMBOL_GPL(hid_haptic_pressure_reset);
-
-void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
-				 __s32 pressure)
-{
-	haptic->pressure_sum += pressure;
-}
-EXPORT_SYMBOL_GPL(hid_haptic_pressure_increase);
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 7878cd73ccdb..6196041eb4f8 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -72,25 +72,112 @@ static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *hapti
 	return haptic->input_dev == input;
 }
 
-void hid_haptic_feature_mapping(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_field *field, struct hid_usage
-				*usage);
-void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
-				    struct hid_input *hi, struct hid_field *field);
-int hid_haptic_input_mapping(struct hid_device *hdev,
-			     struct hid_haptic_device *haptic,
-			     struct hid_input *hi,
-			     struct hid_field *field, struct hid_usage *usage,
-			     unsigned long **bit, int *max);
-bool hid_haptic_input_configured(struct hid_device *hdev,
-				 struct hid_haptic_device *haptic, struct hid_input *hi);
+static inline void hid_haptic_feature_mapping(struct hid_device *hdev,
+					      struct hid_haptic_device *haptic,
+					      struct hid_field *field, struct hid_usage *usage)
+{
+	u16 usage_hid;
+
+	if (usage->hid == HID_HP_AUTOTRIGGER) {
+		if (usage->usage_index >= field->report_count) {
+			dev_err(&hdev->dev, "HID_HP_AUTOTRIGGER out of range\n");
+			return;
+		}
+
+		haptic->auto_trigger_report = field->report;
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ORDINAL) {
+		usage_hid = usage->hid & HID_USAGE;
+		switch (field->logical) {
+		case HID_HP_WAVEFORMLIST:
+			if (usage_hid > haptic->max_waveform_id)
+				haptic->max_waveform_id = usage_hid;
+			break;
+		case HID_HP_DURATIONLIST:
+			if (usage_hid > haptic->max_duration_id)
+				haptic->max_duration_id = usage_hid;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static inline void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+						  struct hid_input *hi, struct hid_field *field)
+{
+	if (hi->application != HID_DG_TOUCHPAD)
+		return;
+
+	if (IS_ERR(haptic->input_dev))
+		return;
+
+	if (field->unit != HID_UNIT_GRAM && field->unit != HID_UNIT_NEWTON)
+		goto reject;
+
+	if (!haptic->input_dev) {
+		haptic->input_dev = hi->input;
+		haptic->pressure_field = field;
+		haptic->force_resolution = input_abs_get_res(hi->input, ABS_MT_PRESSURE);
+		return;
+	}
+
+	if (hid_haptic_connected_to_input(haptic, hi->input) &&
+	    haptic->pressure_field->unit == field->unit &&
+	    haptic->pressure_field->logical_minimum == field->logical_minimum &&
+	    haptic->pressure_field->physical_minimum == field->physical_minimum &&
+	    haptic->force_resolution == input_abs_get_res(hi->input, ABS_MT_PRESSURE))
+		return;
+
+reject:
+	/*
+	 * Reject if:
+	 * - there are multiple input devices with pressure sensors
+	 * - there is any touchpad application with a non-force unit
+	 * - pressure annotations mismatch among HID_DG_TIPPRESSURE usages
+	 */
+	haptic->input_dev = ERR_PTR(-EPROTO);
+}
+
+static inline int hid_haptic_input_mapping(struct hid_device *hdev,
+					   struct hid_haptic_device *haptic,
+					   struct hid_input *hi,
+					   struct hid_field *field, struct hid_usage *usage,
+					   unsigned long **bit, int *max)
+{
+	if (usage->hid == HID_HP_MANUALTRIGGER) {
+		haptic->manual_trigger_report = field->report;
+		/* we don't really want to map these fields */
+		return -1;
+	}
+	return 0;
+}
+
 int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
 		    struct input_dev *dev);
-void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
-void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
-void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
-				  __s32 pressure);
+
+static inline bool hid_haptic_input_configured(struct hid_device *hdev,
+					       struct hid_haptic_device *haptic,
+					       struct hid_input *hi)
+{
+	if (IS_ERR_OR_NULL(haptic->input_dev) || haptic->input_dev != hi->input ||
+	    !haptic->auto_trigger_report || !haptic->manual_trigger_report)
+		return false;
+
+	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
+
+	return hid_haptic_init(hdev, haptic, hi->input) == 0;
+}
+
+static inline void hid_haptic_pressure_reset(struct hid_haptic_device *haptic)
+{
+	haptic->pressure_sum = 0;
+}
+
+static inline void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
+						__s32 pressure)
+{
+	haptic->pressure_sum += pressure;
+}
 #else
 static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
 {
@@ -129,22 +216,12 @@ bool hid_haptic_input_configured(struct hid_device *hdev,
 	return false;
 }
 static inline
-void hid_haptic_reset(struct hid_device *hdev, struct hid_haptic_device *haptic)
-{}
-static inline
 int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
 		    struct input_dev *dev)
 {
 	return 0;
 }
 static inline
-void hid_haptic_handle_press_release(struct hid_haptic_device *haptic) {}
-static inline
-bool hid_haptic_handle_input(struct hid_haptic_device *haptic)
-{
-	return false;
-}
-static inline
 void hid_haptic_pressure_reset(struct hid_haptic_device *haptic) {}
 static inline
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,

-- 
2.55.0

