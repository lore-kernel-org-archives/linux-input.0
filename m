From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 1/2] HID: wacom: Initialize hid_data.inputmode to -1
Date: Mon,  4 Apr 2016 11:26:51 -0700
Message-ID: <1459794412-10306-1-git-send-email-killertofu@gmail.com>
References: <56FD84F4.6060707@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35160 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbcDDS1P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2016 14:27:15 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so4292641pac.2
        for <linux-input@vger.kernel.org>; Mon, 04 Apr 2016 11:27:14 -0700 (PDT)
In-Reply-To: <56FD84F4.6060707@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit 5ae6e89 introduced hid_data.inputmode with a comment that it
would have the value -1 if undefined, but then forgot to actually
perform the initialization. Although this doesn't appear to have
caused any problems in practice, it should still be remedied.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Changes from v1:
 * Introduce this patch

 drivers/hid/wacom_sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 68a5609..b338bbf 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1817,6 +1817,8 @@ static int wacom_probe(struct hid_device *hdev,
 		goto fail_type;
 	}
 
+	wacom_wac->hid_data.inputmode = -1;
+
 	wacom->usbdev = dev;
 	wacom->intf = intf;
 	mutex_init(&wacom->lock);
-- 
2.7.3

