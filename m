From: Sundar Iyer <sundar.iyer@stericsson.com>
Subject: [PATCH 16/20] i2c/nomadik: add adapter name for updated sanity checkings
Date: Fri, 3 Dec 2010 20:35:49 +0530
Message-ID: <1291388753-14662-17-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:55935 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752216Ab0LCPHB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Dec 2010 10:07:01 -0500
In-Reply-To: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, ben-linux@fluff.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sundar Iyer <sundar.iyer@stericsson.com>

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 drivers/i2c/busses/i2c-nomadik.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 2bd3469..baa8ff7 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -872,6 +872,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	adap->owner	= THIS_MODULE;
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo	= &nmk_i2c_algo;
+	snprintf(adap->name, sizeof(adap->name), DRIVER_NAME);
 
 	/* fetch the controller id */
 	adap->nr	= pdev->id;
-- 
1.7.2.dirty

