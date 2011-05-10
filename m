From: <michael.hennerich@analog.com>
Subject: [PATCH 3/5] input: misc: AD714x: Fix thresh and completion interrupt mask and unmask functions
Date: Tue, 10 May 2011 13:35:07 +0200
Message-ID: <1305027309-17637-3-git-send-email-michael.hennerich@analog.com>
References: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:43980 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab1EJLoh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2011 07:44:37 -0400
In-Reply-To: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Fix two issues in the thresh and completion interrupt mask and unmask functions.
According to the AD714x datasheets the highest stage completion
interrupt should be enabled.
Fix mask computation.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/ad714x.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 9d95397..89554eb 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -160,10 +160,10 @@ static void ad714x_use_com_int(struct ad714x_chip *ad714x,
 	unsigned short data;
 	unsigned short mask;
 
-	mask = ((1 << (end_stage + 1)) - 1) - (1 << start_stage);
+	mask = ((1 << (end_stage + 1)) - 1) - ((1 << start_stage) - 1);
 
 	ad714x->read(ad714x->dev, STG_COM_INT_EN_REG, &data);
-	data |= 1 << start_stage;
+	data |= 1 << end_stage;
 	ad714x->write(ad714x->dev, STG_COM_INT_EN_REG, data);
 
 	ad714x->read(ad714x->dev, STG_HIGH_INT_EN_REG, &data);
@@ -177,10 +177,10 @@ static void ad714x_use_thr_int(struct ad714x_chip *ad714x,
 	unsigned short data;
 	unsigned short mask;
 
-	mask = ((1 << (end_stage + 1)) - 1) - (1 << start_stage);
+	mask = ((1 << (end_stage + 1)) - 1) - ((1 << start_stage) - 1);
 
 	ad714x->read(ad714x->dev, STG_COM_INT_EN_REG, &data);
-	data &= ~(1 << start_stage);
+	data &= ~(1 << end_stage);
 	ad714x->write(ad714x->dev, STG_COM_INT_EN_REG, data);
 
 	ad714x->read(ad714x->dev, STG_HIGH_INT_EN_REG, &data);
-- 
1.6.0.2


