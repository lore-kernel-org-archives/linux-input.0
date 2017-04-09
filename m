From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH 4/4] Input: turbografx - use setup_timer
Date: Sun,  9 Apr 2017 09:39:38 +0800
Message-ID: <d134eb4b021e064bcc70f0287d4f6ac2d576d4c0.1490951519.git.geliangtang@gmail.com>
References: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
In-Reply-To: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
References: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/input/joystick/turbografx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index 77f575d..a1fdc75 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -200,9 +200,7 @@ static void tgfx_attach(struct parport *pp)
 	mutex_init(&tgfx->sem);
 	tgfx->pd = pd;
 	tgfx->parportno = pp->number;
-	init_timer(&tgfx->timer);
-	tgfx->timer.data = (long) tgfx;
-	tgfx->timer.function = tgfx_timer;
+	setup_timer(&tgfx->timer, tgfx_timer, (long)tgfx);
 
 	for (i = 0; i < n_devs; i++) {
 		if (n_buttons[i] < 1)
-- 
2.9.3
