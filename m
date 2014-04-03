From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] Input: edt-ft5x06 - add a missing condition
Date: Thu, 3 Apr 2014 04:37:12 +0300
Message-ID: <20140403013712.GA28270@mwanda>
References: <002101cf4eda$184e85b0$48eb9110$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49610 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030465AbaDCBi4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Apr 2014 21:38:56 -0400
Content-Disposition: inline
In-Reply-To: <002101cf4eda$184e85b0$48eb9110$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Fugang Duan <B38611@freescale.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

The if condition was accidentally deleted here so we return every time
instead of returning on error.

Fixes: fd335ab04b3f ('Input: edt-ft5x06 - add support for M09 firmware version')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: removed a stray tab character

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 75b666b..9d0b324 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -291,9 +291,10 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
 		wrbuf[1] |= tsdata->factory_mode ? 0x80 : 0x40;
 
-		error = edt_ft5x06_ts_readwrite(tsdata->client,
-						2, wrbuf, 2, rdbuf);
-		return error;
+		error = edt_ft5x06_ts_readwrite(tsdata->client, 2, wrbuf, 2,
+						rdbuf);
+		if (error)
+			return error;
 
 		if ((wrbuf[0] ^ wrbuf[1] ^ rdbuf[0]) != rdbuf[1]) {
 			dev_err(&tsdata->client->dev,

