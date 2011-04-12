From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RESEND] Input: twl4030_keypad - fix potential NULL
 dereference in twl4030_kp_probe()
Date: Tue, 12 Apr 2011 14:47:51 +0800
Message-ID: <1302590871.17965.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48719 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab1DLGr7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 02:47:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

We should first check whether platform data is NULL or not, before
dereferencing it to get the keymap.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 drivers/input/keyboard/twl4030_keypad.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index cc06c4b..a26922c 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -332,7 +332,7 @@ static int __devinit twl4030_kp_program(struct twl4030_keypad *kp)
 static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 {
 	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
-	const struct matrix_keymap_data *keymap_data = pdata->keymap_data;
+	const struct matrix_keymap_data *keymap_data;
 	struct twl4030_keypad *kp;
 	struct input_dev *input;
 	u8 reg;
@@ -344,6 +344,8 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	keymap_data = pdata->keymap_data;
+
 	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
 	input = input_allocate_device();
 	if (!kp || !input) {
-- 
1.7.1



