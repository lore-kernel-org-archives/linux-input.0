From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v3 1/2] HID: i2c-hid: Use devm to allocate i2c_hid struct
Date: Thu, 21 Jun 2018 19:27:16 -0700
Message-ID: <20180622022717.134300-2-swboyd@chromium.org>
References: <20180622022717.134300-1-swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622022717.134300-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

Use devm here to save some lines and prepare for bulk regulator usage in
this driver. Otherwise, when we devm bulk get regulators we'll free the
containing i2c_hid structure and try to put regulator pointers from
freed memory.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index c1652bb7bd15..c7d6738dc524 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1002,18 +1002,18 @@ static int i2c_hid_probe(struct i2c_client *client,
 		return client->irq;
 	}
 
-	ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
+	ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
 	if (!ihid)
 		return -ENOMEM;
 
 	if (client->dev.of_node) {
 		ret = i2c_hid_of_probe(client, &ihid->pdata);
 		if (ret)
-			goto err;
+			return ret;
 	} else if (!platform_data) {
 		ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
 		if (ret)
-			goto err;
+			return ret;
 	} else {
 		ihid->pdata = *platform_data;
 	}
@@ -1126,7 +1126,6 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 err:
 	i2c_hid_free_buffers(ihid);
-	kfree(ihid);
 	return ret;
 }
 
@@ -1150,8 +1149,6 @@ static int i2c_hid_remove(struct i2c_client *client)
 
 	regulator_disable(ihid->pdata.supply);
 
-	kfree(ihid);
-
 	return 0;
 }
 
-- 
Sent by a computer through tubes
