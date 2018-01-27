From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: turbografx: Improve a size determination in
 tgfx_attach()
Date: Sat, 27 Jan 2018 16:00:03 +0100
Message-ID: <14ac4f8d-90bd-0ad7-eee8-fbb47c2cba5c@users.sourceforge.net>
References: <dfa75f58-43e5-dc80-a606-2914b980f6e7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:57677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752789AbeA0PAG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 27 Jan 2018 10:00:06 -0500
In-Reply-To: <dfa75f58-43e5-dc80-a606-2914b980f6e7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geliang Tang <geliangtang@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 15:46:24 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/turbografx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index 454d4c032292..472bc438927e 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -191,7 +191,7 @@ static void tgfx_attach(struct parport *pp)
 		return;
 	}
 
-	tgfx = kzalloc(sizeof(struct tgfx), GFP_KERNEL);
+	tgfx = kzalloc(sizeof(*tgfx), GFP_KERNEL);
 	if (!tgfx)
 		goto err_unreg_pardev;
 
-- 
2.16.1

