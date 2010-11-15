From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: [PATCH 2/3] input: keyboard: MCS5080: support shutdown.
Date: Mon, 15 Nov 2010 13:32:34 +0900
Message-ID: <4CE0B7E2.4000604@samsung.com>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48015 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab0KOEci (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Nov 2010 23:32:38 -0500
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LBW001YYSMD6RA0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 13:32:38 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LBW00F1BSMDBJ@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 15 Nov 2010 13:32:37 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: kyungmin.park@samsung.com

This patch supports shutdown functions for mcs5080 touchkey
driver.

Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 06385f5..931b28c 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -206,6 +206,14 @@ static int __devexit mcs_touchkey_remove(struct i2c_client *client)
        return 0;
 }

+static void mcs_touchkey_shutdown(struct i2c_client *client)
+{
+       struct mcs_touchkey_data *data = i2c_get_clientdata(client);
+
+       if (data->poweron)
+               data->poweron(0);
+}
+
 #ifdef CONFIG_PM
 static int mcs_touchkey_suspend(struct i2c_client *client, pm_message_t mesg)
 {
@@ -255,6 +263,7 @@ static struct i2c_driver mcs_touchkey_driver = {
        },
        .probe          = mcs_touchkey_probe,
        .remove         = __devexit_p(mcs_touchkey_remove),
+       .shutdown       = mcs_touchkey_shutdown,
        .suspend        = mcs_touchkey_suspend,
        .resume         = mcs_touchkey_resume,
        .id_table       = mcs_touchkey_id,
--
1.7.0.4
