From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 61/63] input: atmel_mxt_ts: Add NULL check for sysfs attribute debug_msg_attr
Date: Fri, 16 Aug 2019 17:39:00 +0900
Message-ID: <20190816083902.19659-2-jiada_wang@mentor.com>
References: <20190816083902.19659-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083902.19659-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>

In some scenarios mxt_debug_msg_remove() can be called from
mxt_remove() even before the data->debug_msg_attr is updated.
So a NULL check is required for data->debug_msg_attr before
accessing it.
There is also an additional change in mxt_debug_msg_init() to update
data->debug_msg_attr only when sysfs_create_bin_file is successful.

Consider the following scenario: Atmel MXT driver module is being loaded
hence mxt_probe() is called, then mxt_probe() calls mxt_initialize() and
in mxt_initialize() function if the Atmel MXT is in bootloader mode there
is a possibility that it can return before calling mxt_debug_msg_init(),
with a value of 0 meaning no error.
In this case data->debug_msg_attr is now at the initialized state only,
which is NULL as allocation of data pointer was done with devm_kzalloc()
call in mxt_probe function. Completion of initialisation will be deferred
until some later time.
If there is now an attempt to remove the Atmel MXT driver module, in
mxt_remove() there is a call to mxt_debug_msg_remove() which calls
sysfs_remove_bin_file() with a NULL data->debug_msg_attr.
Therefore, we need to have check in mxt_debug_msg_remove() for
data->debug_msg_attr being NULL.

Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
Signed-off-by: Mark Craske <Mark_Craske@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index fd9a96ec3fd3..1179f90a8077 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -615,21 +615,26 @@ static int mxt_debug_msg_init(struct mxt_data *data)
 	 * so it is safe to update a single struct bin_attribute entity
 	 */
 	debug_msg_attr.size = data->T5_msg_size * DEBUG_MSG_MAX;
-	data->debug_msg_attr = &debug_msg_attr;
 
 	if (sysfs_create_bin_file(&data->client->dev.kobj,
-				  data->debug_msg_attr) < 0) {
+				  &debug_msg_attr) < 0) {
 		dev_err(&data->client->dev, "Failed to create %s\n",
 			debug_msg_attr.attr.name);
 		return -EINVAL;
 	}
 
+	data->debug_msg_attr = &debug_msg_attr;
+
 	return 0;
 }
 
 static void mxt_debug_msg_remove(struct mxt_data *data)
 {
-	sysfs_remove_bin_file(&data->client->dev.kobj, data->debug_msg_attr);
+	if (data->debug_msg_attr) {
+		sysfs_remove_bin_file(&data->client->dev.kobj,
+				      data->debug_msg_attr);
+		data->debug_msg_attr = NULL;
+	}
 }
 
 static int mxt_wait_for_completion(struct mxt_data *data,
-- 
2.19.2
