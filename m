From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] input: of_touchscreen: Preserve flags passed into touchscreen_parse_properties
Date: Fri,  9 Dec 2016 11:35:19 +0100
Message-ID: <20161209103522.3833-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932349AbcLIKf0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 05:35:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

touchscreen_parse_properties preserves the exisiting max and fuzz
values for axis if not specified as a device_property.

But it would set invert_x / invert_y / swap_x_y to false when
not specified as a device_property, rather then preserving them,
this is not consistent.

All current users of touchscreen_parse_properties pass in a kzalloc-ed
struct touchscreen_properties (or NULL), so preserving the existing
value for these flags preserves existing behavior.

Allowing a caller of touchscreen_parse_properties to set one of these
flags beforehand is useful on ACPI based tablets, where the ACPI
touchscreen node often only contains info on the gpio and the irq
and is missing any info on the axis. In this case drivers may want
to fill in some of these values based on e.g. DMI identification
if a specific model tablet before calling touchscreen_parse_properties.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/of_touchscreen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index 8d7f9c8..180a334 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -116,12 +116,12 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 
 	prop->max_x = input_abs_get_max(input, axis);
 	prop->max_y = input_abs_get_max(input, axis + 1);
-	prop->invert_x =
-		device_property_read_bool(dev, "touchscreen-inverted-x");
-	prop->invert_y =
-		device_property_read_bool(dev, "touchscreen-inverted-y");
-	prop->swap_x_y =
-		device_property_read_bool(dev, "touchscreen-swapped-x-y");
+	if (device_property_read_bool(dev, "touchscreen-inverted-x"))
+		prop->invert_x = true;
+	if (device_property_read_bool(dev, "touchscreen-inverted-y"))
+		prop->invert_y = true;
+	if (device_property_read_bool(dev, "touchscreen-swapped-x-y"))
+		prop->swap_x_y = true;
 
 	if (prop->swap_x_y)
 		swap(input->absinfo[axis], input->absinfo[axis + 1]);
-- 
2.9.3

