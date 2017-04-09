From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH 1/4] Input: db9 - use setup_timer
Date: Sun,  9 Apr 2017 09:39:35 +0800
Message-ID: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35058 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdDIBjq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 8 Apr 2017 21:39:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/input/joystick/db9.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index da32609..f4ad83e 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -609,9 +609,7 @@ static void db9_attach(struct parport *pp)
 	db9->pd = pd;
 	db9->mode = mode;
 	db9->parportno = pp->number;
-	init_timer(&db9->timer);
-	db9->timer.data = (long) db9;
-	db9->timer.function = db9_timer;
+	setup_timer(&db9->timer, db9_timer, (long)db9);
 
 	for (i = 0; i < (min(db9_mode->n_pads, DB9_MAX_DEVICES)); i++) {
 
-- 
2.9.3

