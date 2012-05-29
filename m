From: Markus Niebel <list-09_linux_input@tqsc.de>
Subject: [PATCH] ads7846: enable usage of internal vref for AD7873
Date: Tue, 29 May 2012 17:22:31 +0200
Message-ID: <4FC4E9B7.7050100@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:53823 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab2E2PWf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 May 2012 11:22:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Touchscreen samples are taken in differential mode.
Therefore an external reference is not needed.
When working with internal vref disabling vref after
every touchscreen sample leads to settling effects in sampling
and errors in position data.

This patch disables the internal vref only if keep_vref_on us
is not set in platform_data.

Tested on i.MX35 with costum board


Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
---
 drivers/input/touchscreen/ads7846.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f02028e..b271633 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1001,15 +1001,14 @@ static void __devinit ads7846_setup_spi_msg(struct ads7846 *ts,
 	struct ads7846_packet *packet = ts->packet;
 	int vref = pdata->keep_vref_on;
 
-	if (ts->model == 7873) {
+	if (ts->model == 7873)
 		/*
 		 * The AD7873 is almost identical to the ADS7846
-		 * keep VREF off during differential/ratiometric
-		 * conversion modes.
+		 * set VREF off during differential/ratiometric
+		 * conversion modes if keep_vref_on is not set.
+		 * TODO: does keep_vref_on collide with usage of external vref?
 		 */
 		ts->model = 7846;
-		vref = 0;
-	}
 
 	ts->msg_count = 1;
 	spi_message_init(m);
-- 
1.7.0.4
