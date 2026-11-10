Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276432;
	b=JKxiKbaP4zfuYNVV8W4tQFdTkZ4uhihgUDSQpCMQNkKwLLExnZ+sUc/Sxus1749sAbJW
	 sjOP4zuLsXUVSpz0h7qgCM3va4dZ+OQwzNjZs1KHKJ0WQp3a+DP9M8/CzFypTNP/wakn8
	 A94vQIqMBOwwm8iRHvBTPik1wIbzcBJIlatittbnRBZOcFpAFIHjD4Wdys9/39T1B2gQQ
	 hrR2GX6/Eu21RH+ajjJW8CZJBDC1mWUhBcPeJe9uERXVbxbtIqqiuVwi4g3kr/DWgeWtj
	 XLLfymOTfbvhdwbouBGG6sh3Zm5oTBns6AYZCTBRkVNnLWJKD+AtKegdbTeAOIMgCOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qQsJ/9pgSVKsYqZ3673A40BRQAwaP2YTgXdS7SpVQEw=;
	b=tBRM4WXQz1yOcR1lXAWdLxdITKNSV6Aq4QSowT25KVaLvViMvh708u1v3rlMLDHUkpDv
	 v7G3oSKuMlYYtwof/AtgoqPPc7FTkmxWv0mISu0LIJB/5Wsqlh1AhK4MSCQBcnQ3Skx1c
	 3yo5wOHtl7xXhq6nbInWgt/E6m1EpTo/ObAJV0pbIwF81ib+iC+KZMyPYMDgMvmqFbCPF
	 /d9MhHPqBAEhtYQD0ZlWBRbNo46/FLZ5K1YQxb/sUmYzR2oOaLg/Amc0upM8ROIBVtm8I
	 4uKxNDRUkHFRjLe1p0mPeXLYTHzyvPqVIF/ukPqdeYxOUK4eXlsxu97PfCej0dkDCKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--svv.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c0NU3g3u;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C768606A33F
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C768606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--svv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c0NU3g3u
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36fa5673fccso2937004eec.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794276430; x=1794881230; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQsJ/9pgSVKsYqZ3673A40BRQAwaP2YTgXdS7SpVQEw=;
        b=c0NU3g3ush7/biU8+xfPe774v9CMhNDBT1Ka0IVZGx2iTZWJJJUJ7D9fOQYFOTx6Dx
         4nZKNaBh9PCML+bNJCmWCztk5S49vZdyYTH0X0+V/EsVv4/dm5oyxdxPZ0Srni3/dEBs
         N9wA6gVoP5Y+sB7Te4dAMWBVyEFA8H5nLuGLBW4cK3Na1R4/i0uLvd1nItCA6QbelMfX
         QohKcrxnzjGYU2J/eo2l6FQeINihpVFdNaTfl9PNJ4oQ1SqTrb/rTOST6o5cPprQJvbU
         aq8wq+oBidEd519XXAUVWUqFsQNoMhuJnEc0lzxyVdx1vW2EgfW9etHUE3WBsScdbjr9
         VOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794276430; x=1794881230;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQsJ/9pgSVKsYqZ3673A40BRQAwaP2YTgXdS7SpVQEw=;
        b=EnWRCHlZJf2fAHaXAyNFhshTjwA7FItie1Wmh5Y7RtLn9nxbiiGRYdhITjsT8isiXs
         t8vmzBntZAnIQw0YVV+9MopNJAiCH60sd/3RJk22xAnU4JyTWsnCq8KwdtKK4ZBIqBFX
         R523EBo1Hz5TPLR/laP3SEyd1QKCqn1rf8XxHrNUXoGwTwl67SznnGJrFV53TcUAOwOz
         p2vy0uE2ImbStlAu7FKm2DdeWs2dBLG95yPdn1Wb9uU+XkmPfgqB/wu7OWIOmKt2QH16
         e3BEJ0XlWmwoL3CKqWm6N1n8C6FXiKvhQbkDXmC76bDw8wUj5jIv7PRJ/cl4TZG5IolC
         jKOg==
X-Forwarded-Encrypted: i=1; AL+hErEgQXmIN1gb1R72KLUwGqYAueJQ86+VAvCpItP7BYdyhmKotgO1J2cy9k9vNcdNsfSchzluugSkvRpiWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vM7i049toBBGiXLbwF2k9OUbWgyIdf0V4zm5quBzHUq3W+JCh
	c6a7/cIJvWKGQ4rYMaPqe5vxLyTEvM/7bdRDoHsEH7mmw/1X0VHDDceC+M1X+qKdHVMm3g==
X-Received: from dyboo18.prod.google.com ([2002:a05:7301:1e92:b0:369:739:9a00])
 (user=svv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8244:b0:351:4866:255c
 with SMTP id 5a478bee46e88-3751f9481a3mr1219703eec.32.1794276429735; Mon, 09
 Nov 2026 18:07:09 -0800 (PST)
Date: Mon,  9 Nov 2026 18:06:32 -0800
In-Reply-To: <20261110020632.4003499-1-svv@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110020632.4003499-1-svv@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110020632.4003499-4-svv@google.com>
Subject: [PATCH 3/3] HID: wacom: report ABS_TWIST alongside ABS_Z for pen twist
From: Siarhei Vishniakou <svv@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"

Historically, Wacom tablets reported stylus barrel rotation (twist)
via ABS_Z because a dedicated evdev axis did not exist. Now that we
have this axis, report pen twist on ABS_TWIST in addition to ABS_Z.

Keep reporting ABS_Z to maintain backward compatibility for existing
applications that support Wacom devices.

Signed-off-by: Siarhei Vishniakou <svv@google.com>
---
 drivers/hid/wacom_wac.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 614f2adab563..7676bc26a027 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -802,8 +802,10 @@ static void wacom_exit_report(struct wacom_wac *wacom)
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
@@ -981,6 +983,7 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 			t = (data[7] & 0x20) ? ((t > 900) ? ((t-1) / 2 - 1350) :
 				((t-1) / 2 + 450)) : (450 - t / 2) ;
 			input_report_abs(input, ABS_Z, t);
+			input_report_abs(input, ABS_TWIST, t);
 		} else {
 			/* 4D mouse 2nd packet */
 			t = (data[6] << 3) | ((data[7] >> 5) & 7);
@@ -1411,6 +1414,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 				input_report_abs(pen_input, ABS_TILT_Y,
 						 (signed char)frame[8]);
 				input_report_abs(pen_input, ABS_Z, rotation);
+				input_report_abs(pen_input, ABS_TWIST, rotation);
 				input_report_abs(pen_input, ABS_WHEEL,
 						 get_unaligned_le16(&frame[11]));
 			}
@@ -1935,7 +1939,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int resolution;
 
 	if (equivalent_usage == HID_DG_TWIST) {
-		resolution_code = ABS_RZ;
+		resolution_code = ABS_TWIST;
 	}
 
 	resolution = hidinput_calc_abs_res(field, resolution_code);
@@ -2332,6 +2336,7 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		break;
 	case HID_DG_TWIST:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_TWIST, 0);
 		break;
 	case HID_DG_ERASER:
 		input_set_capability(input, EV_KEY, BTN_TOOL_RUBBER);
@@ -2522,10 +2527,21 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		return;
 
 	/* send pen events only when the pen is in range */
-	if (wacom_wac->hid_data.inrange_state)
-		input_event(input, usage->type, usage->code, value);
-	else if (wacom_wac->shared->stylus_in_proximity && !wacom_wac->hid_data.sense_state)
-		input_event(input, usage->type, usage->code, 0);
+	if (!wacom_wac->hid_data.inrange_state) {
+		if (!wacom_wac->shared->stylus_in_proximity ||
+		    wacom_wac->hid_data.sense_state)
+			return;
+		value = 0;
+	}
+
+	input_event(input, usage->type, usage->code, value);
+	/*
+	 * ABS_Z was used to report twist data, because ABS_TWIST was not yet
+	 * defined at the time. For compatibility purposes, also report twist
+	 * via ABS_Z.
+	 */
+	if (equivalent_usage == HID_DG_TWIST)
+		input_report_abs(input, ABS_Z, value);
 }
 
 static void wacom_wac_pen_pre_report(struct hid_device *hdev,
@@ -3741,6 +3757,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 		__clear_bit(BTN_TOOL_PENCIL, wacom_wac->pen_input->keybit);
 		__clear_bit(BTN_TOOL_AIRBRUSH, wacom_wac->pen_input->keybit);
 		__clear_bit(ABS_Z, wacom_wac->pen_input->absbit);
+		__clear_bit(ABS_TWIST, wacom_wac->pen_input->absbit);
 		__clear_bit(ABS_DISTANCE, wacom_wac->pen_input->absbit);
 		__clear_bit(ABS_TILT_X, wacom_wac->pen_input->absbit);
 		__clear_bit(ABS_TILT_Y, wacom_wac->pen_input->absbit);
@@ -3823,6 +3840,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case CINTIQ_COMPANION_2:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
+		input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_TWIST, 287);
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
@@ -3835,6 +3854,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case INTUOS4S:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
+		input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_TWIST, 287);
 		fallthrough;
 
 	case INTUOS:
@@ -3855,6 +3876,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
+		input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_TWIST, 287);
 
 		wacom_setup_intuos(wacom_wac);
 		break;
-- 
2.56.0.455.g6c5a503b38-goog

