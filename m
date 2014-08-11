From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] input/joystick: use get_cycles on ARMv8
Date: Mon, 11 Aug 2014 16:42:10 +0100
Message-ID: <1407771730-1641-1-git-send-email-broonie@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58368 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbaHKPmX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 11:42:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

As with ARM the ARMv8 architecture provides a cycle counter which can be
used to provide a high resolution time for the joystick driver and silence
the build warning that results from not having a precise timer on ARMv8,
making allmodconfig and allyesconfig quieter.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/input/joystick/analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 9135606c8649..ab0fdcd36e18 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -158,7 +158,7 @@ static unsigned int get_time_pit(void)
 #define GET_TIME(x)	rdtscl(x)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
-#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_TILE)
+#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"get_cycles"
-- 
2.0.1

