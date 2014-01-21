From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input: synaptics-rmi4 - Setup input_dev parent
Date: Tue, 21 Jan 2014 12:17:27 -0800
Message-ID: <1390335447-14667-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:52910 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaAUURc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jan 2014 15:17:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Fixes a pending FIXME to set input_dev->dev.parent correctly.
Since we'll soon be discarding the per-function input_devs and
using just a single input_dev for all the functions on a particular
rmi_dev, we use the rmi_dev->dev as the parent device for the
input_dev.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 3483e5b..c01a6b8 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -325,7 +325,7 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
 static int rmi_driver_set_input_params(struct rmi_device *rmi_dev,
 				struct input_dev *input)
 {
-	// FIXME: set up parent
+	input->dev.parent = &rmi_dev->dev;
 	input->name = SYNAPTICS_INPUT_DEVICE_NAME;
 	input->id.vendor  = SYNAPTICS_VENDOR_ID;
 	input->id.bustype = BUS_RMI;
