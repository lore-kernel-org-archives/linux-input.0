From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] hid: retrode: tell what a Retrode is and drop a blank line
Date: Sat, 23 Sep 2017 17:33:21 -0700
Message-ID: <c9fdca59-26d4-3f5c-aed5-94507ff60517@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:60326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdIXAd1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 23 Sep 2017 20:33:27 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>

From: Randy Dunlap <rdunlap@infradead.org>

Add descriptive info to prompt string so that someone can know what
a Retrode is.  Drop an unneeded blank line.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- lnx-414-rc1.orig/drivers/hid/Kconfig
+++ lnx-414-rc1/drivers/hid/Kconfig
@@ -749,11 +749,10 @@ config HID_PRIMAX
 	HID standard.
 
 config HID_RETRODE
-	tristate "Retrode"
+	tristate "Retrode 2 USB adapter for vintage video games"
 	depends on USB_HID
 	---help---
 	Support for
-
 	  * Retrode 2 cartridge and controller adapter
 
 config HID_ROCCAT


