From: <michael.hennerich@analog.com>
Subject: [PATCH 3/3] Input: touchscreen: ad7877 filter events where pressure is beyond the maximum
Date: Fri, 15 Oct 2010 12:36:11 +0200
Message-ID: <1287138971-24753-3-git-send-email-michael.hennerich@analog.com>
References: <1287138971-24753-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:7241 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab0JOKm6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 06:42:58 -0400
In-Reply-To: <1287138971-24753-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Suppress events where pressure > pressure_max.
These events come typically along with inaccurate X and Y samples.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7877.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 96c0a0d..e6917db 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
 		Rt /= z1;
 		Rt = (Rt + 2047) >> 12;
 
+		/*
+		 * Sample found inconsistent, pressure is beyond
+		 * the maximum. Don't report it to user space.
+		 */
+	 	if (Rt > ts->pressure_max)
+	 		return -EINVAL;
+
 		if (!timer_pending(&ts->timer))
 			input_report_key(input_dev, BTN_TOUCH, 1);
 
-- 
1.6.0.2

