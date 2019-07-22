From: stillcompiling@gmail.com
Subject: [PATCH 2/2] HID: core: only warn once of oversize hid report
Date: Mon, 22 Jul 2019 10:36:42 -0600
Message-ID: <20190722163642.10417-2-stillcompiling@gmail.com>
References: <20190722163642.10417-1-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722163642.10417-1-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Joshua Clayton <stillcompiling@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

On HP spectre x360 convertible the message:
hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
is continually printed many times per second, crowding out all other kernel logs
Protect dmesg by printing the warning only one time.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 210b81a56e1a..7afd0422b280 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1311,7 +1311,7 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 			unsigned offset, unsigned n)
 {
 	if (n > 32) {
-		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
+		hid_warn_once(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
 			 n, current->comm);
 		n = 32;
 	}
-- 
2.21.0
