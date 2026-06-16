Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027839A7F2;
	Tue, 16 Jun 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643088; cv=none; b=CAh5F+99TDxyV27WBgIzA5hKlu7q63LNxmCP7FNxQGq4MHxMa0psY6MoR/5yH/qahOlxu0rRBL4nYx+cL/ESiix4FRa4EiYNBGgUD0e8N4InA3dELErtLnGOHcGGPdYpflePtaHLYKB3k4Mqdp3QKdRhYb8FroS29v7GfFkKtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643088; c=relaxed/simple;
	bh=MbHsw42samx2xH/ZKW+PoB6rmQm91u1z7BybUDOTVuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vtiu5s0PxjTl1SMNddvwh3OWl/0rNWWUJGuFCdZuZKc+fPVPhpkqFmvOTZB84QTgjNiYDebgIqSovBr8sFlzjByALWg6QfjW8ZNKMWjvSrO4tXShp5gZ5mPWksGf3CG8jK3y+sgtebz4XEWm1NzkBSr/MmN/QkNjnQRlbYuxQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hNinVss/; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pQYYykm9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hNinVss/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pQYYykm9"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gfzfx6F4Zz9twZ;
	Tue, 16 Jun 2026 22:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/sbe5AapSrG6r3iBm0A/wH45Y9WOVkUdoSa3TP9fwo=;
	b=hNinVss/IatGzdBlpBpEf3EeVzEO+AMrqEVDW9SE73t4Cymn7kLH9FpTwzLP74bMHWxgds
	5xSI6RF9vzHkK2oAYjk6XstfSZbaaRFyKd/FBvUITCXRqLxWVftvg8RklGUUpjcEPT3MyH
	f1UPubkFHQ4VsqvFLlMPlJsscjJuMEB/RA6J1pEAoFMBJvUNPoAapFhmA4V9SX2LUiL+jw
	JHumRpciNyvYmC2ZTvDn116IWtL6qEmgZFPEKhv7gDWGwH0BiZq9gFZ/oJrWlua53eFHZm
	lPw/o/lu7Fm0bmBey7IbyRp0X655884tCmjhH/fVezYax3Bdpdkzj6JJjXhhRA==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/sbe5AapSrG6r3iBm0A/wH45Y9WOVkUdoSa3TP9fwo=;
	b=pQYYykm9uf3KQxA5YOiFsje8ASRK//ZEL9oFMJTRsPHkOnKqIYl+0QB+V9fkNYRol2H8RK
	G4iK6d/TOx0kieWfFxIYvTFzeR9jWaU7i2ewhzSEDpe2cJF36iX8CRI647wj6tOKwb52/I
	PnTJadLz89TVMmfNT/l8zxAPW2NFgP+ClaQSxCrEqIM7dPebVaU51RWNJozWtNgCalfSKT
	/S0/xtiYZcnPOzRJEW8eY1I4jtShIiSvhw+aH4ByCeVAY8p1Z+TkowwA0gxB1gk/XXZWdR
	0Kpv36JOcfoP6dbBaS6Hz3VtFGpbV086NXefFZc+OxYqMIaXKlUeDrVkUxyAfA==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>
Subject: [PATCH v2 2/4] HID: sony: use guard() and scoped_guard()
Date: Tue, 16 Jun 2026 22:50:41 +0200
Message-ID: <20260616205042.6671-4-rosalie@mailbox.org>
In-Reply-To: <20260616205042.6671-2-rosalie@mailbox.org>
References: <20260616205042.6671-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g9h6z9b8rfrypyqk8udbe5gens3qzgw8
X-MBO-RS-ID: 397d8e5db9a326c155c

This replaces the spin_lock_irqsave() and spin_unlock_irqrestore() calls
with the RAII guard() and scoped_guard().

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 62 ++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2d9a5261b63f..84df55c3cbe1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -29,6 +29,7 @@
  * There will be no PIN request from the device.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -571,14 +572,12 @@ static void sony_set_leds(struct sony_sc *sc);
 static inline void sony_schedule_work(struct sony_sc *sc,
 				      enum sony_worker which)
 {
-	unsigned long flags;
-
 	switch (which) {
 	case SONY_WORKER_STATE:
-		spin_lock_irqsave(&sc->lock, flags);
-		if (!sc->defer_initialization && sc->state_worker_initialized)
-			schedule_work(&sc->state_worker);
-		spin_unlock_irqrestore(&sc->lock, flags);
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			if (!sc->defer_initialization && sc->state_worker_initialized)
+				schedule_work(&sc->state_worker);
+		}
 		break;
 	}
 }
@@ -951,7 +950,6 @@ static const u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 static int sixaxis_raw_event(struct sony_sc *sc, u8 *rd, int size)
 {
 	static const u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
-	unsigned long flags;
 	int offset;
 	u8 index;
 	u8 battery_capacity;
@@ -999,10 +997,10 @@ static int sixaxis_raw_event(struct sony_sc *sc, u8 *rd, int size)
 		battery_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	}
 
-	spin_lock_irqsave(&sc->lock, flags);
-	sc->battery_capacity = battery_capacity;
-	sc->battery_status = battery_status;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		sc->battery_capacity = battery_capacity;
+		sc->battery_status = battery_status;
+	}
 
 	if (sc->quirks & SIXAXIS_CONTROLLER) {
 		int val;
@@ -1148,7 +1146,6 @@ static int rb4_ps5_guitar_raw_event(struct sony_sc *sc, u8 *rd, int size)
 	u8 battery_data;
 	u8 battery_capacity;
 	u8 battery_status;
-	unsigned long flags;
 
 	if (unlikely(size != 64 || rd[0] != 0x01))
 		return 0;
@@ -1191,10 +1188,10 @@ static int rb4_ps5_guitar_raw_event(struct sony_sc *sc, u8 *rd, int size)
 		break;
 	}
 
-	spin_lock_irqsave(&sc->lock, flags);
-	sc->battery_capacity = battery_capacity;
-	sc->battery_status = battery_status;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		sc->battery_capacity = battery_capacity;
+		sc->battery_status = battery_status;
+	}
 
 	input_sync(sc->input_dev);
 	return 0;
@@ -1885,15 +1882,14 @@ static int sony_battery_get_property(struct power_supply *psy,
 				     union power_supply_propval *val)
 {
 	struct sony_sc *sc = power_supply_get_drvdata(psy);
-	unsigned long flags;
 	int ret = 0;
 	u8 battery_capacity;
 	int battery_status;
 
-	spin_lock_irqsave(&sc->lock, flags);
-	battery_capacity = sc->battery_capacity;
-	battery_status = sc->battery_status;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		battery_capacity = sc->battery_capacity;
+		battery_status = sc->battery_status;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -1975,10 +1971,9 @@ static inline int sony_compare_connection_type(struct sony_sc *sc0,
 static int sony_check_add_dev_list(struct sony_sc *sc)
 {
 	struct sony_sc *entry;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&sony_dev_list_lock, flags);
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
 
 	list_for_each_entry(entry, &sony_device_list, list_node) {
 		ret = memcmp(sc->mac_address, entry->mac_address,
@@ -1992,26 +1987,23 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 				"controller with MAC address %pMR already connected\n",
 				sc->mac_address);
 			}
-			goto unlock;
+			goto out;
 		}
 	}
 
 	ret = 0;
 	list_add(&(sc->list_node), &sony_device_list);
 
-unlock:
-	spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+out:
 	return ret;
 }
 
 static void sony_remove_dev_list(struct sony_sc *sc)
 {
-	unsigned long flags;
-
 	if (sc->list_node.next) {
-		spin_lock_irqsave(&sony_dev_list_lock, flags);
-		list_del(&(sc->list_node));
-		spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+		scoped_guard(spinlock_irqsave, &sony_dev_list_lock) {
+			list_del(&(sc->list_node));
+		}
 	}
 }
 
@@ -2145,12 +2137,10 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
 static inline void sony_cancel_work_sync(struct sony_sc *sc)
 {
-	unsigned long flags;
-
 	if (sc->state_worker_initialized) {
-		spin_lock_irqsave(&sc->lock, flags);
-		sc->state_worker_initialized = 0;
-		spin_unlock_irqrestore(&sc->lock, flags);
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			sc->state_worker_initialized = 0;
+		}
 		cancel_work_sync(&sc->state_worker);
 	}
 }
-- 
2.54.0

