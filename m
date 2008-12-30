From: Richard Nauber <RichardNauber@web.de>
Subject: [PATCH] [HID] hid-sony: regression probing a SIXAXIS controller -
 wrong return value
Date: Tue, 30 Dec 2008 23:15:30 +0100
Message-ID: <495A9D82.7090500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:56084 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYL3WPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Dec 2008 17:15:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org

This patch fixes a regression introduced in bd28ce00. It occurs when
attaching a Sony SIXAXIS controller:

input: Sony PLAYSTATION(R)3 Controller as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/input/input9
sony 0003:054C:0268.0006: input,hiddev96,hidraw0: USB HID v1.11 Joystick
[Sony PLAYSTATION(R)3 Controller] on usb-0000:00:1d.0-1/input0
sony: probe of 0003:054C:0268.0006 failed with error 17

The reason for this nasty behavior is a wrong return value emitted by
sony_set_operational().

Carry on playing with your Christmas gifts,
Richard

Signed-off-by: Richard Nauber  <Richard.Nauber@web.de>

---
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 86e563b..e807d2f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -65,12 +65,15 @@ static int sony_set_operational(struct hid_device *hdev)
                                 USB_RECIP_INTERFACE,
                                 (3 << 8) | 0xf2, ifnum, buf, 17,
                                 USB_CTRL_GET_TIMEOUT);
-       if (ret < 0)
-               dev_err(&hdev->dev, "can't set operational mode\n");

        kfree(buf);

-       return ret;
+       if (ret <= 0) {
+               dev_err(&hdev->dev, "can't set operational mode\n");
+               return (ret ? ret : -EIO );
+       }
+
+       return 0;
 }

 static int sony_probe(struct hid_device *hdev, const struct
hid_device_id *id)
--
