From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad -Remove obsolete commment
Date: Mon, 17 Feb 2014 17:26:36 -0300
Message-ID: <1392668796-32280-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:60767 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbaBQU0r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 15:26:47 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so30921495ykr.9
        for <linux-input@vger.kernel.org>; Mon, 17 Feb 2014 12:26:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 81e8f2bc (Input: imx_keypad - add pm suspend and resume support)
the imx_keypad driver supports power management, so remove the obsolete comment.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index cbf4f80..80091c2 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -6,7 +6,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * <<Power management needs to be implemented>>.
  */
 
 #include <linux/clk.h>
-- 
1.8.1.2

