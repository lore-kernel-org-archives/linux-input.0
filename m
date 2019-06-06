From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date: Fri,  7 Jun 2019 00:43:09 +0200
Message-ID: <1559860989-7723-2-git-send-email-info@metux.net>
References: <1559860989-7723-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559860989-7723-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of hardcoding the input name to the driver name
('gpio-keys-polled'), allow the passing a name via platform data
('name' field was already present), but default to old behaviour
in case of NULL.

Even though the general tendency is moving from pdata structs,
towards oftree/acpi/fwnode, pdata structs still have their valid
use cases, when the mentioned mechanisms aren't available or don't
provide the necessary data and so driver setup still needs to be
done explicitly.

An example use case is keys+led support for the APUv2/3 boards.
Here a board specific platform driver probes the board and then
instantiates the individual devices using classic pdata.

The gpio-keys-polled currently lacks support for specifying
input device name, which is fixed by this patch.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262..3312186 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input = poll_dev->input;
 
-	input->name = pdev->name;
+	input->name = (pdata->name ? pdata->name : pdev->name);
 	input->phys = DRV_NAME"/input0";
 
 	input->id.bustype = BUS_HOST;
-- 
1.9.1
