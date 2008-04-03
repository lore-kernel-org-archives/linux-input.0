From: Anssi Hannula <dmitry.torokhov@gmail.com>
Subject: [PATCH 16/37] Input: xpad - enable force feedback on xbox 360 controllers only
Date: Thu, 3 Apr 2008 16:18:57 -0400
Message-ID: <cfbe20106fa00e89c1fb2c74dbff0ba80e0e539d.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760190AbYDUNT3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:29 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106317waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:28 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Commit 4994cd8dadcf9d484ab3ec19f3c7c7a4e5353c1c introduced a
regression which causes xpad to report force feedback cababilities
for non-360 controllers too, even while there is no actual support
for those.

Fix that by adding a check for XTYPE_XBOX360 to xpad_init_ff().

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/joystick/xpad.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index b48f705..fd80113 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -499,6 +499,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data,
 
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
+	if (xpad->xtype != XTYPE_XBOX360)
+		return 0;
+
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
 
 	return input_ff_create_memless(xpad->dev, NULL, xpad_play_effect);
-- 
1.5.5.rc2.6.gf58d


