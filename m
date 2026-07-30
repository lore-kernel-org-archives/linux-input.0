Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BB39B48E
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384877; cv=none; b=iFhE3UHN1hYGhHD0wrY+ttOvKB+DEcCFRLYvARHYCrpIpkqDQMOSJLbmMLBF6hHu3k3AqYlZwvV+f4GxeYqupy7Wiv1dVdut3nH5/2W2lm8DLWvNt8bHjirTd73cmsnTLYnuYBx0U2b/gwHyDIL91ETwNstySfhPc5A8hO0dOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384877; c=relaxed/simple;
	bh=DqJDVIbUgMloduSy9Nx1ZfShKN1ZiC/faE0AMNgS31A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhGNhYUikK78EqqB8aE172B5PsFbUCTxdOnAMr7jKSTM0h8f353w/Inl2Wk9Tne28TZatukDHwgfovf/MEnD7udZGvuaW/J3g1QnZxPHPAoUC5MM6jozrLtSrIpxZmoGrWZAwFkK3kKB1x7ex9qzVAxvpgO0mPmg3VBhFk36FZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=VOJ4onvM; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="VOJ4onvM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384869; bh=DqJDVIbUgMloduSy9Nx1ZfShKN1ZiC/faE0AMNgS31A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOJ4onvMqGuS9BesxTp8xtVvTAQl4vmxBksx2hhdaNTQ1aM2/LADylQA00FPR0Rtp
	 EnH9sYt7E05lBq4YIIk1Pi77ICJNOF7ikgnbvifLcDDT/dUTcYhqXgxIHQggTf6dHa
	 bOPg7dUkYw3ZnL7jbFN3hHQ8OHmKlNsaJVtQkA2hxyVnWo4OrKnMnL4nZVfcPNgNGV
	 6BMYfw0JtmT4Ik5wMWGn8aaudhd7TwtvulLU8yyEdcFKWWXdyzPt3vfpkmw5tGTNw9
	 8oexdxly9hgISlzstVYiLDeRteo1RAvXDF7O6cjm4HzyLA9KVduIh2FqwqOcrm9YQ0
	 wKUEEFlkhv/tg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id C6FD5132038;
	Wed, 29 Jul 2026 21:14:28 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 08/11] HID: steam: Improve logging and other cleanup
Date: Wed, 29 Jul 2026 21:12:31 -0700
Message-ID: <20260730041251.1659029-9-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730041251.1659029-1-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
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
index 663fda8a86fd..222b5751040a 100644
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
@@ -1201,6 +1209,7 @@ static void steam_mode_switch_cb(struct work_struct *work)
 		return;
 
 	steam->gamepad_mode = !steam->gamepad_mode;
+	hid_dbg(steam->hdev, "%s: switching gamepad mode to %i\n", __func__, steam->gamepad_mode);
 	if (steam->gamepad_mode)
 		steam_set_lizard_mode(steam, false);
 	else {
@@ -1841,6 +1850,7 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 		steam->did_mode_switch = false;
 		cancel_delayed_work(&steam->mode_switch);
 	} else if (!steam->client_opened && start_pressed && !steam->did_mode_switch) {
+		hid_dbg(steam->hdev, "%s: doing mode switch\n", __func__);
 		steam->did_mode_switch = true;
 		schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
 	}
-- 
2.54.0

