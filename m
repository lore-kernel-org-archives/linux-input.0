From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 2/4] HID: Display the real wheel model and supported alternate modes through sysfs. This applies only to multimode wheels.
Date: Fri,  6 Feb 2015 17:34:44 +0100
Message-ID: <1423240486-6714-3-git-send-email-madcatxster@devoid-pointer.net>
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

Display the real wheel model and supported alternate modes through sysf=
s. This
applies only to multimode wheels.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>=20
---
 drivers/hid/hid-lg4ff.c | 209 ++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 202 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 3a9de73..b9c9fe6 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -34,19 +34,51 @@
=20
 #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
=20
-#define LG4FF_MMODE_DONE 0
+#define LG4FF_MMODE_IS_MULTIMODE 0
 #define LG4FF_MMODE_SWITCHED 1
 #define LG4FF_MMODE_NOT_MULTIMODE 2
=20
+#define LG4FF_MODE_NATIVE_IDX 0
+#define LG4FF_MODE_DFEX_IDX 1
+#define LG4FF_MODE_DFP_IDX 2
+#define LG4FF_MODE_G25_IDX 3
+#define LG4FF_MODE_DFGT_IDX 4
+#define LG4FF_MODE_G27_IDX 5
+#define LG4FF_MODE_MAX_IDX 6
+
+#define LG4FF_MODE_NATIVE BIT(LG4FF_MODE_NATIVE_IDX)
+#define LG4FF_MODE_DFEX BIT(LG4FF_MODE_DFEX_IDX)
+#define LG4FF_MODE_DFP BIT(LG4FF_MODE_DFP_IDX)
+#define LG4FF_MODE_G25 BIT(LG4FF_MODE_G25_IDX)
+#define LG4FF_MODE_DFGT BIT(LG4FF_MODE_DFGT_IDX)
+#define LG4FF_MODE_G27 BIT(LG4FF_MODE_G27_IDX)
+
+#define LG4FF_DFEX_TAG "DF-EX"
+#define LG4FF_DFEX_NAME "Driving Force / Formula EX"
+#define LG4FF_DFP_TAG "DFP"
+#define LG4FF_DFP_NAME "Driving Force Pro"
+#define LG4FF_G25_TAG "G25"
+#define LG4FF_G25_NAME "G25 Racing Wheel"
+#define LG4FF_G27_TAG "G27"
+#define LG4FF_G27_NAME "G27 Racing Wheel"
+#define LG4FF_DFGT_TAG "DFGT"
+#define LG4FF_DFGT_NAME "Driving Force GT"
+
 #define LG4FF_FFEX_REV_MAJ 0x21
 #define LG4FF_FFEX_REV_MIN 0x00
=20
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
 static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)=
;
+static ssize_t lg4ff_alternate_modes_show(struct device *dev, struct d=
evice_attribute *attr, char *buf);
+static ssize_t lg4ff_alternate_modes_store(struct device *dev, struct =
device_attribute *attr, const char *buf, size_t count);
 static ssize_t lg4ff_range_show(struct device *dev, struct device_attr=
ibute *attr, char *buf);
 static ssize_t lg4ff_range_store(struct device *dev, struct device_att=
ribute *attr, const char *buf, size_t count);
+static ssize_t lg4ff_real_id_show(struct device *dev, struct device_at=
tribute *attr, char *buf);
+static ssize_t lg4ff_real_id_store(struct device *dev, struct device_a=
ttribute *attr, const char *buf, size_t count);
=20
+static DEVICE_ATTR(alternate_modes, S_IRUSR | S_IWUSR | S_IRGRP | S_IW=
GRP | S_IROTH, lg4ff_alternate_modes_show, lg4ff_alternate_modes_store)=
;
 static DEVICE_ATTR(range, S_IRWXU | S_IRWXG | S_IROTH, lg4ff_range_sho=
w, lg4ff_range_store);
+static DEVICE_ATTR(real_id, S_IRUGO, lg4ff_real_id_show, lg4ff_real_id=
_store);
=20
 struct lg4ff_device_entry {
 	__u32 product_id;
@@ -57,6 +89,10 @@ struct lg4ff_device_entry {
 	__u8  led_state;
 	struct led_classdev *led[5];
 #endif
+	u32 alternate_modes;
+	const char *real_tag;
+	const char *real_name;
+	u16 real_product_id;
 	struct list_head list;
 	void (*set_range)(struct hid_device *hid, u16 range);
 };
@@ -91,6 +127,19 @@ struct lg4ff_wheel_ident_checklist {
 	const struct lg4ff_wheel_ident_info *models[];
 };
=20
+struct lg4ff_multimode_wheel {
+	const u16 product_id;
+	const u32 alternate_modes;
+	const char *real_tag;
+	const char *real_name;
+};
+
+struct lg4ff_alternate_mode {
+	const u16 product_id;
+	const char *tag;
+	const char *name;
+};
+
 static const struct lg4ff_wheel lg4ff_devices[] =3D {
 	{USB_DEVICE_ID_LOGITECH_WHEEL,       lg4ff_wheel_effects, 40, 270, NU=
LL},
 	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  lg4ff_wheel_effects, 40, 270, NU=
LL},
@@ -102,6 +151,30 @@ static const struct lg4ff_wheel lg4ff_devices[] =3D=
 {
 	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270, NU=
LL}
 };
=20
+static const struct lg4ff_multimode_wheel lg4ff_multimode_wheels[] =3D=
 {
+	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,
+	 LG4FF_MODE_NATIVE | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
+	 LG4FF_DFP_TAG, LG4FF_DFP_NAME},
+	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,
+	 LG4FF_MODE_NATIVE | LG4FF_MODE_G25 | LG4FF_MODE_DFP | LG4FF_MODE_DFE=
X,
+	 LG4FF_G25_TAG, LG4FF_G25_NAME},
+	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,
+	 LG4FF_MODE_NATIVE | LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DF=
EX,
+	 LG4FF_DFGT_TAG, LG4FF_DFGT_NAME},
+	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,
+	 LG4FF_MODE_NATIVE | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFP=
 | LG4FF_MODE_DFEX,
+	 LG4FF_G27_TAG, LG4FF_G27_NAME},
+};
+
+static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] =3D {
+	[LG4FF_MODE_NATIVE_IDX] =3D {0, "native", ""},
+	[LG4FF_MODE_DFEX_IDX] =3D {USB_DEVICE_ID_LOGITECH_WHEEL, LG4FF_DFEX_T=
AG, LG4FF_DFEX_NAME},
+	[LG4FF_MODE_DFP_IDX] =3D {USB_DEVICE_ID_LOGITECH_DFP_WHEEL, LG4FF_DFP=
_TAG, LG4FF_DFP_NAME},
+	[LG4FF_MODE_G25_IDX] =3D {USB_DEVICE_ID_LOGITECH_G25_WHEEL, LG4FF_G25=
_TAG, LG4FF_G25_NAME},
+	[LG4FF_MODE_DFGT_IDX] =3D {USB_DEVICE_ID_LOGITECH_DFGT_WHEEL, LG4FF_D=
=46GT_TAG, LG4FF_DFGT_NAME},
+	[LG4FF_MODE_G27_IDX] =3D {USB_DEVICE_ID_LOGITECH_G27_WHEEL, LG4FF_G27=
_TAG, LG4FF_G27_NAME}
+};
+
 /* Multimode wheel identificators */
 static const struct lg4ff_wheel_ident_info lg4ff_dfp_ident_info =3D {
 	0xf000,
@@ -443,6 +516,60 @@ static int lg4ff_switch_compatibility_mode(struct =
hid_device *hid, const struct
 	return 0;
 }
=20
+static ssize_t lg4ff_alternate_modes_show(struct device *dev, struct d=
evice_attribute *attr, char *buf)
+{
+	struct hid_device *hid =3D to_hid_device(dev);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	ssize_t count =3D 0;
+	int i;
+
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return 0;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return 0;
+	}
+
+	if (!entry->real_name) {
+		hid_err(hid, "NULL pointer to string\n");
+		return 0;
+	}
+
+	for (i =3D 0; i < LG4FF_MODE_MAX_IDX; i++) {
+		if (entry->alternate_modes & BIT(i)) {
+			/* Print tag and full name */
+			count +=3D scnprintf(buf + count, PAGE_SIZE - count, "%s: %s",
+					   lg4ff_alternate_modes[i].tag,
+					   !lg4ff_alternate_modes[i].product_id ? entry->real_name : lg4f=
f_alternate_modes[i].name);
+			if (count >=3D PAGE_SIZE - 1)
+				return count;
+
+			/* Mark the currently active mode with an asterisk */
+			if (lg4ff_alternate_modes[i].product_id =3D=3D entry->product_id ||
+			    (lg4ff_alternate_modes[i].product_id =3D=3D 0 && entry->product=
_id =3D=3D entry->real_product_id))
+				count +=3D scnprintf(buf + count, PAGE_SIZE - count, " *\n");
+			else
+				count +=3D scnprintf(buf + count, PAGE_SIZE - count, "\n");
+
+			if (count >=3D PAGE_SIZE - 1)
+				return count;
+		}
+	}
+
+	return count;
+}
+
+static ssize_t lg4ff_alternate_modes_store(struct device *dev, struct =
device_attribute *attr, const char *buf, size_t count)
+{
+	return -ENOSYS;
+}
+
 /* Read current range and display it in terminal */
 static ssize_t lg4ff_range_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
 {
@@ -501,6 +628,40 @@ static ssize_t lg4ff_range_store(struct device *de=
v, struct device_attribute *at
 	return count;
 }
=20
+static ssize_t lg4ff_real_id_show(struct device *dev, struct device_at=
tribute *attr, char *buf)
+{
+	struct hid_device *hid =3D to_hid_device(dev);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	size_t count;
+
+	drv_data =3D hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return 0;
+	}
+
+	entry =3D drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return 0;
+	}
+
+	if (!entry->real_tag || !entry->real_name) {
+		hid_err(hid, "NULL pointer to string\n");
+		return 0;
+	}
+
+	count =3D scnprintf(buf, PAGE_SIZE, "%s: %s\n", entry->real_tag, entr=
y->real_name);
+	return count;
+}
+
+static ssize_t lg4ff_real_id_store(struct device *dev, struct device_a=
ttribute *attr, const char *buf, size_t count)
+{
+	/* Real ID is a read-only value */
+	return -EPERM;
+}
+
 #ifdef CONFIG_LEDS_CLASS
 static void lg4ff_set_leds(struct hid_device *hid, __u8 leds)
 {
@@ -665,7 +826,7 @@ int lg4ff_handle_multimode_wheel(struct hid_device =
*hid, u16 *real_product_id, c
 			break;
 		default:
 			hid_err(hid, "Invalid product id %X\n", *real_product_id);
-			return LG4FF_MMODE_DONE;
+			return LG4FF_MMODE_NOT_MULTIMODE;
 		}
=20
 		ret =3D lg4ff_switch_compatibility_mode(hid, s);
@@ -673,12 +834,12 @@ int lg4ff_handle_multimode_wheel(struct hid_devic=
e *hid, u16 *real_product_id, c
 			/* Wheel could not have been switched to native mode,
 			 * leave it in "Driving Force" mode and continue */
 			hid_err(hid, "Unable to switch wheel mode, errno %d\n", ret);
-			return LG4FF_MMODE_DONE;
+			return LG4FF_MMODE_IS_MULTIMODE;
 		}
 		return LG4FF_MMODE_SWITCHED;
 	}
=20
-	return LG4FF_MMODE_DONE;
+	return LG4FF_MMODE_IS_MULTIMODE;
 }
=20
=20
@@ -690,7 +851,8 @@ int lg4ff_init(struct hid_device *hid)
 	const u16 bcdDevice =3D le16_to_cpu(udesc->bcdDevice);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-	int error, i, j, ret;
+	int error, i, j;
+	int mmode_ret, mmode_idx =3D -1;
 	u16 real_product_id;
=20
 	/* Check that the report looks ok */
@@ -699,12 +861,12 @@ int lg4ff_init(struct hid_device *hid)
=20
 	/* Check if a multimode wheel has been connected and
 	 * handle it appropriately */
-	ret =3D lg4ff_handle_multimode_wheel(hid, &real_product_id, bcdDevice=
);
+	mmode_ret =3D lg4ff_handle_multimode_wheel(hid, &real_product_id, bcd=
Device);
=20
 	/* Wheel has been told to switch to native mode. There is no point in=
 going on
 	 * with the initialization as the wheel will do a USB reset when it s=
witches mode
 	 */
-	if (ret =3D=3D LG4FF_MMODE_SWITCHED)
+	if (mmode_ret =3D=3D LG4FF_MMODE_SWITCHED)
 		return 0;
=20
 	/* Check what wheel has been connected */
@@ -721,6 +883,18 @@ int lg4ff_init(struct hid_device *hid)
 		return -1;
 	}
=20
+	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
+		for (mmode_idx =3D 0; mmode_idx < ARRAY_SIZE(lg4ff_multimode_wheels)=
; mmode_idx++) {
+			if (real_product_id =3D=3D lg4ff_multimode_wheels[mmode_idx].produc=
t_id)
+				break;
+		}
+
+		if (mmode_idx =3D=3D ARRAY_SIZE(lg4ff_multimode_wheels)) {
+			hid_err(hid, "Device product ID %X is not listed as a multimode whe=
el", real_product_id);
+			return -1;
+		}
+	}
+
 	/* Set supported force feedback capabilities */
 	for (j =3D 0; lg4ff_devices[i].ff_effects[j] >=3D 0; j++)
 		set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);
@@ -746,9 +920,16 @@ int lg4ff_init(struct hid_device *hid)
 	drv_data->device_props =3D entry;
=20
 	entry->product_id =3D lg4ff_devices[i].product_id;
+	entry->real_product_id =3D real_product_id;
 	entry->min_range =3D lg4ff_devices[i].min_range;
 	entry->max_range =3D lg4ff_devices[i].max_range;
 	entry->set_range =3D lg4ff_devices[i].set_range;
+	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
+		BUG_ON(mmode_idx =3D=3D -1);
+		entry->alternate_modes =3D lg4ff_multimode_wheels[mmode_idx].alterna=
te_modes;
+		entry->real_tag =3D lg4ff_multimode_wheels[mmode_idx].real_tag;
+		entry->real_name =3D lg4ff_multimode_wheels[mmode_idx].real_name;
+	}
=20
 	/* Check if autocentering is available and
 	 * set the centering force to zero by default */
@@ -767,6 +948,14 @@ int lg4ff_init(struct hid_device *hid)
 	error =3D device_create_file(&hid->dev, &dev_attr_range);
 	if (error)
 		return error;
+	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
+		error =3D device_create_file(&hid->dev, &dev_attr_real_id);
+		if (error)
+			return error;
+		error =3D device_create_file(&hid->dev, &dev_attr_alternate_modes);
+		if (error)
+			return error;
+	}
 	dbg_hid("sysfs interface created\n");
=20
 	/* Set the maximum range to start with */
@@ -845,6 +1034,12 @@ int lg4ff_deinit(struct hid_device *hid)
=20
 	device_remove_file(&hid->dev, &dev_attr_range);
=20
+	/* Multimode devices will have at least the "MODE_NATIVE" bit set */
+	if (entry->alternate_modes) {
+		device_remove_file(&hid->dev, &dev_attr_real_id);
+		device_remove_file(&hid->dev, &dev_attr_alternate_modes);
+	}
+
 #ifdef CONFIG_LEDS_CLASS
 	{
 		int j;
--=20
2.2.2
