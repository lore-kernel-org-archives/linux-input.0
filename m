From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/7] HID: sony: Fix error handling bug when touchpad registration fails
Date: Thu,  8 Dec 2016 19:09:50 -0800
Message-ID: <1481252996-25288-2-git-send-email-roderick@gaikai.com>
References: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36376 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbcLIDKl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 22:10:41 -0500
Received: by mail-pg0-f52.google.com with SMTP id f188so2542600pgc.3
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 19:10:40 -0800 (PST)
In-Reply-To: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The error handling code in sony_input_configured in general uses goto
based cleanup. Recently we migrated code from sony_probe to here, but
we didn't update the existing touchpad registration code, which was
already here to use the goto.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 7687c08..f68c921 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2548,7 +2548,7 @@ static int sony_input_configured(struct hid_device *hdev,
 			hid_err(sc->hdev,
 			"Unable to initialize multi-touch slots: %d\n",
 			ret);
-			return ret;
+			goto err_stop;
 		}
 
 		sony_init_output_report(sc, dualshock4_send_output_report);
-- 
2.7.4

