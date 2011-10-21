From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH V2] input:ad7879-i2c use swapped varient of i2c_smbus_read_word_data
Date: Fri, 21 Oct 2011 12:57:16 +0100
Message-ID: <1319198236-2085-1-git-send-email-jic23@cam.ac.uk>
References: <544AC56F16B56944AEC3BD4E3D59177146E75C18DC@LIMKCMBX1.ad.analog.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:47388 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab1JUL5N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Oct 2011 07:57:13 -0400
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E75C18DC@LIMKCMBX1.ad.analog.com>
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
V2: include the write function as pointed out by Michael Hennerich.

The patch introducing this swapped function is working its way through the i2c
tree.

 drivers/input/touchscreen/ad7879-i2c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 4e4e58c..cc51392 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -47,7 +47,7 @@ static int ad7879_i2c_read(struct device *dev, u8 reg)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	return swab16(i2c_smbus_read_word_data(client, reg));
+	return i2c_smbus_read_word_swapped(client, reg);
 }
 
 static int ad7879_i2c_multi_read(struct device *dev,
@@ -68,7 +68,7 @@ static int ad7879_i2c_write(struct device *dev, u8 reg, u16 val)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	return i2c_smbus_write_word_data(client, reg, swab16(val));
+	return i2c_smbus_write_word_swapped(client, reg, val);
 }
 
 static const struct ad7879_bus_ops ad7879_i2c_bus_ops = {
-- 
1.7.7

