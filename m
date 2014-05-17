From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/2] dell-wmi: Add support for Fn key combinations
Date: Sat, 17 May 2014 16:43:37 +0200
Message-ID: <1400337817-14473-3-git-send-email-pali.rohar@gmail.com>
References: <201405171639.45722@pali>
 <1400337817-14473-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400337817-14473-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-hotplug@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

Bios DMI table contains scancodes for some Fn key combinations. But
corresponding keycodes in DMI table have same value 255. And dell-wmi d=
river
map value 255 to KEY_PROG3. This means that it is not possible to disti=
nguish
between Fn key combinations (e.g Fn+Q and Fn+W), because kernel reports=
 for all
of them only KEY_PROG3.

This patch adding new table for mapping Bios DMI scancodes to linux key=
codes
when bios DMI keycode is set to "generic" keycode 255. So different Fn =
key
combinations will have different keycodes.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/platform/x86/dell-wmi.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/del=
l-wmi.c
index 390e8e3..c54d675 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -140,7 +140,27 @@ static const u16 bios_to_linux_keycode[256] __init=
const =3D {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_PROG3
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+};
+
+/* table for bios code 0xff */
+static const u16 scancode_to_linux_keycode[256] __initconst =3D {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	KEY_FN_Q, KEY_FN_W, KEY_FN_E, KEY_FN_R,
+	KEY_FN_T, 0, 0, 0,
+	0, 0, 0, 0,
+	0, 0, KEY_FN_A, KEY_FN_S,
+	KEY_FN_D, KEY_FN_F, KEY_FN_G, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 };
=20
 static struct input_dev *dell_wmi_input_dev;
@@ -212,6 +232,11 @@ static const struct key_entry * __init dell_wmi_pr=
epare_new_keymap(void)
 		keymap[i].keycode =3D bios_entry->keycode < 256 ?
 				    bios_to_linux_keycode[bios_entry->keycode] :
 				    KEY_RESERVED;
+		if (bios_entry->keycode =3D=3D 255 && bios_entry->scancode < 256)
+			keymap[i].keycode =3D
+				scancode_to_linux_keycode[bios_entry->scancode];
+		if (!keymap[i].keycode)
+			keymap[i].keycode =3D KEY_RESERVED;
 	}
=20
 	keymap[hotkey_num].type =3D KE_END;
--=20
1.7.9.5
