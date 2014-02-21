From: Marcin Lulek <admin@webreactor.eu>
Subject: [PATCH 3.14-rc3] input: Add device id for Thrustmaster GPX Gamepad
 for joystick/xpad.c driver
Date: Fri, 21 Feb 2014 22:59:44 +0100
Message-ID: <5307CC50.4070502@webreactor.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:49434 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbaBUV7t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Feb 2014 16:59:49 -0500
Received: by mail-ea0-f179.google.com with SMTP id q10so1844586ead.38
        for <linux-input@vger.kernel.org>; Fri, 21 Feb 2014 13:59:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomaz de Oliveira dos Reis <thor27@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

It seems xpad driver misses quite a few newer device id's for gamepads 
which leads to wrong recognition.


 From 18d5a1b290e4b39596e200449aaac6b93c035d63 Mon Sep 17 00:00:00 2001
From: Marcin Lulek <info@webreactor.eu>
Date: Fri, 21 Feb 2014 22:11:46 +0100
Subject: [PATCH 1/1] Add device id for Thrustmaster GPX Gamepad for
  joystick/xpad.c driver

Signed-off-by: Marcin Lulek <info@webreactor.eu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomaz de Oliveira dos Reis <thor27@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
  drivers/input/joystick/xpad.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 603fe0d..b94668f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -124,6 +124,7 @@ static const struct xpad_device {
      { 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", 
MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
      { 0x045e, 0x0719, "Xbox 360 Wireless Receiver", 
MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
      { 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
+    { 0x24c6, 0x5b02, "Thrustmaster, Inc. GPX Controller", 0, 
XTYPE_XBOX360 },
      { 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
      { 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
      { 0x046d, 0xc242, "Logitech Chillstream Controller", 0, 
XTYPE_XBOX360 },
-- 
1.8.3.2

