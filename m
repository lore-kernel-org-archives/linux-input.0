From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v2] HID: sony: Fix input device leak when connecting a DS4 twice using USB/BT
Date: Fri, 24 Feb 2017 16:14:15 -0800
Message-ID: <20170225001415.21361-2-roderick@gaikai.com>
References: <20170225001415.21361-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33727 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdBYAWV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Feb 2017 19:22:21 -0500
Received: by mail-pg0-f43.google.com with SMTP id z128so17541912pgb.0
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2017 16:22:21 -0800 (PST)
In-Reply-To: <20170225001415.21361-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

When a user connects a DS4 twice using USB and BT, we reject the
second device connection after the setup work. We then perform
a cleanup, but during cleanup we are not removing the touchpad
device. This leads to leakage of an input device, which we would
never remove. It can likely result into a kernel oops as well
when the touchpad evdev node is accessed and the underlaying HID
device has been removed from the system.

Fixes: ac797b95f532 ("HID: sony: Make the DS4 touchpad a separate device")
Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f405b07..740996f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2632,6 +2632,8 @@ static int sony_input_configured(struct hid_device *hdev,
 		sony_leds_remove(sc);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
+	if (sc->touchpad)
+		sony_unregister_touchpad(sc);
 	sony_cancel_work_sync(sc);
 	kfree(sc->output_report_dmabuf);
 	sony_remove_dev_list(sc);
-- 
2.9.3

