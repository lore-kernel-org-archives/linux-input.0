From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: melfas_mip4 - ensure that device is present
Date: Sun, 26 Mar 2017 22:48:44 -0700
Message-ID: <20170327054844.GA35471@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sangwon Jee <jeesw@melfas.com>, djkurtz@chromium.org, milton.chiang@mediatek.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Try a quick read from the device in mip4_query_device() to make sure
that the device is there, as we do not consider failures to retrieve
product name or resolution fatal.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 703d7f983d0a..05108c2fea93 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -253,10 +253,21 @@ static int mip4_get_fw_version(struct mip4_ts *ts)
  */
 static int mip4_query_device(struct mip4_ts *ts)
 {
+	union i2c_smbus_data dummy;
 	int error;
 	u8 cmd[2];
 	u8 buf[14];
 
+	/*
+	 * Make sure there is something at this address as we do not
+	 * consider subsequent failures as fatal.
+	 */
+	if (i2c_smbus_xfer(ts->client->adapter, ts->client->addr,
+			   0, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy) < 0) {
+		dev_err(&ts->client->dev, "nothing at this address\n");
+		return -ENXIO;
+	}
+
 	/* Product name */
 	cmd[0] = MIP4_R0_INFO;
 	cmd[1] = MIP4_R1_INFO_PRODUCT_NAME;
-- 
2.12.1.578.ge9c3154ca4-goog


-- 
Dmitry
