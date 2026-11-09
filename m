Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204688;
	b=LWlY0nn75Cg7FGkBjyXEV2fB1h8AUSjcXbp+lYqeCtjgGJARk63h8QcY1xwtOiF4jiO3
	 6jTUx5yTlWM1XvvA6mKWg5G573RZ+FhW5EYgw9udpV+11rCdUeh+kLQnd8fUWNuM1eKrz
	 1rffHtrbqmj/U/fVEXS8BbnYiZPmjlFTl63zXxByEFZMhN3qKp4NOynFN4l8rUIy2ZBXH
	 d8rkAYTiHqHbFwK3gh51fy+XtF3T+mNLEi1uoZCkXarRpbDa6l/CAdT8lgsDg2+DeNQ6K
	 j0kmgC5ZF/fVH4v3WM3/IkukqkVGIRo37A7ymueP9rIItzoG0p0ntfHiDauraQsONqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9cPwLbG2+KSJgXNfVvajHJA1b7je4WwFtGzmot4ZeZQ=;
	b=H5Uq+fmsQZIVxvUPl3tjBOoBXqNzTFENTuJiMcbeC0Of+Nm1Swz29HTw6RrQKtc8ben2
	 ewN7lRk7EwTX31PBwHli800Ud4CXLcgwOjEjyLNHLKxK/U5EElb+aQmmDXFWwTqnDBf+d
	 Hne+eTAiZPetR9frxV7X3CZqYRjj9stEK0nOUMCufEumUHkVoTnDWWj+D8sV7c2xXRMjw
	 w+swcOaCKfAvCn+tlXzREqQJlW7MBGhzktuUHA//BKWxih22WWditzwC0b/wvad6nTjuV
	 nrO03akDXSMpmwEKgll60gNbBUkj9UVetknLx2WEQaJKQVyZSFL3wN7f6pALtmJ31dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tbf6diBq;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E1606A32A
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5E1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tbf6diBq
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3720addb068so765197eec.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204687; x=1794809487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cPwLbG2+KSJgXNfVvajHJA1b7je4WwFtGzmot4ZeZQ=;
        b=Tbf6diBqYGKmG7fkWGpQS9z9roqQUpY775IrSTmkvHqzeMTFU++f7E0S4F2n50yLmY
         FGUd2E+ig3n80ub5uzkR9ATSnVlRo2XohJ0E3l6t1hXDl/+e8tDAWf9pSfDYHtV/kG/e
         MNz5R6HvT224C0U1e0h76NaZnY513W83wvLW/hhYzTa1SwhTRVOWVnAU4NjGW1OBrIyg
         63VMk4pfBrE7Eh4BJ+R04TA6BFw5hkDy5e4DcyL8cIdqmazqwf7yYkpGxC2i7yW9W0pI
         3XC0zXVbauhoyHpdPXFd9h9jTxzIgXvMHkKRuoMH6sNAPiyMErAAfAgTi+cPG2WvG66h
         zLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204687; x=1794809487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9cPwLbG2+KSJgXNfVvajHJA1b7je4WwFtGzmot4ZeZQ=;
        b=sQvVn4kOLgNTQZthh7smNckXcrJ76DIQg/rWR0QdLUM7pFbiKUyuRcBRRIyMBKk8RK
         sa8hTk6lq2xt5mwpjnSI3RfYZkHcPbPtoh7rC2hj2v10QIzd9zVIfzpLH8aHjxRzdwoG
         it12TT8Q+kBgL0Z8oqEV5AVz6HMqJ2kvgTFk3o+6QOC8DH0HeynRkKcLzKpAnAdN97+o
         N5jftw5J7kL1SQV+pNP96Bs2YK4E0OozunbfpqXobLlHaBco8182ZKqoJjIYrRZKcQ1S
         LhVGx8UCYSPU8HQX5i40jYUCpoTwjTGhdqwps2lSUu+cCy6kTCEPWZ4PtxNRSuqNjVhM
         32eg==
X-Forwarded-Encrypted: i=1; AL+hErFFDkHBRG+Mny47oZ61U2AhLR3dEav3l30x7lal3ScnCil+TSX9+A5QfelC/SQ+034ZwvushjwuXN3nqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Pjn2cACYO7o6fVf+y7VVf3vEGX/anpw8Rg9PrH4DljzfW8uT+
	F/4Nzr9oG+LAOug4oCUABIZiHBXeJqOc35qN6T72bTvO8LaJe4jesnZO
X-Gm-Gg: AYBFou2ixp7R49jA0uuMMZEucHZZWnUSjUw6iAPLS/6qvMLZeVq8V4azuh3uQ5ZqYVT
	5TS1ASEfAOn8oHptIpQjoAI37+lzlnlasb/3VBSqmpU5EmlDuYrTlQrMnmZVgFn893hWTKevzyL
	6hOf1QP6HiHdFfXMvEgnLhYhM/RfakpMvbHATSh+wbICi2TYYYm15+CDiph3qS0HzhVt2d22WtJ
	FobjIQu01gw/uhOjqCdOVlgvsEFmAecuTLJhXIKEBiipZiZz5STCh+d5AjKnCNGOzthMNcKplJz
	8StG5dZmpL/5/57uPsnFepBNSkERxmv9vyQvIZsLcL+s6x+U628LrFVi4dMEF+AF2N/67rOVpJl
	GHJ8g31MIfjeFLZp1P9qGD3Ucx4mPv3t4Ip/DFjCbwyzil4PvtEBxUHP7lRW4P0e+enL9dsF9ir
	P671qWuaHoTsQ3y2TaglMmce0+1pn8Ak3w+TRhDoMbTjRWp7cvVRNC6+T7ZzJS6ppqI72u2M5zY
	g5gSk93cZ/4FarqBIBcqHShZz0CFE5B4h0/mC+G4Gv5Bk1a9mhxO7o71Vj+7fVzD3yhos95uQJQ
	uAOFUnUxInWwAunUjakDx7axqZzpdfZhDKmOj5Epz6aw6pKUUojKubAdqrYQSbl9poizizInamI
	WfRVnkCtplYlFXKO6
X-Received: by 2002:a05:7300:fe86:b0:36f:6b99:f963 with SMTP id 5a478bee46e88-37257aa8815mr5917223eec.21.1794204687386;
        Sun, 08 Nov 2026 22:11:27 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:26 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] HID: logitech-hidpp: use unaligned accessors for multi-byte values
Date: Sun,  8 Nov 2026 22:10:56 -0800
Message-ID: <20261109061103.2887636-13-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several paths in the Logitech HID++ driver manually split and reassemble
16-bit protocol values using shifts and masks instead of using standard
kernel helpers, which obscures endianness intent and adds unnecessary
noise.

Replace open-coded 16-bit big-endian packing and unpacking with
get_unaligned_be16() and put_unaligned_be16().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 87 ++++++++++++--------------------
 1 file changed, 33 insertions(+), 54 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5169f3873257..c4ebfc4d66fe 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -951,7 +951,9 @@ static int hidpp_root_get_feature(struct hidpp_device *hidpp, u16 feature,
 {
 	struct hidpp_report response;
 	int ret;
-	u8 params[2] = { feature >> 8, feature & 0x00FF };
+	u8 params[2];
+
+	put_unaligned_be16(feature, params);
 
 	ret = hidpp_send_fap_command_sync(hidpp,
 			HIDPP_PAGE_ROOT_IDX,
@@ -2156,7 +2158,7 @@ static int hidpp_solar_battery_event(struct hidpp_device *hidpp,
 
 	switch (function) {
 	case EVENT_SOLAR_BATTERY_LIGHT_MEASURE:
-		lux = (report->fap.params[1] << 8) | report->fap.params[2];
+		lux = get_unaligned_be16(&report->fap.params[1]);
 		if (lux > 200)
 			status = POWER_SUPPLY_STATUS_CHARGING;
 		else
@@ -2531,10 +2533,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 		}
 		break;
 	case HIDPP_FF_SET_GLOBAL_GAINS:
-		g920->gain = (wd->params[0] << 8) + wd->params[1];
+		g920->gain = get_unaligned_be16(&wd->params[0]);
 		break;
 	case HIDPP_FF_SET_APERTURE:
-		g920->range = (wd->params[0] << 8) + wd->params[1];
+		g920->range = get_unaligned_be16(&wd->params[0]);
 		break;
 	default:
 		/* no action needed */
@@ -2581,23 +2583,18 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 	int force;
 
 	/* set common parameters */
-	params[2] = effect->replay.length >> 8;
-	params[3] = effect->replay.length & 255;
-	params[4] = effect->replay.delay >> 8;
-	params[5] = effect->replay.delay & 255;
+	put_unaligned_be16(effect->replay.length, &params[2]);
+	put_unaligned_be16(effect->replay.delay, &params[4]);
 
 	switch (effect->type) {
 	case FF_CONSTANT:
 		force = (effect->u.constant.level * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
 		params[1] = HIDPP_FF_EFFECT_CONSTANT;
-		params[6] = force >> 8;
-		params[7] = force & 255;
+		put_unaligned_be16(force, &params[6]);
 		params[8] = effect->u.constant.envelope.attack_level >> 7;
-		params[9] = effect->u.constant.envelope.attack_length >> 8;
-		params[10] = effect->u.constant.envelope.attack_length & 255;
+		put_unaligned_be16(effect->u.constant.envelope.attack_length, &params[9]);
 		params[11] = effect->u.constant.envelope.fade_level >> 7;
-		params[12] = effect->u.constant.envelope.fade_length >> 8;
-		params[13] = effect->u.constant.envelope.fade_length & 255;
+		put_unaligned_be16(effect->u.constant.envelope.fade_length, &params[12]);
 		size = 14;
 		dbg_hid("Uploading constant force level=%d in dir %d = %d\n",
 				effect->u.constant.level,
@@ -2631,20 +2628,14 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 			return -EINVAL;
 		}
 		force = (effect->u.periodic.magnitude * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
-		params[6] = effect->u.periodic.magnitude >> 8;
-		params[7] = effect->u.periodic.magnitude & 255;
-		params[8] = effect->u.periodic.offset >> 8;
-		params[9] = effect->u.periodic.offset & 255;
-		params[10] = effect->u.periodic.period >> 8;
-		params[11] = effect->u.periodic.period & 255;
-		params[12] = effect->u.periodic.phase >> 8;
-		params[13] = effect->u.periodic.phase & 255;
+		put_unaligned_be16(effect->u.periodic.magnitude, &params[6]);
+		put_unaligned_be16(effect->u.periodic.offset, &params[8]);
+		put_unaligned_be16(effect->u.periodic.period, &params[10]);
+		put_unaligned_be16(effect->u.periodic.phase, &params[12]);
 		params[14] = effect->u.periodic.envelope.attack_level >> 7;
-		params[15] = effect->u.periodic.envelope.attack_length >> 8;
-		params[16] = effect->u.periodic.envelope.attack_length & 255;
+		put_unaligned_be16(effect->u.periodic.envelope.attack_length, &params[15]);
 		params[17] = effect->u.periodic.envelope.fade_level >> 7;
-		params[18] = effect->u.periodic.envelope.fade_length >> 8;
-		params[19] = effect->u.periodic.envelope.fade_length & 255;
+		put_unaligned_be16(effect->u.periodic.envelope.fade_length, &params[18]);
 		size = 20;
 		dbg_hid("Uploading periodic force mag=%d/dir=%d, offset=%d, period=%d ms, phase=%d\n",
 				effect->u.periodic.magnitude, effect->direction,
@@ -2661,17 +2652,13 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 	case FF_RAMP:
 		params[1] = HIDPP_FF_EFFECT_RAMP;
 		force = (effect->u.ramp.start_level * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
-		params[6] = force >> 8;
-		params[7] = force & 255;
+		put_unaligned_be16(force, &params[6]);
 		force = (effect->u.ramp.end_level * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
-		params[8] = force >> 8;
-		params[9] = force & 255;
+		put_unaligned_be16(force, &params[8]);
 		params[10] = effect->u.ramp.envelope.attack_level >> 7;
-		params[11] = effect->u.ramp.envelope.attack_length >> 8;
-		params[12] = effect->u.ramp.envelope.attack_length & 255;
+		put_unaligned_be16(effect->u.ramp.envelope.attack_length, &params[11]);
 		params[13] = effect->u.ramp.envelope.fade_level >> 7;
-		params[14] = effect->u.ramp.envelope.fade_length >> 8;
-		params[15] = effect->u.ramp.envelope.fade_length & 255;
+		put_unaligned_be16(effect->u.ramp.envelope.fade_length, &params[14]);
 		size = 16;
 		dbg_hid("Uploading ramp force level=%d -> %d in dir %d = %d\n",
 				effect->u.ramp.start_level,
@@ -2688,18 +2675,12 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 	case FF_SPRING:
 	case FF_DAMPER:
 		params[1] = HIDPP_FF_CONDITION_CMDS[effect->type - FF_SPRING];
-		params[6] = effect->u.condition[0].left_saturation >> 9;
-		params[7] = (effect->u.condition[0].left_saturation >> 1) & 255;
-		params[8] = effect->u.condition[0].left_coeff >> 8;
-		params[9] = effect->u.condition[0].left_coeff & 255;
-		params[10] = effect->u.condition[0].deadband >> 9;
-		params[11] = (effect->u.condition[0].deadband >> 1) & 255;
-		params[12] = effect->u.condition[0].center >> 8;
-		params[13] = effect->u.condition[0].center & 255;
-		params[14] = effect->u.condition[0].right_coeff >> 8;
-		params[15] = effect->u.condition[0].right_coeff & 255;
-		params[16] = effect->u.condition[0].right_saturation >> 9;
-		params[17] = (effect->u.condition[0].right_saturation >> 1) & 255;
+		put_unaligned_be16(effect->u.condition[0].left_saturation >> 1, &params[6]);
+		put_unaligned_be16(effect->u.condition[0].left_coeff, &params[8]);
+		put_unaligned_be16(effect->u.condition[0].deadband >> 1, &params[10]);
+		put_unaligned_be16(effect->u.condition[0].center, &params[12]);
+		put_unaligned_be16(effect->u.condition[0].right_coeff, &params[14]);
+		put_unaligned_be16(effect->u.condition[0].right_saturation >> 1, &params[16]);
 		size = 18;
 		dbg_hid("Uploading %s force left coeff=%d, left sat=%d, right coeff=%d, right sat=%d\n",
 				HIDPP_FF_CONDITION_NAMES[effect->type - FF_SPRING],
@@ -2753,10 +2734,10 @@ static void hidpp_ff_set_autocenter(struct input_dev *dev, u16 magnitude)
 	/* zero delay and duration */
 	params[2] = params[3] = params[4] = params[5] = 0;
 	/* set coeff to 25% of saturation */
-	params[8] = params[14] = magnitude >> 11;
-	params[9] = params[15] = (magnitude >> 3) & 255;
-	params[6] = params[16] = magnitude >> 9;
-	params[7] = params[17] = (magnitude >> 1) & 255;
+	put_unaligned_be16(magnitude >> 3, &params[8]);
+	put_unaligned_be16(magnitude >> 3, &params[14]);
+	put_unaligned_be16(magnitude >> 1, &params[6]);
+	put_unaligned_be16(magnitude >> 1, &params[16]);
 	/* zero deadband and center */
 	params[10] = params[11] = params[12] = params[13] = 0;
 
@@ -2770,8 +2751,7 @@ static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
 
 	dbg_hid("Setting gain to %d.\n", gain);
 
-	params[0] = gain >> 8;
-	params[1] = gain & 255;
+	put_unaligned_be16(gain, params);
 	params[2] = 0; /* no boost */
 	params[3] = 0;
 
@@ -2797,8 +2777,7 @@ static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute
 
 	range = clamp(range, 180, 900);
 
-	params[0] = range >> 8;
-	params[1] = range & 0x00FF;
+	put_unaligned_be16(range, params);
 
 	hidpp_ff_queue_work(g920->ff, -1, HIDPP_FF_SET_APERTURE, params, ARRAY_SIZE(params));
 
-- 
2.56.0.506.g506a7eabc5-goog

