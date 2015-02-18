From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 6/6] thinkpad_acpi: More Carbon X1 2014 keys
Date: Wed, 18 Feb 2015 21:53:57 +0100
Message-ID: <1424292837.32581.50.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add support for newly added evdev keycodes.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a47a56a..90b3f4a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3264,24 +3264,24 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		 * We'll need to offset those by 0x20 */
 		KEY_RESERVED,        /* Mute held, 0x103 */
 		KEY_BRIGHTNESS_MIN,  /* Backlight off */
-		KEY_RESERVED,        /* Clipping tool */
-		KEY_RESERVED,        /* Cloud */
+		KEY_CLIPPING_TOOL,   /* Clipping tool */
+		KEY_CLOUD,           /* Cloud */
 		KEY_RESERVED,
 		KEY_VOICECOMMAND,    /* Voice */
 		KEY_RESERVED,
-		KEY_RESERVED,        /* Gestures */
+		KEY_CAMERA_GESTURES, /* Gestures */
 		KEY_RESERVED,
 		KEY_RESERVED,
 		KEY_RESERVED,
 		KEY_CONFIG,          /* Settings */
-		KEY_RESERVED,        /* New tab */
+		KEY_NEW_TAB,         /* New tab */
 		KEY_REFRESH,         /* Reload */
 		KEY_BACK,            /* Back */
-		KEY_RESERVED,        /* Microphone down */
-		KEY_RESERVED,        /* Microphone up */
-		KEY_RESERVED,        /* Microphone cancellation */
-		KEY_RESERVED,        /* Camera mode */
-		KEY_RESERVED,        /* Rotate display, 0x116 */
+		KEY_MICUP,           /* Microphone down */
+		KEY_MICDOWN,         /* Microphone up */
+		KEY_MICCANCEL_MODE,  /* Microphone cancellation */
+		KEY_CAMERA_ZOOM_MODE,/* Camera mode */
+		KEY_ROTATE_DISPLAY,  /* Rotate display, 0x116 */
 		},
 	};
 
-- 
2.1.0
