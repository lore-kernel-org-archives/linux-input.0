From: Michael Roth <mroth@nessie.de>
Subject: [PATCH 1/2] Input: ads7846 - more detailed model name in sysfs
Date: Mon, 18 May 2009 20:23:12 +0200
Message-ID: <1242670993-6846-2-git-send-email-mroth@nessie.de>
References: <1242670993-6846-1-git-send-email-mroth@nessie.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from monster.nessie.de ([84.200.20.120]:34912 "EHLO
	monster.nessie.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbZERS2T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2009 14:28:19 -0400
In-Reply-To: <1242670993-6846-1-git-send-email-mroth@nessie.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru, imre.deak@nokia.com, mroth@nessie.de

Signed-off-by: Michael Roth <mroth@nessie.de>
---
 drivers/input/touchscreen/ads7846.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4f190dc..642f37d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -83,6 +83,7 @@ struct ads7846_packet {
 struct ads7846 {
 	struct input_dev	*input;
 	char			phys[32];
+	char			name[32];
 
 	struct spi_device	*spi;
 
@@ -958,8 +959,9 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	ts->wait_for_sync = pdata->wait_for_sync ? : null_wait_for_sync;
 
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&spi->dev));
+	snprintf(ts->name, sizeof(ts->name), "ADS%d Touchscreen", ts->model);
 
-	input_dev->name = "ADS784x Touchscreen";
+	input_dev->name = ts->name;
 	input_dev->phys = ts->phys;
 	input_dev->dev.parent = &spi->dev;
 
-- 
1.6.0.6

