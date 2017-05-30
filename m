From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] HID: asus: Stop underlying hardware on remove
Date: Tue, 30 May 2017 22:39:46 +0200
Message-ID: <20170530203946.9346-1-carlo@caione.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33341 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdE3Uj6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 16:39:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>

From: Carlo Caione <carlo@endlessm.com>

We are missing a call to hid_hw_stop() on the remove hook.
Among other things this is causing an Oops when (re-)starting GNOME /
upowerd / ... after the module has been already rmmod-ed.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/hid/hid-asus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 16df6cc..2e9642d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -536,6 +536,8 @@ static void asus_remove(struct hid_device *hdev)
 		drvdata->kbd_backlight->removed = true;
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
+
+	hid_hw_stop(hdev);
 }
 
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-- 
2.9.3

