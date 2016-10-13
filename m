From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 06/18] Input: synaptics-rmi4 - Set the ABS_MT_TOOL_TYPE bit to report tool type
Date: Thu, 13 Oct 2016 17:51:00 +0200
Message-ID: <1476373872-18027-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755469AbcJMPvd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 11:51:33 -0400
In-Reply-To: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

From: Andrew Duggan <aduggan@synaptics.com>

The rmi4 2D sensor functions report the tool type via
input_mt_report_slot_state(), but the abs parameter bit has not been
set so the tool type is not reported to userspace. This patch set
the ABS_MT_TOOL_TYPE bit.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v3
---
 drivers/input/rmi4/rmi_2d_sensor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index e97bd7f..0747890 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -181,6 +181,8 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
 		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,	0, 0x0f, 0, 0);
 		input_set_abs_params(input, ABS_MT_TOUCH_MINOR,	0, 0x0f, 0, 0);
 		input_set_abs_params(input, ABS_MT_ORIENTATION,	0, 1, 0, 0);
+		input_set_abs_params(input, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX,
+					0, 0);
 
 		if (sensor->sensor_type == rmi_sensor_touchpad)
 			input_flags = INPUT_MT_POINTER;
-- 
2.7.4

