From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Sat, 26 May 2007 14:31:05 -0300
Message-ID: <1180200665989-git-send-email-hmh@hmh.eng.br>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
 <11802006651698-git-send-email-hmh@hmh.eng.br>
 <11802006652128-git-send-email-hmh@hmh.eng.br>
 <11802006652058-git-send-email-hmh@hmh.eng.br>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <11802006652058-git-send-email-hmh@hmh.eng.br>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: ibm-acpi-devel@lists.sourceforge.net
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, dtor@mail.ru, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Add hotkeys available in almost all ThinkPads manufactured in the last five
years (more than one million machines given the ammount of batteries
recalled) to input.h, and make thinkpad-acpi use those instead of issuing
KEY_UNKNOWN.

KEY_FN_PAGEDOWN is not ever reported by the ThinkPad firmware due to random
bogon-induced stupidity at IBM some years ago, but it is provided because
it doesn't make sense to define KEY_FN_PAGEUP and not define
KEY_FN_PAGEDOWN at the same time.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: dtor@mail.ru
Cc: linux-input@atrey.karlin.mff.cuni.cz
---
 drivers/misc/thinkpad_acpi.c |    2 +-
 include/linux/input.h        |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 5690247..79a243a 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -712,7 +712,7 @@ static u16 hotkey_event_map[16] = {
 	KEY_FN_F1, KEY_FN_F2, KEY_FN_F3, KEY_FN_F4, KEY_FN_F5, KEY_FN_F6,
 	KEY_FN_F7, KEY_FN_F8, KEY_FN_F9, KEY_FN_F10, KEY_FN_F11, KEY_FN_F12,
 	/* backspace/ins/del/home */
-	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED
+	KEY_FN_BACKSPACE, KEY_FN_INSERT, KEY_FN_DELETE, KEY_FN_HOME
 };
 
 static struct attribute_set *hotkey_dev_attributes = NULL;
diff --git a/include/linux/input.h b/include/linux/input.h
index bde65c8..cd0b13e 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -533,6 +533,11 @@ struct input_absinfo {
 #define KEY_FN_F		0x1e2
 #define KEY_FN_S		0x1e3
 #define KEY_FN_B		0x1e4
+#define KEY_FN_BACKSPACE	0x1e5
+#define KEY_FN_INSERT		0x1e6
+#define KEY_FN_DELETE		0x1e7
+#define KEY_FN_HOME		0x1e8
+#define KEY_FN_END		0x1e9
 
 #define KEY_BRL_DOT1		0x1f1
 #define KEY_BRL_DOT2		0x1f2
-- 
1.5.1.6
