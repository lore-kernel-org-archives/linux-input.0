Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C736921E
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497341; cv=none; b=KvbaPM0zAoVdVi0xSuUIrFTvWODrZ4M0e4IFPsgFfrf7XRHWsS7rA5eDih8ln0lORnTcflZMB/02R0kf+rSop1CSetGi8mEnywXZn9cCZ5vck9Vkt2EIEJd8+o8lcTuCMV8V21/j6jONzJd4urlEanpCTJgR6VGmM2PhvupgJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497341; c=relaxed/simple;
	bh=+NnmqD1sA2EJx7wtD0dRajA6ibk6/IAXASvmWZznKiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQaO1GP47R/KjsDw5L5vR9zzffjSfa9gCdKxfDdQzbC3g0wkdZu7VFXR5nDad6rU+kss3fTvbOjsN1BEVTAH5h6EKu20H1O1dHrvJVgw2Ah8HVx06rME9YCd3sC0kUxlfcrMGMct1zDOewI0Uu7oMloMmb0SoTkT59hco7OP0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=LBdInc6J; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="LBdInc6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786497332; bh=+NnmqD1sA2EJx7wtD0dRajA6ibk6/IAXASvmWZznKiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBdInc6Jy4USHZejBS6IEvdgMRgHRC3pdFK1ZukWUmmhIocplNth8EcckeTtfw5it
	 yjGz1BeTBB2oTRipqQvJiVet9UlIsGP/taLTnuA4txAVpQKRkOy+OyrFsmy74aYA73
	 DRsL2hhmj5gSLoekgWr3h6bKVkP7y1WyXD0zGvQuspVQ6LoStVaB21iolZXy0rogYm
	 wwZ14iyIitMRKGkraRicPi8/m+AZ5gF0yB9lECtFZhopG+daCVL+HZvUrtDQblkQ/q
	 toyCLBoeM6IujAGO327mJbqgfgGP9VKku/gt0pi9xAA98cxFO4aUvXTNhc63khsh15
	 TFJXXdn2cl5/A==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 9A0F4A090;
	Tue, 11 Aug 2026 18:15:32 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 1/6] HID: steam: Refactor registration
Date: Tue, 11 Aug 2026 18:13:52 -0700
Message-ID: <20260812011401.3250968-2-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812011401.3250968-1-vi@endrift.com>
References: <20260812011401.3250968-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactors and simplifies the registration/unregistration flow. Since
we now only perform registration when the client isn't opened anymore, the
logic for handling that can be removed, and the rest of the function
streamlined.

We also remove the previous assumption that we have a serial number to show
we're registered, replacing it with a single purpose boolean.

In a previous refactor the code for unregistering a battery if later
registration steps failed was accidentally left out. As a result, a
lingering power_supply object could get left over after the steam object
was torn down. This is also fixed here.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 81 +++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 6199f67f3c4c..d4ebc1efc01e 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -334,6 +334,7 @@ struct steam_device {
 	unsigned long quirks;
 	struct work_struct work_connect;
 	bool connected;
+	bool registered;
 	char serial_no[STEAM_SERIAL_LEN + 1];
 	struct power_supply_desc battery_desc;
 	struct power_supply __rcu *battery;
@@ -1139,9 +1140,6 @@ static void steam_battery_unregister(struct steam_device *steam)
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
-	unsigned long client_opened;
-	unsigned long flags;
-	bool do_add;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -1149,66 +1147,63 @@ static int steam_register(struct steam_device *steam)
 	 * another client send a get_connection_status command, for example.
 	 * The battery and serial number are set just once per device.
 	 */
-	if (!steam->serial_no[0]) {
-		/*
-		 * Unlikely, but getting the serial could fail, and it is not so
-		 * important, so make up a serial number and go on.
-		 */
-		if (steam_get_serial(steam) < 0)
-			strscpy(steam->serial_no, "XXXXXXXXXX",
-					sizeof(steam->serial_no));
-
-		ret = steam_get_attributes(steam);
-		if (ret < 0)
-			hid_err(steam->hdev,
-				"%s:steam_get_attributes failed with error %d\n",
-				__func__, ret);
+	if (steam->registered)
+		return 0;
 
-		hid_info(steam->hdev, "Steam Controller '%s' connected",
-				steam->serial_no);
+	/*
+	 * Unlikely, but getting the serial could fail, and it is not so
+	 * important, so make up a serial number and go on.
+	 */
+	if (steam_get_serial(steam) < 0 || !steam->serial_no[0])
+		strscpy(steam->serial_no, "XXXXXXXXXX",
+				sizeof(steam->serial_no));
 
-		/* ignore battery errors, we can live without it */
-		if (steam->quirks & STEAM_QUIRK_WIRELESS)
-			steam_battery_register(steam);
+	ret = steam_get_attributes(steam);
+	if (ret < 0)
+		hid_err(steam->hdev,
+			"%s:steam_get_attributes failed with error %d\n",
+			__func__, ret);
 
-		do_add = true;
-	}
+	hid_info(steam->hdev, "Steam Controller '%s' connected",
+			steam->serial_no);
 
-	spin_lock_irqsave(&steam->lock, flags);
-	client_opened = steam->client_opened;
-	spin_unlock_irqrestore(&steam->lock, flags);
+	/* ignore battery errors, we can live without it */
+	if (steam->quirks & STEAM_QUIRK_WIRELESS)
+		steam_battery_register(steam);
 
-	if (!client_opened) {
-		steam_set_lizard_mode(steam, lizard_mode);
-		ret = steam_input_register(steam);
-		if (ret != 0)
-			goto steam_register_input_fail;
-		ret = steam_sensors_register(steam);
-		if (ret != 0)
-			goto steam_register_sensors_fail;
-	}
+	steam_set_lizard_mode(steam, lizard_mode);
+	ret = steam_input_register(steam);
+	if (ret != 0)
+		goto steam_register_input_fail;
+	ret = steam_sensors_register(steam);
+	if (ret != 0)
+		goto steam_register_sensors_fail;
 
-	if (do_add) {
-		mutex_lock(&steam_devices_lock);
-		if (list_empty(&steam->list))
-			list_add(&steam->list, &steam_devices);
-		mutex_unlock(&steam_devices_lock);
-	}
+	steam->registered = true;
+	mutex_lock(&steam_devices_lock);
+	if (list_empty(&steam->list))
+		list_add(&steam->list, &steam_devices);
+	mutex_unlock(&steam_devices_lock);
 	return 0;
 
 steam_register_sensors_fail:
 	steam_input_unregister(steam);
 steam_register_input_fail:
+	steam_battery_unregister(steam);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->mode_switch);
+	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
 	return ret;
 }
 
 static void steam_unregister(struct steam_device *steam)
 {
-	if (!steam->serial_no[0])
+	if (!steam->registered)
 		return;
 
 	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
 			steam->serial_no);
+	steam->registered = false;
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
-- 
2.54.0

