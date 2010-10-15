From: <michael.hennerich@analog.com>
Subject: [PATCH 1/3] Input: touchscreen: ad7877 implement specified chip select behavior
Date: Fri, 15 Oct 2010 12:36:09 +0200
Message-ID: <1287138971-24753-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:7241 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0JOKm4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 06:42:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

According to the AD7877 datasheet:
Each transfer operation is 16-bit. If multiple read/write operations are
to be performed, CS must be taken high after the end of each read/write
operation before another read/write operation can be performed by
taking CS low again.

Make sure CS toggles after each transfer in the message.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7877.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 5f0221c..53f4d79 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -230,6 +230,7 @@ static int ad7877_read(struct spi_device *spi, u16 reg)
 			AD7877_READADD(reg));
 	req->xfer[0].tx_buf = &req->command;
 	req->xfer[0].len = 2;
+	req->xfer[0].cs_change = 1;
 
 	req->xfer[1].rx_buf = &req->sample;
 	req->xfer[1].len = 2;
@@ -295,20 +296,25 @@ static int ad7877_read_adc(struct spi_device *spi, unsigned command)
 
 	req->xfer[0].tx_buf = &req->reset;
 	req->xfer[0].len = 2;
+	req->xfer[0].cs_change = 1;
 
 	req->xfer[1].tx_buf = &req->ref_on;
 	req->xfer[1].len = 2;
 	req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+	req->xfer[1].cs_change = 1;
 
 	req->xfer[2].tx_buf = &req->command;
 	req->xfer[2].len = 2;
 	req->xfer[2].delay_usecs = ts->vref_delay_usecs;
+	req->xfer[2].cs_change = 1;
 
 	req->xfer[3].rx_buf = &req->sample;
 	req->xfer[3].len = 2;
+	req->xfer[3].cs_change = 1;
 
 	req->xfer[4].tx_buf = &ts->cmd_crtl2;	/*REF OFF*/
 	req->xfer[4].len = 2;
+	req->xfer[4].cs_change = 1;
 
 	req->xfer[5].tx_buf = &ts->cmd_crtl1;	/*DEFAULT*/
 	req->xfer[5].len = 2;
@@ -640,17 +646,21 @@ static void ad7877_setup_ts_def_msg(struct spi_device *spi, struct ad7877 *ts)
 
 	ts->xfer[0].tx_buf = &ts->cmd_crtl1;
 	ts->xfer[0].len = 2;
+	ts->xfer[0].cs_change = 1;
 
 	spi_message_add_tail(&ts->xfer[0], m);
 
 	ts->xfer[1].tx_buf = &ts->cmd_dummy; /* Send ZERO */
 	ts->xfer[1].len = 2;
+	ts->xfer[1].cs_change = 1;
 
 	spi_message_add_tail(&ts->xfer[1], m);
 
-	for (i = 0; i < 11; i++) {
+	for (i = 0; i < AD7877_NR_SENSE; i++) {
 		ts->xfer[i + 2].rx_buf = &ts->conversion_data[AD7877_SEQ_YPOS + i];
 		ts->xfer[i + 2].len = 2;
+		if (i < (AD7877_NR_SENSE - 1))
+			ts->xfer[i + 2].cs_change = 1;
 		spi_message_add_tail(&ts->xfer[i + 2], m);
 	}
 }
-- 
1.6.0.2

