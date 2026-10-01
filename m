Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CC47255C
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893432; cv=none; b=V0ZZSFW2s0DGRPDPO+zVi7TKiQJlCrIh6HfI0yfxr9tcH7bUIUK+OA4iFxtaiRgqytQkyNCEfL4RBEdpss86X4kuS2Fbb1vtFJA/ZODDdbxlHaHRxl6KMsmr28eGf6P051fpqzH1v2wOUl/O6zDLQmu0p8jvoM+zVzfyUlAN3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893432; c=relaxed/simple;
	bh=x/e7yl7s008BSTuPC74pXBWvyM9+VoR6pKRHyo0aohM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rp4uxDAad5FFpjXoh+CVhsRFOmM9fZQ/T4DxY7Nj3PprUP9A5kW/m3+NdNHKIYn7N0Nr8BybS64r/XxkwIbVUnPGm5hsB1hmScrbvzEQg5YIEKJpMwz3cbeq+wn38ZLH2z6+jHhyQJJ1cSU0Y9m71F5LFeCWNGh+cRSH4jQp1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPqAqikl; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPqAqikl"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19959791so3208245a12.3
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790893428; x=1791498228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+id7PyiU+adIvbfICPLwOsQXEP7V5BiOEh7awbxMJQ=;
        b=lPqAqiklUHdyr3ZpPwN0B3wzZ5ZRVQVmh5YIsMACayIWap771iMfdKHIhnmOP4Woxw
         aNG3zkkzUPeWbssy+mUfa1tEnEkonxbfFHsXAEcW5zqzTwTsAZyD6VSrxwbhjpe+4+Ye
         Kp+g0B9SnCRsSk1lMR0JrdcirxUSJCMrkd5Fiwt73yRQxhMbUI4krXHTQAnsnSYmFVQi
         SzSXNKvtVeqQPJDsaSRGS53YlmXROaYiLaqdMfhNF1FVOiAXVZfUL0tlGj+X8fRvbArW
         lcl+lUA7Wykhu4QjBwQUzC4wHeLaV2LzOOilFo4w7BxJZoHt+DMFk51C5vkstn6EVdtL
         LT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790893428; x=1791498228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+id7PyiU+adIvbfICPLwOsQXEP7V5BiOEh7awbxMJQ=;
        b=k+cElt1Eoo4M5X3laDCS2j1f+O97rEeIM59zWngy52zfByIK3DU12MB4Zy7oRjqcgq
         vZQJWZfACKfA/5VLRJi5zEfyGUE31ywn+BhQoIRqdW2lBew/hR7pwaL5Xs9DfzCAYJjc
         iQC7lOcisy97iwOCo4e6Q/QeuzOq2wqZuB2hOLkLQSqJUlanYymIZ0yTcgzXDpuyVqla
         6klejzxMTWWF4lsnaLctbW1KR57d6DTYTzFWPdgmd+ED9LLZ2uxhe05nQRCMabkofoXu
         sShD9NxKOMOLrZUXHqUj4RXCycibix0yiOb/zykjZunpxKzGU9F7I+GJQNcDw6sk8Cnc
         an7g==
X-Forwarded-Encrypted: i=1; AKwUvByTcri5I78L94cWDbihTsyeQDfOD0AX8k9dTUM/IDuMTJRCnh/3qQLlh/d3gHEGjXWrkF3eFK55a20/rQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzFnwUwHbyPDFde4o+fptWpOUqJjVYhQpj+P/TleagtyWapY8h
	VztNxuPIbocCOiRaawSwjCtPxylGONjm8YICZ6ASKYardg4GqTHZ1zKG
X-Gm-Gg: AYBFou0mNVQl4GmRgLQdlECcUp6YwM4Nr8LGDGB9qajWnJPT+hNbx0PSEQH+apoBs/u
	YIsO22Is0Heeq8Bg+uORbxTF/gwgL6ct6SPksfEHLkery5zXAxe+8ttXfjIKU5YYz4tBdxc++jG
	29Fi36pF/Itvcb5Bcrmf6/k4DXP4vnUjEgqVr+vJprxsnVewSi+VXFXRxdd4yZozeC+xKEn+7rg
	U6YgdLrOq+uf6ilDfSbjEQXHtrnJW3Kj4rXv+I5W2cPRwjsbqQVVqVoP/dtiSsQtsXZdwEEpbOR
	nuCTDTgNFnEK2y6sdFbAtdsl8479D71Tib8ylutDMnMggJ2Zyy4PwrKdQsM9yhNUmy0L0UK5XZn
	KiW3P4jX37BpmnOvwg+AbzwfmeXMMKS2BQgZns5YSlaLJSapEqz1gKBfX0E1jxm/ZdskugfAJQ7
	Tw7uGWWGCVhMjxSdeRkvG0RjrVjzOz20UV4L02KPklLuW7er5LSQSSBN2hO1cmQyhTop2N9WU7d
	kJhgydzjZ5mz7BSKmzNt5bQBcrvb55lpdR06fD/a3w=
X-Received: by 2002:a05:6402:21ca:b0:6a9:9766:59ad with SMTP id 4fb4d7f45d1cf-6af9e33b4e6mr300424a12.43.1790893427996;
        Thu, 01 Oct 2026 15:23:47 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d87399esm238935a12.9.2026.10.01.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:23:46 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Date: Fri, 02 Oct 2026 00:23:36 +0200
Subject: [PATCH RFC 2/4] HID: logitech: handle HID++ thumbwheel reports
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-bolt-input-rfc-v1-2-333e1f350586@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790893419; l=14730;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=x/e7yl7s008BSTuPC74pXBWvyM9+VoR6pKRHyo0aohM=;
 b=6NyJyC4afN7mKDb/EwQaD6Xiwz+UmJxwEtKOrIQbQ2wJmx9refGzhf2PnEGzpzrKgZvoZ/lsh
 7B5XOJlWPYnCnjNHGHcwHz3tfk52lCzOE4uiJ/QXJGUCb7Iyfhgxmq1
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

Add support for HID++ thumbwheel reports on devices that support the 0x2150
feature. Read resolution and default direction. For Bolt devices, default
to diverting thumbwheel reports to HID++ to get device index support, so
source device is identifiable.

Generalize the scroll handling to support the thumbwheel events in addition
to the already supported vertical scroll events.

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 217 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 192 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ff6a1095e7ba..464685ad21bb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -23,6 +23,8 @@
 #include <linux/workqueue.h>
 #include <linux/atomic.h>
 #include <linux/fixp-arith.h>
+#include <linux/limits.h>
+#include <linux/math64.h>
 #include <linux/unaligned.h>
 #include "usbhid/usbhid.h"
 #include "hid-ids.h"
@@ -98,6 +100,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL	BIT(8)
 #define HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL	BIT(9)
 #define HIDPP_CAPABILITY_ADC_MEASUREMENT	BIT(10)
+#define HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL	BIT(11)
 
 #define lg_map_key_clear(c)  hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
 
@@ -165,15 +168,21 @@ struct hidpp_battery {
 /**
  * struct hidpp_scroll_counter - Utility class for processing high-resolution
  *                             scroll events.
- * @wheel_multiplier: the scalar multiplier to be applied to each wheel event
+ * @scale_numerator: numerator of normal scroll steps per device count
+ * @scale_denominator: denominator of normal scroll steps per device count
  * @remainder: counts the number of high-resolution units moved since the last
  *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
  *             only be used by class methods.
  * @direction: direction of last movement (1 or -1)
  * @last_time: last event time, used to reset remainder after inactivity
+ *
+ * One device count represents scale_numerator / scale_denominator normal
+ * scroll steps: 1 / wheel_multiplier for a vertical wheel, or native_res /
+ * diverted_res for a diverted thumbwheel.
  */
 struct hidpp_scroll_counter {
-	int wheel_multiplier;
+	u16 scale_numerator;
+	u16 scale_denominator;
 	int remainder;
 	int direction;
 	unsigned long long last_time;
@@ -206,6 +215,7 @@ struct hidpp_device {
 
 	struct hidpp_battery battery;
 	struct hidpp_scroll_counter vertical_wheel_counter;
+	struct hidpp_scroll_counter thumbwheel_counter;
 
 	u8 wireless_feature_index;
 	u8 reprog_controls_feature_index;
@@ -215,6 +225,8 @@ struct hidpp_device {
 	u8 hires_wheel_feature_index;
 	bool hires_wheel_has_invert;
 	bool hires_wheel_invert;
+	u8 thumbwheel_feature_index;
+	bool thumbwheel_positive_right;
 
 	bool connected_once;
 };
@@ -544,28 +556,42 @@ static void hidpp_update_usb_wireless_status(struct hidpp_device *hidpp)
 
 /**
  * hidpp_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
- *                                        events given a high-resolution wheel
- *                                        movement.
+ *                                        events given a wheel movement.
  * @input_dev: Pointer to the input device
- * @counter: a hid_scroll_counter struct describing the wheel.
- * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
- *                units.
+ * @counter: a hidpp_scroll_counter struct describing the wheel.
+ * @value: the movement of the wheel, in the device's reporting units.
+ * @hi_res_code: high-resolution event code for this wheel axis.
+ * @low_res_code: low-resolution event code for this wheel axis.
  *
- * Given a high-resolution movement, this function converts the movement into
+ * Given a wheel movement, this function converts the movement into
  * fractions of 120 and emits high-resolution scroll events for the input
- * device. It also uses the multiplier from &struct hid_scroll_counter to
- * emit low-resolution scroll events when appropriate for
- * backwards-compatibility with userspace input libraries.
+ * device. It also uses the counter to emit low-resolution scroll events
+ * when appropriate for backwards-compatibility with userspace input
+ * libraries.
+ *
+ * Return: true if a nonzero scroll event was reported
  */
-static void hidpp_scroll_counter_handle_scroll(struct input_dev *input_dev,
+static bool hidpp_scroll_counter_handle_scroll(struct input_dev *input_dev,
 					       struct hidpp_scroll_counter *counter,
-					       int hi_res_value)
+					       int value,
+					       unsigned int hi_res_code,
+					       unsigned int low_res_code)
 {
+	s64 scaled;
+	int hi_res_value;
 	int low_res_value, remainder, direction;
 	unsigned long long now, previous;
 
-	hi_res_value = hi_res_value * 120/counter->wheel_multiplier;
-	input_report_rel(input_dev, REL_WHEEL_HI_RES, hi_res_value);
+	if (!counter->scale_denominator)
+		return false;
+
+	scaled = div_s64((s64)value * 120 * counter->scale_numerator,
+			 counter->scale_denominator);
+	if (!scaled || scaled > INT_MAX - 120 || scaled < INT_MIN + 120)
+		return false;
+	hi_res_value = scaled;
+
+	input_report_rel(input_dev, hi_res_code, hi_res_value);
 
 	remainder = counter->remainder;
 	direction = hi_res_value > 0 ? 1 : -1;
@@ -599,10 +625,11 @@ static void hidpp_scroll_counter_handle_scroll(struct input_dev *input_dev,
 		low_res_value = remainder / 120;
 		if (low_res_value == 0)
 			low_res_value = (hi_res_value > 0 ? 1 : -1);
-		input_report_rel(input_dev, REL_WHEEL, low_res_value);
+		input_report_rel(input_dev, low_res_code, low_res_value);
 		remainder -= low_res_value * 120;
 	}
 	counter->remainder = remainder;
+	return true;
 }
 
 /* -------------------------------------------------------------------------- */
@@ -2104,6 +2131,47 @@ static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
 					   params, sizeof(params), &response);
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x2150: Thumbwheel                                                         */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_THUMBWHEEL			0x2150
+#define CMD_THUMBWHEEL_GET_INFO			0x00
+#define CMD_THUMBWHEEL_SET_REPORTING		0x20
+#define EVENT_THUMBWHEEL			0x00
+
+static int hidpp_thumbwheel_get_info(struct hidpp_device *hidpp,
+				    u16 *native_res, u16 *diverted_res,
+				    bool *positive_right)
+{
+	struct hidpp_report response;
+	int ret;
+
+	ret = hidpp_send_fap_command_sync(hidpp,
+					  hidpp->thumbwheel_feature_index,
+					  CMD_THUMBWHEEL_GET_INFO,
+					  NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	*native_res = get_unaligned_be16(&response.fap.params[0]);
+	*diverted_res = get_unaligned_be16(&response.fap.params[2]);
+	*positive_right = response.fap.params[4] & BIT(0);
+	return 0;
+}
+
+static int hidpp_thumbwheel_set_reporting(struct hidpp_device *hidpp,
+					 bool diverted)
+{
+	struct hidpp_report response;
+	u8 params[2] = { diverted, 0 }; /* No inversion. */
+
+	return hidpp_send_fap_command_sync(hidpp,
+					   hidpp->thumbwheel_feature_index,
+					   CMD_THUMBWHEEL_SET_REPORTING,
+					   params, sizeof(params), &response);
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x4301: Solar Keyboard                                                     */
 /* -------------------------------------------------------------------------- */
@@ -3323,7 +3391,8 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		v = sign_extend32(data[6], 7);
 		if (v != 0)
 			hidpp_scroll_counter_handle_scroll(hidpp->input,
-					&hidpp->vertical_wheel_counter, v);
+					&hidpp->vertical_wheel_counter, v,
+					REL_WHEEL_HI_RES, REL_WHEEL);
 
 		input_sync(hidpp->input);
 	}
@@ -3931,7 +4000,8 @@ static void hidpp_hrw_update_wheel_mode(struct hidpp_device *hidpp,
 	bool invert, bool high_resolution)
 {
 	hidpp->hires_wheel_invert = invert;
-	hidpp->vertical_wheel_counter.wheel_multiplier =
+	hidpp->vertical_wheel_counter.scale_numerator = 1;
+	hidpp->vertical_wheel_counter.scale_denominator =
 		(high_resolution && hidpp->hires_wheel_multiplier > 0) ?
 		hidpp->hires_wheel_multiplier : 1;
 }
@@ -3986,10 +4056,12 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	}
 
 	hidpp->hires_wheel_multiplier = multiplier;
-	hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
 		hidpp->hires_wheel_has_invert = has_invert;
 		hidpp_hrw_update_wheel_mode(hidpp, false, true);
+	} else {
+		hidpp->vertical_wheel_counter.scale_numerator = 1;
+		hidpp->vertical_wheel_counter.scale_denominator = multiplier;
 	}
 	hid_dbg(hidpp->hid_dev, "wheel multiplier = %d\n", multiplier);
 	return 0;
@@ -4033,6 +4105,49 @@ static int hidpp_initialize_hires_scroll(struct hidpp_device *hidpp)
 	return 0;
 }
 
+static void thumbwheel_scroll_enable(struct hidpp_device *hidpp)
+{
+	bool divert;
+	int ret;
+
+	memset(&hidpp->thumbwheel_counter, 0,
+	       sizeof(hidpp->thumbwheel_counter));
+	ret = hidpp_thumbwheel_get_info(hidpp,
+			&hidpp->thumbwheel_counter.scale_numerator,
+			&hidpp->thumbwheel_counter.scale_denominator,
+			&hidpp->thumbwheel_positive_right);
+
+	/* Non-Bolt devices should default to native HID. Don't enable HID++ */
+	if (!hidpp_is_bolt_child(hidpp->hid_dev))
+		return;
+
+	/* Divert only when both resolutions are available; otherwise request
+	 * native HID reporting.
+	 */
+	divert = !ret && hidpp->thumbwheel_counter.scale_numerator &&
+		 hidpp->thumbwheel_counter.scale_denominator;
+	ret = hidpp_thumbwheel_set_reporting(hidpp, divert);
+	if (ret)
+		hid_dbg(hidpp->hid_dev,
+			"Could not set thumbwheel reporting mode: %d\n", ret);
+}
+
+static void hidpp_initialize_thumbwheel_scroll(struct hidpp_device *hidpp)
+{
+	int ret;
+
+	hidpp->capabilities &= ~HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL;
+	hidpp->thumbwheel_feature_index = 0xff;
+	if (hidpp->protocol_major < 2)
+		return;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_THUMBWHEEL,
+				     &hidpp->thumbwheel_feature_index);
+	if (ret)
+		return;
+	hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL;
+}
+
 /*
  * The low nibble of data[3] is the software ID: 0 for wheel
  * notifications, nonzero and echoed from the request for replies.
@@ -4074,7 +4189,7 @@ static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
 		/* The event flag describes whether the event is high resolution
 		 * or not.
 		 */
-		hidpp->vertical_wheel_counter.wheel_multiplier =
+		hidpp->vertical_wheel_counter.scale_denominator =
 			(data[4] & HIRES_WHEEL_EVENT_HIGH_RESOLUTION) ?
 			hidpp->hires_wheel_multiplier : 1;
 
@@ -4088,15 +4203,57 @@ static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
 		if (hidpp->hires_wheel_has_invert && hidpp->hires_wheel_invert)
 			delta = -delta;
 
-		hidpp_scroll_counter_handle_scroll(hidpp->input,
-			&hidpp->vertical_wheel_counter, delta);
-		input_sync(hidpp->input);
+		if (hidpp_scroll_counter_handle_scroll(hidpp->input,
+			&hidpp->vertical_wheel_counter, delta,
+			REL_WHEEL_HI_RES, REL_WHEEL))
+			input_sync(hidpp->input);
 		return 1;
 	}
 
 	return 0;
 }
 
+static int hidpp20_thumbwheel_raw_event(struct hidpp_device *hidpp,
+					       u8 *data, int size)
+{
+	int delta;
+
+	if (hidpp->thumbwheel_feature_index == 0xff)
+		return 0;
+
+	if (size < 6)
+		return 0;
+
+	if (data[0] != REPORT_ID_HIDPP_LONG ||
+	    data[2] != hidpp->thumbwheel_feature_index)
+		return 0;
+
+	if (data[3] != EVENT_THUMBWHEEL)
+		return 0;
+
+	if (!hidpp->input || !hidpp->thumbwheel_counter.scale_numerator ||
+	    !hidpp->thumbwheel_counter.scale_denominator)
+		return 1;
+
+	/* The specification calls this scroll delta "rotation". The event also
+	 * carries rotation_status, touch, proximity and single_tap data which
+	 * may be exposed in the future.
+	 */
+	delta = (s16)get_unaligned_be16(&data[4]);
+	if (!delta)
+		return 1;
+
+	/* Linux reports left as negative and right as positive. */
+	if (!hidpp->thumbwheel_positive_right)
+		delta = -delta;
+
+	if (hidpp_scroll_counter_handle_scroll(hidpp->input,
+			&hidpp->thumbwheel_counter, delta,
+			REL_HWHEEL_HI_RES, REL_HWHEEL))
+		input_sync(hidpp->input);
+	return 1;
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -4323,6 +4480,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 			return ret;
 	}
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL) {
+		ret = hidpp20_thumbwheel_raw_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -4396,10 +4559,11 @@ static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
 	 */
 	if (!(hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 	    || value == 0 || hidpp->input == NULL
-	    || counter->wheel_multiplier == 0)
+	    || counter->scale_denominator == 0)
 		return 0;
 
-	hidpp_scroll_counter_handle_scroll(hidpp->input, counter, value);
+	hidpp_scroll_counter_handle_scroll(hidpp->input, counter, value,
+					   REL_WHEEL_HI_RES, REL_WHEEL);
 	return 1;
 }
 
@@ -4664,6 +4828,7 @@ static void hidpp_connect_event(struct work_struct *work)
 	hidpp_initialize_battery(hidpp);
 	if (!hid_is_usb(hidpp->hid_dev))
 		hidpp_initialize_hires_scroll(hidpp);
+	hidpp_initialize_thumbwheel_scroll(hidpp);
 
 	/* forward current battery state */
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
@@ -4687,6 +4852,8 @@ static void hidpp_connect_event(struct work_struct *work)
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_THUMBWHEEL)
+		thumbwheel_scroll_enable(hidpp);
 
 	if (!(hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */

-- 
2.55.0

