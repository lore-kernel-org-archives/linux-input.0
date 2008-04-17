From: Julia Lawall <dmitry.torokhov@gmail.com>
Subject: [PATCH 33/37] Input: drivers/char/keyboard.c - use time_after
Date: Thu, 17 Apr 2008 09:28:25 -0400
Message-ID: <2fd746d97fa0452173e06ffd9d0bb376d97bef0b.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759563AbYDUNTo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:44 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106317waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:43 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

The functions time_before, time_before_eq, time_after, and time_after_eq
are more robust for comparing jiffies against other values.

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/char/keyboard.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 59608e3..45806d2 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -42,6 +42,7 @@
 #include <linux/input.h>
 #include <linux/reboot.h>
 #include <linux/notifier.h>
+#include <linux/jiffies.h>
 
 extern void ctrl_alt_del(void);
 
@@ -928,7 +929,8 @@ static void k_brl(struct vc_data *vc, unsigned char value, char up_flag)
 	if (up_flag) {
 		if (brl_timeout) {
 			if (!committing ||
-			    jiffies - releasestart > (brl_timeout * HZ) / 1000) {
+			    time_after(jiffies,
+				       releasestart + msecs_to_jiffies(brl_timeout))) {
 				committing = pressed;
 				releasestart = jiffies;
 			}
-- 
1.5.5.rc2.6.gf58d


