From: akpm@linux-foundation.org
Subject: [patch 5/8] input: mousedev: distinguish a moving finger from a tapping finger
Date: Mon, 01 Dec 2008 14:20:15 -0800
Message-ID: <200812012220.mB1MKFxc012632@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47161 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753341AbYLAWVW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Dec 2008 17:21:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, rydberg@euromail.se

From: Henrik Rydberg <rydberg@euromail.se>

The tap functionality of mousedev does not distinguish between a tap
(on/off localized in time and space) and a quick move (on/off localized in
time only).  This patch improves the tap detection by testing also for
space locality.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/mousedev.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff -puN drivers/input/mousedev.c~input-mousedev-distinguish-a-moving-finger-from-a-tapping-finger drivers/input/mousedev.c
--- a/drivers/input/mousedev.c~input-mousedev-distinguish-a-moving-finger-from-a-tapping-finger
+++ a/drivers/input/mousedev.c
@@ -49,6 +49,10 @@ static unsigned tap_time = 200;
 module_param(tap_time, uint, 0644);
 MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
 
+static unsigned tap_move = 20;
+module_param(tap_move, uint, 0644);
+MODULE_PARM_DESC(tap_move, "Tap distance for touchpads in absolute mode (res)");
+
 struct mousedev_hw_data {
 	int dx, dy, dz;
 	int x, y;
@@ -76,6 +80,7 @@ struct mousedev {
 	int old_x[4], old_y[4];
 	int frac_dx, frac_dy;
 	unsigned long touch;
+	int touch_dx, touch_dy;
 };
 
 enum mousedev_emul {
@@ -143,6 +148,7 @@ static void mousedev_touchpad_event(stru
 			tmp = ((value - fx(2)) * 256 * FRACTION_DENOM) / size;
 			tmp += mousedev->frac_dx;
 			mousedev->packet.dx = tmp / FRACTION_DENOM;
+			mousedev->touch_dx += mousedev->packet.dx;
 			mousedev->frac_dx =
 				tmp - mousedev->packet.dx * FRACTION_DENOM;
 		}
@@ -158,6 +164,7 @@ static void mousedev_touchpad_event(stru
 			tmp = -((value - fy(2)) * 256 * FRACTION_DENOM) / size;
 			tmp += mousedev->frac_dy;
 			mousedev->packet.dy = tmp / FRACTION_DENOM;
+			mousedev->touch_dy += mousedev->packet.dy;
 			mousedev->frac_dy = tmp -
 				mousedev->packet.dy * FRACTION_DENOM;
 		}
@@ -320,6 +327,8 @@ static void mousedev_touchpad_touch(stru
 {
 	if (!value) {
 		if (mousedev->touch &&
+		    abs(mousedev->touch_dx) < tap_move &&
+		    abs(mousedev->touch_dy) < tap_move &&
 		    time_before(jiffies,
 				mousedev->touch + msecs_to_jiffies(tap_time))) {
 			/*
@@ -336,6 +345,7 @@ static void mousedev_touchpad_touch(stru
 			clear_bit(0, &mousedev_mix->packet.buttons);
 		}
 		mousedev->touch = mousedev->pkt_count = 0;
+		mousedev->touch_dx = mousedev->touch_dy = 0;
 		mousedev->frac_dx = 0;
 		mousedev->frac_dy = 0;
 
_
