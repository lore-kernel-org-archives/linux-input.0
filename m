From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/4] Revert "HID: core: Do not call request_module() in async context"
Date: Wed,  5 Jun 2019 14:44:06 +0200
Message-ID: <20190605124408.8637-3-benjamin.tissoires@redhat.com>
References: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This reverts commit 4ceabaf7909d109db6afbffc4ed182741fc32043.

This patch and a025a18fe are giving extended timeouts
on boot for at least Ubuntu and OpenSuse.

Revert them until we get a better fix.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 205d6b82a706..fd9e7a4c107d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -27,7 +27,6 @@
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
 #include <linux/semaphore.h>
-#include <linux/async.h>
 
 #include <linux/hid.h>
 #include <linux/hiddev.h>
@@ -2367,9 +2366,8 @@ int hid_add_device(struct hid_device *hdev)
 	 * not first have hid-generic binding only to have it replaced
 	 * immediately afterwards with a specialized driver.
 	 */
-	if (!current_is_async())
-		request_module("hid:b%04Xg%04Xv%08Xp%08X", hdev->bus,
-			       hdev->group, hdev->vendor, hdev->product);
+	request_module("hid:b%04Xg%04Xv%08Xp%08X",
+		       hdev->bus, hdev->group, hdev->vendor, hdev->product);
 
 	hid_debug_register(hdev, dev_name(&hdev->dev));
 	ret = device_add(&hdev->dev);
-- 
2.19.2
