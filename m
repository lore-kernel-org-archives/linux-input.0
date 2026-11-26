Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661035;
	b=ctCVLusvR9gr0jTpi48+PbK8DviYqCpUBlrq/PGsU5RxtbP7gJt1Pyhp7Dk8/AOpn8xd
	 KT1AV+pmc9POtZEN6Mym8xhzHbPyLyU5ZSF6GfQecxCPZS6GAddNdpNJGWSZDKUwV18IP
	 8/f2Gn8K+16fsJsRGTKgzU793J1jXwLZ8nE7n6h5fzEvuuoWGEfbpYRBEHP87U7P8aL/T
	 fyF4+OZfTwUgdePX26Av188F77Yi7lNiWnYYQa39lP0IfOvC8FEnYQ/PZpMEU5o8xX7TN
	 eJPygBOwHxngIE7DzKiGqB2m+BabjdGlg0mzWD8KLbjHd6XPi4GulFbO1Cb/Z4zJG7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qdJSC7qULMaMbu4Io7XG985sK+snB5nZpP911f48H5c=;
	b=akZ2mUv0YUOZVYD2A8YKpH0GMusojw365WNRm1q1BCkXo/B96MfqG6GrWj21NadePIUc
	 OPweMPinWKmOP67pJmeOOHwVza4yqygiG409zlVUgFJrkXVXESbV62mosqK7kBQbwDt2P
	 ZKyaTHYYt85XmdJd5Hv3na2kj+k6UW1qunYnpgfnHFnh8xOK/kF96fJ50Q65C4RKUCAq3
	 Ghk0YqqooPOVHpsLVa7q9Q/fZouFdQZ9sCm2ZIH++ppijXhyI97XEcdJGtJ5DYIBGsPuf
	 BjFvQzyqa7FqH/9vwMMZmSBfYovc7HBJGRE+9zG/ChKDBeXcQdJ1MUbVJb54ujbP6+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--svv.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P6Uw0aR7;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F511606A337
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 02:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F511606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--svv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P6Uw0aR7
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386b8624cf7so3149532eec.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 18:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795661035; x=1796265835; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdJSC7qULMaMbu4Io7XG985sK+snB5nZpP911f48H5c=;
        b=P6Uw0aR776eVZOc9GwZqU1Up9nBeigWowrprYlTiX4mn/odhWykpqVdvgrl5r6zO2O
         hScS8ZzuXYaFUxv62msKbE8WlWK3Rd55b7EaL/+eveKVXqo+66unaHjGl8KSnpaXViDp
         FJ3hVUF8oN2vQYchA3E16TEfrcripQhhnHWbWKEPXY6gi1NbHLW54M1mc5MrOMRDJ3ie
         rmHWdR418rqpgNh1wu7EuNOTuzgaxUKw/6m2AIsTRQNUZgQ2QRctVypkCQ8FSYR++v0E
         fFyU9ZNE9x/tceWRXNroe22lU0+Fwrrrw13OB0s2AYvKc3QvXQt8jy7uwL/BNBlOmkzt
         qUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661035; x=1796265835;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdJSC7qULMaMbu4Io7XG985sK+snB5nZpP911f48H5c=;
        b=VSHczI20VM0QGC+R06SCR4ZIFlflpCSayK/+R5zDPkTfWi38D385VvrKRQQqybnORu
         s/Yg+x+EuovTMTlFeC1480V92TfCoVUwUb1EUbdyLes0wBgGXZGELn6AW+bWKKCkms1G
         tMq1Gji2QhChoTAgeWSMAlojx/LJU6SnBF/G0GoXV9fa1mZX91raOmw11YobtpLGJ9GP
         /zU1Te2WjK2YgMxdgJUNogSSALyEzPcJDUyixhzi+791koEU0jdL6ik/j8SP0Pf20Zz4
         SyJ0OOVggWXJg8fFL/KU95WEgoo4/UYT708Wfk4Tz4+r1U3+Iv5irq5M8kvewqt2l5mK
         eMDQ==
X-Forwarded-Encrypted: i=1; AL+hErHDsabgFXXc9Awqf4F8iPCOflAXQs5Dxy+r0AUYggLImxcAoNblYppH+S2jW3/MdORSTjiSno8VSIi0+w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/d1KMxYTtkbmZhWKqHMxOYkfluezU2yWU1PLPTcBhGraAtqsrf
	7U2xnZG4mdwW2eYcO3P7K2m2WUyY4pfMQroF5fxIOTwNJaWCscTkOYCUchsBZbrM1qVpiQ==
X-Received: from dlbur9.prod.google.com ([2002:a05:7022:ea49:b0:1b5:8701:544e])
 (user=svv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:844e:20b0:1b5:6c13:c76c
 with SMTP id a92af1059eb24-1b56c13c7a8mr14819441c88.15.1795661034423; Wed, 25
 Nov 2026 18:43:54 -0800 (PST)
Date: Wed, 25 Nov 2026 18:43:37 -0800
In-Reply-To: <20261126024337.4168845-1-svv@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126024337.4168845-1-svv@google.com>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
Message-ID: <20261126024337.4168845-4-svv@google.com>
Subject: [PATCH v2 3/3] HID: wacom: report ABS_TWIST alongside ABS_Z for pen twist
From: Siarhei Vishniakou <svv@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"

Historically, Wacom tablets reported stylus barrel rotation (twist) via
ABS_Z because a dedicated evdev axis did not exist, with the zero point
offset by +1/4 revolution so that 0 aligns with the tablet's left (-X)
edge for compatibility with legacy userspace.

Now that ABS_TWIST is defined, report pen twist on ABS_TWIST using the
standard HID coordinate system (zero at the top/-Y edge, increasing
clockwise), while keeping the shifted ABS_Z axis for backwards
compatibility with existing applications.

Signed-off-by: Siarhei Vishniakou <svv@google.com>
---
Changes since v1:
- Added comments explaining the forced angular resolution_code in
  wacom_map_usage(), the order-dependent double-mapping in
  wacom_wac_pen_usage_mapping(), and explicit ABS_Z emission in
  wacom_wac_pen_event() (Jason).
- Emit un-offset twist (zero at top/-Y, matching ABS_TWIST
  documentation and HID_DG_TWIST) on ABS_TWIST across all three pen
  rotation paths (wacom_intuos_general, wacom_intuos_pro2_bt_pen,
  wacom_wac_pen_event), while preserving the +1/4 revolution offset
  (zero at left/-X) on ABS_Z for backwards compatibility.

 drivers/hid/wacom_wac.c | 94 +++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ab89a11d6740..a57aa95b2d80 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -769,8 +769,10 @@ static void wacom_exit_report(struct wacom_wac *wacom)
 		input_report_key(input, BTN_STYLUS2, 0);
 		input_report_key(input, BTN_TOUCH, 0);
 		input_report_abs(input, ABS_WHEEL, 0);
-		if (features->type >= INTUOS3S)
+		if (features->type >= INTUOS3S) {
 			input_report_abs(input, ABS_Z, 0);
+			input_report_abs(input, ABS_TWIST, 0);
+		}
 	}
 	input_report_key(input, wacom->tool[idx], 0);
 	input_report_abs(input, ABS_MISC, 0); /* reset tool id */
@@ -943,11 +945,22 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 	case 0x05:
 		/* Rotation packet */
 		if (features->type >= INTUOS3S) {
+			int twist, rot;
+
 			/* I3 marker pen rotation */
 			t = (data[6] << 3) | ((data[7] >> 5) & 7);
-			t = (data[7] & 0x20) ? ((t > 900) ? ((t-1) / 2 - 1350) :
-				((t-1) / 2 + 450)) : (450 - t / 2) ;
-			input_report_abs(input, ABS_Z, t);
+			twist = (data[7] & 0x20) ? (int)((t - 1) / 2) :
+				-(int)(t / 2);
+			input_report_abs(input, ABS_TWIST, twist);
+
+			/*
+			 * Shift zero point from top (-Y) to left (-X) for
+			 * legacy ABS_Z compatibility.
+			 */
+			rot = twist + 450;
+			if (rot > 899)
+				rot -= 1800;
+			input_report_abs(input, ABS_Z, rot);
 		} else {
 			/* 4D mouse 2nd packet */
 			t = (data[6] << 3) | ((data[7] >> 5) & 7);
@@ -1365,10 +1378,12 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 			if (wacom->features.type == INTUOSP2_BT ||
 			    wacom->features.type == INTUOSP2S_BT) {
-				/* Fix rotation alignment: userspace expects zero at left */
-				int16_t rotation =
-					(int16_t)get_unaligned_le16(&frame[9]);
-				rotation += 1800/4;
+				s16 twist = (s16)get_unaligned_le16(&frame[9]);
+				/*
+				 * Legacy ABS_Z expects zero at left (-X), while
+				 * hardware and ABS_TWIST use zero at top (-Y).
+				 */
+				int rotation = twist + 1800 / 4;
 
 				if (rotation > 899)
 					rotation -= 1800;
@@ -1377,6 +1392,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 						 (signed char)frame[7]);
 				input_report_abs(pen_input, ABS_TILT_Y,
 						 (signed char)frame[8]);
+				input_report_abs(pen_input, ABS_TWIST, twist);
 				input_report_abs(pen_input, ABS_Z, rotation);
 				input_report_abs(pen_input, ABS_WHEEL,
 						 get_unaligned_le16(&frame[11]));
@@ -1914,9 +1930,14 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int resolution_code = code;
 	int resolution;
 
-	if (equivalent_usage == HID_DG_TWIST) {
-		resolution_code = ABS_RZ;
-	}
+	/*
+	 * HID_DG_TWIST is double-mapped to both ABS_Z (for backwards
+	 * compatibility) and ABS_TWIST. Force a radial axis code here so
+	 * hidinput_calc_abs_res() computes angular resolution (units/radian)
+	 * even when configuring ABS_Z, which it otherwise treats as linear.
+	 */
+	if (equivalent_usage == HID_DG_TWIST)
+		resolution_code = ABS_TWIST;
 
 	resolution = hidinput_calc_abs_res(field, resolution_code);
 
@@ -2385,7 +2406,16 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_TILT_Y, 0);
 		break;
 	case HID_DG_TWIST:
+		/*
+		 * Map HID_DG_TWIST twice for backwards compatibility with
+		 * legacy userspace that expects pen twist on ABS_Z. The order
+		 * matters: the latter call overwrites usage->type and
+		 * usage->code to point to ABS_TWIST, which prevents
+		 * wacom_wac_pen_event() from automatically emitting ABS_Z;
+		 * ABS_Z is emitted explicitly there instead.
+		 */
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_TWIST, 0);
 		break;
 	case HID_DG_ERASER:
 		input_set_capability(input, EV_KEY, BTN_TOOL_RUBBER);
@@ -2492,15 +2522,9 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		}
 		return;
 	case HID_DG_TWIST:
-		/* don't modify the value if the pen doesn't support the feature */
-		if (!wacom_is_art_pen(wacom_wac->id[0])) return;
-
-		/*
-		 * Userspace expects pen twist to have its zero point when
-		 * the buttons/finger is on the tablet's left. HID values
-		 * are zero when buttons are toward the top.
-		 */
-		value = wacom_offset_rotation(input, usage, value, 1, 4);
+		/* don't report twist if the pen doesn't support the feature */
+		if (!wacom_is_art_pen(wacom_wac->id[0]))
+			return;
 		break;
 	case WACOM_HID_WD_SENSE:
 		wacom_wac->hid_data.sense_state = value;
@@ -2588,10 +2612,29 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		return;
 
 	/* send pen events only when the pen is in range */
-	if (wacom_wac->hid_data.inrange_state)
+	if (wacom_wac->hid_data.inrange_state) {
 		input_event(input, usage->type, usage->code, value);
-	else if (wacom_wac->shared->stylus_in_proximity && !wacom_wac->hid_data.sense_state)
+		if (equivalent_usage == HID_DG_TWIST) {
+			/*
+			 * wacom_wac_pen_usage_mapping() double-maps
+			 * HID_DG_TWIST to both ABS_Z and ABS_TWIST, but
+			 * usage->type and usage->code can only hold one
+			 * mapping (ABS_TWIST). The input_event() above emits
+			 * ABS_TWIST using the un-offset HID value (zero when
+			 * buttons are toward the top, -Y). Also report on
+			 * ABS_Z for backwards compatibility, shifted so its
+			 * zero point is on the tablet's left (-X) as legacy
+			 * userspace expects.
+			 */
+			value = wacom_offset_rotation(input, usage, value, 1, 4);
+			input_report_abs(input, ABS_Z, value);
+		}
+	} else if (wacom_wac->shared->stylus_in_proximity &&
+		   !wacom_wac->hid_data.sense_state) {
 		input_event(input, usage->type, usage->code, 0);
+		if (equivalent_usage == HID_DG_TWIST)
+			input_report_abs(input, ABS_Z, 0);
+	}
 }
 
 static void wacom_wac_pen_pre_report(struct hid_device *hdev,
@@ -3807,6 +3850,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 		__clear_bit(BTN_TOOL_PENCIL, wacom_wac->pen_input->keybit);
 		__clear_bit(BTN_TOOL_AIRBRUSH, wacom_wac->pen_input->keybit);
 		__clear_bit(ABS_Z, wacom_wac->pen_input->absbit);
+		__clear_bit(ABS_TWIST, wacom_wac->pen_input->absbit);
 		__clear_bit(ABS_DISTANCE, wacom_wac->pen_input->absbit);
 		__clear_bit(ABS_TILT_X, wacom_wac->pen_input->absbit);
 		__clear_bit(ABS_TILT_Y, wacom_wac->pen_input->absbit);
@@ -3889,6 +3933,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case CINTIQ_COMPANION_2:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
+		input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_TWIST, 287);
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
@@ -3901,6 +3947,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case INTUOS4S:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
+		input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_TWIST, 287);
 		fallthrough;
 
 	case INTUOS:
@@ -3921,6 +3969,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
+		input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_TWIST, 287);
 
 		wacom_setup_intuos(wacom_wac);
 		break;
-- 
2.56.1.911.g883d8bcb20-goog

