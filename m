From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 5/9] Input: atmel_mxt_ts - suspend/resume causes panic if input_dev fails to init
Date: Mon,  3 Aug 2015 16:23:13 +0100
Message-ID: <1438615397-17112-6-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:59141 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754243AbbHCPct (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:49 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Pan Xinhui <xinhuix.pan@intel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

From: Pan Xinhui <xinhuix.pan@intel.com>

input_dev may be NULL if mxt_initialize_input_device fails. But pm ops is
still available and suspend/resume assume
input_dev is not NULL. To fix this issue, we add a check if (!input_dev).

Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 869dbb3..b83e8a0 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2653,6 +2653,9 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 	struct mxt_data *data = i2c_get_clientdata(client);
 	struct input_dev *input_dev = data->input_dev;
 
+	if (!input_dev)
+		return 0;
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
@@ -2669,6 +2672,9 @@ static int __maybe_unused mxt_resume(struct device *dev)
 	struct mxt_data *data = i2c_get_clientdata(client);
 	struct input_dev *input_dev = data->input_dev;
 
+	if (!input_dev)
+		return 0;
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-- 
2.4.6

