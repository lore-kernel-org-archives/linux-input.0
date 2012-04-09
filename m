From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH v2] HID: lg4ff: Take advantage of private driver data
Date: Mon, 09 Apr 2012 09:08:49 +0200
Message-ID: <1649210.pcO5IpzBEF@qosmio-x300>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23429119.Cz5csa3ZSf"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36832 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab2DIHJK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Apr 2012 03:09:10 -0400
Received: by wejx9 with SMTP id x9so2465950wej.19
        for <linux-input@vger.kernel.org>; Mon, 09 Apr 2012 00:09:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org


--nextPart23429119.Cz5csa3ZSf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

this is a revised version of HID: lg4ff: Use Private Data I asked Simon=
 to
submit for me earlier. To recap what the patch is about, it takes advan=
tage
of the changes introduced in my patches from 2011/04/02. lg4ff now call=
s
hid_get/set_drvdata() to read or store device configuration. The way I =
understand
it, this is how all HID drivers store their private data. The change fr=
om the version
that was submitted earlier are removed all occurences of uninitialized_=
var() macro.

Please note that this patch depends on
"[PATCH v4] HID: hid-lg: Allow for custom device-specific properties to=
 be stored in private drv data"
"[PATCH v4] HID: lg4ff: Remove sysfs iface before deallocating memory"

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

---
 drivers/hid/hid-lg4ff.c |   92 ++++++++++++++++++++++-----------------=
--------
 1 file changed, 42 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 1145292..32c173f 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -51,10 +51,7 @@ static ssize_t lg4ff_range_store(struct device *dev,=
 struct device_attribute *at
=20
 static DEVICE_ATTR(range, S_IRWXU | S_IRWXG | S_IRWXO, lg4ff_range_sho=
w, lg4ff_range_store);
=20
-static bool list_inited;
-
 struct lg4ff_device_entry {
-=09char  *device_id;=09/* Use name in respective kobject structure's a=
ddress as the ID */
 =09__u16 range;
 =09__u16 min_range;
 =09__u16 max_range;
@@ -63,8 +60,6 @@ struct lg4ff_device_entry {
 =09void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
-static struct lg4ff_device_entry device_list;
-
 static const signed short lg4ff_wheel_effects[] =3D {
 =09FF_CONSTANT,
 =09FF_AUTOCENTER,
@@ -285,18 +280,20 @@ static void hid_lg4ff_switch_native(struct hid_de=
vice *hid, const struct lg4ff_n
 /* Read current range and display it in terminal */
 static ssize_t lg4ff_range_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
 {
-=09struct lg4ff_device_entry *uninitialized_var(entry);
-=09struct list_head *h;
 =09struct hid_device *hid =3D to_hid_device(dev);
+=09struct lg4ff_device_entry *entry;
+=09struct lg_drv_data *drv_data;
 =09size_t count;
=20
-=09list_for_each(h, &device_list.list) {
-=09=09entry =3D list_entry(h, struct lg4ff_device_entry, list);
-=09=09if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0)
-=09=09=09break;
+=09drv_data =3D hid_get_drvdata(hid);
+=09if (!drv_data) {
+=09=09hid_err(hid, "Private driver data not found!\n");
+=09=09return 0;
 =09}
-=09if (h =3D=3D &device_list.list) {
-=09=09dbg_hid("Device not found!");
+
+=09entry =3D drv_data->device_props;
+=09if (!entry) {
+=09=09hid_err(hid, "Device properties not found!\n");
 =09=09return 0;
 =09}
=20
@@ -308,19 +305,21 @@ static ssize_t lg4ff_range_show(struct device *de=
v, struct device_attribute *att
  * according to the type of the wheel */
 static ssize_t lg4ff_range_store(struct device *dev, struct device_att=
ribute *attr, const char *buf, size_t count)
 {
-=09struct lg4ff_device_entry *uninitialized_var(entry);
-=09struct list_head *h;
 =09struct hid_device *hid =3D to_hid_device(dev);
+=09struct lg4ff_device_entry *entry;
+=09struct lg_drv_data *drv_data;
 =09__u16 range =3D simple_strtoul(buf, NULL, 10);
=20
-=09list_for_each(h, &device_list.list) {
-=09=09entry =3D list_entry(h, struct lg4ff_device_entry, list);
-=09=09if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0)
-=09=09=09break;
+=09drv_data =3D hid_get_drvdata(hid);
+=09if (!drv_data) {
+=09=09hid_err(hid, "Private driver data not found!\n");
+=09=09return 0;
 =09}
-=09if (h =3D=3D &device_list.list) {
-=09=09dbg_hid("Device not found!");
-=09=09return count;
+
+=09entry =3D drv_data->device_props;
+=09if (!entry) {
+=09=09hid_err(hid, "Device properties not found!\n");
+=09=09return 0;
 =09}
=20
 =09if (range =3D=3D 0)
@@ -344,6 +343,7 @@ int lg4ff_init(struct hid_device *hid)
 =09struct hid_report *report;
 =09struct hid_field *field;
 =09struct lg4ff_device_entry *entry;
+=09struct lg_drv_data *drv_data;
 =09struct usb_device_descriptor *udesc;
 =09int error, i, j;
 =09__u16 bcdDevice, rev_maj, rev_min;
@@ -423,28 +423,24 @@ int lg4ff_init(struct hid_device *hid)
 =09=09dev->ff->set_autocenter(dev, 0);
 =09}
=20
-=09=09/* Initialize device_list if this is the first device to handle =
by lg4ff */
-=09if (!list_inited) {
-=09=09INIT_LIST_HEAD(&device_list.list);
-=09=09list_inited =3D 1;
+=09/* Get private driver data */
+=09drv_data =3D hid_get_drvdata(hid);
+=09if (!drv_data) {
+=09=09hid_err(hid, "Cannot add device, private driver data not allocat=
ed\n");
+=09=09return -1;
 =09}
=20
-=09/* Add the device to device_list */
+=09/* Initialize device properties */
 =09entry =3D kzalloc(sizeof(struct lg4ff_device_entry), GFP_KERNEL);
 =09if (!entry) {
-=09=09hid_err(hid, "Cannot add device, insufficient memory.\n");
-=09=09return -ENOMEM;
-=09}
-=09entry->device_id =3D kstrdup((&hid->dev)->kobj.name, GFP_KERNEL);
-=09if (!entry->device_id) {
-=09=09hid_err(hid, "Cannot set device_id, insufficient memory.\n");
-=09=09kfree(entry);
+=09=09hid_err(hid, "Cannot add device, insufficient memory to allocate=
 device properties.\n");
 =09=09return -ENOMEM;
 =09}
+=09drv_data->device_props =3D entry;
+
 =09entry->min_range =3D lg4ff_devices[i].min_range;
 =09entry->max_range =3D lg4ff_devices[i].max_range;
 =09entry->set_range =3D lg4ff_devices[i].set_range;
-=09list_add(&entry->list, &device_list.list);
=20
 =09/* Create sysfs interface */
 =09error =3D device_create_file(&hid->dev, &dev_attr_range);
@@ -463,27 +459,23 @@ int lg4ff_init(struct hid_device *hid)
=20
 int lg4ff_deinit(struct hid_device *hid)
 {
-=09bool found =3D 0;
 =09struct lg4ff_device_entry *entry;
-=09struct list_head *h, *g;
-=09
+=09struct lg_drv_data *drv_data;
+
 =09device_remove_file(&hid->dev, &dev_attr_range);
=20
-=09list_for_each_safe(h, g, &device_list.list) {
-=09=09entry =3D list_entry(h, struct lg4ff_device_entry, list);
-=09=09if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0) {=

-=09=09=09list_del(h);
-=09=09=09kfree(entry->device_id);
-=09=09=09kfree(entry);
-=09=09=09found =3D 1;
-=09=09=09break;
-=09=09}
+=09drv_data =3D hid_get_drvdata(hid);
+=09if (!drv_data) {
+=09=09hid_err(hid, "Error while deinitializing device, no private driv=
er data.\n");
+=09=09return -1;
 =09}
-
-=09if (!found) {
-=09=09hid_err(hid, "Device entry not found!\n");
+=09entry =3D drv_data->device_props;
+=09if (!entry) {
+=09=09hid_err(hid, "Error while deinitializing device, no device prope=
rties data.\n");
 =09=09return -1;
 =09}
+=09/* Deallocate memory */
+=09kfree(entry);
=20
 =09dbg_hid("Device successfully unregistered\n");
 =09return 0;
--=20
1.7.9.6


--nextPart23429119.Cz5csa3ZSf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJPgosMAAoJEERrVaOJCK16BxYH/jh2Kn4hZSNlyr1Cj2wUrkeI
qoGei1PcjN3gJWWjeh4PUQDvqqt+wIB6mN8gfPW4vdJ+0P1vVDFviSNwRuVVvzAD
Emgbwvvp/DenWkAVOow6MfCRuiJGne5VI2wI+ZTSM3W/qB9C5Q+/X1vKNqF/59h5
27NEc5I3m3eGxzbr/9qAOsBCyHz+yehiOZ+pOUnG32sRpfV0u+f6eBgcd+aAsraF
TQxeKv7uMKUMWrUBnVPfbRP7N0zb9/TeN2rIyq8GjFTkDElamW48n5mbnLx1/pIs
+CuU2uNwuWokzRXOTD1iTVB3pjBTcdKOwenYY3NsxDCGpVIsHlUcuApF32eTpuA=
=AyEV
-----END PGP SIGNATURE-----

--nextPart23429119.Cz5csa3ZSf--

