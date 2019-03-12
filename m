From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH v2] hid: logitech: check the return value of create_singlethread_workqueue
Date: Tue, 12 Mar 2019 01:16:28 -0500
Message-ID: <20190312061628.13869-1-kjlu@umn.edu>
References: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

create_singlethread_workqueue may fail and return NULL. The fix
checks if it is NULL to avoid NULL pointer dereference.
Also, the fix moves the call of create_singlethread_workqueue
earlier to avoid resource-release issues.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hid/hid-logitech-hidpp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15ed6177a7a3..1b7c336cae6d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2106,6 +2106,12 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+
+	/* init the hardware command queue */
+	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	if (!data->wq)
+		return -ENOMEM;
+
 	data->effect_ids = kcalloc(num_slots, sizeof(int), GFP_KERNEL);
 	if (!data->effect_ids) {
 		kfree(data);
@@ -2154,8 +2160,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	data->gain = error ? 0xffff : get_unaligned_be16(&response.fap.params[0]);
 	/* ignore boost value at response.fap.params[2] */
 
-	/* init the hardware command queue */
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	atomic_set(&data->workqueue_size, 0);
 
 	/* initialize with zero autocenter to get wheel in usable state */
-- 
2.17.1
