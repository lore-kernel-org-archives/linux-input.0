Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEED3B6BF3
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030986; cv=none; b=jpB4vpPDfpTpHOhUGky3ukJVf6KScYeNn4xXazSuOhHC7NLlPH91V5CGnx5o7Ux/CGSECdlj4LGe9sdVR1eD2Nz976UF6/ZaeM4Wfy6fHKaBYVtyYwlNtUxZ/9FC2xNO8YSR/tAwAXHGOnGdCLCawc9QYRC0DITVpid/e8ZT8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030986; c=relaxed/simple;
	bh=tmL9tDdJz2YDX8fFN+wBJ85NBPgilVNWwRltn28rYtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unezvdFy8sjKuq8ioin0EzFSr4ilmOtphPQ0DHcRJDAPQdTb9KS4a9HKX/+EFCTPIraRshNxX89IJOd20jTVw6vIWNd9X+kh3+Odnk0fp64HytWV9UEGVH7hyy0gUMgnkPOEIiQ6tuXnMsbpP7ni8L7XMjvvk81awzHUS3RF6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=g9tsImt+; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="g9tsImt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783030985; bh=tmL9tDdJz2YDX8fFN+wBJ85NBPgilVNWwRltn28rYtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9tsImt+EmiO95yrpDKXBm6N+HJWZRvuem1yvu3k5cLrk0bNv1RkfuwIfxDZlpdXI
	 2AE0IS4Fyq1eLxEkB3a9RqqXsl9mvplqZXJIY7czfXVyfPIVxh45MUNHVq2M3Fnbgm
	 ri1FeLB+8uNq+CodQTUiyfGkMA9lHp+gc0eJbSlLGsz2zHaVXUsPAzu2pr3Ap69fRx
	 zNKmNjtZ167hioJGQdtyOJjEsqFwqE0tPI9SvH37+qmIF8s5zbPN8hUZGAiqHs1zvW
	 2WEQKAYNv4acyuJ7TygB/gpTtaCIkkFhoXNKihl79If6Cl/lSJGd6H7HA9rlpIA0VL
	 IPrqXPXjkPg3w==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id E0BD9A0CF;
	Thu, 02 Jul 2026 15:23:04 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 10/10] HID: steam: Retry send/recv reports if stale
Date: Thu,  2 Jul 2026 15:21:43 -0700
Message-ID: <20260702222145.1863104-10-vi@endrift.com>
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

Sometimes recv report will reply with a stale result from a previous send
report. Instead of failing out, we should retry them, as they generally
reply correctly after three tries, give or take.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 54 +++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index e97431bc2828..8d036b341253 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -486,6 +486,43 @@ static int steam_write_settings(struct steam_device *steam,
 	return steam_recv_report(steam, cmd, 2 + cmd[1]);
 }
 
+static int steam_exchange_report(struct steam_device *steam, u8 *cmd, int csize,
+		u8 *reply, int rsize)
+{
+	unsigned int retries = 5;
+	int ret;
+
+	guard(mutex)(&steam->report_mutex);
+	do {
+		ret = steam_send_report(steam, cmd, csize);
+		if (ret < 0)
+			return ret;
+		ret = steam_recv_report(steam, reply, rsize);
+		/*
+		 * Sometimes this can fail on the first few tries on the Steam
+		 * Controller (2015). It appears to be a firmware bug, and Steam
+		 * itself just retries, so we should also retry a few times to
+		 * see if we get it.
+		 */
+		if (ret == -EPROTO)
+			continue;
+		if (ret < 0) {
+			hid_err(steam->hdev, "%s: error reading reply (%*ph)\n",
+					__func__, csize, cmd);
+			return ret;
+		}
+		if (reply[0] == cmd[0] && reply[1] >= 1)
+			break;
+		if (retries > 0)
+			continue;
+		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
+				rsize, reply);
+		return -EPROTO;
+	} while (retries--);
+
+	return ret;
+}
+
 static int steam_get_serial(struct steam_device *steam)
 {
 	/*
@@ -496,15 +533,10 @@ static int steam_get_serial(struct steam_device *steam)
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
 	u8 reply[3 + STEAM_SERIAL_LEN + 1];
 
-	guard(mutex)(&steam->report_mutex);
-	ret = steam_send_report(steam, cmd, sizeof(cmd));
+	ret = steam_exchange_report(steam, cmd, sizeof(cmd), reply, sizeof(reply));
 	if (ret < 0)
 		return ret;
-	ret = steam_recv_report(steam, reply, sizeof(reply));
-	if (ret < 0)
-		return ret;
-	if (reply[0] != ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
-	    reply[1] > sizeof(steam->serial_no) || reply[2] != ATTRIB_STR_UNIT_SERIAL) {
+	if (reply[1] > sizeof(steam->serial_no) || reply[2] != ATTRIB_STR_UNIT_SERIAL) {
 		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
 				(int)sizeof(reply), reply);
 		return -EIO;
@@ -523,14 +555,10 @@ static int steam_get_attributes(struct steam_device *steam)
 	int i;
 	struct steam_controller_attribute *attr;
 
-	guard(mutex)(&steam->report_mutex);
-	ret = steam_send_report(steam, cmd, sizeof(cmd));
-	if (ret < 0)
-		return ret;
-	ret = steam_recv_report(steam, reply, sizeof(reply));
+	ret = steam_exchange_report(steam, cmd, sizeof(cmd), reply, sizeof(reply));
 	if (ret < 0)
 		return ret;
-	if (reply[0] != ID_GET_ATTRIBUTES_VALUES || reply[1] < 2) {
+	if (reply[1] < 2) {
 		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
 				(int)sizeof(reply), reply);
 		return -EIO;
-- 
2.54.0

