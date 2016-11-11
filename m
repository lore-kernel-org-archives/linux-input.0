From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Declare tool ID 0x84a as an Intuos eraser
Date: Fri, 11 Nov 2016 15:05:52 -0800
Message-ID: <20161111230552.4221-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32784 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756014AbcKKXGH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Nov 2016 18:06:07 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so509037wmu.0
        for <linux-input@vger.kernel.org>; Fri, 11 Nov 2016 15:06:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The eraser end of the 8K pen available for the MobileStudio Pro has a tool
ID of 0x84a. The 'wacom_intuos_get_tool_type' function does not currently
recognize this ID, causing it to return BTN_TOOL_PEN rather than
BTN_TOOL_RUBBER. This does not cause a problem for the MobileStudio Pro
since, as a HID_GENERIC device, the driver relies on the state of the
HID_DG_INVERT usage instead. It would, however, cause problems if the pen
is used with devices that use the traditional 'wacom_intuos_irq' codepath
instead.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0723ba8..55857bf 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -645,6 +645,7 @@ static int wacom_intuos_get_tool_type(int tool_id)
 		break;
 
 	case 0x82a: /* Eraser */
+	case 0x84a:
 	case 0x85a:
 	case 0x91a:
 	case 0xd1a:
-- 
2.10.2

