From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: mma8450 - fix module device table type
Date: Sun, 07 Aug 2011 22:14:47 +0800
Message-ID: <1312726487.7287.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:42695 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab1HGOPD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Aug 2011 10:15:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Miao <eric.miao@linaro.org>, Sammy He <r62914@freescale.com>, linux-input@vger.kernel.org

The module device table for of_device_id should use "of" type.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/misc/mma8450.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 6c76cf7..0794778 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -234,7 +234,7 @@ static const struct of_device_id mma8450_dt_ids[] = {
 	{ .compatible = "fsl,mma8450", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(i2c, mma8450_dt_ids);
+MODULE_DEVICE_TABLE(of, mma8450_dt_ids);
 
 static struct i2c_driver mma8450_driver = {
 	.driver = {
-- 
1.7.4.1



