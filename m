From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/2] ads7846: Make buffers in struct ser_req and struct ads7845_ser_req DMA save
Date: Thu,  5 May 2011 08:51:07 +0200
Message-ID: <1304578268-24887-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:52584 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab1EEGvL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 02:51:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>

req.sample needs its own cacheline otherwise accessing req.msg fetches
it in again.

Note: This effect doesn't occur if the underlying SPI driver doesn't use
DMA at all.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
This obsoletes the patch
[PATCH 1/2] ads7846: Make buffers in ads7846_read12_ser and ads7845_read12_ser DMA save

 drivers/input/touchscreen/ads7846.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index c24946f..ab51a8d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -281,17 +281,25 @@ struct ser_req {
 	u8			command;
 	u8			ref_off;
 	u16			scratch;
-	__be16			sample;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[6];
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	__be16 sample ____cacheline_aligned;
 };
 
 struct ads7845_ser_req {
 	u8			command[3];
 	u8			pwrdown[3];
-	u8			sample[3];
 	struct spi_message	msg;
 	struct spi_transfer	xfer[2];
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8 sample[3] ____cacheline_aligned;
 };
 
 static int ads7846_read12_ser(struct device *dev, unsigned command)
-- 
1.7.3.4

