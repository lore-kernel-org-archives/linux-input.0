From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 01/15] Input: xpad: add Covert Forces edition of the Xbox One controller
Date: Thu,  1 Oct 2015 22:57:12 +0200
Message-ID: <1443733046-29610-2-git-send-email-rojtberg@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37467 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbbJAU5k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:40 -0400
Received: by wicfx3 with SMTP id fx3so6377663wic.0
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:39 -0700 (PDT)
In-Reply-To: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Erik Lundgren <eriklundgren93@gmail.com>, Pavel Rojtberg <rojtberg@gmail.com>

From: Erik Lundgren <eriklundgren93@gmail.com>

It is identical to the Xbox One controller but has a different product
ID

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f8850f9..c3ba5be 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -125,6 +125,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
+	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Covert Forces)", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
-- 
1.9.1

