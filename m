From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 2/2] HID: intel-ish-hid: format 32-bit integers with %X
Date: Thu, 22 Dec 2016 11:09:10 +0100
Message-ID: <20161222100910.6179-2-nicolas.iooss_linux@m4x.org>
References: <20161222100910.6179-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161222100910.6179-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: linux-input@vger.kernel.org

In ishtp_hid_probe(), use %04X instead of %04hX to format __u32 values,
in order to silent a format error reported by clang:

    drivers/hid/intel-ish-hid/ishtp-hid.c:212:3: error: format specifies
    type 'unsigned short' but the argument has type '__u32' (aka
    'unsigned int') [-Werror,-Wformat]
                    hid->vendor, hid->product);
                    ^~~~~~~~~~~
    drivers/hid/intel-ish-hid/ishtp-hid.c:212:16: error: format
    specifies type 'unsigned short' but the argument has type '__u32'
    (aka 'unsigned int') [-Werror,-Wformat]
                    hid->vendor, hid->product);
                                 ^~~~~~~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 277983aa1d90..cd23903ddcf1 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -208,7 +208,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 	hid->version = le16_to_cpu(ISH_HID_VERSION);
 	hid->vendor = le16_to_cpu(ISH_HID_VENDOR);
 	hid->product = le16_to_cpu(ISH_HID_PRODUCT);
-	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX", "hid-ishtp",
+	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-ishtp",
 		hid->vendor, hid->product);
 
 	rv = hid_add_device(hid);
-- 
2.11.0
