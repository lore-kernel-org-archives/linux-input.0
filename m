From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH v2 2/6] input: pwm-beeper: Fix module autoload for OF
 platform driver
Date: Sat, 29 Aug 2015 12:45:38 +0200
Message-ID: <20150829104538.GA20677@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32950 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbH2Kpl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Aug 2015 06:45:41 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---

Moving the MODULE_DEVICE_TABLE into the CONFIG_OF #ifdef block.
As suggested by Dmitry Torokhov.

Thanks,
Luis

 drivers/input/misc/pwm-beeper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index e82edf8..f2261ab 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -173,6 +173,7 @@ static const struct of_device_id pwm_beeper_match[] = {
 	{ .compatible = "pwm-beeper", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, pwm_beeper_match);
 #endif
 
 static struct platform_driver pwm_beeper_driver = {
-- 
2.4.6

