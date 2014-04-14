From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] uapi/input.h: Add INPUT_PROP_TOPBUTTONPAD device property
Date: Mon, 14 Apr 2014 12:37:54 +0200
Message-ID: <1397471875-31400-2-git-send-email-hdegoede@redhat.com>
References: <1397471875-31400-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbaDNKiA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 06:38:00 -0400
In-Reply-To: <1397471875-31400-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On some newer laptops with a trackpoint the physical buttons for the
trackpoint have been removed to allow for a larger touchpad. On these
laptops the buttonpad has clearly marked areas on the top which are to be
used as trackpad buttons.

Users of the event device-node need to know about this, so that they can
properly interpret BTN_LEFT events as being a left / right / middle click
depending on where on the button pad the clicking finger is.

This commits adds a INPUT_PROP_TOPBUTTONPAD device property which drivers
for such buttonpads will use to signal to the user that this buttonpad not
only has the normal bottom button area, but also a top button area.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/uapi/linux/input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index bd24470..f484952 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -164,6 +164,7 @@ struct input_keymap_entry {
 #define INPUT_PROP_DIRECT		0x01	/* direct input devices */
 #define INPUT_PROP_BUTTONPAD		0x02	/* has button(s) under pad */
 #define INPUT_PROP_SEMI_MT		0x03	/* touch rectangle only */
+#define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
 
 #define INPUT_PROP_MAX			0x1f
 #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
-- 
1.9.0

