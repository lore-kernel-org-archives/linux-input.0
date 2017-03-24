From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 6/6] HID: sony: Make sure to unregister sensors on failure
Date: Fri, 24 Mar 2017 15:17:50 -0700
Message-ID: <20170324221750.19543-7-roderick@gaikai.com>
References: <20170324221750.19543-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36248 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755019AbdCXWSD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 18:18:03 -0400
Received: by mail-it0-f44.google.com with SMTP id w124so22701936itb.1
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 15:18:02 -0700 (PDT)
In-Reply-To: <20170324221750.19543-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Make sure we sure register any sensor when sony_input_configured failes.
Somehow this line got lost during resolving of merge conflicts in the
motion sensor patch series and a redudant remove was added as well later
on.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index cf534a9..71c437f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2696,6 +2696,8 @@ static int sony_input_configured(struct hid_device *hdev,
 		sony_leds_remove(sc);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
+	if (sc->sensor_dev)
+		sony_unregister_sensors(sc);
 	if (sc->touchpad)
 		sony_unregister_touchpad(sc);
 	sony_cancel_work_sync(sc);
@@ -2788,9 +2790,6 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->sensor_dev)
 		sony_unregister_sensors(sc);
 
-	if (sc->sensor_dev)
-		sony_unregister_sensors(sc);
-
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)
 		device_remove_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);
 
-- 
2.9.3

