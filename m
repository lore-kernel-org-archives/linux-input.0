From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elants_i2c - zero-extend hardware ID in firmware name
Date: Fri, 17 Apr 2015 20:43:36 -0700
Message-ID: <20150418034336.GA31454@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33339 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbDRDnk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2015 23:43:40 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Scott Liu <scott.liu@emc.com.tw>, Charlie Mooney <charliemooney@chromium.org>, linux-kernel@vger.kernel.org

Let's zero-extend hardware id number when forming firmware file name,
to avoid kernel requesting firmware like "elants_i2c_   0.bin", which
is quite unexpected.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 43b3c9c..0efd766 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -699,7 +699,7 @@ static int elants_i2c_fw_update(struct elants_data *ts)
 	char *fw_name;
 	int error;
 
-	fw_name = kasprintf(GFP_KERNEL, "elants_i2c_%4x.bin", ts->hw_version);
+	fw_name = kasprintf(GFP_KERNEL, "elants_i2c_%04x.bin", ts->hw_version);
 	if (!fw_name)
 		return -ENOMEM;
 
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
