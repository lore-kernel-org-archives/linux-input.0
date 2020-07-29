Return-Path: <SRS0=4//j=BI=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B18CC433DF
	for <linux-input@archiver.kernel.org>; Wed, 29 Jul 2020 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3013920663
	for <linux-input@archiver.kernel.org>; Wed, 29 Jul 2020 09:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2JW6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:22:58 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:29404 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgG2JW6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Jul 2020 05:22:58 -0400
IronPort-SDR: DQW/OrdW6y9aBLoNFuSz+u29IKhdkeiJEMYOnKHmwZCke314r3qFaWu2LoMyZln1Ubkeo+dxxe
 sfhGgL3GE6q8X5wxkOXV1MpZnf9SFftdKFh3kMLOQrgOi5LUXHtl5IJOIJt5P2fOUtUitT/mT7
 m3kh53kXwjSHYwnQRUtpAC5tMUJZePAPRSQkGZopHslU6QqaGbGznrIa+hZ5CNfsu4i8jNwt9N
 vF6CYb8WUyfCuExGJpQ4/WOovghTT6HM1IB3hrB8Ypwz0CtJJqg5UkBdcibSC2GvMsMn2QAIkT
 LOA=
X-IronPort-AV: E=Sophos;i="5.75,409,1589270400"; 
   d="scan'208";a="51525656"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 29 Jul 2020 01:22:57 -0800
IronPort-SDR: F3bDoXGx/6X38yatA2Y/3REPwZxCD7Tk6gQCa4cYBJ89X0DQObeKnNzW8JP3aeYLx6AYRP+Goz
 DZqDPN48xwG/a+74hFJSwJhKvXa4wyNpGX/Jvu3hfev/0yvO2DJ7KG2sAlZvbjaA5PqIo245f8
 RdGTZtFxQ3lmUcQgIPxBPsRahAv84S5KtB8T9FdP66IugJuO6VCoWsG7+76I/RG2ApMbghMqyV
 EY+n7iRXo/wSFyu2KZVD0bG68n26oLDAEqkh78fbhggL2zmgT2zUSWML7ksbhxnMrW4WD7OJXm
 gks=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>,
        <digetx@gmail.com>, <jiada_wang@mentor.com>
Subject: [PATCH 1/1] Input: atmel_mxt_ts: split large i2c transfers into blocks
Date:   Wed, 29 Jul 2020 18:22:52 +0900
Message-ID: <20200729092252.6394-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Jiada wang <jiada_wang@mentor.com>

Some I2C controllers constrain maximum transferred data in an I2C
transaction by set max_[read|write]_len of i2c_adapter_quirk.
Large i2c transfer transaction beyond this limitation may fail to complete,
cause I2C controller driver aborts the transaction and returns failure.

Therefore this patch was created to split large i2c transaction into
smaller chunks which can complete within max_[read|write]_len defined
by I2C controller driver.

CC: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Jiada wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 60 ++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a2189739e30f..d7c3c24aa663 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -620,8 +620,8 @@ static int mxt_send_bootloader_cmd(struct mxt_data *data, bool unlock)
 	return 0;
 }
 
-static int __mxt_read_reg(struct i2c_client *client,
-			       u16 reg, u16 len, void *val)
+static int __mxt_read_chunk(struct i2c_client *client,
+			    u16 reg, u16 len, void *val)
 {
 	struct i2c_msg xfer[2];
 	u8 buf[2];
@@ -655,8 +655,33 @@ static int __mxt_read_reg(struct i2c_client *client,
 	return ret;
 }
 
-static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
-			   const void *val)
+static int __mxt_read_reg(struct i2c_client *client,
+			  u16 reg, u16 len, void *buf)
+{
+	const struct i2c_adapter_quirks *quirks = client->adapter->quirks;
+	u16 size, offset = 0, max_read_len = len;
+	int ret;
+
+	if (quirks && quirks->max_read_len)
+		max_read_len = quirks->max_read_len;
+
+	while (offset < len) {
+		size = min_t(u16, max_read_len, len - offset);
+
+		ret = __mxt_read_chunk(client,
+				       reg + offset,
+				       size, buf + offset);
+		if (ret)
+			return ret;
+
+		offset += size;
+	}
+
+	return 0;
+}
+
+static int __mxt_write_chunk(struct i2c_client *client, u16 reg, u16 len,
+			     const void *val)
 {
 	u8 *buf;
 	size_t count;
@@ -685,9 +710,34 @@ static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
 	return ret;
 }
 
+static int __mxt_write_reg(struct i2c_client *client, u16 reg, u16 len,
+			   const void *val)
+{
+	const struct i2c_adapter_quirks *quirks = client->adapter->quirks;
+	u16 size, offset = 0, max_write_len = len;
+	int ret;
+
+	if (quirks && quirks->max_write_len)
+		max_write_len = quirks->max_write_len;
+
+	while (offset < len) {
+		size = min_t(u16, max_write_len, len - offset);
+
+		ret = __mxt_write_chunk(client,
+					reg + offset,
+					size, val + offset);
+		if (ret)
+			return ret;
+
+		offset += size;
+	}
+
+	return 0;
+}
+
 static int mxt_write_reg(struct i2c_client *client, u16 reg, u8 val)
 {
-	return __mxt_write_reg(client, reg, 1, &val);
+	return __mxt_write_chunk(client, reg, 1, &val);
 }
 
 static struct mxt_object *
-- 
2.17.1

