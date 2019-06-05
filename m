From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] Revert "HID: core: Call request_module before doing device_add"
Date: Wed,  5 Jun 2019 14:44:07 +0200
Message-ID: <20190605124408.8637-4-benjamin.tissoires@redhat.com>
References: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This reverts commit a025a18fecd4429f4ca66b1746001263c052ecbb.

This patch and 4ceabaf79 are giving extended timeouts
on boot for at least Ubuntu and OpenSuse.

Revert them until we get a better fix.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203741
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index fd9e7a4c107d..210b81a56e1a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2361,14 +2361,6 @@ int hid_add_device(struct hid_device *hdev)
 	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
 		     hdev->vendor, hdev->product, atomic_inc_return(&id));
 
-	/*
-	 * Try loading the module for the device before the add, so that we do
-	 * not first have hid-generic binding only to have it replaced
-	 * immediately afterwards with a specialized driver.
-	 */
-	request_module("hid:b%04Xg%04Xv%08Xp%08X",
-		       hdev->bus, hdev->group, hdev->vendor, hdev->product);
-
 	hid_debug_register(hdev, dev_name(&hdev->dev));
 	ret = device_add(&hdev->dev);
 	if (!ret)
-- 
2.19.2
