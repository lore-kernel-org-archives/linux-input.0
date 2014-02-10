From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies
Date: Mon, 10 Feb 2014 10:16:19 +0900
Message-ID: <003f01cf25fd$b3e274b0$1ba75e10$%han@samsung.com>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:10676 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaBJBQU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Feb 2014 20:16:20 -0500
In-reply-to: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Lars-Peter Clausen' <lars@metafoo.de>

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework. However, legacy
PWM drivers were already moved to the generic PWM framework.
Thus, HAVE_PWM should be removed, because HAVE_PWM is not
required anymore.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ae74df7..762e6d2 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -470,7 +470,7 @@ config INPUT_PCF8574
 
 config INPUT_PWM_BEEPER
 	tristate "PWM beeper support"
-	depends on PWM && HAVE_PWM
+	depends on PWM
 	help
 	  Say Y here to get support for PWM based beeper devices.
 
-- 
1.7.10.4


