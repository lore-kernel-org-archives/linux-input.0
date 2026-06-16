Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDD39D6F6;
	Tue, 16 Jun 2026 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643089; cv=none; b=fp4sEUy8134AjWegmFxdKGvvHokm2a16Bt9lC1QbhTD11ectm2Am45nI4qzluPYrvGmlXBWXRoPWu/fOV8ba+pn723UBnLalpFIM4Wp/UWiLCl8Th3ZfWmHY1hNdTOxzNkmuyPn+98VsbJIZ74JyHdSK7xd4J5a/1urfo2WOECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643089; c=relaxed/simple;
	bh=OQiQk5FKeVvhPZ1ZyAmGFF1PrRpfkCIJ0cxb9YtkaeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6b0y0+HyslYHqergPY06q96C5ovIDVRHsU+lAS3DAUDw22VM3NsxzfnUwcNNXcd7wRZ/4ZzEV/S33hQXJkGNgqM7hI44/MiWbwCEwj8JWLzXVPLxqA7mFC+Wv00ry1hlPrWeZoPJbfN8JuU02MaEehqVzUipr/DfB76rVxFpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MIWJlpWn; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OQNUiTc7; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MIWJlpWn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OQNUiTc7"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gfzfz5g1Cz9tN7;
	Tue, 16 Jun 2026 22:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJG5z4yGA2fTT6p9RAokKoGIXdOZMaoZ/gCQfQ8Jr8I=;
	b=MIWJlpWnQlff/pLV7/cgyGDBl6T8790H6iHhUaSosm8rqgEevkIsDNHGVYWHHnLaddZC7N
	f4VsHNHyaf5EGcNOPk6vxolpdaUr46XuSTOJHkWi6dT7MAzbei7SlvK/Q//O4XXeROCGLq
	bv1HRgnsJ70Kpnxvc9eP9hlInrj9m2VoqaqFpXpsG/RpH5oAenTGYke8wv1fKncgXtef9g
	XDAIyl+5Fvz6PzUpZAFyY6xLjfqi5w34o7+RIrPXz5Z6KClyZ3WCFRRRF7mZISPAYTMdWI
	RSz0qFx6wSi3WJhjjScX5i1nl4usnU3sntxsf6WLTovjUWA2yooq39mecgiftg==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJG5z4yGA2fTT6p9RAokKoGIXdOZMaoZ/gCQfQ8Jr8I=;
	b=OQNUiTc758CuURn7ymoDtA3RASS57krRUSG10oq1yxQtwVBbKKwP01AtSWaHdMgT2WIKbE
	aJE7tdGu0UV2y/5lB1PzsIu9H8yvpWSkaFIZw1GuVVcbCePj6UYu18593rXkUwYnc1vEW5
	GxcrCa0myxCVvvrsB1qQmPjXyOymLvhOOknL+/dAxMq6A6ToDqBrmiN6MNkcb8cg6R0vMj
	/letjTcBCSmLm2LhPGpAx91arUiPgJXAPUtxegNfNYmfmqZundeNt16xRHTnlvMc1Aqdut
	Mex/iCbPL5VB1S7SqK0d+dd07L27K2iwnYmYxA+39zKIYQNsPKxqgvyhTDcGNg==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>
Subject: [PATCH v2 3/4] HID: sony: remove unneeded which argument from sony_schedule_work()
Date: Tue, 16 Jun 2026 22:50:42 +0200
Message-ID: <20260616205042.6671-5-rosalie@mailbox.org>
In-Reply-To: <20260616205042.6671-2-rosalie@mailbox.org>
References: <20260616205042.6671-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a9638ce9cf04dbfa285
X-MBO-RS-META: dar4m95ghq3y97xs1s3ccn655txcz1rm

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

