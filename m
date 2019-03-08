From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: Increase maximum report size allowed by hid_field_extract()
Date: Fri,  8 Mar 2019 13:11:17 +0800
Message-ID: <20190308051117.21899-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
to 256") increases the max report size from 128 to 256.

We also need to update the report size in hid_field_extract() otherwise
it complains and truncates now valid report size:
[ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)

BugLink: https://bugs.launchpad.net/bugs/1818547
Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9993b692598f..860e21ec6a49 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1301,10 +1301,10 @@ static u32 __extract(u8 *report, unsigned offset, int n)
 u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 			unsigned offset, unsigned n)
 {
-	if (n > 32) {
-		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
+	if (n > 256) {
+		hid_warn(hid, "hid_field_extract() called with n (%d) > 256! (%s)\n",
 			 n, current->comm);
-		n = 32;
+		n = 256;
 	}
 
 	return __extract(report, offset, n);
-- 
2.17.1
