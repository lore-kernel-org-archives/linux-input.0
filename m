From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] export module license and other info for Cobalt button
	module
Date: Wed, 13 Aug 2008 14:56:18 +0300
Message-ID: <20080813115617.GA4831@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:3549 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbYHML4b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2008 07:56:31 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Export the module license and other information about the Cobalt
button module in order to avoid the following warning:

| WARNING: modpost: missing MODULE_LICENSE() in drivers/input/misc/cobalt_btns.o

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


diff --git a/drivers/input/misc/cobalt_btns.c b/drivers/input/misc/cobalt_btns.c
index 6a1f48b..2adf9cb 100644
--- a/drivers/input/misc/cobalt_btns.c
+++ b/drivers/input/misc/cobalt_btns.c
@@ -148,6 +148,9 @@ static int __devexit cobalt_buttons_remove(struct platform_device *pdev)
 	return 0;
 }
 
+MODULE_AUTHOR("Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>");
+MODULE_DESCRIPTION("Cobalt button interface driver");
+MODULE_LICENSE("GPL");
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:Cobalt buttons");
 

-- 
Martin Michlmayr
http://www.cyrius.com/
