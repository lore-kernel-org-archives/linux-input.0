Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538852;
	b=b0d5bgpT/THqWKCCVPTodfaTyzCO4X+Vwbr0/VvKbkuiFzsPi21uZjgyD+RyJYHQ+2yT
	 5gKo+gcinr1QAnraQMfO7vS8qlWDJytF7HjD8ahqx3q+Bp9pa74Pv53iQB/YXD+l/+6fT
	 0TDRam1Ez/hX+snu2fxYHmGdo/ID+4MYZ0ysEqZTzAQqiiotzovPV0+zfGiZeJNb1z/Vs
	 aBw6kgpEATY2GkkPgavcY5aQKqvgK0Iufr2qulRhVLL6JYZykhdyaRlzz9mHBiQ+GLN1w
	 Z/ydVFLeVyiy2FO20mdEzAlRNhFz3d5ln5AVG3498MtHA7ifTp/d5hT7mQcarLG53XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538852;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=BFrlAc934swBgB8XrXIkVTj+dmUnmNdVB55epn8i5CY=;
	b=43zuk8QNCXDUzbT48iu4SmVu2JWrWk3WUsv8rMWuoF1/J1uc4FKBWWrWiWP7JUs+cVCq
	 OZZAEh9pbrkryLIOGogluHkOvFtzaGdf4zvgtxIU9cGA/iwkNJZ74UAzvhrCeJPkyQmdR
	 yhoCyV+23jcKLW+KEvkaSOVEzLPjJ2vFOzYBjgZObtxDZY7XdKALTpR0jXMJB8sjIy2ps
	 5jMTPnRE6qRxLaFsuGDNbAxBvOGtSemlT5fXAFX6DFUjrgRF7o06Y1i+Hrp0ejlEbPfWa
	 1b3Nly1Y1+4IZLVNAGS+emSz+7dzpgV7Nj0rM21iEMGLH0G9FO29uaIIjicFRSjyb4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=QEIywtjD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE9606A32E;
	Tue, 24 Nov 2026 16:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61BE9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=QEIywtjD
ARC-Seal: i=1; a=rsa-sha256; t=1795538731; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fVAL7kGqoYyfc+EQf7ZrUg4X+pyVANYm/385bzUyBJUG6TVtwpOB+BOpn96X6Spvb61he5WFNtMr0hhQB4qTFvU/lHriIiQm02SQA1ZlrQ9KVIsIKcbfrCcN/i1NXvXbnAUnc4/3sA/VZKkwz9n7WuOnDTYfHtqsDkXFaNAXxJs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538731; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BFrlAc934swBgB8XrXIkVTj+dmUnmNdVB55epn8i5CY=; 
	b=DjHfX70DK4pfT+yoWReATYHvAYr9Jxw07eM2/lJP1SH93r2fwpk22/rxS5eLZCAqfcqy1j6MV7Uafq/kUUSj4XRMFhe4Cz4T3niOSeJRRdRKhEYohOynp86GgUK0qe0TveNPpemBq6jJeWEk2eVp+QmjQVjRHuuDw1PA8cD0vew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=QEIywtjDxNRzyr3f0LoQ9pZ9Ls/h4tB/RvcDCsNot36/c3PCSWYlMgFZkBuYiu/rkIBmaRFC1EkayY/zY8Mz+qd/ntRLqtRDZ3bgeFJY3vksFdpkq9dOYoIktokir0B0J91GWau1zq+AGeSWktnMNwjJ/kUJDgGJkw3T2gZeC7Wa4ma9Jmor4aeQIqcyyDaU4ye5yrV2CTyD+zZgJxQ4HuA9xJ4EHCGdPLTqNPgn+48BP7rKABl0meVQmtriUQCY9KdvqCABYFFB30EExbdwP6FNihBjTo6rbFqC97vU4qkn7AoqM/eVg72xIyjMgGxythaNjJOkp5FA5pcIsGRD/A==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=BFrlAc934swBgB8XrXIkVTj+dmUnmNdVB55epn8i5CY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179553872885455.16804918146181;
	Tue, 24 Nov 2026 08:45:28 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:34 +0800
Subject: [PATCH v4 6/9] HID: haptic: Convert simple methods into static
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
Message-Id: <20261125-hid-haptic-kmod-v4-6-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
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
 drivers/hid/hid-haptic.c | 111 ---------------------------------------
 drivers/hid/hid-haptic.h | 131 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 104 insertions(+), 138 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index ba3d94fb9334..cbe834a77fd4 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -10,104 +10,6 @@
 
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
-	if (IS_ERR_OR_NULL(haptic->input_dev) ||
-	    !hid_haptic_connected_to_input(haptic, hi->input) ||
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
@@ -537,16 +439,3 @@ int hid_haptic_init(struct hid_device *hdev,
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
index 7878cd73ccdb..fd7093e1764a 100644
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
+					   struct hid_haptic_device *haptic, struct hid_input *hi,
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
+	if (IS_ERR_OR_NULL(haptic->input_dev) ||
+	    !hid_haptic_connected_to_input(haptic, hi->input) ||
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

