From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] input: max77650-onkey: add MODULE_ALIAS()
Date: Wed,  3 Jul 2019 10:46:42 +0200
Message-ID: <20190703084642.9425-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Define a MODULE_ALIAS() in the input sub-driver for max77650 so that
the appropriate module gets loaded together with the core mfd driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/input/misc/max77650-onkey.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/max77650-onkey.c b/drivers/input/misc/max77650-onkey.c
index fbf6caab7217..4d875f2ac13d 100644
--- a/drivers/input/misc/max77650-onkey.c
+++ b/drivers/input/misc/max77650-onkey.c
@@ -119,3 +119,4 @@ module_platform_driver(max77650_onkey_driver);
 MODULE_DESCRIPTION("MAXIM 77650/77651 ONKEY driver");
 MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:max77650-onkey");
-- 
2.21.0
