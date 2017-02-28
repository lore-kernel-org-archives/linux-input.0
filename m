From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 07/10] Input: eeti_ts - use gpio_get_value_cansleep
Date: Tue, 28 Feb 2017 14:46:29 -0800
Message-ID: <20170228224632.3401-7-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35681 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdB1W5Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 17:57:16 -0500
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

We are reading GPIO state in a non-atomic context (workqueue), so we can
use "cansleep" variant, and thus make the driver available on systems where
GPIO controllers require sleeping when reading GPIO state.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/eeti_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index ac78ac6d4936..fc61dbea4736 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -63,7 +63,7 @@ struct eeti_ts {
 
 static inline int eeti_ts_irq_active(struct eeti_ts *eeti)
 {
-	return gpio_get_value(eeti->irq_gpio) == eeti->irq_active_high;
+	return gpio_get_value_cansleep(eeti->irq_gpio) == eeti->irq_active_high;
 }
 
 static void eeti_ts_read(struct work_struct *work)
-- 
2.11.0.483.g087da7b7c-goog

