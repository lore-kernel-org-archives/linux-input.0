From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v3 2/4] Input: zforce_ts: allow open even if initialisation is not completed
Date: Wed, 4 May 2016 12:24:39 +0200
Message-ID: <1462357481-16258-3-git-send-email-dirk.behme@de.bosch.com>
References: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:42113 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383AbcEDKYr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 06:24:47 -0400
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 7546ED8021F
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:45 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 257DF1B8063E
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:45 +0200 (CEST)
In-Reply-To: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>

From: Oleksij Rempel <linux@rempel-privat.de>

Make sure zforce_start() is not called if FW init was not completed.

Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 9839d86..c912a0b 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -102,7 +102,6 @@ struct zforce_point {
 enum zforce_state {
 	ZF_STATE_UNINITIALZED = 0,
 	ZF_STATE_PROBE_COMPLETE,
-	ZF_STATE_DEV_OPENED,
 };
 
 /*
@@ -150,6 +149,7 @@ struct zforce_ts {
 	int			notification;
 
 	enum zforce_state	state;
+	atomic_t		opened;
 };
 
 static int zforce_command(struct zforce_ts *ts, u8 cmd)
@@ -647,12 +647,13 @@ static void zforce_boot(struct zforce_ts *ts)
 
 		ts->state = ZF_STATE_PROBE_COMPLETE;
 		break;
-	case ZF_STATE_DEV_OPENED:
-		ret = zforce_start(ts);
-		if (ret)
-			dev_err(dev, "Failed to restart, %d\n", ret);
-		break;
 	}
+
+	if (!atomic_read(&ts->opened))
+		return;
+
+	if (zforce_start(ts))
+		dev_err(dev, "Failed to restart, %d\n", ret);
 }
 
 static void zforce_notification_queue(struct work_struct *work)
@@ -690,11 +691,13 @@ static int zforce_input_open(struct input_dev *dev)
 	struct zforce_ts *ts = input_get_drvdata(dev);
 	int ret;
 
-	ret = zforce_start(ts);
-	if (ret)
-		return ret;
+	if (ts->state == ZF_STATE_PROBE_COMPLETE) {
+		ret = zforce_start(ts);
+		if (ret)
+			return ret;
+	}
 
-	ts->state = ZF_STATE_DEV_OPENED;
+	atomic_inc(&ts->opened);
 
 	return 0;
 }
@@ -709,7 +712,7 @@ static void zforce_input_close(struct input_dev *dev)
 	if (ret)
 		dev_warn(&client->dev, "stopping zforce failed\n");
 
-	ts->state = ZF_STATE_PROBE_COMPLETE;
+	atomic_dec(&ts->opened);
 
 	return;
 }
-- 
1.9.1

