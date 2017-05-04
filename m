From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elan_i2c - check if device is there before really
 probing
Date: Wed, 3 May 2017 23:29:38 -0700
Message-ID: <20170504062938.GA30771@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34723 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbdEDG3v (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 May 2017 02:29:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: KT Liao <ktalex.liao@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org

Before trying to properly initialize the touchpad and generate bunch of
errors, let's first see it there is anything at the given address. If we
get error, fail silently with -ENXIO.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5d3b53dd2fa2..0479730e7c5c 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1040,6 +1040,7 @@ static int elan_probe(struct i2c_client *client,
 	const struct elan_transport_ops *transport_ops;
 	struct device *dev = &client->dev;
 	struct elan_tp_data *data;
+	union i2c_smbus_data dummy;
 	unsigned long irqflags;
 	int error;
 
@@ -1091,6 +1092,14 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
 
+	/* Make sure there is something at this address */
+	error = i2c_smbus_xfer(client->adapter, client->addr, 0,
+			       I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy);
+	if (error) {
+		dev_dbg(&client->dev, "nothing at this address: %d\n", error);
+		return -ENXIO;
+	}
+
 	/* Initialize the touchpad. */
 	error = elan_initialize(data);
 	if (error)
-- 
2.13.0.rc1.294.g07d810a77f-goog


-- 
Dmitry
