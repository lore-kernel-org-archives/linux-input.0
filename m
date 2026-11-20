Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164269;
	b=B2US1BsBTurU8I6qDvaSP/rwZntmy1WjknANgdksv/19om1/7Lj7PlK2eA05p7Yz+zHp
	 LC0PbVRcSSF7/sfpl7PzVjDNm4u8NhlFv9isREWKAYqVsCxABpPY3O+5ToDFNHdNUjzOz
	 DzctYx/m0WDencV3Y2tJwkLf6B+s7++eXeD1suSOUQv27Ksl179iM5tJ3GktvczRPvcAH
	 A/0uESFMBv0O5vA6BZ0TbycD6YcBY7VxonnbWV9swoEzDaIp8vOsb89XemB9/2OJ3VZLE
	 ib8LK0j77Tx3Uq7irRgHOVqFe+a2mU/gqt1AWTEHXbPw0vk+0AURDJCdqotSai5RPHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=KKrF/3OPdL6xEz+lwHbSUSyJUkI7uH9V+JtYaC3j1O4=;
	b=4M7ibsyWMhf0Ykx+GPo5PELrL9luZ66mUEnvVam6NDRLWRl6LsxhDr7qUiFI3SqaJt1F
	 ggvkkKO8j8gVMFxLZx6vxpf7mOSRUx1jd/8z6H6oBhZpq6erXXLX5owxVI3EGKVfwPiJg
	 n0FIZ6AccyfPDCzWX5yGBbRmJstFRi+Q+9NF0tQPNRQVEah2Tm4GHs+gs+2yxnkOrXNbU
	 Hth1hQWLqJFiuktR3QYD4O3ePThN0bzIUhxASJ396PVgTrTNncocraQ43TzmcgvGc79ZN
	 uv0IEfk9VV/aPHXUBZdmpoeE1yDh6dBH6d8AMTduZuiBVihfGx2CbgTC8TywzsQaLrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd9jYDWx;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D160A5BDC
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B59D160A5BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd9jYDWx
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so933391c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164268; x=1795769068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKrF/3OPdL6xEz+lwHbSUSyJUkI7uH9V+JtYaC3j1O4=;
        b=yd9jYDWxSnmgfJHfqSyZKGNcKL/4y3T65i/88mjFwS/JVSxqz54bPJPG4GqpAnZcnI
         k2ffPZi6N+Qkdf2dCKrjADsxfVgg8BDLybdEkLUNSldSHnR+vCIzHW3i2NTvL8olii7B
         Qqd34k+aOruNNgNBnpcT4OtsUY9vffa4DqX5atq7pb7NHNnbRaRzqMgy+DKoKhmErgZx
         iUO99Pi/nnXWxbU4qBAngA8LqSmIJnT+HaqSoXxvZmnvpSKD71tQm9jRNVNVA68pK9C2
         PNQl6q3sfbokF7YW6N+1hlR7NDIf9036MRnwbbO1FLQeZu9aYSY8OPPo2Mdd7f1orZ54
         GCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164268; x=1795769068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKrF/3OPdL6xEz+lwHbSUSyJUkI7uH9V+JtYaC3j1O4=;
        b=feTzNLWta087/9Ar3Bi41q57euXr3soNZjcDhONbQ56u5dJC4Y6SkUeBXOdqrL7nB7
         YosGJiMACotKhWuvnms85IJuxSHZHwjr5StcE8xn5wtFSfAKzO0uSwYVcP5C9dUe+lm8
         u/MW773dzDhjimYCqTb+TipZ1zMZEJcKvnI+c9aciinOa+wx7d8oLruEA2K4HcrrvsUm
         ed6cXj4aK0PvKq3ZejK12VlAPDzx5yubHMZ1Ca+flIBelxNjAtWM4eK5PGnHS6nf6wtr
         sbCNrtFxZWk2vAQ4CRQS7sL7YbysWvQ7vWYVUQ9vHy7om6Xfv/tWcgP5tD+t4PFz4m/i
         xIiw==
X-Forwarded-Encrypted: i=1; AL+hErFwwNmSk7Yp1lncm13XmW7zDIrsN9l3oVRCNuSu3FnyUrR50I4gf6Klj2AZzYtr3yvMLXSDmw6HJ0jBlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cYnhQJSMf6MrFpmax0nOscDBOq6Xz9aVj42UoqdHLrbfJUHBd
	ubfgQMoYL2BGc6w+Ppeqlv/3b0ea2DqLxIS7/hSGfie4x/iVRiQROyUg
X-Gm-Gg: AYBFou1iFuN+gXl72FqmafhD81SviV725VVFKX7S+8kz6nVjGJaxQQ9a1jcO/puYKzo
	l/AtdPAhr6l7y7UlAgl0OlzikgsJz5rilPAzITu7MPPjcdEylpgTNtnRz6NKcZyokgJ/5vgwX/2
	+KaT5fljZHtF+7JYJKB5Tqlhi8NthPxZbaZHHCHIxtYdHzrbuXE1gil5SePnXifa5dMSfPbz8vg
	9XeJ0pSjyWWnqGfWF+JrugR4sSCaun0oktaiiR3GOnBSQtzSnRAtmAljEU+jC9Qsv7Iinh7Yvj1
	3RGKX5Uzp/9rGhx/9bwVbubqz5bNCNbR8lYvKJawvkFdx4KQSYUm8pnSjNKRDUiSvfl6PzzhzZ3
	8opgUgisvkXTkWdDbc06sbWRu/oL1eztCsnOW8BVxCCOkeyLrEUoh6z/zHLqFsmo8mVncbUKlwv
	Dp0sRxm0gCo46hlIATvMAPjtxSU4P+GGulDbSckiaAEQzNrN3C4KM7iBT/bdZnToOFI+AgHqq3D
	s1IXj12wCMfwNX1T+vKcwy5D1UYSX5Q4IebwRtS6QnB8XMXBmoUxS11jZ8OxRJ85c0uk2zmI00M
	ufPZ4cxeemvJNZWToEwIsj9qyCRB50P2fGcVKeYh7GXxWfSf5oKMsPvV5tLQc+S4AcyrKif71Sd
	icEEHhypw5jE0U4h/kg==
X-Received: by 2002:a05:7023:a5b:20b0:191:a5b2:ef4a with SMTP id a92af1059eb24-1b5568b9f5dmr2015605c88.28.1795164267919;
        Fri, 20 Nov 2026 00:44:27 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:27 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:02 -0800
Subject: [PATCH v3 11/18] HID: logitech-hidpp: use unaligned accessors for
 multi-byte values
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-11-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Several paths in the Logitech HID++ driver manually split and reassemble
16-bit protocol values using shifts and masks instead of using standard
kernel helpers, which obscures endianness intent and adds unnecessary
noise.

Replace open-coded 16-bit big-endian packing and unpacking with
get_unaligned_be16() and put_unaligned_be16().

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 84 +++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 53 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 54e7ee824063..16fb52634437 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -960,7 +960,9 @@ static int hidpp_root_get_feature(struct hidpp_device *hidpp, u16 feature,
 {
 	struct hidpp_report response;
 	int ret;
-	u8 params[2] = { feature >> 8, feature & 0x00FF };
+	u8 params[2];
+
+	put_unaligned_be16(feature, params);
 
 	ret = hidpp_send_fap_command_sync(hidpp,
 			HIDPP_PAGE_ROOT_IDX,
@@ -2113,7 +2115,7 @@ static int hidpp_solar_battery_event(struct hidpp_device *hidpp,
 
 	switch (function) {
 	case EVENT_SOLAR_BATTERY_LIGHT_MEASURE:
-		lux = (report->fap.params[1] << 8) | report->fap.params[2];
+		lux = get_unaligned_be16(&report->fap.params[1]);
 		if (lux > 200)
 			status = POWER_SUPPLY_STATUS_CHARGING;
 		else
@@ -2415,7 +2417,6 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 					  &response);
 	if (ret)
 		hid_err(data->hidpp->hid_dev, "Failed to send command to device!\n");
-
 	atomic_dec(&data->workqueue_size);
 	kfree(wd);
 }
@@ -2460,23 +2461,18 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 
 	/* set common parameters */
 	params[0] = old ? data->slots[effect->id] : 0;
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
@@ -2511,20 +2507,14 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 				effect->u.periodic.waveform);
 			return -EINVAL;
 		}
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
@@ -2541,17 +2531,13 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
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
@@ -2568,18 +2554,12 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
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
@@ -2670,10 +2650,10 @@ static void hidpp_ff_set_autocenter(struct input_dev *dev, u16 magnitude)
 	params[0] = g920->slot_autocenter;
 	params[1] = HIDPP_FF_EFFECT_SPRING | HIDPP_FF_EFFECT_AUTOSTART;
 	/* set coeff to 25% of saturation */
-	params[8] = params[14] = magnitude >> 11;
-	params[9] = params[15] = (magnitude >> 3) & 255;
-	params[6] = params[16] = magnitude >> 9;
-	params[7] = params[17] = (magnitude >> 1) & 255;
+	put_unaligned_be16(magnitude >> 3, &params[8]);
+	put_unaligned_be16(magnitude >> 3, &params[14]);
+	put_unaligned_be16(magnitude >> 1, &params[6]);
+	put_unaligned_be16(magnitude >> 1, &params[16]);
 
 	hidpp_ff_queue_work(data, HIDPP_FF_DOWNLOAD_EFFECT, params, ARRAY_SIZE(params));
 }
@@ -2685,8 +2665,7 @@ static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
 
 	dbg_hid("Setting gain to %d.\n", gain);
 
-	params[0] = gain >> 8;
-	params[1] = gain & 255;
+	put_unaligned_be16(gain, params);
 
 	hidpp_ff_queue_work(data, HIDPP_FF_SET_GLOBAL_GAINS, params, ARRAY_SIZE(params));
 }
@@ -2716,8 +2695,7 @@ static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute
 
 	range = clamp_val(range, 180, 900);
 
-	params[0] = range >> 8;
-	params[1] = range & 0x00FF;
+	put_unaligned_be16(range, params);
 
 	error = hid_hw_open(hid);
 	if (error)

-- 
2.56.1.750.gf70dc682cf-goog

