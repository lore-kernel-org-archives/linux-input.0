From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 2/3] Input: move drivers/input/fixp-arith.h to include/linux
Date: Mon, 23 Apr 2012 15:21:06 +0200
Message-ID: <1335187267-27940-3-git-send-email-ospite@studenti.unina.it>
References: <1335187267-27940-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1335187267-27940-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Jean-Francois Moine <moinejf@free.fr>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Johann Deneux <johann.deneux@gmail.comx>, Anssi Hannula <anssi.hannula@gmail.com>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

Move drivers/input/fixp-arith.h to include/linux so that the functions
defined there can be used by other subsystems, for instance some video
devices ISPs can control the output HUE value by setting registers for
sin(HUE) and cos(HUE).

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/input/ff-memless.c                    |    3 +--
 {drivers/input => include/linux}/fixp-arith.h |    0
 2 files changed, 1 insertion(+), 2 deletions(-)
 rename {drivers/input => include/linux}/fixp-arith.h (100%)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 117a59a..5f55885 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -31,8 +31,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
-
-#include "fixp-arith.h"
+#include <linux/fixp-arith.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Anssi Hannula <anssi.hannula@gmail.com>");
diff --git a/drivers/input/fixp-arith.h b/include/linux/fixp-arith.h
similarity index 100%
rename from drivers/input/fixp-arith.h
rename to include/linux/fixp-arith.h
-- 
1.7.10
