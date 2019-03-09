From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] hid: logitech: check the return value of create_singlethread_workqueue
Date: Fri,  8 Mar 2019 22:43:45 -0600
Message-ID: <20190309044345.7018-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

create_singlethread_workqueue may fail and return NULL. The fix
checks if it is NULL to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15ed6177a7a3..efbc39b92aa2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2156,6 +2156,9 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 
 	/* init the hardware command queue */
 	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	if (!data->wq)
+		return -ENOMEM;
+
 	atomic_set(&data->workqueue_size, 0);
 
 	/* initialize with zero autocenter to get wheel in usable state */
-- 
2.17.1
