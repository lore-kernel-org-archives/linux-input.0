From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] Input: wistron_btns - simplify dependencies
Date: Tue, 11 Mar 2014 14:36:01 +0100
Message-ID: <20140311143601.57cf4cbc@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55455 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263AbaCKNgD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2014 09:36:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Miloslav Trmac <mitr@volny.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Kconfig symbol X86_32 was introduced in October 2005, it's about time
to use it. This clears the last occurrence of the legacy
"X86 && !X86_64" construct :-)

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Miloslav Trmac <mitr@volny.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc6.orig/drivers/input/misc/Kconfig	2014-02-09 16:53:02.902633206 +0100
+++ linux-3.14-rc6/drivers/input/misc/Kconfig	2014-03-11 14:31:38.112813328 +0100
@@ -269,7 +269,7 @@ config INPUT_COBALT_BTNS
 
 config INPUT_WISTRON_BTNS
 	tristate "x86 Wistron laptop button interface"
-	depends on X86 && !X86_64
+	depends on X86_32
 	select INPUT_POLLDEV
 	select INPUT_SPARSEKMAP
 	select NEW_LEDS


-- 
Jean Delvare
SUSE L3 Support
