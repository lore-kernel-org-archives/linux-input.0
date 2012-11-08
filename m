From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: marix-keymap - automatically allocate memory for
 keymap
Date: Thu, 8 Nov 2012 08:45:21 -0800
Message-ID: <20121108164519.GA9334@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52174 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab2KHQp0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 11:45:26 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2107516pad.19
        for <linux-input@vger.kernel.org>; Thu, 08 Nov 2012 08:45:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Alban Bedel <alban.bedel@avionic-design.de>

In device tree enabled setups requiring preallocated memory for storing keymap
is quite often awkward, so let's provide an option of allocating it directly
in matrix_keypad_build_keymap().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/matrix-keymap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index 443ad64b..da04f13 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -122,6 +122,11 @@ static int matrix_keypad_parse_of_keymap(const char *propname,
  * it will attempt load the keymap from property specified by @keymap_name
  * argument (or "linux,keymap" if @keymap_name is %NULL).
  *
+ * If @keymap is %NULL the function will automatically allocate managed
+ * block of memory to store the keymap. This memory will be associated with
+ * the parent device and automatically freed when device unbinds from the
+ * driver.
+ *
  * Callers are expected to set up input_dev->dev.parent before calling this
  * function.
  */
@@ -132,12 +137,27 @@ int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 			       struct input_dev *input_dev)
 {
 	unsigned int row_shift = get_count_order(cols);
+	size_t max_keys = rows << row_shift;
 	int i;
 	int error;
 
+	if (WARN_ON(!input_dev->dev.parent))
+		return -EINVAL;
+
+	if (!keymap) {
+		keymap = devm_kzalloc(input_dev->dev.parent,
+				      max_keys * sizeof(*keymap),
+				      GFP_KERNEL);
+		if (!keymap) {
+			dev_err(input_dev->dev.parent,
+				"Unable to allocate memory for keymap");
+			return -ENOMEM;
+		}
+	}
+
 	input_dev->keycode = keymap;
 	input_dev->keycodesize = sizeof(*keymap);
-	input_dev->keycodemax = rows << row_shift;
+	input_dev->keycodemax = max_keys;
 
 	__set_bit(EV_KEY, input_dev->evbit);
 
-- 
1.7.11.7


-- 
Dmitry
