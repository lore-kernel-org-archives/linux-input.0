From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/8] HID: sony: Fix memory issue when connecting device using both Bluetooth and USB
Date: Wed, 23 Nov 2016 14:07:06 -0800
Message-ID: <1479938833-26424-2-git-send-email-roderick@gaikai.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35788 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbcKWWIJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 17:08:09 -0500
Received: by mail-yw0-f169.google.com with SMTP id i145so23765708ywg.2
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 14:08:09 -0800 (PST)
In-Reply-To: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

A previous patch moved most input initialization from sony_probe to
sony_input_configured to avoid some race conditions. The driver has some
special logic to prevent the device to get registered twice in case the
user connects it both over Bluetooth and USB. When this condition
happens sony_input_configured returns a failure, but sony_probe continues
as hid_hw_start doesn't fail. As was discussed on linux-input, it is
acceptable for this function to fail.

This patch adds a check for the HID_CLAIMED_INPUT flag within sony_probe
to determine whether initialization succeeded correctly. The flag is
not set by the HID layer when sony_input_configured fails.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 14763cd..3385006 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2524,6 +2524,19 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	/* sony_input_configured can fail, but this doesn't result
+	 * in hid_hw_start failures (intended). Check whether
+	 * the HID layer claimed the device else fail.
+	 * We don't know the actual reason for the failure, most
+	 * likely it is due to EEXIST in case of double connection
+	 * of USB and Bluetooth, but could have been due to ENOMEM
+	 * or other reasons as well.
+	 */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
+		hid_err(hdev, "failed to claim input\n");
+		return -ENODEV;
+	}
+
 	return ret;
 }
 
-- 
2.7.4

