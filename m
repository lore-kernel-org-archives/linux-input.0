From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] gpio: acpi: Don't return 0 on acpi_gpio_count()
Date: Mon, 20 Feb 2017 18:15:46 +0200
Message-ID: <20170220161549.39490-2-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 9b37a3692b3f..d7a22c470312 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1067,7 +1067,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 					break;
 				}
 		}
-		if (count >= 0)
+		if (count > 0)
 			break;
 	}
 
@@ -1083,7 +1083,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 		if (crs_count > 0)
 			count = crs_count;
 	}
-	return count;
+	return count ? count : -ENOENT;
 }
 
 struct acpi_crs_lookup {
-- 
2.11.0

