From: Dmitry Torokhov <dtor@google.com>
Subject: [PATCH] HID: i2c-hid: check if device is there before really probing
Date: Wed,  9 May 2018 12:12:15 -0700
Message-ID: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

On many Chromebooks touch devices are multi-sourced; the components are
electrically compatible and one can be freely swapped for another without
changing the OS image or firmware.

To avoid bunch of scary messages when device is not actually present in the
system let's try testing basic communication with it and if there is no
response terminate probe early with -ENXIO.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 7230243b94d30..a59d483ff316a 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1048,6 +1048,14 @@ static int i2c_hid_probe(struct i2c_client *client,
 	pm_runtime_enable(&client->dev);
 	device_enable_async_suspend(&client->dev);
 
+	/* Make sure there is something at this address */
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "nothing at this address: %d\n", ret);
+		ret = -ENXIO;
+		goto err_pm;
+	}
+
 	ret = i2c_hid_fetch_hid_descriptor(ihid);
 	if (ret < 0)
 		goto err_pm;
-- 
2.17.0.441.gb46fe60e1d-goog
