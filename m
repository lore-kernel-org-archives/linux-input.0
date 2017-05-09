From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] Input: elan_i2c - check if device is there before really
 probing
Date: Mon, 8 May 2017 17:45:53 -0700
Message-ID: <20170509004553.GA21295@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35372 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbdEIAp5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 May 2017 20:45:57 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: KT Liao <ktalex.liao@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org

Before trying to properly initialize the touchpad and generate bunch of
errors, let's first see it there is anything at the given address. If we
get error, fail silently with -ENXIO.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: switched over to i2c_smbus_read_byte() as Guenter suggested

 drivers/input/mouse/elan_i2c_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5d3b53dd2fa2..3b616cb7c67f 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1091,6 +1091,13 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
 
+	/* Make sure there is something at this address */
+	error = i2c_smbus_read_byte(client);
+	if (error < 0) {
+		dev_dbg(&client->dev, "nothing at this address: %d\n", error);
+		return -ENXIO;
+	}
+
 	/* Initialize the touchpad. */
 	error = elan_initialize(data);
 	if (error)
-- 
2.13.0.rc2.291.g57267f2277-goog


-- 
Dmitry
