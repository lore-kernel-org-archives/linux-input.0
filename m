From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend fixes for 4.8 1/2] input: touchscreen: silead_gsl1680: Document firmware-name, fix implementation
Date: Wed,  7 Sep 2016 22:09:56 +0200
Message-ID: <20160907200957.3341-2-hdegoede@redhat.com>
References: <20160907200957.3341-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932276AbcIGUKG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Sep 2016 16:10:06 -0400
In-Reply-To: <20160907200957.3341-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

The driver has supported touchscreen-fw-name to specify the firmware to
load since it has been merged, but this was omitted from the dt-binding
documentation.

During review of adding touchscreen-fw-name to the binding documentation
it was brought up that there is a standard property name called
"firmware-name" for this, which should be used.

Since there are no users of touchscreen-fw-name yet, this commit
adds documentation of "firmware-name" to the dt-binding documentation
and switches the driver over to use this.

This commit also makes the driver add a "silead/" prefix to the
firmware name from dt before calling request_firmware. That the
firmware files are stored under /lib/firmware/silead under Linux
is an implementation detail and does not belong in devicetree.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt         | 1 +
 drivers/input/touchscreen/silead.c                                   | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
index ad7f41a..b726823 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
@@ -17,6 +17,7 @@ Required properties:
 - touchscreen-size-y	  : See touchscreen.txt
 
 Optional properties:
+- firmware-name		  : File basename (string) for board specific firmware
 - touchscreen-inverted-x  : See touchscreen.txt
 - touchscreen-inverted-y  : See touchscreen.txt
 - touchscreen-swapped-x-y : See touchscreen.txt
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 3b80f14..7709f5b 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -393,9 +393,10 @@ static void silead_ts_read_props(struct i2c_client *client)
 		data->max_fingers = 5; /* Most devices handle up-to 5 fingers */
 	}
 
-	error = device_property_read_string(dev, "touchscreen-fw-name", &str);
+	error = device_property_read_string(dev, "firmware-name", &str);
 	if (!error)
-		snprintf(data->fw_name, sizeof(data->fw_name), "%s", str);
+		snprintf(data->fw_name, sizeof(data->fw_name),
+			 "silead/%s", str);
 	else
 		dev_dbg(dev, "Firmware file name read error. Using default.");
 }
-- 
2.9.3

