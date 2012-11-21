From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] hid: hid-sensor-hub: Move NULL check to beginning
Date: Wed, 21 Nov 2012 11:50:30 +0530
Message-ID: <1353478830-23788-2-git-send-email-sachin.kamat@linaro.org>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59725 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab2KUG0u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 01:26:50 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1840080pad.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 22:26:50 -0800 (PST)
In-Reply-To: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, jic23@kernel.org, sachin.kamat@linaro.org, patches@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This avoids a possible NULL pointer dereference error when report
is NULL.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/hid/hid-sensor-hub.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index d9d73e9..29f8071 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -428,6 +428,9 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	struct hid_collection *collection = NULL;
 	void *priv = NULL;
 
+	if (!report)
+		goto err_report;
+
 	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
 			 report->id, size, report->type);
 	hid_dbg(hdev, "maxfield:%d\n", report->maxfield);
@@ -437,9 +440,6 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	ptr = raw_data;
 	ptr++; /*Skip report id*/
 
-	if (!report)
-		goto err_report;
-
 	spin_lock_irqsave(&pdata->lock, flags);
 
 	for (i = 0; i < report->maxfield; ++i) {
-- 
1.7.4.1

