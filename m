From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH] Input: mousedev - fix /dev/input/mice minor number
Date: Sun, 18 Nov 2012 10:32:55 +0100
Message-ID: <1353231175-2344-1-git-send-email-krzysiek@podlesie.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: jkosina@suse.cz, pavel@ucw.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>
List-Id: linux-input@vger.kernel.org

The mousedev always used relative minor number 31 for MOUSEDEV_MIX
(/dev/input/mice), but alsolute minor number was 63. Commit
7f8d4cad1e4e11a45d02bd6e024cc2812963c38a ("Input: extend the number
of event (and other) devices") changed it to 31 alsolute minor number.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
Tested on Linux 3.7-rc6 + small patch.

After fixing this I found similar problem:
http://marc.info/?l=linux-kernel&m=135298612202547&w=2

 drivers/input/mousedev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 8f02e3d..fc711a8 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -13,7 +13,7 @@
 
 #define MOUSEDEV_MINOR_BASE	32
 #define MOUSEDEV_MINORS		32
-#define MOUSEDEV_MIX		31
+#define MOUSEDEV_MIX		(MOUSEDEV_MINOR_BASE + 31)
 
 #include <linux/sched.h>
 #include <linux/slab.h>
-- 
1.8.0.283.gc57d856
