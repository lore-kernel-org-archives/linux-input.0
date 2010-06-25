From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] Input: ad7879 - use i2c_smbus_read_i2c_block_data() to
	lower overhead
Date: Fri, 25 Jun 2010 01:22:34 -0700
Message-ID: <20100625082234.8617.98489.stgit@localhost.localdomain>
References: <20100625081847.8617.31150.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44354 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0FYIWh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jun 2010 04:22:37 -0400
Received: by mail-px0-f174.google.com with SMTP id 8so593923pxi.19
        for <linux-input@vger.kernel.org>; Fri, 25 Jun 2010 01:22:37 -0700 (PDT)
In-Reply-To: <20100625081847.8617.31150.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Avoid additional addressing overhead incurred by word_data transfers.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ad7879-i2c.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index f75f753..79e3857 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -51,10 +51,13 @@ static int ad7879_i2c_read(struct device *dev, u8 reg)
 static int ad7879_i2c_multi_read(struct device *dev,
 				 u8 first_reg, u8 count, u16 *buf)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	u8 idx;
 
+	i2c_smbus_read_i2c_block_data(client, first_reg, count * 2, (u8 *)buf);
+
 	for (idx = 0; idx < count; ++idx)
-		buf[idx] = ad7879_i2c_read(dev, first_reg + idx);
+		buf[idx] = swab16(buf[idx]);
 
 	return 0;
 }

