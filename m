From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: turbografx: Delete an error message for a failed
 memory allocation in tgfx_attach()
Date: Sat, 27 Jan 2018 15:59:18 +0100
Message-ID: <0255c4a7-fff6-f427-e8a1-951b44ef3f54@users.sourceforge.net>
References: <dfa75f58-43e5-dc80-a606-2914b980f6e7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:53010 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752911AbeA0O7V (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 27 Jan 2018 09:59:21 -0500
In-Reply-To: <dfa75f58-43e5-dc80-a606-2914b980f6e7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geliang Tang <geliangtang@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 15:43:38 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/turbografx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index e2685753e460..454d4c032292 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -192,10 +192,8 @@ static void tgfx_attach(struct parport *pp)
 	}
 
 	tgfx = kzalloc(sizeof(struct tgfx), GFP_KERNEL);
-	if (!tgfx) {
-		printk(KERN_ERR "turbografx.c: Not enough memory\n");
+	if (!tgfx)
 		goto err_unreg_pardev;
-	}
 
 	mutex_init(&tgfx->sem);
 	tgfx->pd = pd;
-- 
2.16.1

