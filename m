From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: sx8654 - fix memory allocation check
Date: Fri, 8 May 2015 16:50:31 -0700
Message-ID: <20150508235031.GA29274@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34418 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbbEHXuf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2015 19:50:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-kernel@vger.kernel.org

We have been testing wrong variable when trying to make sure that input
allocation succeeded.

Reported by Coverity (CID 1295918).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sx8654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index aecb9ad..642f4a5 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -187,7 +187,7 @@ static int sx8654_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	input = devm_input_allocate_device(&client->dev);
-	if (!sx8654)
+	if (!input)
 		return -ENOMEM;
 
 	input->name = "SX8654 I2C Touchscreen";
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
