From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v2 2/4] Input: zforce_ts: Reject open if initialization not finished
Date: Tue, 3 May 2016 12:41:48 +0200
Message-ID: <1462272110-24610-3-git-send-email-dirk.behme@de.bosch.com>
References: <1462272110-24610-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:47307 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbcECKlz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2016 06:41:55 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 157D8D80101
	for <linux-input@vger.kernel.org>; Tue,  3 May 2016 12:41:54 +0200 (CEST)
Received: from FE-HUB1001.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id BE65DA40562
	for <linux-input@vger.kernel.org>; Tue,  3 May 2016 12:41:53 +0200 (CEST)
In-Reply-To: <1462272110-24610-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>

From: Oleksij Rempel <linux@rempel-privat.de>

Response EAGAIN when open the device while BOOT_COMPLETE
notification is not received and initialization of the zForce touch
controller is not finished.

Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 9839d86..fc0edd6 100644
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
1.9.1

