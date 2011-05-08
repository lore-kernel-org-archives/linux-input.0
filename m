From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] input/atari: Fix atarimouse init
Date: Sun,  8 May 2011 11:17:26 +0200
Message-ID: <1304846247-12401-3-git-send-email-geert@linux-m68k.org>
References: <1304846247-12401-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1304846247-12401-1-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>, Michael Schmitz <schmitz@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

From: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>

Atarimouse fails to load as a module (with ENODEV), due to a brown paper
bag bug, misinterpreting the semantics of atari_keyb_init().

[geert] Propagate the return value of atari_keyb_init() everywhere

Signed-off-by: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/keyboard/atakbd.c  |    5 +++--
 drivers/input/mouse/atarimouse.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
index 1839194..10bcd4a 100644
--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -223,8 +223,9 @@ static int __init atakbd_init(void)
 		return -ENODEV;
 
 	// need to init core driver if not already done so
-	if (atari_keyb_init())
-		return -ENODEV;
+	error = atari_keyb_init();
+	if (error)
+		return error;
 
 	atakbd_dev = input_allocate_device();
 	if (!atakbd_dev)
diff --git a/drivers/input/mouse/atarimouse.c b/drivers/input/mouse/atarimouse.c
index a57143c..16a9d0f 100644
--- a/drivers/input/mouse/atarimouse.c
+++ b/drivers/input/mouse/atarimouse.c
@@ -118,8 +118,9 @@ static int __init atamouse_init(void)
 	if (!MACH_IS_ATARI || !ATARIHW_PRESENT(ST_MFP))
 		return -ENODEV;
 
-	if (!atari_keyb_init())
-		return -ENODEV;
+	error = atari_keyb_init();
+	if (error)
+		return error;
 
 	atamouse_dev = input_allocate_device();
 	if (!atamouse_dev)
-- 
1.7.0.4
