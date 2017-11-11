From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 2/2] Input: ili210x - use separate error handling for different allocators
Date: Sat, 11 Nov 2017 07:02:31 +0200
Message-ID: <20171111050231.29047-3-andi@etezian.org>
References: <20171111050231.29047-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:40642 "EHLO
        20.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdKKFDE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Nov 2017 00:03:04 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4093216F9A3
        for <linux-input@vger.kernel.org>; Sat, 11 Nov 2017 06:03:03 +0100 (CET)
In-Reply-To: <20171111050231.29047-1-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@gmail.com>

Split the error between devm_kzalloc and
devm_input_allocate_device, there is no need to call the second
allocator if the first has failed. Besides this doesn't provide
practical advantages.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/input/touchscreen/ili210x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index da868b1d0e83..9344c4436430 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -225,8 +225,11 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 	ymax = panel.finger_max.y_low | (panel.finger_max.y_high << 8);
 
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	input = devm_input_allocate_device(&client->dev);
-	if (!priv || !input)
+	if (!input)
 		return -ENOMEM;
 
 	priv->client = client;
-- 
2.15.0

