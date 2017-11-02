From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 2/3] HID: cp2112: add HIDRAW dependency
Date: Thu,  2 Nov 2017 12:12:43 +0100
Message-ID: <1509621164-28830-2-git-send-email-sebastien.szymanski@armadeus.com>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:41178 "EHLO
        6.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbdKBLoI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Nov 2017 07:44:08 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id E308FED7A4
        for <linux-input@vger.kernel.org>; Thu,  2 Nov 2017 12:05:18 +0100 (CET)
In-Reply-To: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Julien Boibessot <julien.boibessot@armadeus.com>, =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>

Otherwise, with HIDRAW=n, the probe function crashes because of null
dereference of hdev->hidraw.

Fixes: 42cb6b35b9e6 ("HID: cp2112: use proper hidraw name with minor number")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 374301f..8c7a0ce 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -230,7 +230,7 @@ config HID_CMEDIA
 
 config HID_CP2112
 	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
-	depends on USB_HID && I2C && GPIOLIB
+	depends on USB_HID && HIDRAW && I2C && GPIOLIB
 	select GPIOLIB_IRQCHIP
 	---help---
 	Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
-- 
2.7.3

