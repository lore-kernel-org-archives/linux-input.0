Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812661;
	b=yjQQt+Mhl495KW5bUVFDFN/mIRnwGwB4+c1MsK3fN0t5FAVcMhCaKI0ZDaqkVPzNPwUd
	 RTS2FOAtN0CmqMxi0kFt9lIJMKaAjyg+OgiuVE90IT5dY04qO4LdNORejRY33aWa91lp4
	 m4HYUyAuf4cIVfHMuotxfcigdY7D4KaQHqFdbN+w6z2y78Jb+Xbe2KmzYUa4BGhIWedc9
	 6nYGpOcNYZuP3EKPFM+nh010/SVddNR0jcnLJrXxReOfytOp139aW/pOJRbQEZkKh+51t
	 2X9f3TIKsW8ROl1jFbYMJR+NRPWXT7WaUM4dYQoGNKTtFYqYE67xknqq+4WIaG6iqLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UqibqhDXFVQTJaQLvrkge4wCU3l636dt/KCjheoRN18=;
	b=u6hCCZ1huGO2Dq0GXyr40JfP2c99K7wGiWZYtX05P7kCWYT7hCTWKvLC0my/Z2dBHdEK
	 aOdotXPOO0LzYX5nAkV80pjtmVOBhPL79R9TkjVNG/Qg1U7DnH2zGOtLMnhy1na+Zm0lj
	 /y2mxBdji1rJYtWUOQsfNepysHkgksFfT8Y6a7mwVTPABRM913n7G3qcg6t+7sDUwaspF
	 T8QbM6UWE6XUMI9Yr6Hnpo1ebqsQJ/Ax4/VhM6u04PbU6bk+O454UB65duXNIUGjuucwV
	 NzgqNAC6pPYk2ygJQhCkLzw3lirq0ErgX57jg1/9rFb9PB7E1Xyi73/zHMp5zYLh7kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UwqGBi44;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB1606A322
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 03:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AAB1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UwqGBi44
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1931ff67a29so2362157c88.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 20:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812660; x=1793417460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UqibqhDXFVQTJaQLvrkge4wCU3l636dt/KCjheoRN18=;
        b=UwqGBi44/7agNy6LtbYxT0F6G+OG/eL8S9kWrd1sg+CCCt6oituJd335n9UjKBMlAm
         5EB9uRdpQX4HWeCBgyNNg1eZUCJmvtZ/7Z7RzDZ8Py5NeCKvzdrBq6htAHRZGgfZFY4R
         YReU/naLrwX5NNn8Bg8ZIIZwOH0Lx5wGqhciWK1WlMEocRj2Tg9TXlR4dnlugkdIMnVX
         3zX7c75E/MMZ1nI7RsoZBuQmr+zKN1IbOqeW9tANDe8b0E/EB0GpHzAyoxcXS3l39hyc
         Qe9YDwiEPjVENXS6QRsiXGHZg2ohRnN3z4yGNBTIiTcN6uXppCg3vKsqnk+4v76si5+A
         uywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812660; x=1793417460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UqibqhDXFVQTJaQLvrkge4wCU3l636dt/KCjheoRN18=;
        b=murxzC6MBwFbQXrsh07h5zigciBTWA3SYp8CjQr6U7kSB29WR9LddhyEOOOpsh7wjD
         3QG3Vb/m1cyIKnWor26/ai06hbrc/6AU4R3tv4B05ojzM6n//91ka3Ir7yIa3rGm5BrR
         5UkQ2TraCT3piBGiKDVtYtuJTQSQFHyiL1LmaxtUyiXeMaB7Y+n+3u2BKMW6JQTiU6gz
         O1f1mNvc3MmcOiQFY26UtaHPWf2fVM2hBQ2Bv26uDpADxO8rCEhaJ+Pmv9yS8qSKanMg
         ZDxxdX19s1uXtCyRIwhL+dys51cAJg0z/BWazs7mWuPAJnU4XHTZeflLwZGB6OWYQmAg
         LAvQ==
X-Forwarded-Encrypted: i=1; AKwUvByslqfEIsq0uzUThltTRUkM43vfqhnbEoMHAlUMPAqFABwz0hXauodCJtyxBYtNA6R4bwVhPXGa3QS7ww==@vger.kernel.org
X-Gm-Message-State: AFq9FYKtGBrCuf5p2ZESrVR1tB4gSyNM6Ej3cdT4BicESWO5lmdxRb7b
	JimzqvBsJrrHX+EPoDYs0nQxvF4+StIDyWcwqyPk7wvqkSDZPC0T9+v0
X-Gm-Gg: AYBFou0ajMvl/erc+8d62OwcKLelUOJBxV1E2DKUq93HOibXSXIRXtT4I8f/GFyFUWB
	pIrbQZVrYFXxmXjW+umSWUs9zizanf7zb/Pdx/K5a5EjsQwJ1gtuQylbIvtIuQFDcsF2wfHj/Aj
	76T6Z9k6jh29j2MngvaqvexezAzQ+sLXQHuOY9gIYDP8vFA8lfjQYHe4VVCoclXMzZ3w1WGEWFs
	UP2G321YM+J+D9BPlB8dEtB613Bescj84X3R5xg6ZuIJygQQjaMy4rhfyH0kCSBc6oJr1lwifDJ
	YDBW4nBog2eX5pvMIDEb+dcP0HnctAK5JFGiKYA+EI3S1izEB08v1mHpZh2KYeS3UUR/H6DQAYE
	LXxCgRRQrpf0+8y6ZZjogOOosigdzbHS2yImMS28wSJyZKu6vZi1QQ/CR95caa7h8TDBpKdMKJG
	pLvOS+4TEq33uNMtsTFo4rwgin9cZRtI2aQmL0tUKi8kLT6w0mNW5SQO1jcNrrlu6iyXpoVUELj
	SI9HbPI+8dPKaa5rjBomu1r7nZHntsqh0VwCcb6NAcIn1EkBT18trzNXx5VOwI+q3f2tQjeUEB+
	tdu4PweoPAJKN2hAHk4kZ8jLD1Ep
X-Received: by 2002:a05:7301:2b06:b0:369:9af5:7bcc with SMTP id 5a478bee46e88-369e848b9bdmr2135720eec.8.1792812659549;
        Fri, 23 Oct 2026 20:30:59 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:59 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 5/6] HID: wacom: add NULL input guards to Bamboo handlers
Date: Sat, 24 Oct 2026 12:30:39 +0900
Message-ID: <20261024033040.316652-6-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261024033040.316652-1-jinmo44.yang@gmail.com>
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

wacom_bpt_touch() dereferences both touch_input and pad_input.
wacom_bpt3_touch_msg() dereferences touch_input.
wacom_bpt3_button_msg() dereferences pad_input.
wacom_bpt_pen() dereferences pen_input.

All four can be NULL when the corresponding
wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV during
a successful probe. Add per-function guards.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6e2e67abf80e..c4d6295f57c9 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3157,6 +3157,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	if (data[0] != 0x02)
 	    return 0;
 
+	if (!input || !pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: input is NULL\n", __func__);
+		return 0;
+	}
+
 	for (i = 0; i < 2; i++) {
 		int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
 		bool touch = report_touch_events(wacom)
@@ -3191,8 +3197,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->touch_input;
-	bool touch = data[1] & 0x80;
-	int slot = input_mt_get_slot_by_key(input, data[0]);
+	bool touch;
+	int slot;
+
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
+	touch = data[1] & 0x80;
+	slot = input_mt_get_slot_by_key(input, data[0]);
 
 	if (slot < 0)
 		return;
@@ -3235,6 +3250,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 	struct input_dev *input = wacom->pad_input;
 	struct wacom_features *features = &wacom->features;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return;
+	}
+
 	if (features->type == INTUOSHT || features->type == INTUOSHT2) {
 		input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
 		input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
@@ -3289,6 +3310,12 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	if (data[0] != WACOM_REPORT_PENABLED)
 	    return 0;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	range = (data[1] & 0x80) == 0x80;
 	prox = (data[1] & 0x40) == 0x40;
 	rdy = (data[1] & 0x20) == 0x20;
-- 
2.53.0

