From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] Input: ims-pcu: Delete an error message for a failed
 memory allocation in ims_pcu_buffers_alloc()
Date: Thu, 25 Jan 2018 19:52:33 +0100
Message-ID: <64bbf341-27eb-ed44-a37d-758b9ab486b4@users.sourceforge.net>
References: <ff77a871-d30a-e873-ab73-2d80198bfbe7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff77a871-d30a-e873-ab73-2d80198bfbe7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 19:06:07 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/ims-pcu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 3d51175c4d72..4aca2a02ff6d 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1556,7 +1556,6 @@ static int ims_pcu_buffers_alloc(struct ims_pcu *pcu)
 	 */
 	pcu->urb_out_buf = kmalloc(pcu->max_out_size, GFP_KERNEL);
 	if (!pcu->urb_out_buf) {
-		dev_err(pcu->dev, "Failed to allocate memory for write buffer\n");
 		error = -ENOMEM;
 		goto err_free_in_urb;
 	}
-- 
2.16.1
