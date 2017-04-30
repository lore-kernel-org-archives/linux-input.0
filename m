From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/2 v2] input: touchscreen: ar1021_i2c: use BIT to check for a bit
Date: Sun, 30 Apr 2017 21:38:53 +0200
Message-ID: <20170430193853.10958-1-martink@posteo.de>
References: <1493295756-17812-2-git-send-email-martin.kepplinger@ginzinger.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:52672 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1948867AbdD3TjM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Apr 2017 15:39:12 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 7C8B420BCE
        for <linux-input@vger.kernel.org>; Sun, 30 Apr 2017 21:39:10 +0200 (CEST)
In-Reply-To: <1493295756-17812-2-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

The MSB for the first byte of touch data transmission is always 1. Make
it a little more obvious we're testing this bit by using BIT(7).

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

I'd still use the definition :) but otherwise I'd write the following.
It really doesn't matter though.

thanks for the quick support Dmitry,

                    martin


 drivers/input/touchscreen/ar1021_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index eb1874fe52c2..8c76aa435903 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -44,7 +44,7 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
 		goto out;
 
 	/* sync bit set ? */
-	if ((data[0] & 0x80) == 0)
+	if (!(data[0] & BIT(7)))
 		goto out;
 
 	button = data[0] & BIT(0);
-- 
2.11.0

