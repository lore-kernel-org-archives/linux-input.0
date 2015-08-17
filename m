From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] hid: enable hid device to suspend/resume asynchronously
Date: Mon, 17 Aug 2015 23:55:53 +0800
Message-ID: <55D20409.4060801@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.com
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Enable hid device to suspend/resume asynchronously. This can improve
system suspend/resume speed.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 drivers/hid/hid-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e6fce23..27ac160 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2627,6 +2627,7 @@ struct hid_device *hid_allocate_device(void)
 	device_initialize(&hdev->dev);
 	hdev->dev.release = hid_device_release;
 	hdev->dev.bus = &hid_bus_type;
+	device_enable_async_suspend(&hdev->dev);
 
 	hid_close_report(hdev);
 
-- 1.7.1
