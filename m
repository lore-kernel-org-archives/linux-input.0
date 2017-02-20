From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] gpio: of: Don't return 0 on dt_gpio_count()
Date: Mon, 20 Feb 2017 18:15:47 +0200
Message-ID: <20170220161549.39490-3-andriy.shevchenko@linux.intel.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

It's unusual to have error checking like (ret <= 0) in cases when
counting GPIO resources. In case when it's mandatory we propagate the
error (-ENOENT), otherwise we don't use the result.

This makes consistent behaviour across all possible variants called in
gpiod_count().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8b4d721d6d63..f8ee417de0b7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3122,10 +3122,10 @@ static int dt_gpio_count(struct device *dev, const char *con_id)
 				 gpio_suffixes[i]);
 
 		ret = of_gpio_named_count(dev->of_node, propname);
-		if (ret >= 0)
+		if (ret > 0)
 			break;
 	}
-	return ret;
+	return ret ? ret : -ENOENT;
 }
 
 static int platform_gpio_count(struct device *dev, const char *con_id)
-- 
2.11.0

