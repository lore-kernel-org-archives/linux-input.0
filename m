From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] Input: synaptics-rmi4 - Report slot as inactive when contact is a palm
Date: Thu, 16 Mar 2017 16:56:31 -0700
Message-ID: <1489708591-4320-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:8389
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752193AbdCPX6j (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Mar 2017 19:58:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>

When the firmware identifies a contact as a palm the driver sets the tool
type to MT_TOOL_PALM, but sets the slot state as active. Reporting the
palm as active results in userspace input libraries considering the palm
as a valid contact. Touchpads which previously were using hid-multitouch
are now not suppressing palms when switching to the RMI4 driver. This
change fixes palm rejection when using the RMI4 driver.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Tested-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/rmi4/rmi_2d_sensor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index 8bb866c..8d1f295 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -80,7 +80,8 @@ void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
 		input_mt_slot(input, slot);
 
 	input_mt_report_slot_state(input, obj->mt_tool,
-				   obj->type != RMI_2D_OBJECT_NONE);
+				   (obj->type != RMI_2D_OBJECT_NONE)
+				   && (obj->type != RMI_2D_OBJECT_PALM));
 
 	if (obj->type != RMI_2D_OBJECT_NONE) {
 		obj->x = sensor->tracking_pos[slot].x;
-- 
2.7.4

