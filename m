From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/3] HID: wiimote: explicitly claim hid devices with HID_CLAIMED_OTHER
Date: Sun, 15 Jul 2012 20:21:49 +0200
Message-ID: <1342376509-7228-4-git-send-email-dh.herrmann@googlemail.com>
References: <1342376509-7228-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32856 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2GOSWT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jul 2012 14:22:19 -0400
Received: by wibhm11 with SMTP id hm11so2105466wib.1
        for <linux-input@vger.kernel.org>; Sun, 15 Jul 2012 11:22:18 -0700 (PDT)
In-Reply-To: <1342376509-7228-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

We allow hidraw to be loaded on wiimote devices but if a kernel is
compiled without hidraw, calling hid_hw_start() will always fail as no
driver claims the device. Therefore, we now explicitly set
HID_CLAIMED_OTHER so the hid-core will allow loading the device even if no
generic driver claimed it. The wiimote driver will correctly handle the
device, anyway.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 84e2fbe..39154ff9 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1189,6 +1189,7 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err;
 	}
 
+	hdev->claimed |= HID_CLAIMED_OTHER;
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (ret) {
 		hid_err(hdev, "HW start failed\n");
-- 
1.7.11.2

