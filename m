From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 6/6] input: mms114: Fix module autoload for OF platform driver
Date: Thu, 27 Aug 2015 19:01:21 +0200
Message-ID: <20150827170121.GA5627@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36149 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbbH0RBX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2015 13:01:23 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/input/touchscreen/mms114.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 67c0d31..382ea00 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -573,6 +573,7 @@ static const struct of_device_id mms114_dt_match[] = {
 	{ }
 };
 #endif
+MODULE_DEVICE_TABLE(of, mms114_dt_match);
 
 static struct i2c_driver mms114_driver = {
 	.driver = {
-- 
2.4.6

