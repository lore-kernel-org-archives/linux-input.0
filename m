From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/5] HID: wacom: generic: Report AES battery information
Date: Fri, 28 Apr 2017 09:25:32 -0700
Message-ID: <20170428162534.3051-3-killertofu@gmail.com>
References: <20170428162534.3051-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35729 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756801AbdD1QZ5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 12:25:57 -0400
Received: by mail-qt0-f196.google.com with SMTP id o36so9062077qtb.2
        for <linux-input@vger.kernel.org>; Fri, 28 Apr 2017 09:25:57 -0700 (PDT)
In-Reply-To: <20170428162534.3051-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

When support for the HID_DG_BATTERYSTRENGTH usage was added for AES devices,
it appears that the value was read, but never actually forwarded to the
power_supply subystem for userspace's benefit. Let's correct that.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c3f8fe152e48..11aa28e0a36e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2175,6 +2175,8 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 		input_sync(input);
 	}
 
+	wacom_wac_pad_battery_report(hdev, report);
+
 	if (!prox) {
 		wacom_wac->tool[0] = 0;
 		wacom_wac->id[0] = 0;
-- 
2.12.2

