From: Markus Niebel <list-09_linux_input@tqsc.de>
Subject: [PATCH] INPUT: ads7846 - fix wrong transfer init for ads7845
Date: Thu, 26 Apr 2012 16:17:56 +0200
Message-ID: <4F995914.6050403@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:49707 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2DZOan (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Apr 2012 10:30:43 -0400
Received: from [89.246.71.91] (helo=mail6.tqsc.de)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <list-09_linux_input@tqsc.de>)
	id 1SNPWC-0001AO-PD
	for linux-input@vger.kernel.org; Thu, 26 Apr 2012 16:18:00 +0200
Received: from sc0810201.tqsc.de ([192.168.80.70] helo=[127.0.0.1])
	by mail6.tqsc.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <list-09_linux_input@tqsc.de>)
	id 1SNPWC-0002An-Cg
	for linux-input@vger.kernel.org; Thu, 26 Apr 2012 16:18:00 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

For ads7845 transfer packets are wrong initialized for
activated settle_delay_usec. Buffers of spi_transfers have to point
to the ads7845 buffers also for the transfers used for implementing
the settling delay. Otherwise the filter will see invalid / uninitialized
data and the input gets the first raw samples.

This patch fixes the wrong buffer init.

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
---
 drivers/input/touchscreen/ads7846.c |   50 ++++++++++++++++++++++------------
 1 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 23fd901..9dca61d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1043,16 +1043,23 @@ static void __devinit ads7846_setup_spi_msg(struct ads7846 *ts,
 	 */
 	if (pdata->settle_delay_usecs) {
 		x->delay_usecs = pdata->settle_delay_usecs;
+		if (ts->model == 7845) {
+			x++;
+			x->tx_buf = &packet->read_y_cmd[0];
+			x->rx_buf = &packet->tc.y_buf[0];
+			x->len = 3;
+			spi_message_add_tail(x, m);
+		} else {
+			x++;
+			x->tx_buf = &packet->read_y;
+			x->len = 1;
+			spi_message_add_tail(x, m);
 
-		x++;
-		x->tx_buf = &packet->read_y;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
-		x->rx_buf = &packet->tc.y;
-		x->len = 2;
-		spi_message_add_tail(x, m);
+			x++;
+			x->rx_buf = &packet->tc.y;
+			x->len = 2;
+			spi_message_add_tail(x, m);
+		}
 	}
 
 	ts->msg_count++;
@@ -1086,16 +1093,23 @@ static void __devinit ads7846_setup_spi_msg(struct ads7846 *ts,
 	/* ... maybe discard first sample ... */
 	if (pdata->settle_delay_usecs) {
 		x->delay_usecs = pdata->settle_delay_usecs;
+		if (ts->model == 7845) {
+			x++;
+			x->tx_buf = &packet->read_x_cmd[0];
+			x->rx_buf = &packet->tc.x_buf[0];
+			x->len = 3;
+			spi_message_add_tail(x, m);
+		} else {
+			x++;
+			x->tx_buf = &packet->read_x;
+			x->len = 1;
+			spi_message_add_tail(x, m);
 
-		x++;
-		x->tx_buf = &packet->read_x;
-		x->len = 1;
-		spi_message_add_tail(x, m);
-
-		x++;
-		x->rx_buf = &packet->tc.x;
-		x->len = 2;
-		spi_message_add_tail(x, m);
+			x++;
+			x->rx_buf = &packet->tc.x;
+			x->len = 2;
+			spi_message_add_tail(x, m);
+		}
 	}
 
 	/* turn y+ off, x- on; we'll use formula #2 */
