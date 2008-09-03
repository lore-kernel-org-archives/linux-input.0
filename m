From: Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH 1/3] bcm5974-0.64: minor cleanups for scripts/checkpatch.pl
Date: Wed, 03 Sep 2008 22:21:59 +0200
Message-ID: <48BEF1E7.1040708@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:38384 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752602AbYICUWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2008 16:22:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, akpm@osdl.org, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 2ec921b..ae78bb8 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -63,7 +63,7 @@
 }

 /* table of devices that work with this driver */
-static const struct usb_device_id bcm5974_table [] = {
+static const struct usb_device_id bcm5974_table[] = {
 	/* MacbookAir1.1 */
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
-- 
1.5.4.3

Diff is against v2.6.27-rc5-103-g0a7574e
