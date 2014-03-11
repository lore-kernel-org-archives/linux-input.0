From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] Input: fix dependencies of OLPC AP-SP driver
Date: Tue, 11 Mar 2014 19:42:53 +0100
Message-ID: <20140311194253.23daf5e3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33173 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbaCKSm4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2014 14:42:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I don't think the OLPC AP-SP driver is generally useful without OLPC
support. So make it depend on OLPC, unless build testing is enabled.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc6.orig/drivers/input/serio/Kconfig	2014-02-09 16:53:02.931633818 +0100
+++ linux-3.14-rc6/drivers/input/serio/Kconfig	2014-03-11 18:52:42.280541110 +0100
@@ -263,7 +263,7 @@ config SERIO_APBPS2
 
 config SERIO_OLPC_APSP
 	tristate "OLPC AP-SP input support"
-	depends on OF
+	depends on OLPC || (OF && COMPILE_TEST)
 	help
 	  Say Y here if you want support for the keyboard and touchpad included
 	  in the OLPC XO-1.75 and XO-4 laptops.


-- 
Jean Delvare
SUSE L3 Support
