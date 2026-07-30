Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040739AD3B
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384877; cv=none; b=NMS2admdcA96d/3/UKwzm922fbWyG9CnZXMJ4934oLUfJPexozlukoePuUWyvkW2ADQcezsKQ8OPYKIj3YIggZmFUL3q4aLANpauQ7CaupUsHl0HLYFpskEx7kL8+iR1jBiSddNzzOQKowUEjWTtlFqTpZ7LNY0IFvL9oCQDSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384877; c=relaxed/simple;
	bh=R2l7k6LaMVLOXwgOt3mkUilJ6VwnGwnNp2CqEAV0Qck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/mq8hrWL+ZaehGul9libOSm5zFZSCSPDf3t6kOhRTc8nXk3juLoqZgo7zA/sqDU6kaXR397kWx4TolSX4QmsA4eGdzcqVu2R6IfrgPaGmHHj6fapkaYszJO/xA68yu0aYE+fKphJ7KppGzChOa0fmlqosoXTGlt7yEJG9CzOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=qFnxNG3s; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="qFnxNG3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384870; bh=R2l7k6LaMVLOXwgOt3mkUilJ6VwnGwnNp2CqEAV0Qck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFnxNG3siZDqTZInxphOktt2t+MI7wNm8qLFZThAZH6SN7q/8mndZMahjP5zSD7ho
	 f2aAkYjUl5i1KG8C14ialI3xwTd7FuANmP1RlB348smqRqdH6BK+CNB1Iu9M4fJP8f
	 fOdyhABoftuEyBp2oaozTHGugPGAHt3IucmcQBuO6PjwgtjwfSeANCRsrKEMla2MR9
	 R9y9WjuphXWVMZwZIhHzAcFHZ9PsBjuo5o3ow3+7HErog0Az4G96UCXMhe9dL2l1BD
	 gGT1h8PRWqO+VHisnMouHc54QPKnBDy8beXhQiQ/R/3YXdxBQUO7/31Ha1SnprIw6o
	 bKi2ZTzjUWOCg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 17B3113208C;
	Wed, 29 Jul 2026 21:14:30 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 11/11] HID: steam: Retry send/recv reports if stale
Date: Wed, 29 Jul 2026 21:12:34 -0700
Message-ID: <20260730041251.1659029-12-vi@endrift.com>
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

Sometimes recv report will reply with a stale result from a previous send
report. Instead of failing out, we should retry them, as they generally
reply correctly after three tries, give or take.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 54 +++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 3b4a588c20ad..6199f67f3c4c 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -501,6 +501,43 @@ static int steam_write_settings(struct steam_device *steam,
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
@@ -511,15 +548,10 @@ static int steam_get_serial(struct steam_device *steam)
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
 	u8 reply[3 + STEAM_SERIAL_LEN + 1] = {0};
 
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
@@ -537,14 +569,10 @@ static int steam_get_attributes(struct steam_device *steam)
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

