From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH] HID: wacom: call _query_tablet_data() for BAMBOO_TOUCH
Date: Wed, 29 Mar 2017 11:41:28 -0700
Message-ID: <1490812888-31078-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32973 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbdC2SnP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Mar 2017 14:43:15 -0400
Received: by mail-pg0-f66.google.com with SMTP id 79so3905163pgf.0
        for <linux-input@vger.kernel.org>; Wed, 29 Mar 2017 11:43:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, killertofu@gmail.com, benjamin.tissoires@redhat.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Commit a544c619a54b ("HID: wacom: do not attempt to switch mode
while in probe") introduces delayed work for querying (setting the
mode) on all tablets. Bamboo Touch (056a:00d0) has a ghost
interface which claims to be a pen device. Though this device can
be removed, we have to set the mode on the ghost pen interface
before we remove it. After the aforementioned delay was introduced
the device was being removed before the mode setting could be
executed.

Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
---
This is a fix for 4.11

 drivers/hid/wacom_sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0bcfb2026223..98bc9c90d5f8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2216,6 +2216,8 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	/* touch only Bamboo doesn't support pen */
 	if ((features->type == BAMBOO_TOUCH) &&
 	    (features->device_type & WACOM_DEVICETYPE_PEN)) {
+		cancel_delayed_work_sync(&wacom->init_work);
+		_wacom_query_tablet_data(wacom);
 		error = -ENODEV;
 		goto fail_quirks;
 	}
-- 
2.7.4

