From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH resend] bcm5974: Add pointer and buttonpad properties
Date: Mon, 13 Feb 2012 20:24:08 -0800
Message-ID: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40914 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759300Ab2BNEYM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 23:24:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
I sent to the wrong mailing list address the first time. Sorry!

 drivers/input/mouse/bcm5974.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..9faa049 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -434,6 +434,9 @@ static void setup_events_to_report(struct input_dev *input_dev,
 	__set_bit(BTN_LEFT, input_dev->keybit);
 
 	input_set_events_per_packet(input_dev, 60);
+
+	__set_bit(INPUT_PROP_POINTER, input->propbit);
+	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 }
 
 /* report button data as logical button state */
-- 
1.7.9

