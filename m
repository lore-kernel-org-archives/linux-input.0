From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/5] Input: zforce_ts: Reject open if initialization not finished
Date: Wed, 20 Apr 2016 08:54:42 +0200
Message-ID: <1461135285-17582-2-git-send-email-dirk.behme@de.bosch.com>
References: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:55480 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbcDTGyw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2016 02:54:52 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 21412158016B
	for <linux-input@vger.kernel.org>; Wed, 20 Apr 2016 08:54:50 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id CB5AE2380356
	for <linux-input@vger.kernel.org>; Wed, 20 Apr 2016 08:54:49 +0200 (CEST)
In-Reply-To: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Dirk Behme <dirk.behme@de.bosch.com>

From: Oleksij Rempel <linux@rempel-privat.de>

Response EAGAIN when opening the device while BOOT_COMPLETE
notification is not received and initialization of the zForce touch
controller is not finished.

Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 0c08220..ddfc120 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -690,6 +690,10 @@ static int zforce_input_open(struct input_dev *dev)
 	struct zforce_ts *ts = input_get_drvdata(dev);
 	int ret;
 
+	/* if not probed try again later */
+	if (ts->state == ZF_STATE_UNINITIALZED)
+		return -EAGAIN;
+
 	ret = zforce_start(ts);
 	if (ret)
 		return ret;
-- 
2.8.0

