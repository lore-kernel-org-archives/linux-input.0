From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] hid: intel-ish-hid: use put_device() instead of kfree()
Date: Fri, 30 Mar 2018 16:56:10 +0530
Message-ID: <66bd5f1ab1322081927f657090a04b44da326140.1522408033.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index f272cdd..2623a56 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -418,7 +418,7 @@ static struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
 		list_del(&device->device_link);
 		spin_unlock_irqrestore(&dev->device_list_lock, flags);
 		dev_err(dev->devc, "Failed to register ISHTP client device\n");
-		kfree(device);
+		put_device(&device->dev);
 		return NULL;
 	}
 
-- 
2.7.4
