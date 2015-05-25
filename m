From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Input:keyboard:samsung-keypad - Fix for correct return type
Date: Mon, 25 May 2015 22:30:04 +0530
Message-ID: <1432573204-2923-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35871 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbEYRAV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 13:00:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Ferruh Yigit <fery@cypress.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>

The return type of the function samsung_keypad_report() is bool but we are
returning the unsigned int value.So changing the unsigned int to bool type
and initializing with false.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 6b9fdf6..44b1ba9 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -112,7 +112,7 @@ static bool samsung_keypad_report(struct samsung_keypad *keypad,
 	struct input_dev *input_dev = keypad->input_dev;
 	unsigned int changed;
 	unsigned int pressed;
-	unsigned int key_down = 0;
+	bool key_down = false;
 	unsigned int val;
 	unsigned int col, row;
 
-- 
1.7.9.5

