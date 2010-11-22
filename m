From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: ps2mult - fix wrong kfree in ps2mult_connect error
	path
Date: Mon, 22 Nov 2010 13:13:39 +0800
Message-ID: <1290402820.6941.8.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45528 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0KVFIn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Nov 2010 00:08:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/serio/ps2mult.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
index 6bce22e..15aa81c 100644
--- a/drivers/input/serio/ps2mult.c
+++ b/drivers/input/serio/ps2mult.c
@@ -207,7 +207,7 @@ static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
 err_out:
 	while (--i >= 0)
 		kfree(psm->ports[i].serio);
-	kfree(serio);
+	kfree(psm);
 	return error;
 }
 
-- 
1.7.2



