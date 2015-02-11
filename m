From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: pxa27x_keypad - remove an unneeded NULL check
Date: Wed, 11 Feb 2015 13:28:02 +0300
Message-ID: <20150211102802.GD18515@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35123 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbBKK1W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 05:27:22 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>
Cc: Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Pramod Gurav <pramod.gurav@smartplayin.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Static checkers complain about this NULL check because we dereference it
without checking a couple lines later.  This function is only called
when "keypad->pdata" is non-NULL so we can just delete the NULL test.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index a89488a..385abf8 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -346,7 +346,7 @@ static int pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
 	const struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
 	struct input_dev *input_dev = keypad->input_dev;
 	const struct matrix_keymap_data *keymap_data =
-				pdata ? pdata->matrix_keymap_data : NULL;
+						pdata->matrix_keymap_data;
 	unsigned short keycode;
 	int i;
 	int error;
