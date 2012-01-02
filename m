From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] input/tc3589x: add missing kerneldoc
Date: Mon, 2 Jan 2012 11:49:46 +0100
Message-ID: <1325501386-22011-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:48323 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488Ab2ABKt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jan 2012 05:49:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Naga Radhesh <naga.radheshy@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Naga Radhesh <naga.radheshy@stericsson.com>

This adds two missing kerneldoc entries for the TC3589x
keypad driver.

Signed-off-by: Naga Radhesh <naga.radheshy@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/tc3589x-keypad.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index f60c9e8..277c665 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -74,11 +74,13 @@
 
 /**
  * struct tc_keypad - data structure used by keypad driver
+ * @tc3589x:    pointer to tc35893
  * @input:      pointer to input device object
  * @board:      keypad platform device
  * @krow:	number of rows
  * @kcol:	number of coloumns
  * @keymap:     matrix scan code table for keycodes
+ * @keypad_stopped: holds keypad status
  */
 struct tc_keypad {
 	struct tc3589x *tc3589x;
-- 
1.7.8

