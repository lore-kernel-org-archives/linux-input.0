From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 5/7] Input: max8997_haptic: remove HAVE_PWM dependencies
Date: Mon, 10 Feb 2014 10:15:12 +0900
Message-ID: <003e01cf25fd$8c310490$a4930db0$%han@samsung.com>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:64860 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbaBJBPO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Feb 2014 20:15:14 -0500
In-reply-to: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

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
index 7904ab0..ae74df7 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -156,7 +156,7 @@ config INPUT_MAX8925_ONKEY
 
 config INPUT_MAX8997_HAPTIC
 	tristate "MAXIM MAX8997 haptic controller support"
-	depends on PWM && HAVE_PWM && MFD_MAX8997
+	depends on PWM && MFD_MAX8997
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables device driver support for the haptic controller
-- 
1.7.10.4


