From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH] touchscreen/nuc900: fix wrong setup_timer parameter
Date: Fri, 16 Jul 2010 10:43:02 +0800
Message-ID: <4C3FC736.4010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46044 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935363Ab0GPCnS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jul 2010 22:43:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Dmitry,

This patch fixes wrong setup_timer parameter,when pen up event coming
all codes quoting the w90p910_ts work failed.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 drivers/input/touchscreen/w90p910_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index cc18265..7a45d68 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -233,7 +233,7 @@ static int __devinit w90x900ts_probe(struct platform_device *pdev)
 	w90p910_ts->state = TS_IDLE;
 	spin_lock_init(&w90p910_ts->lock);
 	setup_timer(&w90p910_ts->timer, w90p910_check_pen_up,
-		    (unsigned long)&w90p910_ts);
+		    (unsigned long)w90p910_ts);

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-- 
1.6.3.3
