From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH v2] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 07:26:39 -0800
Message-ID: <1329233199-7424-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43046 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab2BNP0n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 10:26:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmity Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

In order to inform userspace of physical properties of the device.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
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

