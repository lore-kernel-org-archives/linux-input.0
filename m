From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH] Input: ct82c710 - remove a redundant
	serio_register_port()
Date: Mon, 22 Nov 2010 14:06:47 +0800
Message-ID: <1290406007.6941.15.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50365 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab0KVGBu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Nov 2010 01:01:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>

We already call serio_register_port() in ct82c710_probe(),
thus remove a redundant serio_register_port() in ct82c710_init().

Looks like this bug is introduced by 
916d83cfe5da1cda454d8b0ae233f06b58bd7f91
"Input: ct82c710 - convert to the new platform device interface"

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I don't have this hardware handy, I appreciate if someone can test this patch.

Regards,
Axel

 drivers/input/serio/ct82c710.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index 4a30846..0f8304a 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
@@ -237,8 +237,6 @@ static int __init ct82c710_init(void)
 	if (error)
 		goto err_free_device;
 
-	serio_register_port(ct82c710_port);
-
 	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#llx irq %d\n",
 		(unsigned long long)CT82C710_DATA, CT82C710_IRQ);
 
-- 
1.7.2



