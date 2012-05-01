From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] Input: mpu3050: set IRQF_ONESHOT when requesting the interrupt
Date: Tue,  1 May 2012 11:46:46 -0600
Message-ID: <1335894406-27428-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51646 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab2EARqy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 May 2012 13:46:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

Commit 1c6c695 "genirq: Reject bogus threaded irq requests" requires
that request_threaded_irq() either be passed an explicit handler, or
that IRQF_ONESHOT be set. Set this flag.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/input/misc/mpu3050.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index 5403c57..306f84c 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -367,7 +367,7 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
 
 	error = request_threaded_irq(client->irq,
 				     NULL, mpu3050_interrupt_thread,
-				     IRQF_TRIGGER_RISING,
+				     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				     "mpu3050", sensor);
 	if (error) {
 		dev_err(&client->dev,
-- 
1.7.0.4

