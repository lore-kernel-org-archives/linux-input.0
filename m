From: Dario Scarpa <dario.scarpa@duskzone.it>
Subject: [PATCH] Input: xpad - fix "Razer Atrox Arcade Stick" mapping
 definition
Date: Sun, 30 Aug 2015 13:35:00 +0200
Message-ID: <20150830113500.GA12138@xps.deltalabs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:38658 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbbH3Llb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Aug 2015 07:41:31 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, rojtberg@gmail.com, tt.rantala@gmail.com, mwei@lxde.org, aniroop.mathur@gmail.com, benpicco@zedat.fu-berlin.de, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org

The "Razer Atrox Arcade Stick" features 10 buttons,
and two of them (LT/RT) don't work properly.
Change its definition in xpad_device[] (mapping field) to fix.

Signed-off-by: Dario Scarpa <dario.scarpa@duskzone.it>
---
 drivers/input/joystick/xpad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f8850f9..6417a8a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -204,7 +204,7 @@ static const struct xpad_device {
 	{ 0x1bad, 0xf900, "Harmonix Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf901, "Gamestop Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf903, "Tron Xbox 360 controller", 0, XTYPE_XBOX360 },
-	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5300, "PowerA MINI PROEX Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5303, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5500, "Hori XBOX 360 EX 2 with Turbo", 0, XTYPE_XBOX360 },
-- 
1.7.10.4

