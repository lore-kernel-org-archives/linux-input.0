From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 1/2] input: samsung-keypad: Constify platform_device_id
Date: Sat,  2 May 2015 00:53:06 +0900
Message-ID: <1430495587-31762-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 6b9fdf6cf8e8..43e48dac7687 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -585,7 +585,7 @@ static const struct of_device_id samsung_keypad_dt_match[] = {
 MODULE_DEVICE_TABLE(of, samsung_keypad_dt_match);
 #endif
 
-static struct platform_device_id samsung_keypad_driver_ids[] = {
+static const struct platform_device_id samsung_keypad_driver_ids[] = {
 	{
 		.name		= "samsung-keypad",
 		.driver_data	= KEYPAD_TYPE_SAMSUNG,
-- 
2.1.4
