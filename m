Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506119;
	b=F/hQCMZKlEXsxco1Lp0CzI7XabrDZJVY3S10Ek8qPQ26R+gkW4jqN4UVmfkYgXYjj7bz
	 bRXzQsuHZfUnzl4zD5eA+hkUyv/e90aoZOrI3h8QFRU12PTtXGwPdtzUes7h99en5afoA
	 wD7k/xuvBcoZEZjjgp7xHaOy+bkt9DG9/qMYosAoDvQcqW1xAbCHa4lIsElyICC5dlam0
	 xgbS1EwvwJ+Fd2xYG3JOSSpm8to5I1wao+ADhw/oVn7Tq1fFSjaGgtWOHY5QJ7A6Dbdzd
	 W18WhAVcWB5EI5W9MtOwjBDSD/tIJhE4ekgOK/TjsW5Na9E+QPIlH7sVngAj4oyoRng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506119;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=y6EgIrSuluU6L/+i8NPDVLfl/8RE2vW72GSlwlb0s/U=;
	b=kH9znYYp2W5eZ4ZvycexhJMCeraqDdewnK44mx7ruEQmNE1CJk+H2utoP+af8mAmPF7/
	 FKwkCjRUJCSK1CT0Gayjop4opiOSUzcPOmdNi6KOfHR0vVQvXhRID6df86nDm7Ae81wAT
	 aLV29LmJ3SQvdOjahtTd61GTop3zZyHcZ96N4390NP1f54Sc6vcv+htv7RGiCHVHHUyYX
	 9tS/9wtUPbH6Lof6vgnt55IQPfpJbDo3qm5QwuKaukP5mAl0umtQ2WUptdpAvC/YBE6Rs
	 ecAd9wuS4W4bh4SPZIP7Xo0PBeu2oonQEVgXSApqVhmw677tVOJSjffaIJ9mw/fFj7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=JvMubFJq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B2606A880;
	Thu, 12 Nov 2026 17:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094B2606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=JvMubFJq
ARC-Seal: i=1; a=rsa-sha256; t=1794506069; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jb8eCky99fgHhDuOZL+mEenHBGwexYmDQ+0pBP8j5ODh/5txRS2AIgznXI04UbY4ZOp9K3+FETUETi+PrxZsVKG7bi+aw2dYZnAoDAyHOnzSJ+ZDhphTreYs+QKd6bqvQhVaqIe9eL31HxOZ3hwj28ZEUXn1C5vRaMsg3C0E0dM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794506069; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y6EgIrSuluU6L/+i8NPDVLfl/8RE2vW72GSlwlb0s/U=; 
	b=UvfsK59BYXZ/bQwQr/Zptbol6BmnSAfFSceWk+sT63C4U5MdNnhaNSYLwCAHYjjL1hWfKUP57+p4truBra9Qz10nSiETT3UDdPvrLjgqrOXtNgf7/FSBbrtE0j554cuAGMItv2wHRYP3/QvcKLSKWxzb5pGp6RdgWX4M8wq+F/A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=JvMubFJqnzFlxsjV1u4+JXxGutRPQOktIWQWgKjTF53epkoroqDjLjn2GgJJTMLgfUrjaucbMGTSS6/ZyMVossvpy4hIKn0h0iRwbNZeb5f27Ibv3xOqFX2zUzoof++K0MdoZ21NuURAL7zFqKn95oxl/GCHrEwQa40AwDNs1SIPMn6MPI6aq5OatZGBLvzdS1K4g8c9H2gw7RK7LPgSM4XI1CFAh/6SDmlyNtg+oFCm65N/1UOARaT8GQ74G3oi++1albDNbvyiYY0PWAX9/OPubygwaeFI8IwWjCkPN/KLOHZBxku5csviHIXUcFiGlDnVcyM62rnz+J01hGldaQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=y6EgIrSuluU6L/+i8NPDVLfl/8RE2vW72GSlwlb0s/U=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794506068004903.8912376863728;
	Thu, 12 Nov 2026 09:54:28 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Fri, 13 Nov 2026 01:53:59 +0800
Subject: [PATCH v3 6/9] HID: haptic: Convert simple methods into static
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
Message-Id: <20261113-hid-haptic-kmod-v3-6-e7dfa8766c0d@rong.moe>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
In-Reply-To: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
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

