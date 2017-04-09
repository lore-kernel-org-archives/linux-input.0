From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH 2/4] Input: gameport - use setup_timer
Date: Sun,  9 Apr 2017 09:39:36 +0800
Message-ID: <c0e3e8852152b581e5ae671025ab7b231658bce0.1490951519.git.geliangtang@gmail.com>
References: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36451 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbdDIBjv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 8 Apr 2017 21:39:51 -0400
In-Reply-To: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
In-Reply-To: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
References: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/input/gameport/gameport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 092cc41..cedc665 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -542,9 +542,8 @@ static void gameport_init_port(struct gameport *gameport)
 
 	INIT_LIST_HEAD(&gameport->node);
 	spin_lock_init(&gameport->timer_lock);
-	init_timer(&gameport->poll_timer);
-	gameport->poll_timer.function = gameport_run_poll_handler;
-	gameport->poll_timer.data = (unsigned long)gameport;
+	setup_timer(&gameport->poll_timer, gameport_run_poll_handler,
+		    (unsigned long)gameport);
 }
 
 /*
-- 
2.9.3

