From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 2/2] Input: misc/bma150.[ch], make some defines public and fix some comments
Date: Fri,  8 Feb 2013 00:58:25 +0100
Message-ID: <1360281506-13618-3-git-send-email-ospite@studenti.unina.it>
References: <1360281506-13618-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:44106 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab3BGX7R (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 18:59:17 -0500
In-Reply-To: <1360281506-13618-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Albert Zhang <xu.zhang@bosch-sensortec.com>, Eric Andersson <eric.andersson@unixphere.com>, Jonathan Cameron <jic23@cam.ac.uk>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>

From: Michael Trimarchi <michael@amarulasolutions.com>

Make the constants referring to range and bandwidth public so they can
be used when initializing the platform data fields in the platform code.

Fix also some comments regarding the unit of measurement to use for the
range and bandwidth fields, the values are not actually expected to be
in G or HZ, the code in bma150.c just uses the BMA150_RANGE_xxx and
BMA150_BW_xxx constants like they are with no translation from actual
values in G or HZ.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 drivers/input/misc/bma150.c |   12 ------------
 include/linux/bma150.h      |   16 ++++++++++++++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index e5d1894..865c2f9 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -46,18 +46,6 @@
 #define BMA150_POLL_MAX		200
 #define BMA150_POLL_MIN		0
 
-#define BMA150_BW_25HZ		0
-#define BMA150_BW_50HZ		1
-#define BMA150_BW_100HZ		2
-#define BMA150_BW_190HZ		3
-#define BMA150_BW_375HZ		4
-#define BMA150_BW_750HZ		5
-#define BMA150_BW_1500HZ	6
-
-#define BMA150_RANGE_2G		0
-#define BMA150_RANGE_4G		1
-#define BMA150_RANGE_8G		2
-
 #define BMA150_MODE_NORMAL	0
 #define BMA150_MODE_SLEEP	2
 #define BMA150_MODE_WAKE_UP	3
diff --git a/include/linux/bma150.h b/include/linux/bma150.h
index 7911fda..97ade7c 100644
--- a/include/linux/bma150.h
+++ b/include/linux/bma150.h
@@ -22,6 +22,18 @@
 
 #define BMA150_DRIVER		"bma150"
 
+#define BMA150_RANGE_2G		0
+#define BMA150_RANGE_4G		1
+#define BMA150_RANGE_8G		2
+
+#define BMA150_BW_25HZ		0
+#define BMA150_BW_50HZ		1
+#define BMA150_BW_100HZ		2
+#define BMA150_BW_190HZ		3
+#define BMA150_BW_375HZ		4
+#define BMA150_BW_750HZ		5
+#define BMA150_BW_1500HZ	6
+
 struct bma150_cfg {
 	bool any_motion_int;		/* Set to enable any-motion interrupt */
 	bool hg_int;			/* Set to enable high-G interrupt */
@@ -34,8 +46,8 @@ struct bma150_cfg {
 	unsigned char lg_hyst;		/* Low-G hysterisis */
 	unsigned char lg_dur;		/* Low-G duration */
 	unsigned char lg_thres;		/* Low-G threshold */
-	unsigned char range;		/* BMA0150_RANGE_xxx (in G) */
-	unsigned char bandwidth;	/* BMA0150_BW_xxx (in Hz) */
+	unsigned char range;		/* one of BMA0150_RANGE_xxx */
+	unsigned char bandwidth;	/* one of BMA0150_BW_xxx */
 };
 
 struct bma150_platform_data {
-- 
1.7.10.4

