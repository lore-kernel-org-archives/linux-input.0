From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2 1/2] hid-asus: drop dependency on I2C_HID
Date: Wed,  1 Mar 2017 15:48:50 -0600
Message-ID: <20170301214851.5105-1-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34530 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbdCAVuO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 16:50:14 -0500
Received: by mail-ua0-f174.google.com with SMTP id f54so55540475uaa.1
        for <linux-input@vger.kernel.org>; Wed, 01 Mar 2017 13:48:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux@endlessm.com, chiu@endlessm.com

There is nothing transport-specific in this driver, and we will now be
adding support for some Asus USB devices too.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/hid/Kconfig | 1 -
 1 file changed, 1 deletion(-)

v2: Split off earlier patch from Feb 16:
  hid-asus: support Republic of Gamers special keys

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1aeb80e..51e6e9e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -136,7 +136,6 @@ config HID_APPLEIR
 
 config HID_ASUS
 	tristate "Asus"
-	depends on I2C_HID
 	---help---
 	Support for Asus notebook built-in keyboard and touchpad via i2c.
 
-- 
2.9.3

