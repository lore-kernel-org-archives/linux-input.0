From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] Input: w90p910_ts - depend on ARCH_W90X900
Date: Tue, 1 Apr 2014 14:20:46 +0200
Message-ID: <20140401142046.14d4bb8c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41169 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbaDAMUt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Apr 2014 08:20:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Wan ZongShun <mcuos.com@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

The w90p910_ts touchscreen driver is heavily architecture dependent,
so there is no point in letting it be built on other architectures
than it was written for.

All other W90P910/W90X900 drivers already have that dependency, so it
makes things more consistent and configuration easier.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc8.orig/drivers/input/touchscreen/Kconfig	2014-02-09 16:53:02.945634113 +0100
+++ linux-3.14-rc8/drivers/input/touchscreen/Kconfig	2014-04-01 14:10:08.936933702 +0200
@@ -867,7 +867,7 @@ config TOUCHSCREEN_TSC2007
 
 config TOUCHSCREEN_W90X900
 	tristate "W90P910 touchscreen driver"
-	depends on HAVE_CLK
+	depends on ARCH_W90X900
 	help
 	  Say Y here if you have a W90P910 based touchscreen.
 


-- 
Jean Delvare
SUSE L3 Support
