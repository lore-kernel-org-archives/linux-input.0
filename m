From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/2] ads7846: Make buffers in ads7846_read12_ser and ads7845_read12_ser DMA save
Date: Wed,  4 May 2011 17:22:04 +0200
Message-ID: <1304522525-27351-1-git-send-email-alexander.stein@systec-electronic.com>
References: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:51559 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab1EDPWJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 11:22:09 -0400
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anatolij Gustschin <agust@denx.de>, Alexander Stein <alexander.stein@systec-electronic.com>

req.sample needs its own cacheline otherwise accessing req.msg fetches
it in again.
Put req onto stack as it doesn't need to be DMA save.
req.sample is kzalloced itself for DMA access.
req.command doesn't need own cache line because it will only be written to
memory on dma_map_single. req.scratch is unsed at all.

Note: This effect doesn't occur if the underlying SPI driver doesn't use
DMA at all.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Anatolij,

could you please check the ads7845 parts?
Thanks!

 drivers/input/touchscreen/ads7846.c |   92 ++++++++++++++++++-----------------
 1 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index c24946f..6157a80 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -281,7 +281,7 @@ struct ser_req {
 	u8			command;
 	u8			ref_off;
 	u16			scratch;
-	__be16			sample;
+	__be16			*sample;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[6];
 };
@@ -289,7 +289,7 @@ struct ser_req {
 struct ads7845_ser_req {
 	u8			command[3];
 	u8			pwrdown[3];
-	u8			sample[3];
+	u8			*sample;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[2];
 };
@@ -298,71 +298,73 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct ads7846 *ts = dev_get_drvdata(dev);
-	struct ser_req *req;
+	struct ser_req req;
 	int status;
 	int use_internal;
 
-	req = kzalloc(sizeof *req, GFP_KERNEL);
-	if (!req)
+	memset(&req, 0, sizeof(req));
+
+	req.sample = kzalloc(sizeof *(req.sample), GFP_KERNEL);
+	if (!req.sample)
 		return -ENOMEM;
 
-	spi_message_init(&req->msg);
+	spi_message_init(&req.msg);
 
 	/* FIXME boards with ads7846 might use external vref instead ... */
 	use_internal = (ts->model == 7846);
 
 	/* maybe turn on internal vREF, and let it settle */
 	if (use_internal) {
-		req->ref_on = REF_ON;
-		req->xfer[0].tx_buf = &req->ref_on;
-		req->xfer[0].len = 1;
-		spi_message_add_tail(&req->xfer[0], &req->msg);
+		req.ref_on = REF_ON;
+		req.xfer[0].tx_buf = &req.ref_on;
+		req.xfer[0].len = 1;
+		spi_message_add_tail(&req.xfer[0], &req.msg);
 
-		req->xfer[1].rx_buf = &req->scratch;
-		req->xfer[1].len = 2;
+		req.xfer[1].rx_buf = &req.scratch;
+		req.xfer[1].len = 2;
 
 		/* for 1uF, settle for 800 usec; no cap, 100 usec.  */
-		req->xfer[1].delay_usecs = ts->vref_delay_usecs;
-		spi_message_add_tail(&req->xfer[1], &req->msg);
+		req.xfer[1].delay_usecs = ts->vref_delay_usecs;
+		spi_message_add_tail(&req.xfer[1], &req.msg);
 	}
 
 	/* take sample */
-	req->command = (u8) command;
-	req->xfer[2].tx_buf = &req->command;
-	req->xfer[2].len = 1;
-	spi_message_add_tail(&req->xfer[2], &req->msg);
+	req.command = (u8) command;
+	req.xfer[2].tx_buf = &req.command;
+	req.xfer[2].len = 1;
+	spi_message_add_tail(&req.xfer[2], &req.msg);
 
-	req->xfer[3].rx_buf = &req->sample;
-	req->xfer[3].len = 2;
-	spi_message_add_tail(&req->xfer[3], &req->msg);
+	req.xfer[3].rx_buf = req.sample;
+	req.xfer[3].len = 2;
+	spi_message_add_tail(&req.xfer[3], &req.msg);
 
 	/* REVISIT:  take a few more samples, and compare ... */
 
 	/* converter in low power mode & enable PENIRQ */
-	req->ref_off = PWRDOWN;
-	req->xfer[4].tx_buf = &req->ref_off;
-	req->xfer[4].len = 1;
-	spi_message_add_tail(&req->xfer[4], &req->msg);
+	req.ref_off = PWRDOWN;
+	req.xfer[4].tx_buf = &req.ref_off;
+	req.xfer[4].len = 1;
+	spi_message_add_tail(&req.xfer[4], &req.msg);
 
-	req->xfer[5].rx_buf = &req->scratch;
-	req->xfer[5].len = 2;
-	CS_CHANGE(req->xfer[5]);
-	spi_message_add_tail(&req->xfer[5], &req->msg);
+	req.xfer[5].rx_buf = &req.scratch;
+	req.xfer[5].len = 2;
+	CS_CHANGE(req.xfer[5]);
+	spi_message_add_tail(&req.xfer[5], &req.msg);
 
 	mutex_lock(&ts->lock);
 	ads7846_stop(ts);
-	status = spi_sync(spi, &req->msg);
+	status = spi_sync(spi, &req.msg);
 	ads7846_restart(ts);
 	mutex_unlock(&ts->lock);
 
 	if (status == 0) {
 		/* on-wire is a must-ignore bit, a BE12 value, then padding */
-		status = be16_to_cpu(req->sample);
+		status = be16_to_cpu(*req.sample);
 		status = status >> 3;
 		status &= 0x0fff;
 	}
 
-	kfree(req);
+	kfree(req.sample);
 	return status;
 }
 
@@ -370,35 +372,37 @@ static int ads7845_read12_ser(struct device *dev, unsigned command)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct ads7846 *ts = dev_get_drvdata(dev);
-	struct ads7845_ser_req *req;
+	struct ads7845_ser_req req;
 	int status;
 
-	req = kzalloc(sizeof *req, GFP_KERNEL);
-	if (!req)
+	memset(&req, 0, sizeof(req));
+
+	req.sample = kzalloc(3 * sizeof *(req.sample), GFP_KERNEL);
+	if (!req.sample)
 		return -ENOMEM;
 
-	spi_message_init(&req->msg);
+	spi_message_init(&req.msg);
 
-	req->command[0] = (u8) command;
-	req->xfer[0].tx_buf = req->command;
-	req->xfer[0].rx_buf = req->sample;
-	req->xfer[0].len = 3;
-	spi_message_add_tail(&req->xfer[0], &req->msg);
+	req.command[0] = (u8) command;
+	req.xfer[0].tx_buf = req.command;
+	req.xfer[0].rx_buf = req.sample;
+	req.xfer[0].len = 3;
+	spi_message_add_tail(&req.xfer[0], &req.msg);
 
 	mutex_lock(&ts->lock);
 	ads7846_stop(ts);
-	status = spi_sync(spi, &req->msg);
+	status = spi_sync(spi, &req.msg);
 	ads7846_restart(ts);
 	mutex_unlock(&ts->lock);
 
 	if (status == 0) {
 		/* BE12 value, then padding */
-		status = be16_to_cpu(*((u16 *)&req->sample[1]));
+		status = be16_to_cpu(*((u16 *)&req.sample[1]));
 		status = status >> 3;
 		status &= 0x0fff;
 	}
 
-	kfree(req);
+	kfree(req.sample);
 	return status;
 }
 
-- 
1.7.3.4

