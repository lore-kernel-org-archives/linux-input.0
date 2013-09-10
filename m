From: Andrew Deason <adeason@dson.org>
Subject: [PATCH] Input: synaptics_usb - Scale stick axes evenly
Date: Mon, 9 Sep 2013 22:30:03 -0500
Message-ID: <20130909223003.fe88fffa873b71cfa20de502@dson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:58347 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3IJDaF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 23:30:05 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so7335307oah.23
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 20:30:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Currently, we report relative x and y coordinates when receiving data
from the pointing stick. We try to divide each value by 16, since the
raw values are very large, and send the pointer flying across the
screen. Currently we try to do this by shifting the relative
coordinates for the pointing stick over by 4 bits by doing, e.g.:

	x = (s16)(be16_to_cpup((__be16 *)&synusb->data[2]) << 3) >> 7;

The raw value from usb is 13-bits wide, so I assume that we shift left
by 3 then right by 7 in order to effectively shift right by 4 while
preserving sign.

However, this is inconsistent with different directions. For example,
an x value of 1 would indicate movement to the right by 1 unit, and
shifting right by 4 reduces this value to 0. But a value of -1
(movement left by 1 unit) is 0x1fff, and running this through the
above code yields a result of -1, not 0.

The result of this is that very tiny movements in the right and up
directions result in no movement, but very tiny movements in the left
and down directions do result in movement, resulting in a confusing
user experience.

So instead of all of this, just figure out what the raw value is, and
divide it by 16 explicitly.

Signed-off-by: Andrew Deason <adeason@dson.org>
---
To be clear, I'm still finishing a larger change to how we report stick
movement, per
<http://permalink.gmane.org/gmane.linux.kernel.input/31777>. But in the
meantime, this simple change removes one of the more aggravating
characteristics of the existing code.
---
 drivers/input/mouse/synaptics_usb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 64cf34e..2c4a3c1 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -108,8 +108,10 @@ static void synusb_report_stick(struct synusb *synusb)
 	unsigned int pressure;
 
 	pressure = synusb->data[6];
-	x = (s16)(be16_to_cpup((__be16 *)&synusb->data[2]) << 3) >> 7;
-	y = (s16)(be16_to_cpup((__be16 *)&synusb->data[4]) << 3) >> 7;
+	x = (s16)(be16_to_cpup((__be16 *)&synusb->data[2]) << 3) >> 3;
+	y = (s16)(be16_to_cpup((__be16 *)&synusb->data[4]) << 3) >> 3;
+	x /= 16;
+	y /= 16;
 
 	if (pressure > 0) {
 		input_report_rel(input_dev, REL_X, x);
-- 
1.8.4.rc3
