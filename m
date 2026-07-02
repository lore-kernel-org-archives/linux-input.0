Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B193B8930
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030986; cv=none; b=qPxWaQaCzHfRtj57JwVCO8HWaYz8llkwodlXe9yxCBmqItMqiboUtKVGSvcLodNGdou5izr/8KYoWHdSm1EHSbl2d66sfHhbP34S8dGWawi98xWqbQXlM4dJguoubmLHVqBwcLMR2CSEo5fPG+nSUMZSZYhFGdq/vAxXq7Pgk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030986; c=relaxed/simple;
	bh=95DD6+s4VQdJOALYog/Xp9cZu4mAke3sp4D1qYl2cQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmxiazQhZEfSSe2N0ze9dlprVKsM091K9HqFZ9j5oywQJWUWyYXRKCjsCZ9K7igkVs1EZoHOZZsHMVNidHC/rAj/JyaFBCYo1NnE0TT5mMEOvDnbNbM4zisEPMkEAPCgFfML77751zUBuqme1SLigRjQHuPIcy6GIciJ1gih9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=ljPsf8bV; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="ljPsf8bV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783030984; bh=95DD6+s4VQdJOALYog/Xp9cZu4mAke3sp4D1qYl2cQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljPsf8bVafJavgo030CWztx6RH3Zpc9uMQO6p9y+IO8Ark+k5/SS3c7qIURC/dkV/
	 ASpvXZaIhWcjGq1KZGYMSO1jJGDx1/h9cKf/T0NvqUBUoH2bxM5M1koI6hlUiUochY
	 mlL6Fm16yTLUgJ1mq+1XSudd5SsGnNzT6B/M/gr+Hj/XkveFdtZaEMPYHKDb4cq6vX
	 ISsxVBwLvkTS6UftaWG1J9STZTPWIYOFwmR1BR9mK3VM/ahMjGuRGm6T+O+HydrUlj
	 Q49mbeSIlhN/9bA9yRaabJtoVRqtLBka0/B+shTsCBNdGO2z4OPkcChr21WLsFhC8Q
	 7A8pcvs+RnNGQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0F7F4A0B5;
	Thu, 02 Jul 2026 15:23:04 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 08/10] HID: steam: Improve logging and other cleanup
Date: Thu,  2 Jul 2026 15:21:41 -0700
Message-ID: <20260702222145.1863104-8-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702222145.1863104-1-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds more logging as appropriate, reindents an enum to match surrounding
style, as well as cleaning up some places where we can use guard() instead
of doing locking and unlocking manually.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 56 ++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 9d1fe9792101..593151709cf1 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -246,14 +246,14 @@ enum {
 /* Input report identifiers */
 enum
 {
-	ID_CONTROLLER_STATE = 1,
-	ID_CONTROLLER_DEBUG = 2,
-	ID_CONTROLLER_WIRELESS = 3,
-	ID_CONTROLLER_STATUS = 4,
-	ID_CONTROLLER_DEBUG2 = 5,
-	ID_CONTROLLER_SECONDARY_STATE = 6,
-	ID_CONTROLLER_BLE_STATE = 7,
-	ID_CONTROLLER_DECK_STATE = 9
+	ID_CONTROLLER_STATE		= 1,
+	ID_CONTROLLER_DEBUG		= 2,
+	ID_CONTROLLER_WIRELESS		= 3,
+	ID_CONTROLLER_STATUS		= 4,
+	ID_CONTROLLER_DEBUG2		= 5,
+	ID_CONTROLLER_SECONDARY_STATE	= 6,
+	ID_CONTROLLER_BLE_STATE		= 7,
+	ID_CONTROLLER_DECK_STATE	= 9,
 };
 
 /* Read-only attributes */
@@ -379,9 +379,16 @@ static int steam_recv_report(struct steam_device *steam,
 	ret = hid_hw_raw_request(steam->hdev, 0x00,
 			buf, hid_report_len(r) + 1,
 			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
-	if (ret > 0)
-		memcpy(data, buf + 1, min(size, ret - 1));
+	if (ret > 0) {
+		ret = min(size, ret - 1);
+		memcpy(data, buf + 1, ret);
+	}
 	kfree(buf);
+
+	if (ret < 0)
+		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
+	else
+		hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
 	return ret;
 }
 
@@ -409,6 +416,8 @@ static int steam_send_report(struct steam_device *steam,
 	/* The report ID is always 0 */
 	memcpy(buf + 1, cmd, size);
 
+	hid_dbg(steam->hdev, "Sending report %*ph\n", size, cmd);
+
 	/*
 	 * Sometimes the wireless controller fails with EPIPE
 	 * when sending a feature report.
@@ -481,22 +490,21 @@ static int steam_get_serial(struct steam_device *steam)
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
 	u8 reply[3 + STEAM_SERIAL_LEN + 1];
 
-	mutex_lock(&steam->report_mutex);
+	guard(mutex)(&steam->report_mutex);
 	ret = steam_send_report(steam, cmd, sizeof(cmd));
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = steam_recv_report(steam, reply, sizeof(reply));
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (reply[0] != ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
 	    reply[1] > sizeof(steam->serial_no) || reply[2] != ATTRIB_STR_UNIT_SERIAL) {
-		ret = -EIO;
-		goto out;
+		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
+				(int)sizeof(reply), reply);
+		return -EIO;
 	}
 	reply[3 + STEAM_SERIAL_LEN] = 0;
 	strscpy(steam->serial_no, reply + 3, reply[1]);
-out:
-	mutex_unlock(&steam->report_mutex);
 	return ret;
 }
 
@@ -516,8 +524,11 @@ static int steam_get_attributes(struct steam_device *steam)
 	ret = steam_recv_report(steam, reply, sizeof(reply));
 	if (ret < 0)
 		return ret;
-	if (reply[0] != ID_GET_ATTRIBUTES_VALUES || reply[1] < 2)
+	if (reply[0] != ID_GET_ATTRIBUTES_VALUES || reply[1] < 2) {
+		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
+				(int)sizeof(reply), reply);
 		return -EIO;
+	}
 
 	size = min(reply[1], sizeof(reply) - 2);
 	for (i = 0; i + sizeof(*attr) <= size; i += sizeof(*attr)) {
@@ -539,11 +550,8 @@ static int steam_get_attributes(struct steam_device *steam)
  */
 static inline int steam_request_conn_status(struct steam_device *steam)
 {
-	int ret;
-	mutex_lock(&steam->report_mutex);
-	ret = steam_send_report_byte(steam, ID_DONGLE_GET_WIRELESS_STATE);
-	mutex_unlock(&steam->report_mutex);
-	return ret;
+	guard(mutex)(&steam->report_mutex);
+	return steam_send_report_byte(steam, ID_DONGLE_GET_WIRELESS_STATE);
 }
 
 /*
@@ -1193,6 +1201,7 @@ static void steam_mode_switch_cb(struct work_struct *work)
 		return;
 
 	steam->gamepad_mode = !steam->gamepad_mode;
+	hid_dbg(steam->hdev, "%s: switching gamepad mode to %i\n", __func__, steam->gamepad_mode);
 	if (steam->gamepad_mode)
 		steam_set_lizard_mode(steam, false);
 	else {
@@ -1834,6 +1843,7 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 		steam->did_mode_switch = false;
 		cancel_delayed_work(&steam->mode_switch);
 	} else if (!steam->client_opened && start_pressed && !steam->did_mode_switch) {
+		hid_dbg(steam->hdev, "%s: doing mode switch\n", __func__);
 		steam->did_mode_switch = true;
 		schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
 	}
-- 
2.54.0

