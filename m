From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 5/8] HID: i2c-hid: remove custom locking from i2c_hid_open/close
Date: Tue,  6 Jun 2017 23:59:35 -0700
Message-ID: <20170607065938.33332-6-dmitry.torokhov@gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Now that HID core enforces serialization of transport driver open/close
calls we can remove custom locking from i2c-hid driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index fb55fb4c39fc..6355015ed249 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -743,18 +743,12 @@ static int i2c_hid_open(struct hid_device *hid)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret = 0;
 
-	mutex_lock(&i2c_hid_open_mut);
-	if (!hid->open++) {
-		ret = pm_runtime_get_sync(&client->dev);
-		if (ret < 0) {
-			hid->open--;
-			goto done;
-		}
-		set_bit(I2C_HID_STARTED, &ihid->flags);
-	}
-done:
-	mutex_unlock(&i2c_hid_open_mut);
-	return ret < 0 ? ret : 0;
+	ret = pm_runtime_get_sync(&client->dev);
+	if (ret < 0)
+		return ret;
+
+	set_bit(I2C_HID_STARTED, &ihid->flags);
+	return 0;
 }
 
 static void i2c_hid_close(struct hid_device *hid)
@@ -762,18 +756,10 @@ static void i2c_hid_close(struct hid_device *hid)
 	struct i2c_client *client = hid->driver_data;
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
-	/* protecting hid->open to make sure we don't restart
-	 * data acquistion due to a resumption we no longer
-	 * care about
-	 */
-	mutex_lock(&i2c_hid_open_mut);
-	if (!--hid->open) {
-		clear_bit(I2C_HID_STARTED, &ihid->flags);
+	clear_bit(I2C_HID_STARTED, &ihid->flags);
 
-		/* Save some power */
-		pm_runtime_put(&client->dev);
-	}
-	mutex_unlock(&i2c_hid_open_mut);
+	/* Save some power */
+	pm_runtime_put(&client->dev);
 }
 
 static int i2c_hid_power(struct hid_device *hid, int lvl)
-- 
2.13.0.506.g27d5fe0cd-goog
