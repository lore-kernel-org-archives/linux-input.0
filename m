From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v3 8/8] Input: synaptics-rmi4: Use the RMI_F11_REL_BYTES define in rmi_f11_rel_pos_report
Date: Wed, 13 Jul 2016 23:10:13 -0700
Message-ID: <1468476613-8293-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:2967 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbcGNGKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2016 02:10:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>

The size of relative data in F11 is already defined by RMI_F11_REL_BYTES.
Use the define in rmi_f11_rel_pos_report() to be consistent.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Reviewed-by: Nick Dyer <nick@shmanahar.org>
---
This is the same as the v2 version.

 drivers/input/rmi4/rmi_f11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 3fda75b..cce82a1 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -530,8 +530,8 @@ static void rmi_f11_rel_pos_report(struct f11_data *f11, u8 n_finger)
 	struct f11_2d_data *data = &f11->data;
 	s8 x, y;
 
-	x = data->rel_pos[n_finger * 2];
-	y = data->rel_pos[n_finger * 2 + 1];
+	x = data->rel_pos[n_finger * RMI_F11_REL_BYTES];
+	y = data->rel_pos[n_finger * RMI_F11_REL_BYTES + 1];
 
 	rmi_2d_sensor_rel_report(sensor, x, y);
 }
-- 
2.5.0

