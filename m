From: Stefan Achatz <stefan_achatz@web.de>
Subject: [PATCH 6/7] HID: roccat: Deprecated some Koneplus sysfs attributes
Date: Sun, 11 Nov 2012 06:21:15 +0100
Message-ID: <1352611275.2463.226.camel@neuromancer.tessier-ashpool>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Introduced attribute "control" and made profile_settings and profile_buttons
readable, which makes profile[1-5]_settings and profile[1-5]_buttons obsolete.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 .../ABI/obsolete/sysfs-driver-hid-roccat-koneplus  |   27 ++++++++++++++++++
 .../ABI/testing/sysfs-driver-hid-roccat-koneplus   |   29 +++-----------------
 drivers/hid/hid-roccat-koneplus.c                  |   10 ++++---
 drivers/hid/hid-roccat-koneplus.h                  |    2 +
 4 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus
index 22568b4..833fd59 100644
--- a/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus
+++ b/Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus
@@ -8,6 +8,7 @@ Description:	The integer value of this attribute ranges from 0-4.
 		When written, this file sets the number of the startup profile
 		and the mouse activates this profile immediately.
 		Please use actual_profile, it does the same thing.
+Users:		http://roccat.sourceforge.net
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/firmware_version
 Date:		October 2010
@@ -19,3 +20,29 @@ Description:	When read, this file returns the raw integer version number of the
 		left. E.g. a returned value of 121 means 1.21
 		This file is readonly.
 		Please read binary attribute info which contains firmware version.
+Users:		http://roccat.sourceforge.net
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/profile[1-5]_buttons
+Date:		August 2010
+Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
+Description:	The mouse can store 5 profiles which can be switched by the
+		press of a button. A profile is split in settings and buttons.
+		profile_buttons holds information about button layout.
+		When read, these files return the respective profile buttons.
+		The returned data is 77 bytes in size.
+		This file is readonly.
+		Write control to select profile and read profile_buttons instead.
+Users:		http://roccat.sourceforge.net
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/profile[1-5]_settings
+Date:		August 2010
+Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
+Description:	The mouse can store 5 profiles which can be switched by the
+		press of a button. A profile is split in settings and buttons.
+		profile_settings holds information like resolution, sensitivity
+		and light effects.
+		When read, these files return the respective profile settings.
+		The returned data is 43 bytes in size.
+		This file is readonly.
+		Write control to select profile and read profile_settings instead.
+Users:		http://roccat.sourceforge.net
\ No newline at end of file
diff --git a/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus b/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus
index ed1213d..1a126ed 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus
+++ b/Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus
@@ -39,18 +39,8 @@ Description:	The mouse can store 5 profiles which can be switched by the
 		The mouse will reject invalid data.
 		Which profile to write is determined by the profile number
 		contained in the data.
-		This file is writeonly.
-Users:		http://roccat.sourceforge.net
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/profile[1-5]_buttons
-Date:		August 2010
-Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
-Description:	The mouse can store 5 profiles which can be switched by the
-		press of a button. A profile is split in settings and buttons.
-		profile_buttons holds information about button layout.
-		When read, these files return the respective profile buttons.
-		The returned data is 77 bytes in size.
-		This file is readonly.
+		Before reading this file, control has to be written to select
+		which profile to read.
 Users:		http://roccat.sourceforge.net
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/profile_settings
@@ -65,19 +55,8 @@ Description:	The mouse can store 5 profiles which can be switched by the
 		The mouse will reject invalid data.
 		Which profile to write is determined by the profile number
 		contained in the data.
-		This file is writeonly.
-Users:		http://roccat.sourceforge.net
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/profile[1-5]_settings
-Date:		August 2010
-Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
-Description:	The mouse can store 5 profiles which can be switched by the
-		press of a button. A profile is split in settings and buttons.
-		profile_settings holds information like resolution, sensitivity
-		and light effects.
-		When read, these files return the respective profile settings.
-		The returned data is 43 bytes in size.
-		This file is readonly.
+		Before reading this file, control has to be written to select
+		which profile to read.
 Users:		http://roccat.sourceforge.net
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/koneplus/roccatkoneplus<minor>/sensor
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 9fe4450..6a48fa3 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -177,14 +177,15 @@ KONEPLUS_SYSFS_R(thingy, THINGY)
 	.write = koneplus_sysfs_write_ ## thingy \
 }
 
+KONEPLUS_SYSFS_W(control, CONTROL)
 KONEPLUS_SYSFS_RW(info, INFO)
 KONEPLUS_SYSFS_W(talk, TALK)
 KONEPLUS_SYSFS_W(macro, MACRO)
 KONEPLUS_SYSFS_RW(sensor, SENSOR)
 KONEPLUS_SYSFS_RW(tcu, TCU)
 KONEPLUS_SYSFS_R(tcu_image, TCU_IMAGE)
-KONEPLUS_SYSFS_W(profile_settings, PROFILE_SETTINGS)
-KONEPLUS_SYSFS_W(profile_buttons, PROFILE_BUTTONS)
+KONEPLUS_SYSFS_RW(profile_settings, PROFILE_SETTINGS)
+KONEPLUS_SYSFS_RW(profile_buttons, PROFILE_BUTTONS)
 
 static ssize_t koneplus_sysfs_read_profilex_settings(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
@@ -306,14 +307,15 @@ static struct device_attribute koneplus_attributes[] = {
 };
 
 static struct bin_attribute koneplus_bin_attributes[] = {
+	KONEPLUS_BIN_ATTRIBUTE_W(control, CONTROL),
 	KONEPLUS_BIN_ATTRIBUTE_RW(info, INFO),
 	KONEPLUS_BIN_ATTRIBUTE_W(talk, TALK),
 	KONEPLUS_BIN_ATTRIBUTE_W(macro, MACRO),
 	KONEPLUS_BIN_ATTRIBUTE_RW(sensor, SENSOR),
 	KONEPLUS_BIN_ATTRIBUTE_RW(tcu, TCU),
 	KONEPLUS_BIN_ATTRIBUTE_R(tcu_image, TCU_IMAGE),
-	KONEPLUS_BIN_ATTRIBUTE_W(profile_settings, PROFILE_SETTINGS),
-	KONEPLUS_BIN_ATTRIBUTE_W(profile_buttons, PROFILE_BUTTONS),
+	KONEPLUS_BIN_ATTRIBUTE_RW(profile_settings, PROFILE_SETTINGS),
+	KONEPLUS_BIN_ATTRIBUTE_RW(profile_buttons, PROFILE_BUTTONS),
 	{
 		.attr = { .name = "profile1_settings", .mode = 0440 },
 		.size = KONEPLUS_SIZE_PROFILE_SETTINGS,
diff --git a/drivers/hid/hid-roccat-koneplus.h b/drivers/hid/hid-roccat-koneplus.h
index 563b9d3..d2b55f2 100644
--- a/drivers/hid/hid-roccat-koneplus.h
+++ b/drivers/hid/hid-roccat-koneplus.h
@@ -16,6 +16,7 @@
 
 enum {
 	KONEPLUS_SIZE_ACTUAL_PROFILE = 0x03,
+	KONEPLUS_SIZE_CONTROL = 0x03,
 	KONEPLUS_SIZE_FIRMWARE_WRITE = 0x0402,
 	KONEPLUS_SIZE_INFO = 0x06,
 	KONEPLUS_SIZE_MACRO = 0x0822,
@@ -47,6 +48,7 @@ struct koneplus_info {
 
 enum koneplus_commands {
 	KONEPLUS_COMMAND_ACTUAL_PROFILE = 0x5,
+	KONEPLUS_COMMAND_CONTROL = 0x4,
 	KONEPLUS_COMMAND_PROFILE_SETTINGS = 0x6,
 	KONEPLUS_COMMAND_PROFILE_BUTTONS = 0x7,
 	KONEPLUS_COMMAND_MACRO = 0x8,
-- 
1.7.3.4



