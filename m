From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 11/13] Input: introduce BTN/ABS bits for drums and guitars
Date: Fri,  1 Nov 2013 21:16:22 +0100
Message-ID: <1383336984-26601-12-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:61641 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3KAURC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:17:02 -0400
Received: by mail-ea0-f170.google.com with SMTP id q10so1869589eaj.29
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:17:01 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

There are a bunch of guitar and drums devices out there that all report
similar data. To avoid reporting this as BTN_MISC or ABS_MISC, we
allocate some proper namespace for them. Note that most of these devices
are toys and we cannot report any sophisticated physics via this API.

I did some google-images research and tried to provide definitions that
work with all common devices. That's why I went with 4 toms, 4 cymbals,
one bass, one hi-hat. I haven't seen other drums and I doubt that we need
any additions to that. Anyway, the naming-scheme is intentionally done in
an extensible way.

For guitars, we support 5 frets (normally aligned vertically, compared to
the real horizontal layouts), a single strum-bar with up/down directions,
an optional fret-board and a whammy-bar.

Most of the devices provide pressure values so I went with ABS_* bits. If
we ever support devices which only provide digital input, we have to
decide whether to emulate pressure data or add additional BTN_* bits.

If someone is not familiar with these devices, here are two pictures which
provide almost all introduced interfaces (or try the given keywords
with a google-image search):
  Guitar: ("guitar hero world tour guitar")
    http://images1.wikia.nocookie.net/__cb20120911023442/applezone/es/images/f/f9/Wii_Guitar.jpg
  Drums: ("guitar hero drums")
    http://oyster.ignimgs.com/franchises/images/03/55/35526_band-hero-drum-set-hands-on-20090929040735768.jpg

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/linux/mod_devicetable.h |  2 +-
 include/uapi/linux/input.h      | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 329aa30..61f358a 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -277,7 +277,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING	0x71
 #define INPUT_DEVICE_ID_KEY_MAX		0x2ff
 #define INPUT_DEVICE_ID_REL_MAX		0x0f
-#define INPUT_DEVICE_ID_ABS_MAX		0x4f
+#define INPUT_DEVICE_ID_ABS_MAX		0x5f
 #define INPUT_DEVICE_ID_MSC_MAX		0x07
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index f347498..3aac45a 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -742,6 +742,14 @@ struct input_keymap_entry {
 #define BTN_DPAD_LEFT		0x222
 #define BTN_DPAD_RIGHT		0x223
 
+#define BTN_FRET_FAR_UP		0x224
+#define BTN_FRET_UP		0x225
+#define BTN_FRET_MID		0x226
+#define BTN_FRET_LOW		0x227
+#define BTN_FRET_FAR_LOW	0x228
+#define BTN_STRUM_BAR_UP	0x229
+#define BTN_STRUM_BAR_DOWN	0x22a
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
@@ -870,12 +878,26 @@ struct input_keymap_entry {
 #define ABS_GYRO_Y		0x44	/* Gyroscope Y axis */
 #define ABS_GYRO_Z		0x45	/* Gyroscope Z axis */
 
+/* Drums and guitars (mostly toys) */
+#define ABS_TOM_FAR_LEFT	0x50
+#define ABS_TOM_LEFT		0x51
+#define ABS_TOM_RIGHT		0x52
+#define ABS_TOM_FAR_RIGHT	0x53
+#define ABS_CYMBAL_FAR_LEFT	0x54
+#define ABS_CYMBAL_LEFT		0x55
+#define ABS_CYMBAL_RIGHT	0x56
+#define ABS_CYMBAL_FAR_RIGHT	0x57
+#define ABS_BASS		0x58
+#define ABS_HI_HAT		0x59
+#define ABS_FRET_BOARD		0x5a	/* Guitar fret board, vertical pos */
+#define ABS_WHAMMY_BAR		0x5b	/* Guitar whammy bar (or vibrato) */
+
 /*
  * Due to API restrictions the legacy evdev API only supports ABS values up to
  * ABS_MAX/CNT. Use the extended *ABS2 ioctls to operate on any ABS values in
  * between ABS_MAX and ABS_MAX2.
  */
-#define ABS_MAX2		0x4f
+#define ABS_MAX2		0x5f
 #define ABS_CNT2		(ABS_MAX2+1)
 
 /*
-- 
1.8.4.1

