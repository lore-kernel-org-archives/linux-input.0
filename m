From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 1/4] Input: atmel_mxt_ts - Set pointer emulation if is_tp
Date: Tue,  6 May 2014 16:13:09 -0600
Message-ID: <1399414392-32572-2-git-send-email-swarren@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41868 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbaEFWNY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2014 18:13:24 -0400
In-Reply-To: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Benson Leung <bleung@chromium.org>

Touchpads are pointers, so make sure to pass the correct values to
input_mt_report_pointer_emulation(). Without this, tap-to-click doesn't
work.

Signed-off-by: Benson Leung <bleung@chromium.org>
[swarren, rewrote the commit description, since the downstream version
concentrated on patch rebase history rather than the functionality]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a70400754e92..9ba7e30c7894 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -619,7 +619,8 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 	} while (reportid != 0xff);
 
 	if (update_input) {
-		input_mt_report_pointer_emulation(data->input_dev, false);
+		input_mt_report_pointer_emulation(data->input_dev,
+						  data->is_tp);
 		input_sync(data->input_dev);
 	}
 
-- 
1.8.1.5

