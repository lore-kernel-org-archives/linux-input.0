From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 3/5] Skip matrix size check
Date: Fri, 11 Feb 2011 15:32:17 +0200
Message-ID: <4D553A61.1090608@atmel.com>
References: <4D3DAE3C.6060806@atmel.com> <20110124170756.GB31066@core.coreip.homeip.net> <4D3EA7DD.6000601@atmel.com> <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com> <20110203074318.GA5814@core.coreip.homeip.net> <4D4AB605.4080106@atmel.com> <20110204085906.GF13046@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:55075 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab1BKNcn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 08:32:43 -0500
In-Reply-To: <20110204085906.GF13046@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org


Ok, I think the "matrix size check" should be really skipped altogether. It is currently setting the CTE mode to match xline/yline info that is in the platform data, but it does not take into account for example the fact that we could have a key array in use too (key array would need some x/y lines too). I think it would be best to just rely on the config data, and make sure that the CTE mode set in there matches the touch object (touchscreen, key array, proximity) configuration (which are set in the config data too). Here's a patch removing the check.

Regards,
-- 
Iiro


From: Iiro Valkonen <iiro.valkonen@atmel.com>

Remove the mxt224-specific matrix size check

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |   73 -------------------------------
 1 files changed, 0 insertions(+), 73 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 08fd136..bbbaefc 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -633,74 +633,6 @@ static int mxt_check_reg_init(struct mxt_data *data)
 	return 0;
 }
 
-static int mxt_check_matrix_size(struct mxt_data *data)
-{
-	const struct mxt_platform_data *pdata = data->pdata;
-	struct device *dev = &data->client->dev;
-	int mode = -1;
-	int error;
-	u8 val;
-
-	dev_dbg(dev, "Number of X lines: %d\n", pdata->x_line);
-	dev_dbg(dev, "Number of Y lines: %d\n", pdata->y_line);
-
-	switch (pdata->x_line) {
-	case 0 ... 15:
-		if (pdata->y_line <= 14)
-			mode = 0;
-		break;
-	case 16:
-		if (pdata->y_line <= 12)
-			mode = 1;
-		if (pdata->y_line == 13 || pdata->y_line == 14)
-			mode = 0;
-		break;
-	case 17:
-		if (pdata->y_line <= 11)
-			mode = 2;
-		if (pdata->y_line == 12 || pdata->y_line == 13)
-			mode = 1;
-		break;
-	case 18:
-		if (pdata->y_line <= 10)
-			mode = 3;
-		if (pdata->y_line == 11 || pdata->y_line == 12)
-			mode = 2;
-		break;
-	case 19:
-		if (pdata->y_line <= 9)
-			mode = 4;
-		if (pdata->y_line == 10 || pdata->y_line == 11)
-			mode = 3;
-		break;
-	case 20:
-		mode = 4;
-	}
-
-	if (mode < 0) {
-		dev_err(dev, "Invalid X/Y lines\n");
-		return -EINVAL;
-	}
-
-	error = mxt_read_object(data, MXT_SPT_CTECONFIG,
-				MXT_CTE_MODE, &val);
-	if (error)
-		return error;
-
-	if (mode == val)
-		return 0;
-
-	/* Change the CTE configuration */
-	mxt_write_object(data, MXT_SPT_CTECONFIG,
-			MXT_CTE_CTRL, 1);
-	mxt_write_object(data, MXT_SPT_CTECONFIG,
-			MXT_CTE_MODE, mode);
-	mxt_write_object(data, MXT_SPT_CTECONFIG,
-			MXT_CTE_CTRL, 0);
-
-	return 0;
-}
-
 static int mxt_make_highchg(struct mxt_data *data)
 {
 	struct device *dev = &data->client->dev;
@@ -867,11 +799,6 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
 
-	/* Check X/Y matrix size */
-	error = mxt_check_matrix_size(data);
-	if (error)
-		return error;
-
 	error = mxt_make_highchg(data);
 	if (error)
 		return error;
-- 
1.7.0.4
