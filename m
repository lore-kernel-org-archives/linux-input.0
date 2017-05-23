From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/3] Input: synaptics - warn the users when there is a better mode
Date: Tue, 23 May 2017 10:36:56 +0200
Message-ID: <20170523083657.11148-2-benjamin.tissoires@redhat.com>
References: <20170523083657.11148-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935569AbdEWIhH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2017 04:37:07 -0400
In-Reply-To: <20170523083657.11148-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The Synaptics touchpads are now either using i2c-hid or rmi-smbus.
Warn the users if they are missing the rmi-smbus modules and have no
chance of reporting correct data.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 58ff388..fc42259 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1814,6 +1814,10 @@ int synaptics_init(struct psmouse *psmouse)
 	}
 
 	if (SYN_CAP_INTERTOUCH(info.ext_cap_0c)) {
+#if !IS_ENABLED(CONFIG_RMI4_SMB) || !defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)
+		psmouse_warn(psmouse, "The touchpad can support a better bus than the too old PS/2 protocol.\n"
+			"Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.\n");
+#endif
 		error = synaptics_setup_intertouch(psmouse, &info, true);
 		if (!error)
 			return PSMOUSE_SYNAPTICS_SMBUS;
-- 
2.9.4

