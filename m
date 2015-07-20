From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/4] Input: zforce - don't invert the interrupt GPIO
Date: Mon, 20 Jul 2015 14:56:34 +0200
Message-ID: <1437396997-3182-2-git-send-email-dirk.behme@de.bosch.com>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:30544 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbbGTM4l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 08:56:41 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta23.fe.bosch.de (Postfix) with ESMTP id BB8B01580228
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:39 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 77817238050D
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:39 +0200 (CEST)
In-Reply-To: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>

Commit 2d53809594af ("Input: zforce_ts - convert to use the gpiod
interface") converted this driver to use the gpiod functions. These
functions take the active low property into account, so we don't have
to invert the result of gpiod_get_value_cansleep(). This has been
missed in that commit. Fix it.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 32749db..edf01c3 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -510,7 +510,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	if (!ts->suspending && device_may_wakeup(&client->dev))
 		pm_stay_awake(&client->dev);
 
-	while (!gpiod_get_value_cansleep(ts->gpio_int)) {
+	while (gpiod_get_value_cansleep(ts->gpio_int)) {
 		ret = zforce_read_packet(ts, payload_buffer);
 		if (ret < 0) {
 			dev_err(&client->dev,
-- 
2.3.4

