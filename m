From: Maks Naumov <maksqwe1@ukr.net>
Subject: [PATCH] Input: Remove superfluous assignment in
 edt_ft5x06_register_write()
Date: Wed, 13 Aug 2014 13:00:05 -0700
Message-ID: <1407960005.4388.2.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from frv151.fwdcdn.com ([212.42.77.151]:14846 "EHLO
	frv150.fwdcdn.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752050AbaHMUQ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2014 16:16:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Maks Naumov <maksqwe1@ukr.net>
---
 drivers/input/touchscreen/edt-ft5x06.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 5a6d50c..8857d5b 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -262,7 +262,6 @@ static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
 	case M06:
 		wrbuf[0] = tsdata->factory_mode ? 0xf3 : 0xfc;
 		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
-		wrbuf[1] = tsdata->factory_mode ? addr & 0x7f : addr & 0x3f;
 		wrbuf[2] = value;
 		wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
 		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
-- 
1.9.1



