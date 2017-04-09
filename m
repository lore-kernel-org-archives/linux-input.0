From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH 3/4] Input: locomokbd - use setup_timer
Date: Sun,  9 Apr 2017 09:39:37 +0800
Message-ID: <5bbe944c53fd30d26689e515f306180c03b9abc8.1490951519.git.geliangtang@gmail.com>
References: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36473 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbdDIBkC (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 8 Apr 2017 21:40:02 -0400
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
 drivers/input/keyboard/locomokbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index c94d610..0d74312d 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -264,9 +264,8 @@ static int locomokbd_probe(struct locomo_dev *dev)
 
 	spin_lock_init(&locomokbd->lock);
 
-	init_timer(&locomokbd->timer);
-	locomokbd->timer.function = locomokbd_timer_callback;
-	locomokbd->timer.data = (unsigned long) locomokbd;
+	setup_timer(&locomokbd->timer, locomokbd_timer_callback,
+		    (unsigned long)locomokbd);
 
 	locomokbd->suspend_jiffies = jiffies;
 
-- 
2.9.3

