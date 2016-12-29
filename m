From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: mousedev - stop offering PS/2 to userspace by default
Date: Thu, 29 Dec 2016 10:07:31 -0800
Message-ID: <20161229180731.GA5321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36820 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbcL2SHf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Dec 2016 13:07:35 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org

Evdev interface has been available for many years and by now everyone
is switched to using it, so let's stop offering /dev/input/mouseN
and /dev/psaux by default.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 6261874..ff80377 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -94,7 +94,6 @@ comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
 	tristate "Mouse interface"
-	default y
 	help
 	  Say Y here if you want your mouse to be accessible as char devices
 	  13:32+ - /dev/input/mouseX and 13:63 - /dev/input/mice as an
@@ -109,7 +108,6 @@ config INPUT_MOUSEDEV
 
 config INPUT_MOUSEDEV_PSAUX
 	bool "Provide legacy /dev/psaux device"
-	default y
 	depends on INPUT_MOUSEDEV
 	help
 	  Say Y here if you want your mouse also be accessible as char device
@@ -118,7 +116,6 @@ config INPUT_MOUSEDEV_PSAUX
 
 	  If unsure, say Y.
 
-
 config INPUT_MOUSEDEV_SCREEN_X
 	int "Horizontal screen resolution"
 	depends on INPUT_MOUSEDEV
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
