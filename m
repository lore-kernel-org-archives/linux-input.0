From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: cma3000-d0x - remove unneeded checks
Date: Wed, 11 Apr 2012 22:12:47 -0700
Message-ID: <20120412051246.GA16931@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34505 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab2DLFMw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Apr 2012 01:12:52 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hemanth V <hemanthv@ti.com>, werner <w.landgraf@ru.ru>, linux-kernel@vger.kernel.org

data->mode is unsigned and can not be less than 0.

Reported-by: Werner <w.landgraf@ru.ru>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/cma3000_d0x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index 06517e6..a3735a0 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -318,7 +318,7 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
 	mutex_init(&data->mutex);
 
 	data->mode = pdata->mode;
-	if (data->mode < CMAMODE_DEFAULT || data->mode > CMAMODE_POFF) {
+	if (data->mode > CMAMODE_POFF) {
 		data->mode = CMAMODE_MOTDET;
 		dev_warn(dev,
 			 "Invalid mode specified, assuming Motion Detect\n");
-- 
1.7.7.6


-- 
Dmitry
