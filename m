From: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: [PATCH 2/3] driver: input: twl4030-vibra: fix missing of_node_put
Date: Sat, 31 Aug 2013 14:45:01 +0800
Message-ID: <522190ED.6020909@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: peter.ujfalusi@ti.com, Bill Pemberton <wfp5p@virginia.edu>, broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


decrease node device_node refcount after task completion

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/input/misc/twl4030-vibra.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 68a5f33..b8d1526 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -185,8 +185,10 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
 	if (pdata && pdata->coexist)
 		return true;

-	if (of_find_node_by_name(node, "codec"))
+	if (of_find_node_by_name(node, "codec")) {
+		of_node_put(node);
 		return true;
+	}

 	return false;
 }
-- 
1.7.1
