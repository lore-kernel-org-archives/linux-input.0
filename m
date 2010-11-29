From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 4/4] input: mt: Add pressure to pointer emulation code
Date: Mon, 29 Nov 2010 08:13:22 +0100
Message-ID: <1291014802-17061-5-git-send-email-rydberg@euromail.se>
References: <1291014802-17061-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:48356 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755059Ab0K2HOI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Nov 2010 02:14:08 -0500
In-Reply-To: <1291014802-17061-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Some MT devices report pressure per contact. This patch adds
ABS_PRESSURE to the pointer emulation code.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/input-mt.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 08aa682..49ccd15 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -97,7 +97,8 @@ EXPORT_SYMBOL(input_mt_report_slot_state);
  * input_mt_report_pointer_emulation() - common pointer emulation
  * @dev: input device with allocated MT slots
  *
- * Performs legacy pointer emulation via BTN_TOUCH, ABS_X and ABS_Y.
+ * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y and
+ * ABS_PRESSURE.
  */
 void input_mt_report_pointer_emulation(struct input_dev *dev)
 {
@@ -124,9 +125,13 @@ void input_mt_report_pointer_emulation(struct input_dev *dev)
 	if (oldest) {
 		int x = input_mt_get_value(oldest, ABS_MT_POSITION_X);
 		int y = input_mt_get_value(oldest, ABS_MT_POSITION_Y);
+		int p = input_mt_get_value(oldest, ABS_MT_PRESSURE);
 
 		input_event(dev, EV_ABS, ABS_X, x);
 		input_event(dev, EV_ABS, ABS_Y, y);
+		input_event(dev, EV_ABS, ABS_PRESSURE, p);
+	} else {
+		input_event(dev, EV_ABS, ABS_PRESSURE, 0);
 	}
 }
 EXPORT_SYMBOL(input_mt_report_pointer_emulation);
-- 
1.7.1

