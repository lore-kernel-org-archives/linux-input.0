From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] ims-pcu: sanity check against missing interfaces
Date: Thu, 17 Mar 2016 15:10:47 +0100
Message-ID: <1458223847-9878-1-git-send-email-oneukum@suse.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Oliver Neukum <oneukum@suse.com>, Oliver Neukum <ONeukum@suse.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

A malicious device missing interface can make the driver oops.
Add sanity checking.

Signed-off-by: Oliver Neukum <ONeukum@suse.com>
CC: stable@vger.kernel.org
---
 drivers/input/misc/ims-pcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index ac1fa5f..9c0ea36 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1663,6 +1663,8 @@ static int ims_pcu_parse_cdc_data(struct usb_interface *intf, struct ims_pcu *pc
 
 	pcu->ctrl_intf = usb_ifnum_to_if(pcu->udev,
 					 union_desc->bMasterInterface0);
+	if (!pcu->ctrl_intf)
+		return -EINVAL;
 
 	alt = pcu->ctrl_intf->cur_altsetting;
 	pcu->ep_ctrl = &alt->endpoint[0].desc;
@@ -1670,6 +1672,8 @@ static int ims_pcu_parse_cdc_data(struct usb_interface *intf, struct ims_pcu *pc
 
 	pcu->data_intf = usb_ifnum_to_if(pcu->udev,
 					 union_desc->bSlaveInterface0);
+	if (!pcu->data_intf)
+		return -EINVAL;
 
 	alt = pcu->data_intf->cur_altsetting;
 	if (alt->desc.bNumEndpoints != 2) {
-- 
2.1.4
