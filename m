From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 1/6] input: ab8500-ponkey: Fix module autoload for OF
 platform driver
Date: Thu, 27 Aug 2015 18:58:34 +0200
Message-ID: <20150827165834.GA5495@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35792 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbH0Q6h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2015 12:58:37 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/input/misc/ab8500-ponkey.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 1f7e15c..1c8b81a 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -120,6 +120,8 @@ static const struct of_device_id ab8500_ponkey_match[] = {
 };
 #endif
 
+MODULE_DEVICE_TABLE(of, ab8500_ponkey_match);
+
 static struct platform_driver ab8500_ponkey_driver = {
 	.driver		= {
 		.name	= "ab8500-poweron-key",
-- 
2.4.6

