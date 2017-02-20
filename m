From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] platform/x86: surface3_button: Propagate error from gpiod_count()
Date: Mon, 20 Feb 2017 18:15:48 +0200
Message-ID: <20170220161549.39490-4-andriy.shevchenko@linux.intel.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Since gpiod_count() does not return 0 anymore, we don't need to shadow
its error code and would safely propagate to the user.

While here, replace second parameter by NULL in order to prevent side
effects on _DSD enabled firmware.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/surface3_button.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/surface3_button.c b/drivers/platform/x86/surface3_button.c
index 8bfd7f613d36..57f51476bb65 100644
--- a/drivers/platform/x86/surface3_button.c
+++ b/drivers/platform/x86/surface3_button.c
@@ -196,9 +196,10 @@ static int surface3_button_probe(struct i2c_client *client,
 		    strlen(SURFACE_BUTTON_OBJ_NAME)))
 		return -ENODEV;
 
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

