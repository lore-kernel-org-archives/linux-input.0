From: Michael Wright <michaelwr@android.com>
Subject: [PATCH] HID: add new gamepad LED constants
Date: Sun, 14 Sep 2014 20:13:31 -0700
Message-ID: <1410750811-11156-1-git-send-email-michaelwr@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40718 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbaIODNj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Sep 2014 23:13:39 -0400
Received: by mail-pa0-f51.google.com with SMTP id kx10so5395782pab.24
        for <linux-input@vger.kernel.org>; Sun, 14 Sep 2014 20:13:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Wright <michaelwr@google.com>

Improve gamepad support by introducing new LED constants for player
LEDs and the mappings from their corresponding HID usages introduced
in HUTTR47: http://www.usb.org/developers/hidpage/HUTRR47.pdf

Change-Id: If25d8a8e2570dfab3a35f9be5b1d03ab662f6b1c
Signed-off-by: Michael Wright <michaelwr@google.com>
---
 drivers/hid/hid-input.c    | 4 ++++
 include/uapi/linux/input.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2619f7f..a1cb3bf 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -633,6 +633,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
 		case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
 		case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
+		case 0x4f:  map_led (LED_PLAYER_1); break;    /*   "Player 1" */
+		case 0x50:  map_led (LED_PLAYER_2); break;    /*   "Player 2" */
+		case 0x51:  map_led (LED_PLAYER_3); break;    /*   "Player 3" */
+		case 0x52:  map_led (LED_PLAYER_4); break;    /*   "Player 4" */
 
 		default: goto ignore;
 		}
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 1874ebe..bb43f20 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -908,6 +908,10 @@ struct input_keymap_entry {
 #define LED_MISC		0x08
 #define LED_MAIL		0x09
 #define LED_CHARGING		0x0a
+#define LED_PLAYER_1		0x0b
+#define LED_PLAYER_2		0x0c
+#define LED_PLAYER_3		0x0d
+#define LED_PLAYER_4		0x0e
 #define LED_MAX			0x0f
 #define LED_CNT			(LED_MAX+1)
 
-- 
2.1.0.rc2.206.gedb03e5

