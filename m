From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 4/4] Detect the WiFi/Bluetooth/3G devices available
Date: Sat, 30 Oct 2010 10:44:22 -0600
Message-ID: <4CCCE6160200002300022EF9@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, trenn@suse.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add CC. Thomas

=E6=96=BC =E6=97=A5=EF=BC=8C2010-10-31 =E6=96=BC 00:36 +0800=EF=BC=8CLe=
e, Chun-Yi =E6=8F=90=E5=88=B0=EF=BC=9A
> Check the Acer OEM-specific Type AA to detect the WiFi/Bluetooth/3G
> devices available or not, and set the devices capability flag.
>=20
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> ---
>  drivers/platform/x86/acer-wmi.c |   50 +++++++++++++++++++++++++++++=
+++------
>  1 files changed, 42 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/a=
cer-wmi.c
> index 9656464..0247a70 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -39,6 +39,7 @@
>  #include <linux/slab.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
> +#include <linux/dmi.h>
> =20
>  #include <acpi/acpi_drivers.h>
> =20
> @@ -138,7 +139,9 @@ struct lm_return_value {
>  /*
>   * GUID3 Get Device Status device flags
>   */
> -#define ACER_WMID3_GDS_THREEG		(1<<6)	/* 3G */
> +#define ACER_WMID3_GDS_WIRELESS           (1<<0)  /* WiFi */
> +#define ACER_WMID3_GDS_THREEG             (1<<6)  /* 3G */
> +#define ACER_WMID3_GDS_BLUETOOTH          (1<<11) /* BT */
> =20
>  struct wmid3_gds_input_param {	/* Get Device Status input parameter =
*/
>  	u8 function_num;	/* Function Number */
> @@ -153,6 +156,15 @@ struct wmid3_gds_return_value {	/* Get Device St=
atus return value*/
>  	u32 reserved;
>  } __attribute__((packed));
> =20
> +#define ACER_DMI_DEV_TYPE_AA		170
> +
> +struct hotkey_function_type_aa {
> +	u8 type;
> +	u8 length;
> +	u16 handle;
> +	u16 commun_func_bitmap;
> +} __attribute__((packed));
> +
>  /*
>   * Interface capability flags
>   */
> @@ -184,6 +196,7 @@ static int brightness =3D -1;
>  static int threeg =3D -1;
>  static int force_series;
>  static bool ec_raw_mode;
> +static struct hotkey_function_type_aa *type_aa;
> =20
>  module_param(mailled, int, 0444);
>  module_param(brightness, int, 0444);
> @@ -824,6 +837,18 @@ static acpi_status WMID_set_u32(u32 value, u32 c=
ap, struct wmi_interface *iface)
>  	return WMI_execute_u32(method_id, (u32)value, NULL);
>  }
> =20
> +static void type_aa_dmi_decode(const struct dmi_header *header, void=
 *dummy)
> +{
> +	/* We are looking for OEM-specific Type Aah */
> +	if (header->type !=3D ACER_DMI_DEV_TYPE_AA)
> +		return;
> +
> +	type_aa =3D (struct hotkey_function_type_aa *) header;
> +
> +	printk(ACER_INFO "Function biti map for Communication Button: 0x%x\=
n",
> +		type_aa->commun_func_bitmap);
> +}
> +
>  static acpi_status WMID_set_capabilities(void)
>  {
>  	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -844,16 +869,24 @@ static acpi_status WMID_set_capabilities(void)
>  		return AE_ERROR;
>  	}
> =20
> -	/* Not sure on the meaning of the relevant bits yet to detect these=
 */
> -	interface->capability |=3D ACER_CAP_WIRELESS;
> -	interface->capability |=3D ACER_CAP_THREEG;
> +	dmi_walk(type_aa_dmi_decode, NULL);
> +	if (type_aa) {
> +		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_WIRELESS)
> +			interface->capability |=3D ACER_CAP_WIRELESS;
> +		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_THREEG)
> +			interface->capability |=3D ACER_CAP_THREEG;
> +		if (type_aa->commun_func_bitmap & ACER_WMID3_GDS_BLUETOOTH)
> +			interface->capability |=3D ACER_CAP_BLUETOOTH;
> +	} else {
> +		interface->capability |=3D ACER_CAP_WIRELESS;
> +		interface->capability |=3D ACER_CAP_THREEG;
> +		if (devices & 0x10)
> +			interface->capability |=3D ACER_CAP_BLUETOOTH;
> +	}
> =20
>  	/* WMID always provides brightness methods */
>  	interface->capability |=3D ACER_CAP_BRIGHTNESS;
> =20
> -	if (devices & 0x10)
> -		interface->capability |=3D ACER_CAP_BLUETOOTH;
> -
>  	if (!(devices & 0x20))
>  		max_brightness =3D 0x9;
> =20
> @@ -932,7 +965,8 @@ static void __init acer_commandline_init(void)
>  	 * capability isn't available on the given interface
>  	 */
>  	set_u32(mailled, ACER_CAP_MAILLED);
> -	set_u32(threeg, ACER_CAP_THREEG);
> +	if (!type_aa)
> +		set_u32(threeg, ACER_CAP_THREEG);
>  	set_u32(brightness, ACER_CAP_BRIGHTNESS);
>  }
> =20
