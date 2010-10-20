From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 4/4] Detect the WiFi/Bluetooth/3G devices available
Date: Tue, 19 Oct 2010 22:12:15 -0600
Message-ID: <4CBF06CF0200002300022595@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: corentin.chary@gmail.com, Greg Kroah-Hartman <GregKH@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Dmitry,=20

Thank's for your review.

=E6=96=BC =E4=B8=80=EF=BC=8C2010-10-18 =E6=96=BC 08:55 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi,
>=20
> On Mon, Oct 18, 2010 at 11:07:43PM +0800, Lee, Chun-Yi wrote:
> > +static void type_aa_dmi_decode(const struct dmi_header *header, vo=
id *dummy)
> > +{
> > +	/* We are looking for OEM-specific Type Aah */
> > +	if (header->type !=3D ACER_DMI_DEV_TYPE_AA)
> > +		return;
> > +
> > +	type_aa =3D (struct hotkey_function_type_aa *) header;
> > +
> > +	printk(ACER_INFO "Function biti map for Communication Button: 0x%=
x\n",
> > +		type_aa->commun_func_bitmap);
> > +	if (!!(type_aa->commun_func_bitmap & ACER_WMID3_GDS_WIRELESS))
> > +		interface->capability |=3D ACER_CAP_WIRELESS;
> > +	if (!!(type_aa->commun_func_bitmap & ACER_WMID3_GDS_THREEG))
> > +		interface->capability |=3D ACER_CAP_THREEG;
> > +	if (!!(type_aa->commun_func_bitmap & ACER_WMID3_GDS_BLUETOOTH))
> > +		interface->capability |=3D ACER_CAP_BLUETOOTH;
>=20
> The "!!" is completely redundant here.
>=20

Sorry my fail, removed.

> > +}
> > +
> >  static acpi_status WMID_set_capabilities(void)
> >  {
> >  	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
> > @@ -844,16 +875,17 @@ static acpi_status WMID_set_capabilities(void=
)
> >  		return AE_ERROR;
> >  	}
> > =20
> > -	/* Not sure on the meaning of the relevant bits yet to detect the=
se */
> > -	interface->capability |=3D ACER_CAP_WIRELESS;
> > -	interface->capability |=3D ACER_CAP_THREEG;
> > +	dmi_walk(type_aa_dmi_decode, NULL);
> > +	if (!type_aa) {
> > +		interface->capability |=3D ACER_CAP_WIRELESS;
> > +		interface->capability |=3D ACER_CAP_THREEG;
> > +		if (devices & 0x10)
> > +			interface->capability |=3D ACER_CAP_BLUETOOTH;
> > +	}
>=20
> Since you are storing "type_aa" anyways it probably would be better t=
o
> set all capabilities here, in one place...
>=20

=46ollow your suggestion to modified the patch like following:


>From ca67b42b36dea9b5e8d3ac8560f29622447ea470 Mon Sep 17 00:00:00 2001
=46rom: Lee, Chun-Yi <jlee@novell.com>
Date: Wed, 20 Oct 2010 10:50:46 +0100
Subject: [PATCH 4/4] Detect the WiFi/Bluetooth/3G devices available

Check the Acer OEM-specific Type AA to detect the WiFi/Bluetooth/3G
devices available or not, and set the devices capability flag.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |   50
++++++++++++++++++++++++++++++++------
 1 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c
b/drivers/platform/x86/acer-wmi.c
index 7a17ebe..a5ac42c 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/dmi.h>
=20
 #include <acpi/acpi_drivers.h>
=20
@@ -138,7 +139,9 @@ struct lm_return_value {
 /*
  * GUID3 Get Device Status device flags
  */
-#define ACER_WMID3_GDS_THREEG		(1<<6)	/* 3G */
+#define ACER_WMID3_GDS_WIRELESS           (1<<0)  /* WiFi */
+#define ACER_WMID3_GDS_THREEG             (1<<6)  /* 3G */
+#define ACER_WMID3_GDS_BLUETOOTH          (1<<11) /* BT */
=20
 struct wmid3_gds_input_param {	/* Get Device Status input parameter */
 	u8 function_num;	/* Function Number */
@@ -153,6 +156,15 @@ struct wmid3_gds_return_value {	/* Get Device
Status return value*/
 	u32 reserved;
 } __attribute__((packed));
=20
+#define ACER_DMI_DEV_TYPE_AA		170
+
+struct hotkey_function_type_aa {
+	u8 type;
+	u8 length;
+	u16 handle;
+	u16 commun_func_bitmap;
+} __attribute__((packed));
+
 /*
  * Interface capability flags
  */
@@ -184,6 +196,7 @@ static int brightness =3D -1;
 static int threeg =3D -1;
 static int force_series;
 static bool launch_manager;
+static struct hotkey_function_type_aa *type_aa;
=20
 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -824,6 +837,18 @@ static acpi_status WMID_set_u32(u32 value, u32 cap=
,
struct wmi_interface *iface)
 	return WMI_execute_u32(method_id, (u32)value, NULL);
 }
=20
+static void type_aa_dmi_decode(const struct dmi_header *header, void
*dummy)
+{
+	/* We are looking for OEM-specific Type Aah */
+	if (header->type !=3D ACER_DMI_DEV_TYPE_AA)
+		return;
+
+	type_aa =3D (struct hotkey_function_type_aa *) header;
+
+	printk(ACER_INFO "Function biti map for Communication Button: 0x%x\n"=
,
+		type_aa->commun_func_bitmap);
+}
+
 static acpi_status WMID_set_capabilities(void)
 {
 	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
@@ -844,16 +869,24 @@ static acpi_status WMID_set_capabilities(void)
 		return AE_ERROR;
 	}
=20
-	/* Not sure on the meaning of the relevant bits yet to detect these *=
/
-	interface->capability |=3D ACER_CAP_WIRELESS;
-	interface->capability |=3D ACER_CAP_THREEG;
+	dmi_walk(type_aa_dmi_decode, NULL);
+	if (type_aa) {
+		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_WIRELESS)
+			interface->capability |=3D ACER_CAP_WIRELESS;
+		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_THREEG)
+			interface->capability |=3D ACER_CAP_THREEG;
+		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_BLUETOOTH)
+			interface->capability |=3D ACER_CAP_BLUETOOTH;
+	} else {
+		interface->capability |=3D ACER_CAP_WIRELESS;
+		interface->capability |=3D ACER_CAP_THREEG;
+		if (devices & 0x10)
+			interface->capability |=3D ACER_CAP_BLUETOOTH;
+	}
=20
 	/* WMID always provides brightness methods */
 	interface->capability |=3D ACER_CAP_BRIGHTNESS;
=20
-	if (devices & 0x10)
-		interface->capability |=3D ACER_CAP_BLUETOOTH;
-
 	if (!(devices & 0x20))
 		max_brightness =3D 0x9;
=20
@@ -932,7 +965,8 @@ static void __init acer_commandline_init(void)
 	 * capability isn't available on the given interface
 	 */
 	set_u32(mailled, ACER_CAP_MAILLED);
-	set_u32(threeg, ACER_CAP_THREEG);
+	if (!type_aa)
+		set_u32(threeg, ACER_CAP_THREEG);
 	set_u32(brightness, ACER_CAP_BRIGHTNESS);
 }
=20
--=20
1.6.0.2



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
