From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] Input: matrix-keymap - provide a proper module license
Date: Mon, 10 Dec 2012 12:01:05 -0800 (PST)
Message-ID: <11020313.JpKK99GBpl@bender>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:39954 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2LJUBI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Dec 2012 15:01:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The matrix-keymap module is currently lacking a proper module license,
add one so we don't have this module tainting the entire kernel. This
issue has been present since commit 1932811f (Input: matrix-keymap -
uninline and prepare for device tree support)

Signed-off-by: Florian Fainelli <florian@openwrt.org>
CC: stable@vger.kernel.org
---
Dmitry, can you try to push this to Linus before 3.7 final? Thank you!

 drivers/input/matrix-keymap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index 443ad64b..d88d9be 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -23,6 +23,7 @@
 #include <linux/input.h>
 #include <linux/of.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/input/matrix_keypad.h>
 
 static bool matrix_keypad_map_key(struct input_dev *input_dev,
@@ -161,3 +162,5 @@ int matrix_keypad_build_keymap(const struct matrix_keymap_data *keymap_data,
 	return 0;
 }
 EXPORT_SYMBOL(matrix_keypad_build_keymap);
+
+MODULE_LICENSE("GPL");
-- 
1.7.10.4
