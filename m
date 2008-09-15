From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc6] ads7846: work better with DMA
Date: Mon, 15 Sep 2008 16:32:17 -0700
Message-ID: <200809151632.17505.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:44867 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753554AbYIOXi7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2008 19:38:59 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

From: David Brownell <dbrownell@users.sourceforge.net>

We had a report a while back that the ads7846 driver had some issues
when used with DMA-based SPI controllers (like atmel_spi) on systems
where main memory is not DMA-coherent (most non-x86 boards) ... but no
mergeable patch addressed it.  Pending any more comprehensive fix,
just push the relevant data into cache lines that won't be shared,
preventing those issues (but not in a very pretty way).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Please merge for 2.6.27-final (and forward to -stable for backports);
this lack-of-patch has lingered for way too long.

 drivers/input/touchscreen/ads7846.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -85,10 +85,6 @@ struct ads7846 {
 	u16			x_plate_ohms;
 	u16			pressure_max;
 
-	u8			read_x, read_y, read_z1, read_z2, pwrdown;
-	u16			dummy;		/* for the pwrdown read */
-	struct ts_event		tc;
-
 	struct spi_transfer	xfer[18];
 	struct spi_message	msg[5];
 	struct spi_message	*last_msg;
@@ -116,6 +112,26 @@ struct ads7846 {
 	void			*filter_data;
 	void			(*filter_cleanup)(void *data);
 	int			(*get_pendown_state)(void);
+
+	/* NOTE: this is a bit klugey.  Ideally all these I/O buffers
+	 * would be in a separate buffer (from the heap) to make DMA
+	 * work better.  Instead, we trust that starting them on their
+	 * own cache line, at the end of this struct, suffices to avoid
+	 * cacheline sharing issues -- pending any better fix.
+	 *
+	 * The first several systems to use this driver didn't use DMA
+	 * with SPI, at least for small I/O requests as used here, so
+	 * the cache line sharing issues wouldn't show up there.
+	 */
+	u8			read_x ____cacheline_aligned;
+	u8			read_y;
+	u8			read_z1:
+	u8			read_z2;
+	u8			pwrdown;
+	u16			dummy;		/* for the pwrdown read */
+
+	struct ts_event		tc;
+
 };
 
 /* leave chip selected when we're done, for quicker re-select? */
