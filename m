From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3 1/3] ACPI video hotkey: add new input key code for ACPI
	video hotkey events
Date: Mon, 20 Aug 2007 18:23:47 +0800
Message-ID: <1187605427.2920.140.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Cc: lenb@kernel.org, mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

From: Yu Luming <luming.yu@intel.com>

Add keycode for ACPI video driver hotkey events.

Signed-off-by: Yu Luming <luming.yu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/input.h |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.23-rc3/include/linux/input.h
===================================================================
--- linux-2.6.23-rc3.orig/include/linux/input.h
+++ linux-2.6.23-rc3/include/linux/input.h
@@ -553,6 +553,13 @@ struct input_absinfo {
 #define KEY_BRL_DOT7		0x1f7
 #define KEY_BRL_DOT8		0x1f8
 
+#define KEY_DISPLAY_CYCLE	0x1f9
+#define KEY_VIDEO_NEXT		0x1fa
+#define KEY_VIDEO_PREV		0x1fb
+#define KEY_BRIGHTNESS_CYCLE	0x1fc
+#define KEY_BRIGHTNESS_ZERO	0x1fd
+#define KEY_DISPLAY_OFF		0x1fe
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x1ff
