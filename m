Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407672;
	b=IQPC0z0UK0wgObzUMRkONyrKSXqccxnMklJakRU8AKHS3kBJYBq0RT6MwVCLF0iUX/cW
	 oBK80cnRTTBEFhZKQXkRq56ZEgd+bkZNm0uEfMhJlQKq4jbxEVTfi0ygAZei0vxeowpck
	 CIKo2nlz4CoJk0qEQmJNdA81/07Tj6MQz+6lPPgQBtp8FL/IA8fBpVk+Ucm3U2e9WL30F
	 M17pBQntvN8RrQeIdANj+xmoLJPhv+nDbXb/DIAQvcLH5FE5/3TCx+Xho7w4jFFaOWWxI
	 nSTB+M7Cbg29p8/jSbLGMrRtJg34/7gZqKg7UeKABk1mB9Z78n4edkboE8M7M68oXjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f8WZRTMWeUNZbRkyn0Ahjw8OEwEI2bTGwo54bTQ7BkQ=;
	b=xSIATBYydOWfSlFJYmSzjUTxRMb2uz77W3PPj5CnrzT9S7mO5ACEtDEua/7GpKRPeB0s
	 FPVTAxCTg6UnqgD1+3zo8taaNlsKEilRGmyJDC6by8F5T9rk9tBRWkZ7x2iwiwRkaauXR
	 zgValSnvQlxYjj93G1V0zdcNtUdujvOxhr0oSz7G3eWlL+L/yoc1H+NV9PLTRAcXwjGtU
	 tPC3zMsf2kyXPudxtQEZUFRPHnw4HzIhsVYJWChY4TVy9QBI9hiZ/wQp656kUuLg6wcgW
	 NZwziWmTiQEHhS6k1+pNAweXCmwgFI3zdUh+8dgGWLNBewTPct3rcVycHLxfaDhjGkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXbZ1khg;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCB606A330
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8CCB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXbZ1khg
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-385c497bf94so1208935eec.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407671; x=1796012471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f8WZRTMWeUNZbRkyn0Ahjw8OEwEI2bTGwo54bTQ7BkQ=;
        b=UXbZ1khgD9hwP0GeIYbUIzE/Jr0bVRjkLi17dSvJn5QK+LOjvvVNwo8d7lhhQMk1VB
         kQs7einaXfFoYcDURVbCuyOJu+9sAVxzB4AyUd0D1If1M0ckGrxvwuuvksHzYlVazZ3y
         H6qenANHsMPTMv38xAV+svIDElAlevXF3ZSfX9iq8twH+2a1c2LjCqWZ6qO6GzwpAMfS
         C44D1GlpBjWbSzqcmOI7LPKdHC3D0P6NUjNJ23+OO/QJh2FvbGNztgrIyfkZuGkAKuMr
         yb5M/Jp4SArn5KyjO4Dq79P6/+2GRRmae6ZwBEYEnyylathJC9sbKQHQKRJgyOb8MA7O
         6/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407671; x=1796012471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f8WZRTMWeUNZbRkyn0Ahjw8OEwEI2bTGwo54bTQ7BkQ=;
        b=N0LvMTWWtNxfJq7EyAEM1CdpV2vORMAwaCFnnpAmq6JaxXww7flERjSOd3RM4AwcOI
         EPZ66mDPGrWKlQ/FRRWTtvou2jA5wEwBjW5DOsRV6ReqD6YpfiF/pYFVHjbGoBxv+HXv
         lKbaDz5ym4UMOT6cAEehBQ4U6C+rqYONFHSRAC1vBIvQ/O6rlOfUnjoBhROVDBlmGrGi
         iYwDV5gaGddigXx+gR4bTGHGHKHXnFaEX8l9t373QlkAoxOyVChzMfrQ7hYxniWg394n
         oL/gEPU5XejqJNXbU4NUSfpYrXclIIPuPBqxazhRoa7738gBBsl3nca/OsH4TquSucXI
         mUUg==
X-Forwarded-Encrypted: i=1; AL+hErErdvjNql1bnN3wdR1IIDlrEBaaUHfcwjCyqhzBqzDuuQ6smlV1zM5QT8Aqhh1Q/7Mu2r2X0MLpoGI1Pw==@vger.kernel.org
X-Gm-Message-State: APuU4Z90Vfccu1Of3IM0eit5KVjfWpVb2c1hd6T41jYJgvQfkk0hX+Ca
	TTMZCOSM9xTMqKZeC3pYWBcCaGP531+ninBOxdILnKF7ky1ChLWjjqqM
X-Gm-Gg: AZFdTZcKanb3R9BFJb8h0U0s9C9DKf8QcHK86A4CcV+GmldkcU2R97qg8RCk10Nfh02
	EqPocHHqppgw6TnI8JU1zKrkq7j1OdyKTocDcmtdT/SqI9EHT1U+SbFKsVk7F1kS2dDEGnJmsdj
	enrvHcHvBGJDV1n1hE+WMZRwfyMUdcHYRw2UULD9UZpei5u/p93xXhXhjRVWQGHJT9q83vHm8Wy
	W9xjsqnZsbBX5nVFCs7s1Ek9+dT3ea5nT9nH5UEPk1mI4SCVar0kZqZeQ1ZJsB5Ux771oPuKhGz
	ACaa1rAWjJWrOFfWeTWQVo0nqVbUipmN4HjM2PBkW2E1sLHV4lQcM5pvLtDITzNHkPZLeGtJD1K
	Wjhb33WdC7AoBRbVuClj3Tr1N/2vVjTqrZhqdwH+QjtQa2qFG7KLU1LJKi0a+rRvsDxeTvFTZnh
	ue4F8MkZqyrpeS8K0DrAfIOdTPVcZiSnXEtoamATDpzb2bCjpwJ9FqwPl3023JoUYojGomocV2C
	BiWyVgW7f20DfbdGGcQs73PZ4ysdu/bB760hcC7JMIuO90Ab5mvcg/Vu/3Qt+gkY8wRwcePzOSl
	E25cQ1Ck4FTJCJcD6gFkTNNAlYq9a7lnpdEUJZiGwYJzI1Zq3AMaseG88fFWMA6c+LEWLOTdD8L
	xv/JjUqTII2ORbfKlMdTMVegCZm8CixADEruoiHSYn76nlVVr
X-Received: by 2002:a05:7300:ce11:b0:385:774:fb23 with SMTP id 5a478bee46e88-3856e63b5cdmr11897862eec.6.1795407670545;
        Sun, 22 Nov 2026 20:21:10 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:21:09 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4 . 6" <noreply@anthropic.com>
Subject: [PATCH v5 5/6] HID: wacom: add NULL input guards to Bamboo handlers
Date: Mon, 23 Nov 2026 04:20:14 +0000
Message-ID: <caccdc6abf435f2d6844e6f8e3c3b3ec1d8ecc1b.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795405057.git.jinmo44.yang@gmail.com>
References: <cover.1795405057.git.jinmo44.yang@gmail.com>
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

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e2c2bdf91c5b..db8d3432dbd7 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3177,6 +3177,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
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
@@ -3211,8 +3217,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
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
@@ -3255,6 +3270,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
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
@@ -3309,6 +3330,12 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
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
2.43.0

