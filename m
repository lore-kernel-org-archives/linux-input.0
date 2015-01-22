From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: cyapa - off by on in cyapa_update_fw_store()
Date: Thu, 22 Jan 2015 10:48:01 +0300
Message-ID: <20150122074801.GA11491@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51456 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbAVHrh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 02:47:37 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Dudley Du <dudl@cypress.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

If "(count == NAME_MAX)" then we could end up putting the NUL terminator
one space beyond the end of the fw_name[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 64c6128..58f4f6f 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1013,7 +1013,7 @@ static ssize_t cyapa_update_fw_store(struct device *dev,
 	char fw_name[NAME_MAX];
 	int ret, error;
 
-	if (count > NAME_MAX) {
+	if (count >= NAME_MAX) {
 		dev_err(dev, "File name too long\n");
 		return -EINVAL;
 	}
