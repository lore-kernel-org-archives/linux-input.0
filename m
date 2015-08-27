From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 2/6] input: pwm-beeper: Fix module autoload for OF platform
 driver
Date: Thu, 27 Aug 2015 18:59:09 +0200
Message-ID: <20150827165909.GA5506@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35279 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbH0Q7M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2015 12:59:12 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/input/misc/pwm-beeper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index e82edf8..a02b9a4 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -175,6 +175,8 @@ static const struct of_device_id pwm_beeper_match[] = {
 };
 #endif
 
+MODULE_DEVICE_TABLE(of, pwm_beeper_match);
+
 static struct platform_driver pwm_beeper_driver = {
 	.probe	= pwm_beeper_probe,
 	.remove = pwm_beeper_remove,
-- 
2.4.6

