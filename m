Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD488286A7;
	Fri,  8 May 2026 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216652; cv=none; b=pt07+n6R1QcNL120X3ba/KCrV252/UDrdrMV6E3NHfGgF/2AgXwX0Y7pvP2mxcYS5Dme2p/kGLOPvnEZd6kNt6IUB5G5s+p2pXiq395Ilkjr1rz0fyCyUCLl8zCrcn8dKv3PJKgZ1THMOoeLkAuAxn+MP1OE4Ry8GaawaWK3Qec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216652; c=relaxed/simple;
	bh=OQiQk5FKeVvhPZ1ZyAmGFF1PrRpfkCIJ0cxb9YtkaeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVPYsCwaDaox6qTn4xm9hIYTAcaWZw3N5STW3Z+pTdcyWJ8iIt9ppqHqwSTz9oK25WlPoH4tIykgRf5PJ0cnjke/Jm5EIPeSPPAPMyoIxePJMUbUKqNXHaIkkbHjKusKXQBJr1BHz+lqgBHBWEezCmMOmPf+gtotKWAMpxPUYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kLFSHKTI; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ub4YF8At; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kLFSHKTI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ub4YF8At"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBcJH3plmz9t8p;
	Fri,  8 May 2026 06:55:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778216143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJG5z4yGA2fTT6p9RAokKoGIXdOZMaoZ/gCQfQ8Jr8I=;
	b=kLFSHKTIYXMJFL6bZRv5xpJ8TPnYqv5HIZdwtGZaryPN8nprn0N3AVPbuzwzT0whpv4Ssd
	9J2kU5O+8vuROKsC0b9J1btBf8mBcX/cQOiiG9RjpF8FdzuAGpumhoBw9fGqRl/BiF54nN
	mlTVFu20vwnKBGr3hC1sR8eHyCtcYKbQMD+BQzrRsFgbGyMrQ7nNShiDzOKcH4Vja+9eSC
	yqsP/7jqPi8V+D0kHBFLKx5RW2LMu0fnDE7XadEnzJXyY33xhqOjBI3PNE6Xb204xqMsax
	q8MbK1AFYGYYh1us9V/U573kEb0uCQKQMJEAHQ+3q6Ger6qUDAwSeVMr4DYjkw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Ub4YF8At;
	spf=pass (outgoing_mbo_mout: domain of rosalie@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=rosalie@mailbox.org
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778216142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJG5z4yGA2fTT6p9RAokKoGIXdOZMaoZ/gCQfQ8Jr8I=;
	b=Ub4YF8At/C5uUtFY3kFOq28dXblhDBgFVSW84hpqP0M8PMC90vcK7vfN5CW1Yvcc7cuc4U
	bPsGjqjs43xP+9PselbaeT1SQ1/7eTq1Jtf7kSKrWKOBajra0fEhZmKn5uZWPOxYxaBReS
	qVCuzRrcOqmhVGQuBHCl8Szi8o17C93zRi/BNc6/Pv0R/f4T05VzRK/KWQBgEaHm0Tfgvu
	8ATXcUhToVTg5XGRzVzGq7z3p5ejKZfHQ4WFl6zUR3qnH2h06nSy+vPr1eCnC80n2O0r7S
	OL9C304/WdkhIeya42Q3lergr4YeOoW2EWXjhoRenFE0twCgImtokwHBx/R8XQ==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>
Subject: [PATCH 2/3] HID: sony: remove unneeded which argument from sony_schedule_work()
Date: Fri,  8 May 2026 06:51:10 +0200
Message-ID: <20260508045111.495032-3-rosalie@mailbox.org>
In-Reply-To: <20260508045111.495032-1-rosalie@mailbox.org>
References: <20260508045111.495032-1-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jnafdcrjf6ihkhd8wxgeqm7wiqrp5dk8
X-MBO-RS-ID: af7852410ad091bbfba
X-Rspamd-Queue-Id: 4gBcJH3plmz9t8p

The sony_worker enum only had a single member, so removing it simplifies
sony_schedule_work().

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 84df55c3cbe1..ff681ebc76ce 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -523,10 +523,6 @@ static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
 
-enum sony_worker {
-	SONY_WORKER_STATE
-};
-
 struct sony_sc {
 	spinlock_t lock;
 	struct list_head list_node;
@@ -569,17 +565,11 @@ struct sony_sc {
 
 static void sony_set_leds(struct sony_sc *sc);
 
-static inline void sony_schedule_work(struct sony_sc *sc,
-				      enum sony_worker which)
+static inline void sony_schedule_work(struct sony_sc *sc)
 {
-	switch (which) {
-	case SONY_WORKER_STATE:
-		scoped_guard(spinlock_irqsave, &sc->lock) {
-			if (!sc->defer_initialization && sc->state_worker_initialized)
-				schedule_work(&sc->state_worker);
-		}
-		break;
-	}
+	guard(spinlock_irqsave)(&sc->lock);
+	if (!sc->defer_initialization && sc->state_worker_initialized)
+		schedule_work(&sc->state_worker);
 }
 
 static void ghl_magic_poke_cb(struct urb *urb)
@@ -1211,7 +1201,7 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (unlikely(sc->defer_initialization)) {
 		sc->defer_initialization = 0;
-		sony_schedule_work(sc, SONY_WORKER_STATE);
+		sony_schedule_work(sc);
 	}
 
 	return 0;
@@ -1520,7 +1510,7 @@ static void buzz_set_leds(struct sony_sc *sc)
 static void sony_set_leds(struct sony_sc *sc)
 {
 	if (!(sc->quirks & BUZZ_CONTROLLER))
-		sony_schedule_work(sc, SONY_WORKER_STATE);
+		sony_schedule_work(sc);
 	else
 		buzz_set_leds(sc);
 }
@@ -1631,7 +1621,7 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
 		new_off != drv_data->led_delay_off[n]) {
 		drv_data->led_delay_on[n] = new_on;
 		drv_data->led_delay_off[n] = new_off;
-		sony_schedule_work(drv_data, SONY_WORKER_STATE);
+		sony_schedule_work(drv_data);
 	}
 
 	return 0;
@@ -1859,7 +1849,7 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 	sc->left = effect->u.rumble.strong_magnitude / 256;
 	sc->right = effect->u.rumble.weak_magnitude / 256;
 
-	sony_schedule_work(sc, SONY_WORKER_STATE);
+	sony_schedule_work(sc);
 	return 0;
 }
 
-- 
2.54.0

