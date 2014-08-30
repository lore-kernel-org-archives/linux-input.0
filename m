From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH 3/5] Input: elantech - report the middle button of the touchpad
Date: Sat, 30 Aug 2014 16:10:44 +0200
Message-ID: <1409407846-15449-4-git-send-email-ulrik.debie-os@e2big.org>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:47770 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaH3OLh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Aug 2014 10:11:37 -0400
In-Reply-To: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

In the past, no elantech was known with 3 touchpad mouse buttons.
Fujitsu H730 is the first known elantech with a middle button. This commit
enables this middle button.

Reported-by: Stefan Valouch <stefan@valouch.com>
Tested-by: Stefan Valouch <stefan@valouch.com>
Tested-by: Alfredo Gemma <alfredo.gemma@gmail.com>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 67d56c0..e86bbd7 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -563,6 +563,7 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
 	} else {
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+		input_report_key(dev, BTN_MIDDLE, packet[0] & 0x04);
 	}
 
 	input_mt_report_pointer_emulation(dev, true);
@@ -1150,6 +1151,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	__clear_bit(EV_REL, dev->evbit);
 
 	__set_bit(BTN_LEFT, dev->keybit);
+	__set_bit(BTN_MIDDLE, dev->keybit);
 	__set_bit(BTN_RIGHT, dev->keybit);
 
 	__set_bit(BTN_TOUCH, dev->keybit);
-- 
2.1.0

