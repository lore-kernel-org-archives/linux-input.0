From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 09/12] HID: hid-lg4ff: Constify those members of lg4ff_device_entry struct whose value is not supposed to change.
Date: Sat, 21 Mar 2015 12:47:39 +0100
Message-ID: <1426938462-884-10-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Prevent accidental modifications of read-only members of the lg4ff_devi=
ce_entry
struct.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 54 +++++++++++++++++++++++++++++++++++------=
--------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index fd6f140..ad959e2 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -72,18 +72,18 @@ static void lg4ff_set_range_dfp(struct hid_device *=
hid, u16 range);
 static void lg4ff_set_range_g25(struct hid_device *hid, u16 range);
=20
 struct lg4ff_wheel_data {
-	u32 product_id;
+	const u32 product_id;
 	u16 range;
-	u16 min_range;
-	u16 max_range;
+	const u16 min_range;
+	const u16 max_range;
 #ifdef CONFIG_LEDS_CLASS
 	u8  led_state;
 	struct led_classdev *led[5];
 #endif
-	u32 alternate_modes;
-	const char *real_tag;
-	const char *real_name;
-	u16 real_product_id;
+	const u32 alternate_modes;
+	const char * const real_tag;
+	const char * const real_name;
+	const u16 real_product_id;
=20
 	void (*set_range)(struct hid_device *hid, u16 range);
 };
@@ -300,6 +300,34 @@ int lg4ff_adjust_input_event(struct hid_device *hi=
d, struct hid_field *field,
 	}
 }
=20
+static void lg4ff_init_wheel_data(struct lg4ff_wheel_data * const wdat=
a, const struct lg4ff_wheel *wheel,
+				  const struct lg4ff_multimode_wheel *mmode_wheel,
+				  const u16 real_product_id)
+{
+	u32 alternate_modes =3D 0;
+	const char *real_tag =3D NULL;
+	const char *real_name =3D NULL;
+
+	if (mmode_wheel) {
+		alternate_modes =3D mmode_wheel->alternate_modes;
+		real_tag =3D mmode_wheel->real_tag;
+		real_name =3D mmode_wheel->real_name;
+	}
+
+	{
+		struct lg4ff_wheel_data t_wdata =3D  { .product_id =3D wheel->produc=
t_id,
+						     .real_product_id =3D real_product_id,
+						     .min_range =3D wheel->min_range,
+						     .max_range =3D wheel->max_range,
+						     .set_range =3D wheel->set_range,
+						     .alternate_modes =3D alternate_modes,
+						     .real_tag =3D real_tag,
+						     .real_name =3D real_name };
+
+		memcpy(wdata, &t_wdata, sizeof(t_wdata));
+	}
+}
+
 static int lg4ff_play(struct input_dev *dev, void *data, struct ff_eff=
ect *effect)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
@@ -1101,6 +1129,7 @@ int lg4ff_init(struct hid_device *hid)
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
 	const struct usb_device_descriptor *udesc =3D &(hid_to_usb_dev(hid)->=
descriptor);
 	const u16 bcdDevice =3D le16_to_cpu(udesc->bcdDevice);
+	const struct lg4ff_multimode_wheel *mmode_wheel =3D NULL;
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
 	int error, i, j;
@@ -1174,17 +1203,12 @@ int lg4ff_init(struct hid_device *hid)
 	if (error)
 		goto err_init;
=20
-	entry->wdata.product_id =3D lg4ff_devices[i].product_id;
-	entry->wdata.real_product_id =3D real_product_id;
-	entry->wdata.min_range =3D lg4ff_devices[i].min_range;
-	entry->wdata.max_range =3D lg4ff_devices[i].max_range;
-	entry->wdata.set_range =3D lg4ff_devices[i].set_range;
+	/* Initialize device properties */
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
 		BUG_ON(mmode_idx =3D=3D -1);
-		entry->wdata.alternate_modes =3D lg4ff_multimode_wheels[mmode_idx].a=
lternate_modes;
-		entry->wdata.real_tag =3D lg4ff_multimode_wheels[mmode_idx].real_tag=
;
-		entry->wdata.real_name =3D lg4ff_multimode_wheels[mmode_idx].real_na=
me;
+		mmode_wheel =3D &lg4ff_multimode_wheels[mmode_idx];
 	}
+	lg4ff_init_wheel_data(&entry->wdata, &lg4ff_devices[i], mmode_wheel, =
real_product_id);
=20
 	/* Check if autocentering is available and
 	 * set the centering force to zero by default */
--=20
2.3.3
