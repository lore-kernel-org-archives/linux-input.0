From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v2] Input: synaptics - update OLPC XO exclusion
Date: Fri, 11 Nov 2011 18:42:19 +0000 (GMT)
Message-ID: <20111111184220.03CC49D401E@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:5968 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116Ab1KKSmZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Nov 2011 13:42:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org, dilinger@queued.net

We have determined that the jumpiness previously seen when using
the synaptics kernel mouse driver on OLPC XO was due to not using
the synaptics X11 userspace driver - the xf86-input-evdev driver was
interpreting 'finger near pad' signals as movements. Newer versions
of xf86-input-evdev fix this issue.

Additionally, the synaptics kernel driver is now usable on this
platform, but only when run in relative mode.

Update the comment and refine the check to allow the synaptics driver
to run on OLPC XO in relative mode.

We will continue investigating the EC issue as time becomes available.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/synaptics.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a3bb49c..06c9ee5 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1389,15 +1389,12 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	int err = -1;
 
 	/*
-	 * The OLPC XO has issues with Synaptics' absolute mode; similarly to
-	 * the HGPK, it quickly degrades and the hardware becomes jumpy and
-	 * overly sensitive.  Not only that, but the constant packet spew
-	 * (even at a lowered 40pps rate) overloads the EC such that key
-	 * presses on the keyboard are missed.  Given all of that, don't
-	 * even attempt to use Synaptics mode.  Relative mode seems to work
-	 * just fine.
+	 * The OLPC XO has issues with Synaptics' absolute mode; the constant
+	 * packet spew overloads the EC such that key presses on the keyboard
+	 * are missed.  Given that, don't even attempt to use Absolute mode.
+	 * Relative mode seems to work just fine.
 	 */
-	if (broken_olpc_ec) {
+	if (absolute_mode && broken_olpc_ec) {
 		psmouse_info(psmouse,
 			     "OLPC XO detected, not enabling Synaptics protocol.\n");
 		return -ENODEV;
-- 
1.7.7.1

