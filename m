From: Matthias Brugger <matthias.bgg@googlemail.com>
Subject: [PATCH 1/2] touchscreen/ads7846.c: Alloc filter data only when needed.
Date: Wed, 24 Oct 2012 13:38:55 +0200
Message-ID: <1351078736-16785-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45723 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758496Ab2JXLjN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Oct 2012 07:39:13 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so200281wey.19
        for <linux-input@vger.kernel.org>; Wed, 24 Oct 2012 04:39:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, grinberg@compulab.co.il
Cc: Matthias Brugger <matthias.bgg@gmail.com>

This patch encapsulates the variables used by the default debounce
filter in a struct. The values are allocated only if the debounce filter
is used by the platform.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |   42 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f02028e..9e61a4b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -90,6 +90,15 @@ struct ads7846_packet {
 	u8			read_x_cmd[3], read_y_cmd[3], pwrdown_cmd[3];
 };
 
+struct ads7846_filterd {
+	int			read_cnt;
+	int			read_rep;
+	int			last_read;
+	u16			debounce_max;
+	u16			debounce_tol;
+	u16			debounce_rep;
+};
+
 struct ads7846 {
 	struct input_dev	*input;
 	char			phys[32];
@@ -121,14 +130,6 @@ struct ads7846 {
 
 	bool			pendown;
 
-	int			read_cnt;
-	int			read_rep;
-	int			last_read;
-
-	u16			debounce_max;
-	u16			debounce_tol;
-	u16			debounce_rep;
-
 	u16			penirq_recheck_delay_usecs;
 
 	struct mutex		lock;
@@ -643,9 +644,14 @@ static void null_wait_for_sync(void)
 {
 }
 
+static void ads7864_filter_cleanup(void *data)
+{
+	kfree(data);
+}
+
 static int ads7846_debounce_filter(void *ads, int data_idx, int *val)
 {
-	struct ads7846 *ts = ads;
+	struct ads7846_filterd *ts = (struct ads7846_filterd*) ads;
 
 	if (!ts->read_cnt || (abs(ts->last_read - *val) > ts->debounce_tol)) {
 		/* Start over collecting consistent readings. */
@@ -1261,13 +1267,19 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		ts->filter = pdata->filter;
 		ts->filter_cleanup = pdata->filter_cleanup;
 	} else if (pdata->debounce_max) {
-		ts->debounce_max = pdata->debounce_max;
-		if (ts->debounce_max < 2)
-			ts->debounce_max = 2;
-		ts->debounce_tol = pdata->debounce_tol;
-		ts->debounce_rep = pdata->debounce_rep;
+		struct ads7846_filterd *fdata = kmalloc(sizeof(struct ads7846_filterd), GFP_KERNEL);
+		if (!fdata) {
+			err = -ENOMEM;
+			goto err_free_mem;
+		}
+		fdata->debounce_max = pdata->debounce_max;
+		if (fdata->debounce_max < 2)
+			fdata->debounce_max = 2;
+		fdata->debounce_tol = pdata->debounce_tol;
+		fdata->debounce_rep = pdata->debounce_rep;
 		ts->filter = ads7846_debounce_filter;
-		ts->filter_data = ts;
+		ts->filter_cleanup = ads7864_filter_cleanup;
+		ts->filter_data = fdata;
 	} else {
 		ts->filter = ads7846_no_filter;
 	}
-- 
1.7.9.5

