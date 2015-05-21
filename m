From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 1/2] HID: wacom: Have wacom_{get,set}_report retry on -EAGAIN, not -EPIPE
Date: Thu, 21 May 2015 10:44:31 -0700
Message-ID: <1432230272-3614-1-git-send-email-killertofu@gmail.com>
References: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35169 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835AbbEURpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 13:45:00 -0400
Received: by pacwv17 with SMTP id wv17so112473571pac.2
        for <linux-input@vger.kernel.org>; Thu, 21 May 2015 10:45:00 -0700 (PDT)
In-Reply-To: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Retrying on -EPIPE makes very little sense since this typically indicates
a problem that will not just disappear on its own. For instance, the USB
documentation states that it will be sent if the endpoint is stalled or
the device has disconnected. Instead, we should retry if -EAGAIN is
received since this indicates a temporary error condition such as a busy
bus.

In addition to adjusting the conditions we retry under, we also log an
error on failure so that we can be aware of what's going on.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Changed in v2:
 - Renamed from "HID: wacom: Allow wacom_{get,set}_report to retry on -EAGAIN"
 - Changed retry conditions so that we no longer retry on -EPIPE
 - Use 'hid_err' instead of 'dev_err'

 drivers/hid/wacom_sys.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 7abf52c..109312f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -35,7 +35,11 @@ static int wacom_get_report(struct hid_device *hdev, u8 type, u8 *buf,
 	do {
 		retval = hid_hw_raw_request(hdev, buf[0], buf, size, type,
 				HID_REQ_GET_REPORT);
-	} while ((retval == -ETIMEDOUT || retval == -EPIPE) && --retries);
+	} while ((retval == -ETIMEDOUT || retval == -EAGAIN) && --retries);
+
+	if (retval < 0)
+		hid_err(hdev, "wacom_get_report: ran out of retries "
+			"(last error = %d)\n", retval);
 
 	return retval;
 }
@@ -48,7 +52,11 @@ static int wacom_set_report(struct hid_device *hdev, u8 type, u8 *buf,
 	do {
 		retval = hid_hw_raw_request(hdev, buf[0], buf, size, type,
 				HID_REQ_SET_REPORT);
-	} while ((retval == -ETIMEDOUT || retval == -EPIPE) && --retries);
+	} while ((retval == -ETIMEDOUT || retval == -EAGAIN) && --retries);
+
+	if (retval < 0)
+		hid_err(hdev, "wacom_set_report: ran out of retries "
+			"(last error = %d)\n", retval);
 
 	return retval;
 }
-- 
2.4.1

