From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RFC, PATCH] hid-ps3remote: handle multiple keypresses for joypad buttons
Date: Mon, 24 Sep 2012 13:25:37 +0200
Message-ID: <1348485938-20510-1-git-send-email-ospite@studenti.unina.it>
References: <20120921220659.1e257048fed597061efb07f9@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:56685 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab2IXL0N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 07:26:13 -0400
In-Reply-To: <20120921220659.1e257048fed597061efb07f9@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Dillow <dave@thedillows.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-bluetooth@vger.kernel.org, David Herrmann <dh.herrmann@googlemail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, jkosina@suse.cz

---
 drivers/hid/hid-ps3remote.c |  153 +++++++++++++++++++++++++++----------------
 1 file changed, 96 insertions(+), 57 deletions(-)

Hey David D., I was able to improve the situation with the patch below,
basically that's what I am doing:

  - In the descriptor have two collections, one for "joypad buttons"
    which allow multiple keypresses, and one for the remote buttons
    which do not allow multiple keypresses.

  - Have two key maps, one for each collection.

In order to make this work I have to put joypad buttons only in one of
the key maps, I don't know if that is compatible with the Harmony
adapter.

BTW to deal with HID descriptors I am using this gHID tool which
provides a "smart language" that ease things a little bit:
http://code.google.com/p/ghid/

The code spacing and naming of variables can be improved in the patch
below but I wanted to get it out ASAP to avoid duplicate work.

Regards,
   Antonio

diff --git a/drivers/hid/hid-ps3remote.c b/drivers/hid/hid-ps3remote.c
index 11a6c1f..fa2e50d 100644
--- a/drivers/hid/hid-ps3remote.c
+++ b/drivers/hid/hid-ps3remote.c
@@ -49,6 +49,26 @@
  * The keymap is generally ordered by the physical location of the buttons,
  * as this makes it easier to verify a correct mapping during testing.
  */
+static const unsigned int ps3remote_keymap_1[] = {
+	[0x01] = KEY_SELECT,
+	[0x02] = BTN_THUMBL,		/* L3 */
+	[0x03] = BTN_THUMBR,		/* R3 */
+	[0x04] = BTN_START,
+	[0x05] = KEY_UP,
+	[0x06] = KEY_RIGHT,
+	[0x07] = KEY_DOWN,
+	[0x08] = KEY_LEFT,
+	[0x09] = BTN_TL2,		/* L2 */
+	[0x0a] = BTN_TR2,		/* R2 */
+	[0x0b] = BTN_TL,		/* L1 */
+	[0x0c] = BTN_TR,		/* R1 */
+	[0x0d] = KEY_OPTION,		/* options/triangle */
+	[0x0e] = KEY_BACK,		/* back/circle */
+	[0x0f] = BTN_0,			/* cross */
+	[0x10] = KEY_SCREEN,		/* view/square */
+	[0x11] = KEY_HOMEPAGE,		/* PS button */
+	[0x14] = KEY_ENTER,
+};
 static const unsigned int ps3remote_keymap[] = {
 	[0x16] = KEY_EJECTCD,
 	[0x64] = KEY_AUDIO,
@@ -74,24 +94,24 @@ static const unsigned int ps3remote_keymap[] = {
 	[0x1a] = KEY_MENU,		/* top menu */
 	[0x40] = KEY_CONTEXT_MENU,	/* pop up/menu */
 	[0x0e] = KEY_ESC,		/* return */
-	[0x5c] = KEY_OPTION,		/* options/triangle */
-	[0x5d] = KEY_BACK,		/* back/circle */
-	[0x5f] = KEY_SCREEN,		/* view/square */
-	[0x5e] = BTN_0,			/* cross */
-	[0x54] = KEY_UP,
-	[0x56] = KEY_DOWN,
-	[0x57] = KEY_LEFT,
-	[0x55] = KEY_RIGHT,
-	[0x0b] = KEY_ENTER,
-	[0x5a] = BTN_TL,		/* L1 */
-	[0x58] = BTN_TL2,		/* L2 */
-	[0x51] = BTN_THUMBL,		/* L3 */
-	[0x5b] = BTN_TR,		/* R1 */
-	[0x59] = BTN_TR2,		/* R2 */
-	[0x52] = BTN_THUMBR,		/* R3 */
-	[0x43] = KEY_HOMEPAGE,		/* PS button */
-	[0x50] = KEY_SELECT,
-	[0x53] = BTN_START,
+	//[0x5c] = KEY_OPTION,		/* options/triangle */
+	//[0x5d] = KEY_BACK,		/* back/circle */
+	//[0x5f] = KEY_SCREEN,		/* view/square */
+	//[0x5e] = BTN_0,			/* cross */
+	//[0x54] = KEY_UP,
+	//[0x56] = KEY_DOWN,
+	//[0x57] = KEY_LEFT,
+	//[0x55] = KEY_RIGHT,
+	//[0x0b] = KEY_ENTER,
+	//[0x5a] = BTN_TL,		/* L1 */
+	//[0x58] = BTN_TL2,		/* L2 */
+	//[0x51] = BTN_THUMBL,		/* L3 */
+	//[0x5b] = BTN_TR,		/* R1 */
+	//[0x59] = BTN_TR2,		/* R2 */
+	//[0x52] = BTN_THUMBR,		/* R3 */
+	//[0x43] = KEY_HOMEPAGE,		/* PS button */
+	//[0x50] = KEY_SELECT,
+	//[0x53] = BTN_START,
 	[0x33] = KEY_REWIND,		/* scan back */
 	[0x32] = KEY_PLAY,
 	[0x34] = KEY_FORWARD,		/* scan forward */
@@ -104,42 +124,54 @@ static const unsigned int ps3remote_keymap[] = {
 };
 
 static __u8 ps3remote_rdesc[] = {
-	0x05, 0x01,	/* USAGE PAGE (Generic Desktop) */
-	0x09, 0x05,	/* USAGE (Game Pad) */
-	0xa1, 0x01,	/* COLLECTION (Application) */
-
-	/* First four bytes contain a bitmask for some of the buttons, and
-	 * possibly a controller number. We don't need this information,
-	 * as the keys will be reported in the next field as well.
-	 */
-	0x75, 0x20,	/*   REPORT SIZE (32) */
-	0x95, 0x01,	/*   REPORT COUNT (1) */
-	0x81, 0x01,	/*   INPUT (Constant) */
-
-	/* All key presses are reported in this field  */
-	0x05, 0x09,	/*   USAGE PAGE (Button) */
-	0x19, 0x00,	/*   USAGE MINIMUM (0) */
-	0x29, 0xfe,	/*   USAGE MAXIMUM (254) */
-	0x15, 0x00,	/*   LOGICAL MINIMUM (0) */
-	0x25, 0xfe,	/*   LOGICAL MAXIMUM (254) */
-	0x75, 0x08,	/*   REPORT SIZE (8) */
-	0x95, 0x06,	/*   REPORT COUNT (6) */
-	0x81, 0x00,	/*   INPUT (Array, Absolute) */
-
-	/* Ignore press indication */
-	0x75, 0x08,	/*   REPORT SIZE (8) */
-	0x95, 0x01,	/*   REPORT COUNT (1) */
-	0x81, 0x01,	/*   INPUT (Constant) */
-
-	/* Report the battery level */
-	0x05, 0x06,	/*   USAGE PAGE (Generic Device) */
-	0x09, 0x20,	/*   USAGE (Battery Strength) */
-	0x15, 0x00,	/*   LOGICAL MINIMUM (0) */
-	0x25, 0x05,	/*   LOGICAL MAXIMUM (5) */
-	0x75, 0x08,	/*   REPORT SIZE (8) */
-	0x95, 0x01,	/*   REPORT COUNT (1) */
-	0x81, 0x02,	/*   INPUT (Variable, Absolute) */
-	0xc0,		/* END_COLLECTION */
+ 0x05, 0x01,          //  GUsagePage Generic Desktop
+ 0x09, 0x05,          //  LUsage 0x05 [Game Pad]
+ 0xA1, 0x01,          //  MCollection Application (mouse, keyboard)
+  0xA1, 0x02,         //  MCollection Logical (interrelated data)
+   0x75, 0x08,        //  GReportSize 0x08 [8]
+   0x95, 0x01,        //  GReportCount 0x01 [1]
+   0x81, 0x00,        //  MInput 0x03
+                      //  Const[0] Var[1] Abs[2] 
+
+   0x05, 0x09,        //  GUsagePage Button
+   0x19, 0x01,        //  LUsageMinimum 0x01 [Button 1 (primary/trigger)]
+   0x29, 0x18,        //  LUsageMaximum 0x18 [Button 18]
+   0x14,              //  GLogicalMinimum  [0]
+   0x25, 0x01,        //  GLogicalMaximum 0x01 [1]
+   0x75, 0x01,        //  GReportSize 0x01 [1]
+   0x95, 0x18,        //  GReportCount 0x18 [24]
+   0x81, 0x02,        //  MInput 0x02
+   0xC0,              //  MEndCollection  [Game Pad]
+                      //  Data[0] Var[1] Abs[2] 
+
+  0xA1, 0x02,         //  MCollection Logical (interrelated data)
+   0x05, 0x09,        //  GUsagePage Button
+   0x18,              //  LUsageMinimum  [No button pressed]
+   0x29, 0xFE,        //  LUsageMaximum 0xFE [Button FE]
+   0x14,              //  GLogicalMinimum  [0]
+   0x26, 0xFE, 0x00,  //  GLogicalMaximum 0x00FE [254]
+   0x75, 0x08,        //  GReportSize 0x08 [8]
+   0x95, 0x06,        //  GReportCount 0x06 [6]
+   0x80,              //  MInput 
+                      //  
+
+   0x75, 0x08,        //  GReportSize 0x08 [8]
+   0x95, 0x01,        //  GReportCount 0x01 [1]
+   0x81, 0x01,        //  MInput 0x01
+                      //  Const[0] Arr[1] Abs[2] 
+
+   0x05, 0x06,        //  GUsagePage Generic Device Controls
+   0x09, 0x20,        //  LUsage 0x20 [Battery Strength]
+   0x14,              //  GLogicalMinimum  [0]
+   0x25, 0x05,        //  GLogicalMaximum 0x05 [5]
+   0x75, 0x08,        //  GReportSize 0x08 [8]
+   0x95, 0x01,        //  GReportCount 0x01 [1]
+   0x81, 0x02,        //  MInput 0x02
+                      //  Data[0] Var[1] Abs[2] 
+
+   0xC0,              //  MEndCollection  [Game Pad]
+
+  0xC0                //  MEndCollection  [Game Pad]
 };
 
 static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -159,9 +191,16 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    key >= ARRAY_SIZE(ps3remote_keymap))
 		return -1;
 
-	key = ps3remote_keymap[key];
-	if (!key)
-		return -1;
+	if (usage->collection_index == 1) {
+		key = ps3remote_keymap_1[key];
+		if (!key)
+			return -1;
+	}
+	if (usage->collection_index == 2) {
+		key = ps3remote_keymap[key];
+		if (!key)
+			return -1;
+	}
 
 	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
 	return 1;
-- 
1.7.10.4

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
