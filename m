Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888A261B8D
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290053; cv=none; b=hqB6zPzHZWJxPJJTLW0Zex/MFKRT6EdPrOymRBlDlFpEqH05mb5UgJh1c3apPUu9KiLGK1W/KL446n/N+sawe34YdWAJtIxRBDla+vrwX2R2YCL46RyVDff0F12G3QNx8iDbaq75XwwjP/BXi0vaSLGsICaQQtY//1jsGmsE67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290053; c=relaxed/simple;
	bh=+FC1LJDJyTMjyMRTyyr9gGlxU4p3N1zii14wIJ1B0O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSRbJapmmAtPr3vWMt0HNgjl4+6gsTUhUIiAZAHvTBfYVitLuTgPslWOv6sGD/JTPP9fo/cx8frfM2b88NTFInEu3CAOFqPpp6wL64PKSlXnXYtKSjrjteeCkICv8ZvnCvjoVOO+S6dd58KSaK7MNE/pipAakZQXtw5XM5v1qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=DvAQHTXu; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="DvAQHTXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290047; bh=+FC1LJDJyTMjyMRTyyr9gGlxU4p3N1zii14wIJ1B0O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvAQHTXuF4BLupWzHgLK48FAcbGswHbZJHIt1JUCYTJrOx0pGDzJ5UhMG+YAUmsIH
	 9b1TzJzpTg68qr3VxYv0vw96rTMon/a5w+k9IFY17dS7VpH9dMHYGvpFhks8pIytIg
	 V3r3E3ad/IC5A+3XnCDUPS5VJOk0V1r4IPQLfbUnO0oy00OuPO39kL2tNBF1kxKAqv
	 HoHfoss1CWwp7XBM+8K971txREi/vuJNJ1GWViEv1zIQT+pLoGAbJifgrTdK1UTvT0
	 fdi1Zaf+d38zn5YJPaDMmEySC21+MXyxMPT6k6/GicQTmH1Hk8R8jslUT1l74JrnmJ
	 h9EpjjrabufWw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3B87BA29A;
	Tue, 28 Jul 2026 18:54:07 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 09/11] HID: steam: Improve logging and other cleanup
Date: Tue, 28 Jul 2026 18:52:31 -0700
Message-ID: <20260729015243.1170573-10-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
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
index 5ab4396a241e..3738a4de3bff 100644
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
@@ -481,21 +490,20 @@ static int steam_get_serial(struct steam_device *steam)
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
 	u8 reply[3 + STEAM_SERIAL_LEN + 1] = {0};
 
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
 	strscpy(steam->serial_no, reply + 3, reply[1]);
-out:
-	mutex_unlock(&steam->report_mutex);
 	return ret;
 }
 
@@ -515,8 +523,11 @@ static int steam_get_attributes(struct steam_device *steam)
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
@@ -538,11 +549,8 @@ static int steam_get_attributes(struct steam_device *steam)
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
@@ -1195,6 +1203,7 @@ static void steam_mode_switch_cb(struct work_struct *work)
 		return;
 
 	steam->gamepad_mode = !steam->gamepad_mode;
+	hid_dbg(steam->hdev, "%s: switching gamepad mode to %i\n", __func__, steam->gamepad_mode);
 	if (steam->gamepad_mode)
 		steam_set_lizard_mode(steam, false);
 	else {
@@ -1838,6 +1847,7 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 		steam->did_mode_switch = false;
 		cancel_delayed_work(&steam->mode_switch);
 	} else if (!steam->client_opened && start_pressed && !steam->did_mode_switch) {
+		hid_dbg(steam->hdev, "%s: doing mode switch\n", __func__);
 		steam->did_mode_switch = true;
 		schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
 	}
-- 
2.54.0

