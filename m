Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554951;
	b=D74YjzU/yq9XuRRRc7ZOgVYp2qKBaZ/XpIpzDAKeS6pLUxgFmgoG8QZtyOznPcHoEnCG
	 nbt1z41G6Qg3nmkJZmAbuNXGsalYC+QrItPfR4pP0HJES4BjTncgpqiV/lHLEFNyw0zpY
	 8/i9T5o2hzGmWfRbkbIvKuAKbHhNXoOkjAt903WDmiUDHjZgwe2u9sbW7GxatOUBqLoTM
	 kLw8yGTWa8J9hdgVxEyj6w7KPAsEwluFr2Lfrh3MrRgn1BOkrWcbV9Eq3dya/JhuRHSkQ
	 WPFqaDAzThRV5YkrV2hx3AM7xgIPDuNgtMR5J06C4TeupC9xutYDtjsMcHjnOC3GBCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554951;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=adfDJh0tcXAHMBvP4gSyNCMGARRuUWUsz7stG81M0fk=;
	b=Ca9t8wQ2zIrIP6Z0fnkCWUKNUQwzHen9kpfjfCkcmKnw7QGQ3w54rbrLEGklr3CRqJhx
	 KoaJ/DJTuIoEjDH0Ba8ALLM8w+YLJekdAeSHvAA90aBzrcTKPkFaSm3OmSD4BjLQ7jd/a
	 cLe7upc6dMXp+NlaK2ik4yFDadAvGgCANa37Kv0wPO1k8Phwio7ALvZ8ioQuPR/+iwVbB
	 CXZeZQcb9KlXzlRC1OrtDvl3q6Oro6Gyvg1e0cw5BjYFneoAPqTkdhuyWBBso/Q5kP+pd
	 D5B33HeWw//6P+Bf03fgL6hgKb3qbqUKsb5DlKT0+4aGqEcEogT+CPS0nP7gseUxx4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Z13K++Fp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71CC606A324;
	Sun,  1 Nov 2026 17:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D71CC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Z13K++Fp
ARC-Seal: i=1; a=rsa-sha256; t=1793554905; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nxau5Oej0oMOXax2+1kJT11aU/maMUL9xKhc6lRYBTjJv9aN6mJ8xLUzVJ9rGjJbyrpfLYeKoy0AVKHfRhBp7sXNyRLLtGOiGJi6iL/Bjj1Lh56zlMkSJZo7d/xz2ZmQb6MTqjEpNeqcqohOdcatnb9PcZsT5b2PgZ4biDMCsAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554905; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=adfDJh0tcXAHMBvP4gSyNCMGARRuUWUsz7stG81M0fk=; 
	b=DrFIiU1JY68F5dCttwsMyN6rN10GJVAL/02Mbk1ruUGMqZrm8F2VN97pxBSL6O+60r6ZAnCNv8k1oMn9zZwmkdQqsMQuuiuzxqKfBNmJWXjSXxIgwIM5VTPWRtZFyCBTWGMxQY2cjtcTbIf+FjVtRl1fX8oCr7XNx+Og4YIw2ig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=Z13K++Fpchl/yFNnsRlwDxo0Gc0/eRuwExsAFlVzJDgb0XWmZdIEiLVzE84p9x6b9o6suowJEI87bsBjwO373wwdH9bMe0HMdHJyjkiLIR14g9gXZdDX4CpWf6eb6osU8ObrKQdFijaY3ZtadK4BzDSQQVrcR0lpModIzvbI4pS1bVc4ZmnvEfOH0RqXZfuaf6R7iRVmXD9HvT7XHDRhEt8UMojwtTYhq91T/fTj0Qns6dcGcUpQoKVqg6cAuf65fHSJKjL0m2qMV22OBRBET3wbJgWxvsFc2J/B3CJh8nMc0fR88WuIqMHqtVKHTeAHDo26dASXO2uVzk8HjtnYDA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=adfDJh0tcXAHMBvP4gSyNCMGARRuUWUsz7stG81M0fk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793554903565516.6552086867458;
	Sun, 1 Nov 2026 09:41:43 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:23 +0800
Subject: [PATCH 6/9] HID: haptic: Convert simple methods into static inline
 ones
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
Message-Id: <20261102-hid-haptic-kmod-v1-6-a3de5626dade@rong.moe>
References: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
In-Reply-To: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Denose <jdenose@google.com>, Angela Czubak <aczubak@google.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-6be7c
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
 drivers/hid/hid-haptic.h | 130 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 103 insertions(+), 137 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 37b3eaf110ea..dcecb89e8fd5 100644
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
-	/* Don't care about input devices with no pressure sensor. */
-	if (field->unit != HID_UNIT_GRAM && field->unit != HID_UNIT_NEWTON)
-		return;
-
-	if (IS_ERR(haptic->input_dev))
-		return;
-
-	if (!haptic->input_dev) {
-		haptic->input_dev = hi->input;
-		haptic->pressure_field = field;
-		haptic->force_resolution = input_abs_get_res(hi->input, ABS_MT_PRESSURE);
-		return;
-	}
-
-	if (haptic->input_dev == hi->input &&
-	    haptic->pressure_field->unit == field->unit &&
-	    haptic->pressure_field->logical_minimum == field->logical_minimum &&
-	    haptic->pressure_field->physical_minimum == field->physical_minimum &&
-	    haptic->force_resolution == input_abs_get_res(hi->input, ABS_MT_PRESSURE))
-		return;
-
-	/*
-	 * Reject if:
-	 * - there are multiple input devices with pressure sensors
-	 * - the pressure annotation mismatches
-	 */
-	haptic->input_dev = ERR_PTR(-EPROTO);
-	return;
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
@@ -557,16 +460,3 @@ int hid_haptic_init(struct hid_device *hdev,
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
index 32f3c9304be3..d09068689a5e 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -68,25 +68,111 @@ static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev
 	return haptic;
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
+	/* Don't care about input devices with no pressure sensor. */
+	if (field->unit != HID_UNIT_GRAM && field->unit != HID_UNIT_NEWTON)
+		return;
+
+	if (IS_ERR(haptic->input_dev))
+		return;
+
+	if (!haptic->input_dev) {
+		haptic->input_dev = hi->input;
+		haptic->pressure_field = field;
+		haptic->force_resolution = input_abs_get_res(hi->input, ABS_MT_PRESSURE);
+		return;
+	}
+
+	if (haptic->input_dev == hi->input &&
+	    haptic->pressure_field->unit == field->unit &&
+	    haptic->pressure_field->logical_minimum == field->logical_minimum &&
+	    haptic->pressure_field->physical_minimum == field->physical_minimum &&
+	    haptic->force_resolution == input_abs_get_res(hi->input, ABS_MT_PRESSURE))
+		return;
+
+	/*
+	 * Reject if:
+	 * - there are multiple input devices with pressure sensors
+	 * - the pressure annotation mismatches
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
 
 static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev, gfp_t gfp)
@@ -120,22 +206,12 @@ bool hid_haptic_input_configured(struct hid_device *hdev,
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

