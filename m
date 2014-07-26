From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: synaptics - properly initialize slots for semi-MT
Date: Fri, 25 Jul 2014 17:27:53 -0700
Message-ID: <20140726002751.GA16660@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:60606 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaGZA16 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2014 20:27:58 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org

Semi-MT devices are pointers too, so let's tell that to
input_mt_init_slots(), as well as let it set up the devices as semi-MT,
instead of us doing it manually.

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ef9e0b8..fe607e9 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1371,11 +1371,11 @@ static void set_input_params(struct psmouse *psmouse,
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
 		__set_bit(BTN_TOOL_QUINTTAP, dev->keybit);
 	} else if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
-		/* Non-image sensors with AGM use semi-mt */
-		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
-		input_mt_init_slots(dev, 2, 0);
 		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
 					ABS_MT_POSITION_Y);
+		/* Non-image sensors with AGM use semi-mt */
+		input_mt_init_slots(dev, 2,
+				    INPUT_MT_POINTER | INPUT_MT_SEMI_MT);
 	}
 
 	if (SYN_CAP_PALMDETECT(priv->capabilities))
-- 
2.0.0.526.g5318336


-- 
Dmitry
