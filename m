From: Pan Bian <bianpan201603@163.com>
Subject: [PATCH 1/1] input: usbhid: fix improper check
Date: Sun,  4 Dec 2016 13:10:09 +0800
Message-ID: <1480828209-4131-1-git-send-email-bianpan201603@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-input@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

Function hid_post_reset() returns 0 on success, or 1 on failures.
However, in function hid_reset_resume(), uses "status >= 0" to check the
return value of hid_post_reset(). Obviously, the condition will always
be satisfied. This patch fixes the bug, uses "status == 0" to check the
return value.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188921

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/hid/usbhid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ae83af6..3639b70 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1590,7 +1590,7 @@ static int hid_reset_resume(struct usb_interface *intf)
 	int status;
 
 	status = hid_post_reset(intf);
-	if (status >= 0 && hid->driver && hid->driver->reset_resume) {
+	if (status == 0 && hid->driver && hid->driver->reset_resume) {
 		int ret = hid->driver->reset_resume(hid);
 		if (ret < 0)
 			status = ret;
-- 
1.9.1
