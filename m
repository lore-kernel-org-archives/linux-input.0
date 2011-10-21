From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] input:ad7879-i2c use swapped varient of i2c_smbus_read_word_data
Date: Fri, 21 Oct 2011 11:03:27 +0100
Message-ID: <1319191407-23362-1-git-send-email-jic23@cam.ac.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:48410 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab1JUKDY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Oct 2011 06:03:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael.Hennerich@analog.com, dmitry.torokhov@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>

This varient was introduced in
i2c: boilerplate function for byte swapped smbus_write/read_word_data

This also has the side effect of ensuring any errors from the i2c
read and no longer mangled.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---
The patch introducing this swapped function is working its way through the i2c
tree.

 drivers/input/touchscreen/ad7879-i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 4e4e58c..1c1683e 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -47,7 +47,7 @@ static int ad7879_i2c_read(struct device *dev, u8 reg)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	return swab16(i2c_smbus_read_word_data(client, reg));
+	return i2c_smbus_read_word_swapped(client, reg);
 }
 
 static int ad7879_i2c_multi_read(struct device *dev,
-- 
1.7.7

