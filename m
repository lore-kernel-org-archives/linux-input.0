From: stillcompiling@gmail.com
Subject: [PATCH v3 3/3] HID: core: fix dmesg flooding if report field larger than 32bit
Date: Mon, 12 Aug 2019 09:20:22 -0600
Message-ID: <20190812152022.27963-4-stillcompiling@gmail.com>
References: <20190812152022.27963-1-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812152022.27963-1-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Joe Perches <joe@perches.com>, Joshua Clayton <stillcompiling@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

Only warn once of oversize hid report value field

On HP spectre x360 convertible the message:
hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
is continually printed many times per second, crowding out all else.
Protect dmesg by printing the warning only one time.

The size of the hid report field data structure should probably be increased.
The data structure is treated as a u32 in Linux, but an unlimited number
of bits in the USB hid spec, so there is some rearchitecture needed now that
devices are sending more than 32 bits.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 210b81a56e1a..3eaee2c37931 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 			unsigned offset, unsigned n)
 {
 	if (n > 32) {
-		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
-			 n, current->comm);
+		hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
+			      __func__, n, current->comm);
 		n = 32;
 	}
 
-- 
2.21.0
