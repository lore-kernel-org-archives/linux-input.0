From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] HID: hid-logitech-hidpp: add NULL check on devm_kmemdup()
 return value
Date: Fri, 7 Jul 2017 00:12:13 -0500
Message-ID: <20170707051213.GA6074@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-input@vger.kernel.org

Check return value from call to devm_kmemdup()
in order to prevent a NULL pointer dereference.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 41b3946..501e16a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2732,6 +2732,9 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 				     hidpp_battery_props,
 				     sizeof(hidpp_battery_props),
 				     GFP_KERNEL);
+	if (!battery_props)
+		return -ENOMEM;
+
 	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 2;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE)
-- 
2.5.0
