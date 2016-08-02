From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ili210x - fix permissions on "calibrate" attribute
Date: Tue, 2 Aug 2016 11:56:09 -0700
Message-ID: <20160802185609.GA9952@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36515 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbcHBUHG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2016 16:07:06 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Olivier Sobrie <olivier@sobrie.be>, linux-kernel@vger.kernel.org

"calibrate" attribute does not provide "show" methods and thus we should
not mark it as readable.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ili210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index ddf694b..fe4848b 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -169,7 +169,7 @@ static ssize_t ili210x_calibrate(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(calibrate, 0644, NULL, ili210x_calibrate);
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, ili210x_calibrate);
 
 static struct attribute *ili210x_attributes[] = {
 	&dev_attr_calibrate.attr,
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
