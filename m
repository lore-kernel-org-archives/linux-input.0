From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: sh_keysc: 8x8 MODE_6 fix
Date: Wed, 15 Jun 2011 23:33:40 +0900
Message-ID: <20110615143340.21798.61858.sendpatchset@t400s>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, simon@horms.net, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The MODE_6 support in sh_keysc.c is incorrect without
this patch. According to the data sheet for G4, AP4 and
AG5 KEYSC MODE_6 is 8x8 keys. Bump up MAXKEYS to 64 too.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |    2 +-
 include/linux/input/sh_keysc.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2011-06-15 17:59:27.000000000 +0900
@@ -32,7 +32,7 @@ static const struct {
 	[SH_KEYSC_MODE_3] = { 2, 4, 7 },
 	[SH_KEYSC_MODE_4] = { 3, 6, 6 },
 	[SH_KEYSC_MODE_5] = { 4, 6, 7 },
-	[SH_KEYSC_MODE_6] = { 5, 7, 7 },
+	[SH_KEYSC_MODE_6] = { 5, 8, 8 },
 };
 
 struct sh_keysc_priv {
--- 0001/include/linux/input/sh_keysc.h
+++ work/include/linux/input/sh_keysc.h	2011-06-15 17:48:05.000000000 +0900
@@ -1,7 +1,7 @@
 #ifndef __SH_KEYSC_H__
 #define __SH_KEYSC_H__
 
-#define SH_KEYSC_MAXKEYS 49
+#define SH_KEYSC_MAXKEYS 64
 
 struct sh_keysc_info {
 	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3,
