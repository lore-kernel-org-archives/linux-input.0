From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2] ads7846: Add possibility to use external vref on ads7846
Date: Thu,  5 May 2011 12:55:27 +0200
Message-ID: <1304592927-22687-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:42562 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab1EEKza (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 06:55:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>

Just set vref_mv in your platform config to use external vref. Otherwise
the internal one is used.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes since v1:
* Actually change the SPI commands to select internal or external reference.

 drivers/input/touchscreen/ads7846.c |   19 +++++++++++--------
 include/linux/spi/ads7846.h         |    3 ++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1de1c19..c25049c 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -109,6 +109,7 @@ struct ads7846 {
 	u16			pressure_max;
 
 	bool			swap_xy;
+	bool			use_internal;
 
 	struct ads7846_packet	*packet;
 
@@ -307,7 +308,6 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	struct ads7846 *ts = dev_get_drvdata(dev);
 	struct ser_req *req;
 	int status;
-	int use_internal;
 
 	req = kzalloc(sizeof *req, GFP_KERNEL);
 	if (!req)
@@ -315,11 +315,8 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 
 	spi_message_init(&req->msg);
 
-	/* FIXME boards with ads7846 might use external vref instead ... */
-	use_internal = (ts->model == 7846);
-
 	/* maybe turn on internal vREF, and let it settle */
-	if (use_internal) {
+	if (ts->use_internal) {
 		req->ref_on = REF_ON;
 		req->xfer[0].tx_buf = &req->ref_on;
 		req->xfer[0].len = 1;
@@ -331,8 +328,14 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 		/* for 1uF, settle for 800 usec; no cap, 100 usec.  */
 		req->xfer[1].delay_usecs = ts->vref_delay_usecs;
 		spi_message_add_tail(&req->xfer[1], &req->msg);
+
+		/* Enable reference voltage */
+		command |= ADS_PD10_REF_ON;
 	}
 
+	/* Enable ADC in every case */
+	command |= ADS_PD10_ADC_ON;
+
 	/* take sample */
 	req->command = (u8) command;
 	req->xfer[2].tx_buf = &req->command;
@@ -416,7 +419,7 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct ads7846 *ts = dev_get_drvdata(dev); \
 	ssize_t v = ads7846_read12_ser(dev, \
-			READ_12BIT_SER(var) | ADS_PD10_ALL_ON); \
+			READ_12BIT_SER(var)); \
 	if (v < 0) \
 		return v; \
 	return sprintf(buf, "%u\n", adjust(ts, v)); \
@@ -509,6 +512,7 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 		if (!ts->vref_mv) {
 			dev_dbg(&spi->dev, "assuming 2.5V internal vREF\n");
 			ts->vref_mv = 2500;
+			ts->use_internal = true;
 		}
 		break;
 	case 7845:
@@ -1340,8 +1344,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	if (ts->model == 7845)
 		ads7845_read12_ser(&spi->dev, PWRDOWN);
 	else
-		(void) ads7846_read12_ser(&spi->dev,
-				READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
+		(void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
 
 	err = sysfs_create_group(&spi->dev.kobj, &ads784x_attr_group);
 	if (err)
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 92bd083..c64de9d 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -14,7 +14,8 @@ enum ads7846_filter {
 struct ads7846_platform_data {
 	u16	model;			/* 7843, 7845, 7846, 7873. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
-	u16	vref_mv;		/* external vref value, milliVolts */
+	u16	vref_mv;		/* external vref value, milliVolts
+					 * ads7846: if 0, use internal vref */
 	bool	keep_vref_on;		/* set to keep vref on for differential
 					 * measurements as well */
 	bool	swap_xy;		/* swap x and y axes */
-- 
1.7.3.4

