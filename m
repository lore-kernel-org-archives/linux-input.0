From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] input/atari: Fix mouse movement and button mapping
Date: Sun,  8 May 2011 11:17:27 +0200
Message-ID: <1304846247-12401-4-git-send-email-geert@linux-m68k.org>
References: <1304846247-12401-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1304846247-12401-1-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

Up and down movements were reversed, left and right buttons were swapped.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/mouse/atarimouse.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/atarimouse.c b/drivers/input/mouse/atarimouse.c
index 16a9d0f..5c4a692 100644
--- a/drivers/input/mouse/atarimouse.c
+++ b/drivers/input/mouse/atarimouse.c
@@ -77,15 +77,15 @@ static void atamouse_interrupt(char *buf)
 #endif
 
 	/* only relative events get here */
-	dx =  buf[1];
-	dy = -buf[2];
+	dx = buf[1];
+	dy = buf[2];
 
 	input_report_rel(atamouse_dev, REL_X, dx);
 	input_report_rel(atamouse_dev, REL_Y, dy);
 
-	input_report_key(atamouse_dev, BTN_LEFT,   buttons & 0x1);
+	input_report_key(atamouse_dev, BTN_LEFT,   buttons & 0x4);
 	input_report_key(atamouse_dev, BTN_MIDDLE, buttons & 0x2);
-	input_report_key(atamouse_dev, BTN_RIGHT,  buttons & 0x4);
+	input_report_key(atamouse_dev, BTN_RIGHT,  buttons & 0x1);
 
 	input_sync(atamouse_dev);
 
-- 
1.7.0.4
