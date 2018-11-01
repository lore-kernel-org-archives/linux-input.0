From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 2/3] asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
Date: Wed, 31 Oct 2018 17:21:27 -0700
Message-ID: <20181101002128.28884-3-jprvita@endlessm.com>
References: <20181101002128.28884-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101002128.28884-1-jprvita@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Cc: hadess@hadess.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
List-Id: linux-input@vger.kernel.org

When the OS registers to handle events from the display off hotkey the
EC will send a notification with 0x35 for every key press, independent
of the backlight state.

The behavior of this key on Windows, with the ATKACPI driver from Asus
installed, is turning off the backlight of all connected displays with a
fading effect, and any cursor input or key press turning the backlight
back on. The key press or cursor input that wakes up the display is also
passed through to the application under the cursor or under focus.

The key that matches this behavior the closest is KEY_SCREENLOCK.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index db2af09067db..5a00a7665f9b 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -444,6 +444,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x32, { KEY_MUTE } },
 	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
 	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
+	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
 	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */
-- 
2.19.1
