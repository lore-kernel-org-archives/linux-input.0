From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 03/05] input synaptics-rmi4: rmi_f01 - Fix a comment and add a diagnostic output message.
Date: Fri, 7 Mar 2014 18:29:53 -0800
Message-ID: <1394245795-17347-3-git-send-email-cheiny@synaptics.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:13277 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbaCHCaG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 21:30:06 -0500
In-Reply-To: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

In debugging certain touch sensor failures, it's useful to know
whether the device is stuck in bootloader, so print a message
to that effect.

Also, point to the actual location of the defs for the F01 CTRL0
bitfields.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_f01.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 8504865..a078d7d 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -16,7 +16,7 @@
 #include "rmi_f01.h"
 
 /**
- * @ctrl0 - see the bit definitions above.
+ * @ctrl0 - see the bit definitions in rmi_f01.h.
  * @doze_interval - controls the interval between checks for finger presence
  * when the touch sensor is in doze mode, in units of 10ms.
  * @wakeup_threshold - controls the capacitance threshold at which the touch
@@ -415,6 +415,13 @@ static int rmi_f01_probe(struct rmi_function *fn)
 		return error;
 	}
 
+	driver_data->f01_bootloader_mode =
+			RMI_F01_STATUS_BOOTLOADER(device_status);
+	if (driver_data->f01_bootloader_mode)
+		dev_warn(&rmi_dev->dev,
+			 "WARNING: RMI4 device is in bootloader mode!\n");
+
+
 	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
 		dev_err(&fn->dev,
 			"Device was reset during configuration process, status: %#02x!\n",
