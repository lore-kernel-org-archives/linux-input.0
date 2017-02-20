From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] Input: soc_button_array - Propagate error from gpiod_count()
Date: Mon, 20 Feb 2017 18:15:49 +0200
Message-ID: <20170220161549.39490-5-andriy.shevchenko@linux.intel.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:10314 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdBTQQM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Feb 2017 11:16:12 -0500
In-Reply-To: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since gpiod_count() does not return 0 anymore, we don't need to shadow
its error code and would safely propagate to the user.

While here, replace second parameter by NULL in order to prevent side
effects on _DSD enabled firmware.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/misc/soc_button_array.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index ddb2f22fca7a..c3b8e1fb4699 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -169,9 +169,10 @@ static int soc_button_probe(struct platform_device *pdev)
 
 	button_info = (struct soc_button_info *)id->driver_data;
 
-	if (gpiod_count(dev, KBUILD_MODNAME) <= 0) {
+	error = gpiod_count(dev, NULL);
+	if (error < 0) {
 		dev_dbg(dev, "no GPIO attached, ignoring...\n");
-		return -ENODEV;
+		return error;
 	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-- 
2.11.0

