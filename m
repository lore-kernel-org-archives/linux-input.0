From: Tapasweni Pathak <tapaswenipathak@gmail.com>
Subject: [PATCH] drivers: hid: Remove dead storage
Date: Sat, 29 Sep 2018 21:36:46 +0530
Message-ID: <5bafa31a.1c69fb81.ff018.dc43@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Remove storing of return value of ntrig_version_string function
to ret as it is a dead storage and not used afterwards.

Found using Facebook's Infer. Build tested it.

Signed-off-by: Tapasweni Pathak <tapaswenipathak@gmail.com>
---
There is another option to instead check for non zero return
value for ntrig_version_string() as a successful completion
of the function. ntrig_version_string() returns the length
of output printed by sprintf() after converting the raw firmware
code into a 5 comma separated numbers.

 drivers/hid/hid-ntrig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 43b1c72..22aebf4 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -159,7 +159,7 @@ static void ntrig_report_version(struct hid_device *hdev)
 			      USB_CTRL_SET_TIMEOUT);

 	if (ret == 8) {
-		ret = ntrig_version_string(&data[2], buf);
+		ntrig_version_string(&data[2], buf);

 		hid_info(hdev, "Firmware version: %s (%02x%02x %02x%02x)\n",
 			 buf, data[2], data[3], data[4], data[5]);
--
2.7.4
