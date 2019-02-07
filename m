From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date: Thu,  7 Feb 2019 18:05:31 +0100
Message-ID: <1549559131-7423-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

Instead of hardcoding the input name to the driver name ('gpio-keys-polled'),
allow the passing a name via platform data ('name' field was already present),
but default to old behaviour in case of NULL.

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
