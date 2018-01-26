From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: omap4-keypad: Delete two error messages for a
 failed memory allocation in omap4_keypad_probe()
Date: Fri, 26 Jan 2018 14:49:07 +0100
Message-ID: <e547d1f3-e4d8-b69b-c9b2-0298feb2bef7@users.sourceforge.net>
References: <3df8e062-2a39-05c9-bf49-c85fd636abff@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3df8e062-2a39-05c9-bf49-c85fd636abff@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 26 Jan 2018 14:24:35 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/omap4-keypad.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 940d38b08e6b..6fe554e4026e 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -257,10 +257,8 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad_data = kzalloc(sizeof(struct omap4_keypad), GFP_KERNEL);
-	if (!keypad_data) {
-		dev_err(&pdev->dev, "keypad_data memory allocation failed\n");
+	if (!keypad_data)
 		return -ENOMEM;
-	}
 
 	keypad_data->irq = irq;
 
@@ -340,7 +338,6 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	keypad_data->keymap = kzalloc(max_keys * sizeof(keypad_data->keymap[0]),
 				      GFP_KERNEL);
 	if (!keypad_data->keymap) {
-		dev_err(&pdev->dev, "Not enough memory for keymap\n");
 		error = -ENOMEM;
 		goto err_free_input;
 	}
-- 
2.16.1
