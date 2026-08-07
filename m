Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870A3F4845
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145113; cv=none; b=KGgyCHxso7mQ0s+W8BluZde/90XHkQ0nWxps69qwdxCVjApZkmPp57n1jNPuvcMkEc6B3Ncq70F9yUzUcGnzXyajXBlKSq/uctu38tXEI7SOXIdzwjJRxYrFafcYJfGtv6lKkvk1eeQaqEXzF0lOGiNJyJoQ8pbY5x6pIg3dHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145113; c=relaxed/simple;
	bh=iX2koLzLC5LC2Z5HkRI/KgsEtd46/HWcQAs6oq7Lk9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/VW+tR90RTcofmynb7bZ1mmh6tk3yZCPXnTeVyeDTOtM7FnXgEPMQcrTcWGLRLQ1spCBNyscAlEvWsM5nYLaqq8kzzBUVnPK9J0vV8oniyxyTU7Gu8VMaJ3lm7y1lLRQWvaZ6WaDu2Hz28J3uFS/NzNtdQqqnH1pFrW2JcShrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=xylMgkHN; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="xylMgkHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786145105; bh=iX2koLzLC5LC2Z5HkRI/KgsEtd46/HWcQAs6oq7Lk9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xylMgkHNCDAA35OimN8PjKyo3iSuwvkL/VQm/A+alJ7HdW05sxoN1LRIj2bCBNIXo
	 XBngTWMbTmNQKmXcy5Khm93j+Pq7Uxu8mMq+i8mPMIAWtJfvcE6sujULYvazvSILpD
	 E7FNAYafRz1dpcYdyGJ3nxGzzevQ+7trhEjr0DYvP9whRcpvOyKG0PGmtSAZ8Jc6L0
	 wGWjEw0WotncGZXvnb+QcfUZaZ5yHrUDDq9L6gKnMd07uq3aI15sD/phOMiG1J8JFW
	 cci0ZeXNf35fZloS5Hsa6KdpQfKpYgu5kASwDbtiPmO/geLHzTIopj4DQFUNtFMAxY
	 0TWHnZ4rw5u/w==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 89680A074;
	Fri, 07 Aug 2026 16:25:05 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 1/6] HID: steam: Refactor registration
Date: Fri,  7 Aug 2026 16:23:32 -0700
Message-ID: <20260807232339.2799205-2-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807232339.2799205-1-vi@endrift.com>
References: <20260807232339.2799205-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 78 ++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 6199f67f3c4c..5deeff2db266 100644
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
@@ -1149,66 +1147,60 @@ static int steam_register(struct steam_device *steam)
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

