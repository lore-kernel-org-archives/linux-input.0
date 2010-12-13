From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 1/2] hid-mosart: ignore buttons report
Date: Mon, 13 Dec 2010 15:59:12 +0100
Message-ID: <1292252353-3029-2-git-send-email-benjamin.tissoires@enac.fr>
References: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39625 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985Ab0LMPJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 10:09:34 -0500
In-Reply-To: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

This commit allows the device to be recognized as a touchscreen, and not a
touchpad by xf86-input-evdev.

The device has 2 modes. The first one is an emulation of a touchscreen by
sending left and right button, and the second mode is the one used in
dual-touch (sending trackingID, touch and else).

That's why there is a hid report containing left and right buttons
(9000001 and 9000002). The point is that xorg relies on these fields to
determine if it's a touchpad or a touchscreen.
Clearing the report (return -1) makes xorg detecting it out of the box
as a quite pleasant (dual)touchscreen.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/hid-mosart.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-mosart.c b/drivers/hid/hid-mosart.c
index ac5421d..acd8a49 100644
--- a/drivers/hid/hid-mosart.c
+++ b/drivers/hid/hid-mosart.c
@@ -90,6 +90,10 @@ static int mosart_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case 0xff000000:
 		/* ignore HID features */
 		return -1;
+
+	case HID_UP_BUTTON:
+		/* ignore buttons */
+		return -1;
 	}
 
 	return 0;
-- 
1.7.3.2

