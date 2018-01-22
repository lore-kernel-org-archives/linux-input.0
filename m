From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] input: da9052_tsi: remove unused mutex
Date: Mon, 22 Jan 2018 16:52:53 +0100
Message-ID: <20180122155254.9255-1-marcus.folkesson@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43599 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeAVPxZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 10:53:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Support Opensource <support.opensource@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/touchscreen/da9052_tsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 5a013bb7bcad..b5dfd5944cc3 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -26,7 +26,6 @@ struct da9052_tsi {
 	struct da9052 *da9052;
 	struct input_dev *dev;
 	struct delayed_work ts_pen_work;
-	struct mutex mutex;
 	bool stopped;
 	bool adc_on;
 };
-- 
2.15.1

