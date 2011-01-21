From: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Subject: [PATCH] input:bu21013: Update the regulator name
Date: Fri, 21 Jan 2011 17:08:25 +0530
Message-ID: <1295609905-2905-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:58316 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753847Ab1AULjm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 06:39:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org, rydberg@euromail.se, lee.jones@linaro.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

Update the regulator name for getting the regulator of
the bu21013 touch device.

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
---
 drivers/input/touchscreen/bu21013_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 1507ce1..03e60d3 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -460,7 +460,7 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	bu21013_data->chip = pdata;
 	bu21013_data->client = client;
 
-	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
+	bu21013_data->regulator = regulator_get(&client->dev, "avdd");
 	if (IS_ERR(bu21013_data->regulator)) {
 		dev_err(&client->dev, "regulator_get failed\n");
 		error = PTR_ERR(bu21013_data->regulator);
-- 
1.7.2.dirty

