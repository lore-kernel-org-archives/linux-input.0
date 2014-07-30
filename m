From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH 2/2] Input: jornada720_ts: Get rid of space indentation and use tab
Date: Wed, 30 Jul 2014 19:18:27 +0530
Message-ID: <1406728107-26969-2-git-send-email-pramod.gurav@smartplayin.com>
References: <1406728107-26969-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp104.ord1c.emailsrvr.com ([108.166.43.104]:51756 "EHLO
	smtp104.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752713AbaG3Np2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2014 09:45:28 -0400
In-Reply-To: <1406728107-26969-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/input/touchscreen/jornada720_ts.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index 7422480..5d34e3d 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -36,22 +36,21 @@ struct jornada_ts {
 
 static void jornada720_ts_collect_data(struct jornada_ts *jornada_ts)
 {
+	/* 3 low word X samples */
+	jornada_ts->x_data[0] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->x_data[1] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->x_data[2] = jornada_ssp_byte(TXDUMMY);
 
-    /* 3 low word X samples */
-    jornada_ts->x_data[0] = jornada_ssp_byte(TXDUMMY);
-    jornada_ts->x_data[1] = jornada_ssp_byte(TXDUMMY);
-    jornada_ts->x_data[2] = jornada_ssp_byte(TXDUMMY);
+	/* 3 low word Y samples */
+	jornada_ts->y_data[0] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->y_data[1] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->y_data[2] = jornada_ssp_byte(TXDUMMY);
 
-    /* 3 low word Y samples */
-    jornada_ts->y_data[0] = jornada_ssp_byte(TXDUMMY);
-    jornada_ts->y_data[1] = jornada_ssp_byte(TXDUMMY);
-    jornada_ts->y_data[2] = jornada_ssp_byte(TXDUMMY);
+	/* combined x samples bits */
+	jornada_ts->x_data[3] = jornada_ssp_byte(TXDUMMY);
 
-    /* combined x samples bits */
-    jornada_ts->x_data[3] = jornada_ssp_byte(TXDUMMY);
-
-    /* combined y samples bits */
-    jornada_ts->y_data[3] = jornada_ssp_byte(TXDUMMY);
+	/* combined y samples bits */
+	jornada_ts->y_data[3] = jornada_ssp_byte(TXDUMMY);
 }
 
 static int jornada720_ts_average(int coords[4])
-- 
1.7.9.5

