From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sensor-hub: Remove pointless NULL check
Date: Tue, 09 Oct 2012 15:20:18 +0100
Message-ID: <20121009142010.16433.64833.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60895 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab2JIOSq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Oct 2012 10:18:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com

From: Alan Cox <alan@linux.intel.com>

report cannot be NULL, fortunately as we use it before we check !

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hid/hid-sensor-hub.c |    4 ----
 1 file changed, 4 deletions(-)


diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index d9d73e9..4ff2497 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -437,9 +437,6 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	ptr = raw_data;
 	ptr++; /*Skip report id*/
 
-	if (!report)
-		goto err_report;
-
 	spin_lock_irqsave(&pdata->lock, flags);
 
 	for (i = 0; i < report->maxfield; ++i) {
@@ -485,7 +482,6 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 				callback->pdev);
 	spin_unlock_irqrestore(&pdata->lock, flags);
 
-err_report:
 	return 1;
 }
 

