Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746771;
	b=BdPlcrZlfVJZJMmhXeSFjetNewL32OPl/YoGDPj8xBx34jFZM/A/fAbjS/yN5wtHlZWx
	 I0efzdUqPyA5KmNqkdTCxFQs8Q1T9p+OZ7WkvlG0cu/JTPs5giekyFEhJfsXa7/iyeUsb
	 vu0r4U+oXIq91PsgSJOByrePT8GSgWf9FqWADsjcbeMhKOOn2BSjB5bb6WJO1me2wH2Z7
	 QxNCDwedAq3PKfBZZptkbq2Z/B2whnIGAOBHXh1vl2ia/3QLSqkjHN7Ho0jFwU8dd3HGH
	 BGnU7QAjNBDGZ6lfG4O2ZbtQCpIzVnbiogZNC652dnwAKynrlYCPZ9lkAaJGHyukfSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NpSqWnf1WT+kM3nlRcG6tO5fjhwFoYLjYPpGUhC0vJ0=;
	b=ZzCfrWaGJd0BMpAvd/tnjhzczZy3tpiER1sEedDpsChEzKGJVA4TuaQV5XITCmfhIJJe
	 MORFlO1AWuTB6LMI48SfuMpan/fuqc31shYAeotgAaXzmHNvdiAvtmH6lWf9CwpktJvFv
	 m33s6WfJls3Yej0uUOZBQoe3xBujDO7COcnMswcZ88uOrjCZb+Nrrw8DukKq2Em0s2S+J
	 lecgv/ZgCt6JY/8CuanadnNVtkwy0rTnkNidoEGSZMiBKvheFYEvZ2DxLc7erApTbJYUw
	 ExUyGi+6pKCevO+DkHLfqtW53F4LD4oMuUHrgNTh+fSBjm9a7sIDfUn1owmkHWCdtZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ph1gOnlD;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690D606A338
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 22:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B690D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ph1gOnlD
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so111379eec.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 14:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746770; x=1794351570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NpSqWnf1WT+kM3nlRcG6tO5fjhwFoYLjYPpGUhC0vJ0=;
        b=ph1gOnlDegiQiQZRWoj/mRXGskH1KJ/1GwEFCydAYlJNBEDdOZmsPy/KV3B9iOCKXt
         JcR7EQbXfeiWFLJVvnFPJ+JLdvuO7VM7nUxuM1TypqCmArX7cwj4FiOr3r3F6GuMJuAL
         s3x0Ugmoy2+l3b7D/8Mwxb/xriXtOCy4gX7PmtAwPWA15A2OfmOpo+SW+38h/bY+/Wg3
         yD62t78MjcL7eepEFnkn1ckKFChcmlPcFQEcCrbmhFXf3eyqCSG+9HNt6d9JKYHkCtaD
         2g9HVpByQ+UZiHAqQEpDKR1oPgYmLrTKNMfHcA/T6nu3msg1tdt0fLeWdrlfnY8qeFJw
         oVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746770; x=1794351570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NpSqWnf1WT+kM3nlRcG6tO5fjhwFoYLjYPpGUhC0vJ0=;
        b=wDyHfVBjBe1eTcPiC2qGYgj7ktvvgmlxjLGxnCn1GmUPKDDRR9UCf4YcZ/rYWVce3o
         1Um5WWBBLnuiBdDWXkS2IXoUtF5ZImaIAnIze7KFeX0xiPU5sT+p30OOAraO9G6iPdNJ
         yna8GDqMfpv/xgNotFubC1yUP/bt0f9bzyUm4yY9PA58lKTxYKoA0ZfelQmHN5kYETfs
         Vl2eUkwAqQOaysP2fGFgnFIti356kljdXYIYBqaM3St3qsddvxvWz5Mm9ZEHqglUhMBO
         RJlkoYucY1bBlbnThx0Mn7LXsWOkdxpFtsp3UjvIgQpMuEpK6aTzpRNPYIi2fIj3IuXU
         8ZnA==
X-Forwarded-Encrypted: i=1; AKwUvBxLJdYgDdqngHbD/jXQCV32sN1M6VLznRP1CqeWpZ3u5N2klT4NBo5kb3DkkTWmUte9fMZwgY4AR19ovA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+68Ku2f34SfU0WksQPW/7HdXR53poM60/jyzLsPVTbo2u6Fd+i
	za5ivK8Efn8gWDav/pkINFtpMBi4vlA9jiIsm3oYVmuiCUqXBr29NdzJ
X-Gm-Gg: AYBFou3fPVifyDr4tDH/ZKDSQRCtlWzsxKPR3P67XYfqfyX+vhkCnuqiwtUVGCobecq
	ErwpxJkfCXbPolv2zj7D0VlNQM+gWYXMGeAgS/tooTlS6whf6S1iDvT+1VRqrBRk4Xm2GWVxOAj
	P3FWhaLExq8+DNorJTocuH0/tyDNXs0eJNqHHplWLVY30FXLF5qhqpa9NCbhiB/SIYZHOzKt48N
	kkg5pGYFXhP2ItGwVM+LrW47pWQNHfI0y7wrmpCzRkMUdAE5B35yXcHM93p2H5PGug/LT407gag
	be37uKHYN7ENmY7YN0nnzv4rwyUx1OFDQMLvj7MA/PBG8TcYG6nUrrKbP/+VHebQZzRzw1tV0z2
	DRyzKRJiJU1zbrj+N0SeZ3XCCLKWROb2eLhTyC2nVsIE7/YOM8Agvgh9Wn/kCrevHfdAA2vPzzO
	LAXRR8b//QhZzJWDw2tM0miRc4rJ8cA89v5bDN3UMD6FFs/I23qkn6nnHvg9NCRd5annBpqHQ6o
	ZD4izZe0J1QBh11LtaVI2+dJ00oi7TM4F4bDcjJm5hR+UuEOtjuPnrjVO5ZkOC3LCwvMt4X9tR6
	zWygqALh7uVo4snPWTcxXn1wL191HNGzGDb4FrKYLEiZ2e0VLbzjBSGpELHxcGzMYHPDChSM3X6
	LuGBDQHzsyPWJWxptzA==
X-Received: by 2002:a05:7301:490c:b0:36a:1819:4d0c with SMTP id 5a478bee46e88-36a42438ebamr22641043eec.41.1793746769329;
        Tue, 03 Nov 2026 14:59:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm1187111eec.8.2026.11.03.14.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:59:28 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Input: stmfts - do not abort event parsing on non-touch events
Date: Tue,  3 Nov 2026 14:58:41 -0800
Message-ID: <20261103225923.3892612-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225923.3892612-1-dmitry.torokhov@gmail.com>
References: <20261103225923.3892612-1-dmitry.torokhov@gmail.com>
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

When processing hardware interrupts, stmfts_read_events() reads a batch
of up to 32 events from the controller FIFO into the buffer. Only
STMFTS_EV_NO_EVENT (0x00) marks the end of valid events in this buffer.

Currently, both stmfts_parse_events() and stmfts5_parse_events() abort
the event parsing loop early upon encountering non-touch events such as
controller-ready, status, user-report, or debug events. This causes any
subsequent touch events that were already read from the FIFO in the same
batch to be discarded.

Update both event parsing loops so only STMFTS_EV_NO_EVENT terminates
processing, while non-touch events complete cmd_done when applicable and
continue processing the remaining entries in the FIFO buffer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmfts.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 727dc8041518..3613c7f2ab15 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -391,15 +391,17 @@ static void stmfts_parse_events(struct stmfts_data *sdata)
 		u8 *event = &sdata->data[i * STMFTS_EVENT_SIZE];
 
 		switch (event[0]) {
+		case STMFTS_EV_NO_EVENT:
+			return;
+
 		case STMFTS_EV_CONTROLLER_READY:
 		case STMFTS_EV_SLEEP_OUT_CONTROLLER_READY:
 		case STMFTS_EV_STATUS:
 			complete(&sdata->cmd_done);
 			fallthrough;
 
-		case STMFTS_EV_NO_EVENT:
 		case STMFTS_EV_DEBUG:
-			return;
+			continue;
 		}
 
 		switch (event[0] & STMFTS_MASK_EVENT_ID) {
@@ -442,19 +444,19 @@ static void stmfts5_parse_events(struct stmfts_data *sdata)
 		u8 *event = &sdata->data[i * STMFTS_EVENT_SIZE];
 
 		switch (event[0]) {
-		case STMFTS5_EV_CONTROLLER_READY:
-			complete(&sdata->cmd_done);
-			fallthrough;
-
 		case STMFTS_EV_NO_EVENT:
 			goto sync;
+
+		case STMFTS5_EV_CONTROLLER_READY:
+			complete(&sdata->cmd_done);
+			continue;
 		}
 
 		switch (event[0] & STMFTS5_MASK_EVENT_ID) {
 		case STMFTS5_EV_STATUS_UPDATE:
 		case STMFTS5_EV_USER_REPORT:
 		case STMFTS5_EV_DEBUG:
-			goto sync;
+			continue;
 
 		case STMFTS5_EV_MULTI_TOUCH_ENTER:
 		case STMFTS5_EV_MULTI_TOUCH_MOTION:
-- 
2.56.0.385.gac671c819a-goog

