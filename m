From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] Input: hil_mlc: convert timeval to time64_t
Date: Mon, 27 Nov 2017 12:22:57 +0100
Message-ID: <20171127112324.1917698-1-arnd@arndb.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, "James E . J . Bottomley" <jejb@parisc-linux.org>, WEN Pingbo <pingbo.wen@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: WEN Pingbo <pingbo.wen@linaro.org>

Since mlc->lcv_t is only interested in seconds, directly using time64_t
here.

This gets rid of the deprecated do_gettimeofday() and avoids problems
with time going backwards since we now use the monotonic clocksource.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/serio/hil_mlc.c | 8 +++-----
 include/linux/hil_mlc.h       | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index d66d01c5373b..581e47119363 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -274,14 +274,12 @@ static int hilse_match(hil_mlc *mlc, int unused)
 /* An LCV used to prevent runaway loops, forces 5 second sleep when reset. */
 static int hilse_init_lcv(hil_mlc *mlc, int unused)
 {
-	struct timeval tv;
+	time64_t now = ktime_get_seconds();
 
-	do_gettimeofday(&tv);
-
-	if (mlc->lcv && (tv.tv_sec - mlc->lcv_tv.tv_sec) < 5)
+	if (mlc->lcv && (now - mlc->lcv_time) < 5)
 		return -1;
 
-	mlc->lcv_tv = tv;
+	mlc->lcv_time = now;
 	mlc->lcv = 0;
 
 	return 0;
diff --git a/include/linux/hil_mlc.h b/include/linux/hil_mlc.h
index 394a8405dd74..d6fc839bdf46 100644
--- a/include/linux/hil_mlc.h
+++ b/include/linux/hil_mlc.h
@@ -149,7 +149,7 @@ struct hil_mlc {
 
 	int			ddi;	/* Last operational device id */
 	int			lcv;	/* LCV to throttle loops */
-	struct timeval		lcv_tv; /* Time loop was started */
+	time64_t		lcv_time; /* Time loop was started */
 
 	int			di_map[7]; /* Maps below items to live devs */
 	struct hil_mlc_devinfo	di[HIL_MLC_DEVMEM];
-- 
2.9.0

