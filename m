From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 3/4] HID: Introduce a module parameter to disable automatic switch of Logitech gaming wheels from compatibility to native mode. This only applies to multimode wheels.
Date: Fri,  6 Feb 2015 17:34:45 +0100
Message-ID: <1423240486-6714-4-git-send-email-madcatxster@devoid-pointer.net>
References: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: simon@mungewell.org, elias.vds@gmail.com, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Introduce a module parameter to disable automatic switch of Logitech ga=
ming
wheels from compatibility to native mode. This only applies to multimod=
e wheels.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>=20
---
 drivers/hid/hid-lg.c    | 6 ++++++
 drivers/hid/hid-lg4ff.c | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index f91ff14..8dae03f 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -818,4 +818,10 @@ static struct hid_driver lg_driver =3D {
 };
 module_hid_driver(lg_driver);
=20
+#ifdef CONFIG_LOGIWHEELS_FF
+extern int lg4ff_no_autoswitch; /* From hid-lg4ff.c */
+module_param_named(lg4ff_no_autoswitch, lg4ff_no_autoswitch, int, S_IR=
UGO);
+MODULE_PARM_DESC(lg4ff_no_autoswitch, "Do not switch multimode wheels =
to their native mode automatically");
+#endif
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index b9c9fe6..cbb000a 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -67,6 +67,7 @@
 #define LG4FF_FFEX_REV_MAJ 0x21
 #define LG4FF_FFEX_REV_MIN 0x00
=20
+int lg4ff_no_autoswitch =3D 0;
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
 static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)=
;
 static ssize_t lg4ff_alternate_modes_show(struct device *dev, struct d=
evice_attribute *attr, char *buf);
@@ -808,7 +809,8 @@ int lg4ff_handle_multimode_wheel(struct hid_device =
*hid, u16 *real_product_id, c
 	/* Switch from "Driving Force" mode to native mode automatically.
 	 * Otherwise keep the wheel in its current mode */
 	if (reported_product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL &&
-	    reported_product_id !=3D *real_product_id) {
+	    reported_product_id !=3D *real_product_id &&
+	    !lg4ff_no_autoswitch) {
 		const struct lg4ff_compat_mode_switch *s;
=20
 		switch (*real_product_id) {
--=20
2.2.2
