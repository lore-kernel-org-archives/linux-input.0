From: Julia Lawall <julia@diku.dk>
Subject: [PATCH] drivers/input/keyboard: Move a dereference below a NULL test
Date: Sun, 30 Aug 2009 11:18:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0908301117010.17060@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:42894 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbZH3JSN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Aug 2009 05:18:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

If the NULL test is necessary, then the dereference should be moved below
the NULL test.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/).

// <smpl>
@@
type T;
expression E;
identifier i,fld;
statement S;
@@

- T i = E->fld;
+ T i;
  ... when != E
      when != i
  if (E == NULL) S
+ i = E->fld;
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/input/keyboard/w90p910_keypad.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -u -p a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -120,7 +120,7 @@ static int __devinit w90p910_keypad_prob
 {
 	const struct w90p910_keypad_platform_data *pdata =
 						pdev->dev.platform_data;
-	const struct matrix_keymap_data *keymap_data = pdata->keymap_data;
+	const struct matrix_keymap_data *keymap_data;
 	struct w90p910_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -132,6 +132,7 @@ static int __devinit w90p910_keypad_prob
 		dev_err(&pdev->dev, "no platform data defined\n");
 		return -EINVAL;
 	}
+	keymap_data = pdata->keymap_data;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
