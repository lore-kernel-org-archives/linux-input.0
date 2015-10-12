From: Petri Gynther <pgynther@google.com>
Subject: [PATCH v2] Input: improve autorepeat initialization
Date: Mon, 12 Oct 2015 12:04:46 -0700
Message-ID: <1444676686-26900-1-git-send-email-pgynther@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34453 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbbJLTFe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 15:05:34 -0400
Received: by padhy16 with SMTP id hy16so160885438pad.1
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2015 12:05:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Petri Gynther <pgynther@google.com>

Allow driver to initialize its own values for input_dev->rep[REP_DELAY]
and input_dev->rep[REP_PERIOD], but also use the software autorepeat
functionality from input.c.

For example, a HID driver could do:

static void xyz_input_configured(struct hid_device *hid,
                                 struct hid_input *hidinput)
{
        hidinput->input->rep[REP_DELAY] = 400;
        hidinput->input->rep[REP_PERIOD] = 100;
        hidinput->input->softrepeat = true;
}

static struct hid_driver xyz_driver = {
        .input_configured = xyz_input_configured,
}

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/input/input.c | 9 +++++++--
 include/linux/input.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 5391abd..a6f65c7 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2106,13 +2106,18 @@ int input_register_device(struct input_dev *dev)
 
 	/*
 	 * If delay and period are pre-set by the driver, then autorepeating
-	 * is handled by the driver itself and we don't do it in input.c.
+	 * is handled by the driver itself and we don't do it in input.c
+	 * unless the driver also requests softrepeat.
 	 */
 	if (!dev->rep[REP_DELAY] && !dev->rep[REP_PERIOD]) {
-		dev->timer.data = (long) dev;
+		dev->softrepeat = true;
+		dev->timer.data = (unsigned long) dev;
 		dev->timer.function = input_repeat_key;
 		dev->rep[REP_DELAY] = 250;
 		dev->rep[REP_PERIOD] = 33;
+	} else if (dev->softrepeat) {
+		dev->timer.data = (unsigned long) dev;
+		dev->timer.function = input_repeat_key;
 	}
 
 	if (!dev->getkeycode)
diff --git a/include/linux/input.h b/include/linux/input.h
index 82ce323..2535948 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -150,6 +150,7 @@ struct input_dev {
 
 	struct ff_device *ff;
 
+	bool softrepeat;
 	unsigned int repeat_key;
 	struct timer_list timer;
 
-- 
2.6.0.rc2.230.g3dd15c0

