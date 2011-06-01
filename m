From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH] HID: roccat: Changed plain Kconfig menu to submenu for
 roccat devices.
Date: Wed, 01 Jun 2011 15:54:10 +0200
Message-ID: <1306936450.2486.6.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-18.arcor-online.net ([151.189.21.58]:34870 "EHLO
	mail-in-18.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755441Ab1FANyP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Jun 2011 09:54:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

As module roccat is needed by all devices, it's the toplevel
menu entry with all devices dependent.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/Kconfig |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 67d2a75..14ba3e2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -434,6 +434,7 @@ config HID_QUANTA
 config HID_ROCCAT
 	tristate "Roccat special event support"
 	depends on USB_HID
+	select HID_ROCCAT_COMMON
 	---help---
 	Support for Roccat special events.
 	Say Y here if you have a Roccat mouse or keyboard and want OSD or
@@ -441,44 +442,40 @@ config HID_ROCCAT
 
 config HID_ROCCAT_COMMON
 	tristate
+	depends on HID_ROCCAT
 
 config HID_ROCCAT_ARVO
 	tristate "Roccat Arvo keyboard support"
 	depends on USB_HID
-	select HID_ROCCAT
-	select HID_ROCCAT_COMMON
+	depends on HID_ROCCAT
 	---help---
 	Support for Roccat Arvo keyboard.
 
 config HID_ROCCAT_KONE
 	tristate "Roccat Kone Mouse support"
 	depends on USB_HID
-	select HID_ROCCAT
-	select HID_ROCCAT_COMMON
+	depends on HID_ROCCAT
 	---help---
 	Support for Roccat Kone mouse.
 
 config HID_ROCCAT_KONEPLUS
 	tristate "Roccat Kone[+] mouse support"
 	depends on USB_HID
-	select HID_ROCCAT
-	select HID_ROCCAT_COMMON
+	depends on HID_ROCCAT
 	---help---
 	Support for Roccat Kone[+] mouse.
 
 config HID_ROCCAT_KOVAPLUS
 	tristate "Roccat Kova[+] mouse support"
 	depends on USB_HID
-	select HID_ROCCAT
-	select HID_ROCCAT_COMMON
+	depends on HID_ROCCAT
 	---help---
 	Support for Roccat Kova[+] mouse.
 
 config HID_ROCCAT_PYRA
 	tristate "Roccat Pyra mouse support"
 	depends on USB_HID
-	select HID_ROCCAT
-	select HID_ROCCAT_COMMON
+	depends on HID_ROCCAT
 	---help---
 	Support for Roccat Pyra mouse.
 
-- 
1.7.3.4



