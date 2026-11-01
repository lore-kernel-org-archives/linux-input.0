Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554926;
	b=jrg/HUplU7VsmN4wfZ5os9tIW6qn/dvXCAsmS0TFnscKoxjUS5Td3g7boRxzUokHvsgn
	 Qu5Vl0IlvAptFeVKEkLMpw02znYv90+0UqaMoFEiI4yplFLu6Xd+8kkBJ8N8q4c3VPv5Q
	 LakwLE6F4240XVmbZ4AvEiY7uhFEclKrXpBLsv93ujEN96qNNucpW51kERy/9W0E+DyXJ
	 Keg2YLdzIJIguEUQ/bDDaGmf/WYtIL3zDGgSFUE1RYFCbJlfJ/4i7QiCNi74SrGntrUw+
	 FI1lGACqXxjRs7brn9BfuiSHFl3kwotH7RJ31XH+5Mp+5eIXAxAjVAokYYs80NEo2Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554926;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=DY54u/WILFKyMZKlw6oGU4omBxkvg7WXwo9hrBUQuvs=;
	b=lmkS45L30pgVxEo0QuHA5SSaXgyONsQ37Zv6d4QavxxdVLH6uAz2uQ28taJepP6bbjjG
	 suQTT58Ff8nUN9cQqPv1FEHODhpBUU0Qj5h/7GIKbpY11oA0HyfnIjln5ZCAVYqRH6BJB
	 jrqzxBNOZglTTxi8SC7i1e5AOyIx2Y5VpvkYlYVhY7jDGOF7YRdUhJXyUJLyXksmlinTr
	 nRCfZ62k6muQ15Ms35xw8mZ4o4PrLz1t+/BBDxPGOb1RWDP7FmGdMIp6U3BaMy2zCUfWZ
	 qkMm5mXywEXS27/GSW+dAeN6yc80nKwwCz2bt0UDB0OwBxRaFUfnCVn0HFUmimgdDZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=D62qvW55;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.105
Received: from sender5-pp-e105.zoho.com (sender5-pp-e105.zoho.com [165.173.182.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B55606A327;
	Sun,  1 Nov 2026 17:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0B55606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=D62qvW55
ARC-Seal: i=1; a=rsa-sha256; t=1793554897; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oLRaf38WydJfmWR8xkB0m7VKMb8LxqeZEjgEWFqYmj/Z+6/ji5hKFSC96DTF1pfo76UCA9dWY3BsOyOKNPeySzM42wnT+Aqz5haGynPUsP11jgjWr9nQ8EZhlD2AoAhFKZLCN9r6WVTe5f7cst8HhD5cMtqz9mGJW9TTA8cOGy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554897; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DY54u/WILFKyMZKlw6oGU4omBxkvg7WXwo9hrBUQuvs=; 
	b=e0vd1iHC4MhTOBujEh07Qay1CqxY2bE4f7kZKO3YT/mFkUoY+Kka350TajayOhhlTVhrf8+UAEYW41+dRZd517jKoamrJ/tLmhpKI3YwAjUSZUqB4UWfTdYkyDeHTBG3dq/lJ91QpIR2qmSW3E/eABwtCCr9Lt9ZjyaRXKBlywE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=D62qvW55/TqCJcgnGyN820oANwEB97Gtn8G0BFExI341dY/WjsMIN9OXjtVjSW8v7FForYKbGan529gBFR3Ym+S4JbB1riA7WuV/yRpV2n/dtfT2xguyJutEOtcqxHaN7HdH89xMeSeIhvZBycM+oK9TX+/dL/QD7qtiAUZTZkuqw9+lk0xzb30wx7PeB4oKKMYp2ZLyJdzkiK4lW80zkJHME0YSZ7aTIPYqTZebfH40BPWvfli5XNu8c+u3Z+rzP4gUFVPTKl6eGPhj8B23an9A4dgs2BUDbSAkRaDShzuoea8jNg/WyMBxokWmq0vEJVSaU6fGwpVp6wFJf+cNzQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=DY54u/WILFKyMZKlw6oGU4omBxkvg7WXwo9hrBUQuvs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793554895357322.87931089371625;
	Sun, 1 Nov 2026 09:41:35 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:20 +0800
Subject: [PATCH 3/9] HID: haptic, multitouch: Check haptic prerequisite
 properly
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
Message-Id: <20261102-hid-haptic-kmod-v1-3-a3de5626dade@rong.moe>
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

The td->is_haptic_touchpad boolean is multiplexed through during the
probe- and run-time procedures of hid-multitouch. However, the way it
flips is fragile on faulty devices.

MT touchpads have multiple HID_DG_TIPPRESSURE usages, but the
td->is_haptic_touchpad only depends on the last usage, and doesn't check
if all usages have the same critical annotations. Moreover, if the HID
device happens to have multiple HID_DG_TOUCHPAD applications, the haptic
device may be initialized more than once.

Fix them by storing the relevant HID_DG_TOUCHPAD input device (must have
a pressure sensor) during hid_haptic_check_pressure_unit(), with proper
sanity checks that reject annotation mismatches and duplicated input
devices. Later, hid_haptic_input_configured() continues the
initialization only if the input device matches the previously stored
one.

With that, the td->is_haptic_touchpad is converted into a one-way (false
=> true) flipping manner. All calls to hid_haptic_*() during the
probe-time procedures are now guarded by the nullability of td->haptic
instead of td->is_haptic_touchpad or no guard, preparing to skip
allocating td->haptic in !CONFIG_HID_HAPTIC builds in the following
changes.

Fixes: 7939f787f450 ("HID: haptic: move FF initialization into .input_configured()")
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.c     | 64 ++++++++++++++++++++++++++------------------
 drivers/hid/hid-haptic.h     | 23 +++++++---------
 drivers/hid/hid-multitouch.c | 30 ++++++++++-----------
 3 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 9cbacc827dc9..27cc8a2d9b59 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -48,17 +48,40 @@ void hid_haptic_feature_mapping(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(hid_haptic_feature_mapping);
 
-bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 				    struct hid_input *hi, struct hid_field *field)
 {
-	if (field->unit == HID_UNIT_GRAM || field->unit == HID_UNIT_NEWTON) {
-		haptic->force_logical_minimum = field->logical_minimum;
-		haptic->force_physical_minimum = field->physical_minimum;
-		haptic->force_resolution = input_abs_get_res(hi->input,
-							     ABS_MT_PRESSURE);
-		return true;
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
 	}
-	return false;
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
+	return;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_check_pressure_unit);
 
@@ -78,28 +101,16 @@ int hid_haptic_input_mapping(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_mapping);
 
-int hid_haptic_input_configured(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_input *hi)
+bool hid_haptic_input_configured(struct hid_device *hdev,
+				 struct hid_haptic_device *haptic, struct hid_input *hi)
 {
-	int error;
-
-	if (hi->application != HID_DG_TOUCHPAD)
-		return -1;
-
-	if (!haptic->auto_trigger_report || !haptic->manual_trigger_report)
-		return 0;
+	if (IS_ERR_OR_NULL(haptic->input_dev) || haptic->input_dev != hi->input ||
+	    !haptic->auto_trigger_report || !haptic->manual_trigger_report)
+		return false;
 
 	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
 
-	error = hid_haptic_init(hdev, haptic, hi->input);
-	if (error) {
-		dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
-			 hdev->name);
-		return 0;
-	}
-
-	return 1;
+	return hid_haptic_init(hdev, haptic, hi->input) == 0;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
 
@@ -539,6 +550,7 @@ int hid_haptic_init(struct hid_device *hdev,
 put_device:
 	put_device(&hdev->dev);
 exit:
+	dev_warn(&hdev->dev, "Cannot allocate haptic for %s: %d\n", hdev->name, ret);
 	module_put(THIS_MODULE);
 	return ret;
 }
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 6332991a7844..1c11fcbc76f8 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -33,12 +33,11 @@ struct hid_haptic_device {
 	struct mutex auto_trigger_mutex;
 	struct workqueue_struct *wq;
 	struct hid_report *manual_trigger_report;
+	struct hid_field *pressure_field;
 	struct mutex manual_trigger_mutex;
 	size_t manual_trigger_report_len;
 	int pressed_state;
 	s32 pressure_sum;
-	s32 force_logical_minimum;
-	s32 force_physical_minimum;
 	s32 force_resolution;
 	u32 mode;
 	u32 default_auto_trigger;
@@ -59,16 +58,15 @@ void hid_haptic_feature_mapping(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_field *field, struct hid_usage
 				*usage);
-bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 				    struct hid_input *hi, struct hid_field *field);
 int hid_haptic_input_mapping(struct hid_device *hdev,
 			     struct hid_haptic_device *haptic,
 			     struct hid_input *hi,
 			     struct hid_field *field, struct hid_usage *usage,
 			     unsigned long **bit, int *max);
-int hid_haptic_input_configured(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_input *hi);
+bool hid_haptic_input_configured(struct hid_device *hdev,
+				 struct hid_haptic_device *haptic, struct hid_input *hi);
 int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
 		    struct input_dev *dev);
 void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
@@ -83,11 +81,9 @@ void hid_haptic_feature_mapping(struct hid_device *hdev,
 				*usage)
 {}
 static inline
-bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
+void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 				    struct hid_input *hi, struct hid_field *field)
-{
-	return false;
-}
+{}
 static inline
 int hid_haptic_input_mapping(struct hid_device *hdev,
 			     struct hid_haptic_device *haptic,
@@ -98,11 +94,10 @@ int hid_haptic_input_mapping(struct hid_device *hdev,
 	return 0;
 }
 static inline
-int hid_haptic_input_configured(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_input *hi)
+bool hid_haptic_input_configured(struct hid_device *hdev,
+				 struct hid_haptic_device *haptic, struct hid_input *hi)
 {
-	return 0;
+	return false;
 }
 static inline
 void hid_haptic_reset(struct hid_device *hdev, struct hid_haptic_device *haptic)
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c4d238..d744ccc3e0b0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -605,7 +605,8 @@ static void mt_feature_mapping(struct hid_device *hdev,
 		break;
 	}
 
-	hid_haptic_feature_mapping(hdev, td->haptic, field, usage);
+	if (td->haptic)
+		hid_haptic_feature_mapping(hdev, td->haptic, field, usage);
 }
 
 static void set_abs(struct input_dev *input, unsigned int code,
@@ -962,9 +963,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_TIPPRESSURE:
 			set_abs(hi->input, ABS_MT_PRESSURE, field,
 				cls->sn_pressure);
-			td->is_haptic_touchpad =
-				hid_haptic_check_pressure_unit(td->haptic,
-							       hi, field);
+			if (td->haptic)
+				hid_haptic_check_pressure_unit(td->haptic, hi, field);
 			MT_STORE_FIELD(p);
 			return 1;
 		case HID_DG_SCANTIME:
@@ -1554,10 +1554,11 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (field->physical == HID_DG_STYLUS)
 		hi->application = HID_DG_STYLUS;
 
-	ret = hid_haptic_input_mapping(hdev, td->haptic, hi, field, usage, bit,
-				       max);
-	if (ret != 0)
-		return ret;
+	if (td->haptic) {
+		ret = hid_haptic_input_mapping(hdev, td->haptic, hi, field, usage, bit, max);
+		if (ret)
+			return ret;
+	}
 
 	/* let hid-core decide for the others */
 	return 0;
@@ -1955,14 +1956,11 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct hid_report *report;
 	int ret;
 
-	if (td->is_haptic_touchpad && (td->mtclass.name == MT_CLS_WIN_8 ||
-	    td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
-	    td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
-		if (hid_haptic_input_configured(hdev, td->haptic, hi) == 0)
-			td->is_haptic_touchpad = false;
-	} else {
-		td->is_haptic_touchpad = false;
-	}
+	if (td->haptic && !td->is_haptic_touchpad &&
+	    (td->mtclass.name == MT_CLS_WIN_8 ||
+	     td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
+	     td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE))
+		td->is_haptic_touchpad = hid_haptic_input_configured(hdev, td->haptic, hi);
 
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
 		rdata = mt_find_report_data(td, report);

-- 
2.55.0

