From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] Revert "HID: Increase maximum report size allowed by hid_field_extract()"
Date: Wed,  5 Jun 2019 14:44:05 +0200
Message-ID: <20190605124408.8637-2-benjamin.tissoires@redhat.com>
References: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This reverts commit 94a9992f7dbdfb28976b565af220e0c4a117144a.

The commit allows for more than 32 bits in hid_field_extract(),
but the return value is a 32 bits int.
So basically what this commit is doing is just silencing those
legitimate errors.

Revert to a previous situation in the hope that a proper
fix will be impletemented.

Fixes: 94a9992f7dbd ("HID: Increase maximum report size allowed by hid_field_extract()")
Cc: stable@vger.kernel.org # v5.1
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 08d310723e96..205d6b82a706 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1311,10 +1311,10 @@ static u32 __extract(u8 *report, unsigned offset, int n)
 u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 			unsigned offset, unsigned n)
 {
-	if (n > 256) {
-		hid_warn(hid, "hid_field_extract() called with n (%d) > 256! (%s)\n",
+	if (n > 32) {
+		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
 			 n, current->comm);
-		n = 256;
+		n = 32;
 	}
 
 	return __extract(report, offset, n);
-- 
2.19.2
