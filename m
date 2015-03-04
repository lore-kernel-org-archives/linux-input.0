From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 2/2] use more descriptive KEY_ROTATE_DISPLAY instead of KEY_DIRECTION
Date: Thu, 5 Mar 2015 00:31:10 +0100
Message-ID: <cf97f856-7e6d-4753-a3f0-51c410cc2db4@HUB2.rwth-ad.de>
References: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net>
 <1425511870-3303-1-git-send-email-stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-out-1.rwth-aachen.de ([134.130.5.186]:18567 "EHLO
	mx-out-1.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbCDXb0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 18:31:26 -0500
In-Reply-To: <1425511870-3303-1-git-send-email-stefan.bruens@rwth-aachen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>

Signed-off-by: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
---
 drivers/hid/hid-debug.c               | 2 +-
 drivers/platform/x86/fujitsu-tablet.c | 6 +++---
 drivers/platform/x86/hp-wmi.c         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8bf61d2..1086800 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -814,7 +814,7 @@ static const char *keys[KEY_MAX + 1] =3D {
 	[KEY_DELETEFILE] =3D "DeleteFile",	[KEY_XFER] =3D "X-fer",
 	[KEY_PROG1] =3D "Prog1",			[KEY_PROG2] =3D "Prog2",
 	[KEY_WWW] =3D "WWW",			[KEY_MSDOS] =3D "MSDOS",
-	[KEY_COFFEE] =3D "Coffee",		[KEY_DIRECTION] =3D "Direction",
+	[KEY_COFFEE] =3D "Coffee",		[KEY_ROTATE_DISPLAY] =3D "RotateDisplay",
 	[KEY_CYCLEWINDOWS] =3D "CycleWindows",	[KEY_MAIL] =3D "Mail",
 	[KEY_BOOKMARKS] =3D "Bookmarks",		[KEY_COMPUTER] =3D "Computer",
 	[KEY_BACK] =3D "Back",			[KEY_FORWARD] =3D "Forward",
diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x=
86/fujitsu-tablet.c
index 53bdbb0..baea077 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -59,7 +59,7 @@ static unsigned short keymap_Lifebook_Tseries[KEYMAP_=
LEN] __initdata =3D {
 	KEY_RESERVED,
 	KEY_SCROLLDOWN,
 	KEY_SCROLLUP,
-	KEY_DIRECTION,
+	KEY_ROTATE_DISPLAY,
 	KEY_LEFTCTRL,
 	KEY_BRIGHTNESSUP,
 	KEY_BRIGHTNESSDOWN,
@@ -116,7 +116,7 @@ static unsigned short keymap_Lifebook_U810[KEYMAP_L=
EN] __initdata =3D {
 	KEY_RESERVED,
 	KEY_PROG1,
 	KEY_PROG2,
-	KEY_DIRECTION,
+	KEY_ROTATE_DISPLAY,
 	KEY_RESERVED,
 	KEY_RESERVED,
 	KEY_RESERVED,
@@ -153,7 +153,7 @@ static unsigned short keymap_Stylistic_ST5xxx[KEYMA=
P_LEN] __initdata =3D {
 	KEY_RESERVED,
 	KEY_RESERVED,
 	KEY_MAIL,
-	KEY_DIRECTION,
+	KEY_ROTATE_DISPLAY,
 	KEY_ESC,
 	KEY_ENTER,
 	KEY_BRIGHTNESSUP,
diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wm=
i.c
index 0ab2b37..0669731 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -144,7 +144,7 @@ static const struct key_entry hp_wmi_keymap[] =3D {
 	{ KE_KEY, 0x20e8, { KEY_MEDIA } },
 	{ KE_KEY, 0x2142, { KEY_MEDIA } },
 	{ KE_KEY, 0x213b, { KEY_INFO } },
-	{ KE_KEY, 0x2169, { KEY_DIRECTION } },
+	{ KE_KEY, 0x2169, { KEY_ROTATE_DISPLAY } },
 	{ KE_KEY, 0x216a, { KEY_SETUP } },
 	{ KE_KEY, 0x231b, { KEY_HELP } },
 	{ KE_END, 0 }
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
