From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 3/4] HID: hid-lg4ff: Introduce a module parameter to disable automatic switch of Logitech gaming wheels from compatibility to native mode. This only applies to multimode wheels.
Date: Wed, 18 Feb 2015 17:59:22 +0100
Message-ID: <1424278763-29072-4-git-send-email-madcatxster@devoid-pointer.net>
References: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Introduce a module parameter to disable automatic switch of Logitech ga=
ming
wheels from compatibility to native mode. This only applies to multimod=
e wheels.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 v3: - Share the module parameter through header file.
     - Create a new "hid-lg4ff.h" header file containing stuff specific=
 to
       hid-lg4ff submodule.
=20
 drivers/hid/hid-lg.c    |  7 +++++++
 drivers/hid/hid-lg.h    | 12 ------------
 drivers/hid/hid-lg4ff.c |  4 +++-
 drivers/hid/hid-lg4ff.h | 18 ++++++++++++++++++
 4 files changed, 28 insertions(+), 13 deletions(-)
 create mode 100644 drivers/hid/hid-lg4ff.h

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index f91ff14..b86c18e 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -27,6 +27,7 @@
 #include "usbhid/usbhid.h"
 #include "hid-ids.h"
 #include "hid-lg.h"
+#include "hid-lg4ff.h"
=20
 #define LG_RDESC		0x001
 #define LG_BAD_RELATIVE_KEYS	0x002
@@ -818,4 +819,10 @@ static struct hid_driver lg_driver =3D {
 };
 module_hid_driver(lg_driver);
=20
+#ifdef CONFIG_LOGIWHEELS_FF
+int lg4ff_no_autoswitch =3D 0;
+module_param_named(lg4ff_no_autoswitch, lg4ff_no_autoswitch, int, S_IR=
UGO);
+MODULE_PARM_DESC(lg4ff_no_autoswitch, "Do not switch multimode wheels =
to their native mode automatically");
+#endif
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index 142ce3f..10dd8f0 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -24,16 +24,4 @@ int lg3ff_init(struct hid_device *hdev);
 static inline int lg3ff_init(struct hid_device *hdev) { return -1; }
 #endif
=20
-#ifdef CONFIG_LOGIWHEELS_FF
-int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field =
*field,
-			     struct hid_usage *usage, __s32 value, struct lg_drv_data *drv_=
data);
-int lg4ff_init(struct hid_device *hdev);
-int lg4ff_deinit(struct hid_device *hdev);
-#else
-static inline int lg4ff_adjust_input_event(struct hid_device *hid, str=
uct hid_field *field,
-					   struct hid_usage *usage, __s32 value, struct lg_drv_data *drv_=
data) { return 0; }
-static inline int lg4ff_init(struct hid_device *hdev) { return -1; }
-static inline int lg4ff_deinit(struct hid_device *hdev) { return -1; }
-#endif
-
 #endif
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index a64a35e..dd30772 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -30,6 +30,7 @@
=20
 #include "usbhid/usbhid.h"
 #include "hid-lg.h"
+#include "hid-lg4ff.h"
 #include "hid-ids.h"
=20
 #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
@@ -803,7 +804,8 @@ static int lg4ff_handle_multimode_wheel(struct hid_=
device *hid, u16 *real_produc
 	/* Switch from "Driving Force" mode to native mode automatically.
 	 * Otherwise keep the wheel in its current mode */
 	if (reported_product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL &&
-	    reported_product_id !=3D *real_product_id) {
+	    reported_product_id !=3D *real_product_id &&
+	    !lg4ff_no_autoswitch) {
 		const struct lg4ff_compat_mode_switch *s;
=20
 		switch (*real_product_id) {
diff --git a/drivers/hid/hid-lg4ff.h b/drivers/hid/hid-lg4ff.h
new file mode 100644
index 0000000..5b6a508
--- /dev/null
+++ b/drivers/hid/hid-lg4ff.h
@@ -0,0 +1,18 @@
+#ifndef __HID_LG4FF_H
+#define __HID_LG4FF_H
+
+#ifdef CONFIG_LOGIWHEELS_FF
+extern int lg4ff_no_autoswitch; /* From hid-lg.c */
+
+int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field =
*field,
+			     struct hid_usage *usage, __s32 value, struct lg_drv_data *drv_=
data);
+int lg4ff_init(struct hid_device *hdev);
+int lg4ff_deinit(struct hid_device *hdev);
+#else
+static inline int lg4ff_adjust_input_event(struct hid_device *hid, str=
uct hid_field *field,
+					   struct hid_usage *usage, __s32 value, struct lg_drv_data *drv_=
data) { return 0; }
+static inline int lg4ff_init(struct hid_device *hdev) { return -1; }
+static inline int lg4ff_deinit(struct hid_device *hdev) { return -1; }
+#endif
+
+#endif
--=20
2.3.0
