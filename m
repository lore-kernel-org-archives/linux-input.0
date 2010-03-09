From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] input: ad7879: use i2c_smbus_read_i2c_block_data() to lower overhead
Date: Tue,  9 Mar 2010 10:00:58 -0500
Message-ID: <1268146858-15902-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49619 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab0CIO5m (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 09:57:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Avoid additional addressing overhead incurred by word_data transfers.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/touchscreen/ad7879-i2c.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 3742ca1..50ed9e4 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -41,8 +41,12 @@ static int ad7879_i2c_read(void *client, u8 reg)
 static int ad7879_i2c_multi_read(void *client, u8 first_reg, u8 count, u16 *buf)
 {
 	u8 idx;
+
+	i2c_smbus_read_i2c_block_data(client, first_reg, count * 2, (u8 *)buf);
+
 	for (idx = 0; idx < count; ++idx)
-		buf[idx] = ad7879_i2c_read(client, first_reg + idx);
+		buf[idx] = swab16(buf[idx]);
+
 	return 0;
 }
 
-- 
1.7.0.2

