From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/6] Input - soc_button_array: use gpio_is_valid()
Date: Fri, 13 May 2016 18:05:49 +0200
Message-ID: <1463155554-11747-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>
List-Id: linux-input@vger.kernel.org

gpio_keys will later use gpio_is_valid(). To match the actual
behavior, we should use it here too.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
changes in v2:
- fixed gpio_is_valid(gpio) -> !gpio_is_valid(gpio)

 drivers/input/misc/soc_button_array.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index c14b827..bbd433c 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -17,6 +17,7 @@
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 
 /*
@@ -92,7 +93,7 @@ soc_button_device_create(struct platform_device *pdev,
 			continue;
 
 		gpio = soc_button_lookup_gpio(&pdev->dev, info->acpi_index);
-		if (gpio < 0)
+		if (!gpio_is_valid(gpio))
 			continue;
 
 		gpio_keys[n_buttons].type = info->event_type;
-- 
2.5.0
