From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] input: uinput: Setup MT usage during device creation
Date: Sun, 19 Sep 2010 13:54:13 +0200
Message-ID: <1284897253-1634-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:37377 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753220Ab0ISLys (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Sep 2010 07:54:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The input devices created by uinput do not currently handle multitouch
properly. All events will appear as if they came from slot zero, and
the input event buffers are not adjusted. This patch creates the MT
slots during setup, and sets the number of events per packet based
on the MT usage.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/misc/uinput.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 0d4266a..3606985 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -404,6 +404,13 @@ static int uinput_setup_device(struct uinput_device *udev, const char __user *bu
 		retval = uinput_validate_absbits(dev);
 		if (retval < 0)
 			goto exit;
+		if (test_bit(ABS_MT_SLOT, dev->absbit)) {
+			int nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
+			input_mt_create_slots(dev, nslot);
+			input_set_events_per_packet(dev, 6 * nslot);
+		} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
+			input_set_events_per_packet(dev, 60);
+		}
 	}
 
 	udev->state = UIST_SETUP_COMPLETE;
-- 
1.7.1

