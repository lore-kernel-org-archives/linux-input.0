From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Input:mouse:cyapa_gen5.c - Fix for typos in comment in function cyapa_gen5_irq_cmd_handler().
Date: Mon, 25 May 2015 23:11:17 +0530
Message-ID: <1432575677-3462-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36360 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbEYRl3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 13:41:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dudley Du <dudl@cypress.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/mouse/cyapa_gen5.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 5b611dd..a12c32a 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -2547,8 +2547,8 @@ static bool cyapa_gen5_irq_cmd_handler(struct cyapa *cyapa)
 				gen5_pip->irq_cmd_buf, length))) {
 			/*
 			 * Cover the Gen5 V1 firmware issue.
-			 * The issue is there is no interrut will be
-			 * asserted to notityf host to read a command
+			 * The issue is there is no interrupt will be
+			 * asserted to notify host to read a command
 			 * data out when always has finger touch on
 			 * trackpad during the command is issued to
 			 * trackad device.
-- 
1.7.9.5

