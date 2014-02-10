From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 06/14] HID: usbhid: change return error of usbhid_output_report
Date: Mon, 10 Feb 2014 12:58:51 -0500
Message-ID: <1392055139-19631-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1392055139-19631-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392055139-19631-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If there is no urbout when sending a output report, ENOSYS (Function
not implemented) is a better error than EIO (I/O error).

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/usbhid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b9a770f..0d1d875 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -922,7 +922,7 @@ static int usbhid_output_report(struct hid_device *hid, __u8 *buf, size_t count)
 	int actual_length, skipped_report_id = 0, ret;
 
 	if (!usbhid->urbout)
-		return -EIO;
+		return -ENOSYS;
 
 	if (buf[0] == 0x0) {
 		/* Don't send the Report ID */
-- 
1.8.3.1
