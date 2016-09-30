From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: eKTF2127: mark PM functions as __maybe_unused
Date: Fri, 30 Sep 2016 18:22:33 +0200
Message-ID: <20160930162329.183073-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>, Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>, Rob Herring <robh@kernel.org>, Michel Verlaan <michel.verl@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The newly added ektf2127 driver uses the SIMPLE_DEV_PM_OPS macro
to conditionally refer to the resume/suspend functions, which
causes a warning when CONFIG_PM_SLEEP is disabled:

drivers/input/touchscreen/ektf2127.c:168:12: error: 'ektf2127_resume' defined but not used [-Werror=unused-function]
drivers/input/touchscreen/ektf2127.c:156:12: error: 'ektf2127_suspend' defined but not used [-Werror=unused-function]

We could either put these functions inside of an #ifdef or
add __maybe_unused annotations. This uses the second approach,
which is generally more foolproof.

Fixes: 9ca5bf5029b6 ("Input: add support for Elan eKTF2127 touchscreen controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/ektf2127.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index 31a2dd7f38aa..0ed34ff787ce 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -153,7 +153,7 @@ static void ektf2127_stop(struct input_dev *dev)
 	gpiod_set_value_cansleep(ts->power_gpios, 0);
 }
 
-static int ektf2127_suspend(struct device *dev)
+static int __maybe_unused ektf2127_suspend(struct device *dev)
 {
 	struct ektf2127_ts *ts = i2c_get_clientdata(to_i2c_client(dev));
 
@@ -165,7 +165,7 @@ static int ektf2127_suspend(struct device *dev)
 	return 0;
 }
 
-static int ektf2127_resume(struct device *dev)
+static int __maybe_unused ektf2127_resume(struct device *dev)
 {
 	struct ektf2127_ts *ts = i2c_get_clientdata(to_i2c_client(dev));
 
-- 
2.9.0
