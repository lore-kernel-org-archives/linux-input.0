From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Input: omap-keypad - fix error handling code
Date: Sat,  8 Apr 2017 19:18:58 +0200
Message-ID: <20170408171858.7266-1-christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@roeck-us.net
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-input@vger.kernel.org

According to the previous error handling code, it is likely that
'goto err_free_keymap' is expected here in order to avoid a memory leak
in error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/keyboard/omap4-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index ebc67ba41fe2..940d38b08e6b 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -358,7 +358,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 				     "omap4-keypad", keypad_data);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register interrupt\n");
-		goto err_free_input;
+		goto err_free_keymap;
 	}
 
 	device_init_wakeup(&pdev->dev, true);
-- 
2.11.0

