From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/33] Input: samsung-keypad - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:27 -0800
Message-ID: <1484761614-12225-7-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Error messages after memory allocation failures are unnecessary and
can be dropped.

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unnecessary braces around conditional return statements
- Drop error message after devm_kzalloc() failure

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/samsung-keypad.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 4e319eb9e19d..b6ea0cd3542b 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -258,10 +258,8 @@ samsung_keypad_parse_dt(struct device *dev)
 	}
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(dev, "could not allocate memory for platform data\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	of_property_read_u32(np, "samsung,keypad-num-rows", &num_rows);
 	of_property_read_u32(np, "samsung,keypad-num-columns", &num_cols);
@@ -273,19 +271,15 @@ samsung_keypad_parse_dt(struct device *dev)
 	pdata->cols = num_cols;
 
 	keymap_data = devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
-	if (!keymap_data) {
-		dev_err(dev, "could not allocate memory for keymap data\n");
+	if (!keymap_data)
 		return ERR_PTR(-ENOMEM);
-	}
 	pdata->keymap_data = keymap_data;
 
 	key_count = of_get_child_count(np);
 	keymap_data->keymap_size = key_count;
 	keymap = devm_kzalloc(dev, sizeof(uint32_t) * key_count, GFP_KERNEL);
-	if (!keymap) {
-		dev_err(dev, "could not allocate memory for keymap\n");
+	if (!keymap)
 		return ERR_PTR(-ENOMEM);
-	}
 	keymap_data->keymap = keymap;
 
 	for_each_child_of_node(np, key_np) {
-- 
2.7.4
