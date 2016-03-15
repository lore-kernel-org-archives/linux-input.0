From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: synaptics-rmi4 - using logical instead of bitwise AND
Date: Tue, 15 Mar 2016 10:11:40 +0300
Message-ID: <20160315071140.GF13560@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48671 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734AbcCOHMB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 03:12:01 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

There is a typo so we have && instead of &.

Fixes: ff8f83708b3e ('Input: synaptics-rmi4 - add support for 2D sensors and F11')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 77a5eb8..ec8a10d 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -775,7 +775,7 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
 	sensor_query->has_abs = !!(query_buf[0] & RMI_F11_HAS_ABS);
 	sensor_query->has_gestures = !!(query_buf[0] & RMI_F11_HAS_GESTURES);
 	sensor_query->has_sensitivity_adjust =
-		!!(query_buf[0] && RMI_F11_HAS_SENSITIVITY_ADJ);
+		!!(query_buf[0] & RMI_F11_HAS_SENSITIVITY_ADJ);
 	sensor_query->configurable = !!(query_buf[0] & RMI_F11_CONFIGURABLE);
 
 	sensor_query->nr_x_electrodes =
@@ -803,7 +803,7 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
 		sensor_query->has_bending_correction =
 			!!(query_buf[0] & RMI_F11_HAS_BENDING_CORRECTION);
 		sensor_query->has_large_object_suppression =
-		!!(query_buf[0] && RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
+			!!(query_buf[0] & RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
 		sensor_query->has_jitter_filter =
 			!!(query_buf[0] & RMI_F11_HAS_JITTER_FILTER);
 		query_size++;
