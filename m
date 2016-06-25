From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2 8/8] Input: synaptics-rmi4: Use the RMI_F11_REL_BYTES define in rmi_f11_rel_pos_report
Date: Fri, 24 Jun 2016 17:19:52 -0700
Message-ID: <1466813992-16085-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

The size of relative data in F11 is already defined by RMI_F11_REL_BYTES.
Use the define in rmi_f11_rel_pos_report() to be consistent.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
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
