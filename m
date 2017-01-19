From: Dennis Chen <barracks510@gmail.com>
Subject: [PATCH v2 2/2] HID: whitespace cleanup
Date: Thu, 19 Jan 2017 06:32:10 -0500
Message-ID: <1484825530-30326-2-git-send-email-barracks510@gmail.com>
References: <1484825530-30326-1-git-send-email-barracks510@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484825530-30326-1-git-send-email-barracks510@gmail.com>
In-Reply-To: <1484819753.20429.4.camel@gmail.com>
References: <1484819753.20429.4.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Dennis Chen <barracks510@gmail.com>
List-Id: linux-input@vger.kernel.org

Removes trailing whitespace in hid-core.c and usbhid/hid-quirks.c

Signed-off-by: Dennis Chen <barracks510@gmail.com>
---
 drivers/hid/hid-core.c          | 2 +-
 drivers/hid/usbhid/hid-quirks.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3d78f2a..52863e7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2302,7 +2302,7 @@ __ATTRIBUTE_GROUPS(hid_dev);
 
 static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct hid_device *hdev = to_hid_device(dev);	
+	struct hid_device *hdev = to_hid_device(dev);
 
 	if (add_uevent_var(env, "HID_ID=%04X:%08X:%08X",
 			hdev->bus, hdev->vendor, hdev->product))
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a1e5dc3..80df173 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -290,7 +290,7 @@ static void usbhid_remove_all_dquirks(void)
 
 }
 
-/** 
+/**
  * usbhid_quirks_init: apply USB HID quirks specified at module load time
  */
 int usbhid_quirks_init(char **quirks_param)
@@ -354,7 +354,7 @@ static const struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor,
 
 	if (bl_entry != NULL)
 		dbg_hid("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
-				bl_entry->quirks, bl_entry->idVendor, 
+				bl_entry->quirks, bl_entry->idVendor,
 				bl_entry->idProduct);
 	return bl_entry;
 }
-- 
2.7.4
