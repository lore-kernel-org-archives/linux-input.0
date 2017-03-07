From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 08/12] HID: sony: Mark DS4 touchpad device as a pointer
Date: Tue,  7 Mar 2017 15:45:07 -0800
Message-ID: <20170307234511.30380-9-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36068 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933271AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pf0-f171.google.com with SMTP id o126so6630643pfb.3
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:23 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Currently the DS4 touchpad device is neither classified as a direct
input device nor as a pointer device. It makes most sense to mark
it as a pointer device.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index de74d5a..1c62698 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1236,7 +1236,7 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	snprintf(name, name_sz, "%s" DS4_TOUCHPAD_SUFFIX, sc->hdev->name);
 	sc->touchpad->name = name;
 
-	ret = input_mt_init_slots(sc->touchpad, touch_count, 0);
+	ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
 	if (ret < 0)
 		goto err;
 
-- 
2.9.3

