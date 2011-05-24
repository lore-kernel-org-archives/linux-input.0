From: Andy Lutomirski <luto@MIT.EDU>
Subject: [PATCH] Add KEY_MICMUTE and enable it on Lenovo X220
Date: Tue, 24 May 2011 15:16:43 -0400
Message-ID: <39a4de113f7f069ad3537229d7460af029fd879c.1306264339.git.luto@mit.edu>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86
Cc: Andy Lutomirski <luto@mit.edu>
List-Id: linux-input@vger.kernel.org

I suspect that this works on T410.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---

The Lenovo X220, T410, and probably other models have a "mute the microphone"
button with a little picture of a crossed-out microphone on it.

I'm not sure what the protocol for new buttons is, and we're halfway through
the merge window, but here it is anyway.

I can split this into separate input and thinkpad-acpi patches if that
would be better.

 drivers/platform/x86/thinkpad_acpi.c |   11 ++++++++++-
 include/linux/input.h                |    2 ++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 28972d4..2797a97 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3211,8 +3211,17 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_VENDOR,	/* 0x17: Thinkpad/AccessIBM/Lenovo */
 
 		/* (assignments unknown, please report if found) */
+		KEY_UNKNOWN, KEY_UNKNOWN,
+
+		/*
+		 * The mic mute button only sends 0x1a.  It does not
+		 * automatically mute the mic or change the mute light.
+		 */
+		KEY_MICMUTE,	/* 0x1a: Mic mute (since ?400 or so) */
+
+		/* (assignments unknown, please report if found) */
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+		KEY_UNKNOWN,
 		},
 	};
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 771d6d8..f26d3b7 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -438,6 +438,8 @@ struct input_keymap_entry {
 #define KEY_WIMAX		246
 #define KEY_RFKILL		247	/* Key that controls all radios */
 
+#define KEY_MICMUTE		248	/* Mute / unmute the microphone */
+
 /* Code 255 is reserved for special needs of AT keyboard driver */
 
 #define BTN_MISC		0x100
-- 
1.7.5.1
