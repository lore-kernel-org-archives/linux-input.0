From: Petri Gynther <pgynther@google.com>
Subject: [PATCH] Input: improve autorepeat initialization
Date: Fri,  9 Oct 2015 14:10:01 -0700
Message-ID: <1444425001-141384-1-git-send-email-pgynther@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35842 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbbJIVKs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 17:10:48 -0400
Received: by pablk4 with SMTP id lk4so96563327pab.3
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2015 14:10:48 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Petri Gynther <pgynther@google.com>

Allow driver to initialize only input_dev->rep[REP_DELAY] and
input_dev->rep[REP_PERIOD], but then use the input timer and
repeat function from input.c.

For example, a HID driver could do:

static void xyz_input_configured(struct hid_device *hid,
                                 struct hid_input *hidinput)
{
        hidinput->input->rep[REP_DELAY] = 400;
        hidinput->input->rep[REP_PERIOD] = 100;
}

static struct hid_driver xyz_driver = {
        .input_configured = xyz_input_configured,
}

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/input/input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 5391abd..1984ba5 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2115,6 +2115,15 @@ int input_register_device(struct input_dev *dev)
 		dev->rep[REP_PERIOD] = 33;
 	}
 
+	/*
+	 * If the driver didn't initialize the timer data and function, then
+	 * handle the autorepeating here in input.c.
+	 */
+	if (!dev->timer.data && !dev->timer.function) {
+		dev->timer.data = (unsigned long) dev;
+		dev->timer.function = input_repeat_key;
+	}
+
 	if (!dev->getkeycode)
 		dev->getkeycode = input_default_getkeycode;
 
-- 
2.6.0.rc2.230.g3dd15c0

