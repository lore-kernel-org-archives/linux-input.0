From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH] input: soc_button_array: update calls to gpiod_get*()
Date: Thu, 23 Oct 2014 17:17:55 +0900
Message-ID: <1414052275-20310-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-input@vger.kernel.org

Add the new flags argument to calls of (devm_)gpiod_get*().

Currently both forms (with or without the flags argument)
are valid thanks to transitional macros in
<linux/gpio/consumer.h>. These macros will be removed once
all consumers are updated and the flags argument will become
compulsary.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 735604753568..e097f1ab427f 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -55,7 +55,7 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
 	struct gpio_desc *desc;
 	int gpio;
 
-	desc = gpiod_get_index(dev, KBUILD_MODNAME, acpi_index);
+	desc = gpiod_get_index(dev, KBUILD_MODNAME, acpi_index, GPIOD_ASIS);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.1.2
