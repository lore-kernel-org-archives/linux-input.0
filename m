From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Do not repeatedly attempt to set device mode on error
Date: Wed,  5 Aug 2015 15:45:30 -0700
Message-ID: <1438814730-12108-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33810 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbbHEWpd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2015 18:45:33 -0400
Received: by pawu10 with SMTP id u10so46343040paw.1
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2015 15:45:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

As an extension of aef3156d7, there is no sense in repeatedly calling the
'wacom_set_report' and 'wacom_get_report' functions if they return an
error. Getting an error from them implies that the device is out to lunch:
either a hard error code was returned or repeated attempts at recovering
from a "soft" error all failed. In either case, doing even more retries is
not likely to resolve whatever is wrong.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 20d15c5..6edb7d1 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -335,7 +335,7 @@ static int wacom_set_device_mode(struct hid_device *hdev, int report_id,
 		if (error >= 0)
 			error = wacom_get_report(hdev, HID_FEATURE_REPORT,
 			                         rep_data, length, 1);
-	} while ((error < 0 || rep_data[1] != mode) && limit++ < WAC_MSG_RETRIES);
+	} while (error >= 0 && rep_data[1] != mode && limit++ < WAC_MSG_RETRIES);
 
 	kfree(rep_data);
 
-- 
2.5.0

