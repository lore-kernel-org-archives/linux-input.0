From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: [PATCH v2 2/2] input: keyboard: MCS5080: support shutdown.
Date: Fri, 19 Nov 2010 15:23:09 +0900
Message-ID: <4CE617CD.2090006@samsung.com>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64743 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab0KSGXL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 01:23:11 -0500
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC400DL5CELG3E0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Fri, 19 Nov 2010 15:23:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC400G5XCEMHC@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Fri, 19 Nov 2010 15:23:10 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>

This patch supports shutdown functions for mcs5080 touchkey
driver.

Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 92149e4..e842ebb 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -212,6 +212,14 @@ static int __devexit mcs_touchkey_remove(struct i2c_client *client)
 	return 0;
 }
 
+static void mcs_touchkey_shutdown(struct i2c_client *client)
+{
+	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
+
+	if (data->poweron)
+		data->poweron(0);
+}
+
 #ifdef CONFIG_PM
 static int mcs_touchkey_suspend(struct device *dev)
 {
@@ -267,6 +275,7 @@ static struct i2c_driver mcs_touchkey_driver = {
 	},
 	.probe		= mcs_touchkey_probe,
 	.remove		= __devexit_p(mcs_touchkey_remove),
+	.shutdown       = mcs_touchkey_shutdown,
 	.id_table	= mcs_touchkey_id,
 };
 
-- 
1.7.0.4
