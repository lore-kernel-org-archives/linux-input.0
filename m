From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: ams_delta_serio - fix wrong kfree in
	ams_delta_serio_exit
Date: Mon, 22 Nov 2010 13:36:58 +0800
Message-ID: <1290404218.6941.10.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44123 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0KVFcA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Nov 2010 00:32:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

serio_unregister_port() will call put_device() to free the memory.
Thus remove kfree(ams_delta_serio) after serio_unregister_port(ams_delta_serio).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/serio/ams_delta_serio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 8f1770e..ebe9553 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -172,6 +172,5 @@ static void __exit ams_delta_serio_exit(void)
 	free_irq(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
 	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
 	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
-	kfree(ams_delta_serio);
 }
 module_exit(ams_delta_serio_exit);
-- 
1.7.2



