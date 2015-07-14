From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Set default device name to value from wacom->features
Date: Mon, 13 Jul 2015 18:03:45 -0700
Message-ID: <1436835825-15380-2-git-send-email-killertofu@gmail.com>
References: <1436835825-15380-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34415 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbbGNBDz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 21:03:55 -0400
Received: by pacan13 with SMTP id an13so24559621pac.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 18:03:54 -0700 (PDT)
In-Reply-To: <1436835825-15380-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Allocated input devices should not use the 'pen_name' by default since
we do not know at that point in time if that is an appropriate choice
of name. Instead, use the (tool-agnostic) name that is stored in the
device's 'wacom_features' structure. This also has the nice side-effect
of requring us to be explicit about the naming of the pen device, as
we already are for touch and pad devices.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 3512d83..2a22163 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1130,7 +1130,7 @@ static struct input_dev *wacom_allocate_input(struct wacom *wacom)
 	if (!input_dev)
 		return NULL;
 
-	input_dev->name = wacom_wac->pen_name;
+	input_dev->name = wacom_wac->features.name;
 	input_dev->phys = hdev->phys;
 	input_dev->dev.parent = &hdev->dev;
 	input_dev->open = wacom_open;
@@ -1183,6 +1183,7 @@ static int wacom_allocate_inputs(struct wacom *wacom)
 		return -ENOMEM;
 	}
 
+	wacom_wac->pen_input->name = wacom_wac->pen_name;
 	wacom_wac->touch_input->name = wacom_wac->touch_name;
 	wacom_wac->pad_input->name = wacom_wac->pad_name;
 
-- 
2.4.5

