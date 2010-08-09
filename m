From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] Input: xpad - add USB-ID for PL-3601 Xbox 360 pad
Date: Mon, 09 Aug 2010 18:48:04 +0200
Message-ID: <1281372484.20805.56.camel@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48128 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab0HIQok (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Aug 2010 12:44:40 -0400
Received: by bwz3 with SMTP id 3so1352926bwz.19
        for <linux-input@vger.kernel.org>; Mon, 09 Aug 2010 09:44:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

This patch adds USB Vendor and Product ID for Pelican PL-3601 'TSZ'
Wired Xbox 360 Controller to the device table.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/joystick/xpad.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 269a846..f9fb7fa 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -148,6 +148,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0005, "Eclipse wireless Controller", 0, XTYPE_XBOX },
 	{ 0x0e6f, 0x0006, "Edge wireless Controller", 0, XTYPE_XBOX },
 	{ 0x0e6f, 0x0006, "Pelican 'TSZ' Wired Xbox 360 Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0201, "Pelican PL-3601 'TSZ' Wired Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", 0, XTYPE_XBOX },
 	{ 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
 	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", 0, XTYPE_XBOX },
-- 
1.7.1



