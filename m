From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: logitech-hidpp: 2 fixes in hidpp_root_get_protocol_version()
Date: Mon,  3 Nov 2014 14:50:53 -0500
Message-ID: <1415044253-18734-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1415044253-18734-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415044253-18734-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

- remove the constant '1'
- when the device is not connected, the protocol error
  HIDPP_ERROR_RESOURCE_ERROR is raised. We should not warn the user about
  it because it is somewhat expected as an answer when we check if the
  device is connected.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4793d4b..2683564 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -361,12 +361,16 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 			CMD_ROOT_GET_PROTOCOL_VERSION,
 			NULL, 0, &response);
 
-	if (ret == 1) {
+	if (ret == HIDPP_ERROR_INVALID_SUBID) {
 		hidpp->protocol_major = 1;
 		hidpp->protocol_minor = 0;
 		return 0;
 	}
 
+	/* the device might not be connected */
+	if (ret == HIDPP_ERROR_RESOURCE_ERROR)
+		return -EIO;
+
 	if (ret > 0) {
 		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
 			__func__, ret);
-- 
2.1.0
