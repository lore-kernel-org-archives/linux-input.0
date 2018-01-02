From: Matteo Croce <mcroce@redhat.com>
Subject: [PATCH] synaptics: fix rmi4 bus dependencies
Date: Tue,  2 Jan 2018 20:16:09 +0100
Message-ID: <20180102191609.21460-1-mcroce@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32976 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeABTQM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 14:16:12 -0500
Received: by mail-wr0-f196.google.com with SMTP id v21so38741952wrc.0
        for <linux-input@vger.kernel.org>; Tue, 02 Jan 2018 11:16:11 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>

Make MOUSE_PS2_SYNAPTICS_SMBUS select MOUSE_PS2_SYNAPTICS because if
the latter is disabled the detection and switching code isn't being run.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/input/mouse/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 89ebb8f39fee..77a0bcb611a4 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -83,6 +83,7 @@ config MOUSE_PS2_SYNAPTICS_SMBUS
 	default y
 	depends on MOUSE_PS2
 	depends on I2C=y || I2C=MOUSE_PS2
+	select MOUSE_PS2_SYNAPTICS
 	select MOUSE_PS2_SMBUS
 	help
 	  Say Y here if you have a Synaptics RMI4 touchpad connected to
-- 
2.14.3

