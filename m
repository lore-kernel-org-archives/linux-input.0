From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 02/66] HID: Increase maximum report size allowed by hid_field_extract()
Date: Wed, 24 Apr 2019 09:56:40 -0400
Message-ID: <20190424135746.22655-2-sashal@kernel.org>
References: <20190424135746.22655-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424135746.22655-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 94a9992f7dbdfb28976b565af220e0c4a117144a ]

Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
to 256") increases the max report size from 128 to 256.

We also need to update the report size in hid_field_extract() otherwise
it complains and truncates now valid report size:
[ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)

BugLink: https://bugs.launchpad.net/bugs/1818547
Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
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
2.19.1
