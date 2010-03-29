From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH 8/9] Input: topstar-laptop - switch to using sparse keymap library
Date: Mon, 29 Mar 2010 19:19:17 -0300
Message-ID: <201003291919.17554.herton@mandriva.com.br>
References: <20091204060701.28288.91430.stgit@localhost.localdomain> <20091204061236.28288.18526.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091204061236.28288.18526.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>, Anisse Astier <anisse@astier.eu>
List-Id: linux-input@vger.kernel.org

Em Sex 04 Dez 2009, =C3=A0s 04:12:36, Dmitry Torokhov escreveu:
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>=20
>  drivers/platform/x86/Kconfig          |    1=20
>  drivers/platform/x86/topstar-laptop.c |  162 +++++++++++------------=
----------
>  2 files changed, 55 insertions(+), 108 deletions(-)

Hi, I saw this wasn't included in 2.6.34. From my side is ok, I was wit=
hout any
topstar notebook for some time, now I got a sample and tested it too, t=
he patch
is ok, It only needs a rediff now with latest 2.6.34-rc2-gitX

I thought it was going to be included without any ack etc., if needed y=
ou can add:
Acked-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
and tested-by or signed-off if desired.

The rediffed patch for latest 2.6.34 is below:

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
index e631dbe..02d31db 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -455,6 +455,7 @@ config TOPSTAR_LAPTOP
 	tristate "Topstar Laptop Extras"
 	depends on ACPI
 	depends on INPUT
+	select INPUT_SPARSEKMAP
 	---help---
 	  This driver adds support for hotkeys found on Topstar laptops.
=20
diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x=
86/topstar-laptop.c
index 4d6516f..75a8b62 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
=20
 #define ACPI_TOPSTAR_CLASS "topstar"
=20
@@ -25,52 +26,37 @@ struct topstar_hkey {
 	struct input_dev *inputdev;
 };
=20
-struct tps_key_entry {
-	u8 code;
-	u16 keycode;
-};
-
-static struct tps_key_entry topstar_keymap[] =3D {
-	{ 0x80, KEY_BRIGHTNESSUP },
-	{ 0x81, KEY_BRIGHTNESSDOWN },
-	{ 0x83, KEY_VOLUMEUP },
-	{ 0x84, KEY_VOLUMEDOWN },
-	{ 0x85, KEY_MUTE },
-	{ 0x86, KEY_SWITCHVIDEOMODE },
-	{ 0x87, KEY_F13 }, /* touchpad enable/disable key */
-	{ 0x88, KEY_WLAN },
-	{ 0x8a, KEY_WWW },
-	{ 0x8b, KEY_MAIL },
-	{ 0x8c, KEY_MEDIA },
-	{ 0x96, KEY_F14 }, /* G key? */
-	{ }
-};
-
-static struct tps_key_entry *tps_get_key_by_scancode(unsigned int code=
)
-{
-	struct tps_key_entry *key;
-
-	for (key =3D topstar_keymap; key->code; key++)
-		if (code =3D=3D key->code)
-			return key;
+static const struct key_entry topstar_keymap[] =3D {
+	{ KE_KEY, 0x80, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 0x81, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x83, { KEY_VOLUMEUP } },
+	{ KE_KEY, 0x84, { KEY_VOLUMEDOWN } },
+	{ KE_KEY, 0x85, { KEY_MUTE } },
+	{ KE_KEY, 0x86, { KEY_SWITCHVIDEOMODE } },
+	{ KE_KEY, 0x87, { KEY_F13 } }, /* touchpad enable/disable key */
+	{ KE_KEY, 0x88, { KEY_WLAN } },
+	{ KE_KEY, 0x8a, { KEY_WWW } },
+	{ KE_KEY, 0x8b, { KEY_MAIL } },
+	{ KE_KEY, 0x8c, { KEY_MEDIA } },
=20
-	return NULL;
-}
-
-static struct tps_key_entry *tps_get_key_by_keycode(unsigned int code)
-{
-	struct tps_key_entry *key;
+	/* Known non hotkey events don't handled or that we don't care yet */
+	{ KE_IGNORE, 0x8e, },
+	{ KE_IGNORE, 0x8f, },
+	{ KE_IGNORE, 0x90, },
=20
-	for (key =3D topstar_keymap; key->code; key++)
-		if (code =3D=3D key->keycode)
-			return key;
+	/*
+	 * 'G key' generate two event codes, convert to only
+	 * one event/key code for now, consider replacing by
+	 * a switch (3G switch - SW_3G?)
+	 */
+	{ KE_KEY, 0x96, { KEY_F14 } },
+	{ KE_KEY, 0x97, { KEY_F14 } },
=20
-	return NULL;
-}
+	{ KE_END, 0 }
+};
=20
 static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 {
-	struct tps_key_entry *key;
 	static bool dup_evnt[2];
 	bool *dup;
 	struct topstar_hkey *hkey =3D acpi_driver_data(device);
@@ -85,27 +71,8 @@ static void acpi_topstar_notify(struct acpi_device *=
device, u32 event)
 		*dup =3D true;
 	}
=20
-	/*
-	 * 'G key' generate two event codes, convert to only
-	 * one event/key code for now (3G switch?)
-	 */
-	if (event =3D=3D 0x97)
-		event =3D 0x96;
-
-	key =3D tps_get_key_by_scancode(event);
-	if (key) {
-		input_report_key(hkey->inputdev, key->keycode, 1);
-		input_sync(hkey->inputdev);
-		input_report_key(hkey->inputdev, key->keycode, 0);
-		input_sync(hkey->inputdev);
-		return;
-	}
-
-	/* Known non hotkey events don't handled or that we don't care yet */
-	if (event =3D=3D 0x8e || event =3D=3D 0x8f || event =3D=3D 0x90)
-		return;
-
-	pr_info("unknown event =3D 0x%02x\n", event);
+	if (!sparse_keymap_report_event(hkey->inputdev, event, 1, true))
+		pr_info("unknown event =3D 0x%02x\n", event);
 }
=20
 static int acpi_topstar_fncx_switch(struct acpi_device *device, bool s=
tate)
@@ -126,62 +93,41 @@ static int acpi_topstar_fncx_switch(struct acpi_de=
vice *device, bool state)
 	return 0;
 }
=20
-static int topstar_getkeycode(struct input_dev *dev,
-				unsigned int scancode, unsigned int *keycode)
-{
-	struct tps_key_entry *key =3D tps_get_key_by_scancode(scancode);
-
-	if (!key)
-		return -EINVAL;
-
-	*keycode =3D key->keycode;
-	return 0;
-}
-
-static int topstar_setkeycode(struct input_dev *dev,
-				unsigned int scancode, unsigned int keycode)
-{
-	struct tps_key_entry *key;
-	int old_keycode;
-
-	key =3D tps_get_key_by_scancode(scancode);
-
-	if (!key)
-		return -EINVAL;
-
-	old_keycode =3D key->keycode;
-	key->keycode =3D keycode;
-	set_bit(keycode, dev->keybit);
-	if (!tps_get_key_by_keycode(old_keycode))
-		clear_bit(old_keycode, dev->keybit);
-	return 0;
-}
-
 static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
 {
-	struct tps_key_entry *key;
+	struct input_dev *input;
+	int error;
=20
-	hkey->inputdev =3D input_allocate_device();
-	if (!hkey->inputdev) {
+	input =3D input_allocate_device();
+	if (!input) {
 		pr_err("Unable to allocate input device\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
-	hkey->inputdev->name =3D "Topstar Laptop extra buttons";
-	hkey->inputdev->phys =3D "topstar/input0";
-	hkey->inputdev->id.bustype =3D BUS_HOST;
-	hkey->inputdev->getkeycode =3D topstar_getkeycode;
-	hkey->inputdev->setkeycode =3D topstar_setkeycode;
-	for (key =3D topstar_keymap; key->code; key++) {
-		set_bit(EV_KEY, hkey->inputdev->evbit);
-		set_bit(key->keycode, hkey->inputdev->keybit);
+
+	input->name =3D "Topstar Laptop extra buttons";
+	input->phys =3D "topstar/input0";
+	input->id.bustype =3D BUS_HOST;
+
+	error =3D sparse_keymap_setup(input, topstar_keymap, NULL);
+	if (error) {
+		pr_err("Unable to setup input device keymap\n");
+		goto err_free_dev;
 	}
-	if (input_register_device(hkey->inputdev)) {
+
+	error =3D input_register_device(input);
+	if (error) {
 		pr_err("Unable to register input device\n");
-		input_free_device(hkey->inputdev);
-		return -ENODEV;
+		goto err_free_keymap;
 	}
=20
+	hkey->inputdev =3D input;
 	return 0;
+
+ err_free_keymap:
+	sparse_keymap_free(input);
+ err_free_dev:
+	input_free_device(input);
+	return error;
 }
=20
 static int acpi_topstar_add(struct acpi_device *device)
@@ -215,6 +161,7 @@ static int acpi_topstar_remove(struct acpi_device *=
device, int type)
=20
 	acpi_topstar_fncx_switch(device, false);
=20
+	sparse_keymap_free(tps_hkey->inputdev);
 	input_unregister_device(tps_hkey->inputdev);
 	kfree(tps_hkey);
=20



>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
> index e555d39..00e94b0 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -405,6 +405,7 @@ config TOPSTAR_LAPTOP
>  	tristate "Topstar Laptop Extras"
>  	depends on ACPI
>  	depends on INPUT
> +	select INPUT_SPARSEKMAP
>  	---help---
>  	  This driver adds support for hotkeys found on Topstar laptops.
> =20
> diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform=
/x86/topstar-laptop.c
> index 02f3d4e..75a8b62 100644
> --- a/drivers/platform/x86/topstar-laptop.c
> +++ b/drivers/platform/x86/topstar-laptop.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> =20
>  #define ACPI_TOPSTAR_CLASS "topstar"
> =20
> @@ -25,52 +26,37 @@ struct topstar_hkey {
>  	struct input_dev *inputdev;
>  };
> =20
> -struct tps_key_entry {
> -	u8 code;
> -	u16 keycode;
> -};
> -
> -static struct tps_key_entry topstar_keymap[] =3D {
> -	{ 0x80, KEY_BRIGHTNESSUP },
> -	{ 0x81, KEY_BRIGHTNESSDOWN },
> -	{ 0x83, KEY_VOLUMEUP },
> -	{ 0x84, KEY_VOLUMEDOWN },
> -	{ 0x85, KEY_MUTE },
> -	{ 0x86, KEY_SWITCHVIDEOMODE },
> -	{ 0x87, KEY_F13 }, /* touchpad enable/disable key */
> -	{ 0x88, KEY_WLAN },
> -	{ 0x8a, KEY_WWW },
> -	{ 0x8b, KEY_MAIL },
> -	{ 0x8c, KEY_MEDIA },
> -	{ 0x96, KEY_F14 }, /* G key? */
> -	{ }
> -};
> -
> -static struct tps_key_entry *tps_get_key_by_scancode(int code)
> -{
> -	struct tps_key_entry *key;
> -
> -	for (key =3D topstar_keymap; key->code; key++)
> -		if (code =3D=3D key->code)
> -			return key;
> +static const struct key_entry topstar_keymap[] =3D {
> +	{ KE_KEY, 0x80, { KEY_BRIGHTNESSUP } },
> +	{ KE_KEY, 0x81, { KEY_BRIGHTNESSDOWN } },
> +	{ KE_KEY, 0x83, { KEY_VOLUMEUP } },
> +	{ KE_KEY, 0x84, { KEY_VOLUMEDOWN } },
> +	{ KE_KEY, 0x85, { KEY_MUTE } },
> +	{ KE_KEY, 0x86, { KEY_SWITCHVIDEOMODE } },
> +	{ KE_KEY, 0x87, { KEY_F13 } }, /* touchpad enable/disable key */
> +	{ KE_KEY, 0x88, { KEY_WLAN } },
> +	{ KE_KEY, 0x8a, { KEY_WWW } },
> +	{ KE_KEY, 0x8b, { KEY_MAIL } },
> +	{ KE_KEY, 0x8c, { KEY_MEDIA } },
> =20
> -	return NULL;
> -}
> -
> -static struct tps_key_entry *tps_get_key_by_keycode(int code)
> -{
> -	struct tps_key_entry *key;
> +	/* Known non hotkey events don't handled or that we don't care yet =
*/
> +	{ KE_IGNORE, 0x8e, },
> +	{ KE_IGNORE, 0x8f, },
> +	{ KE_IGNORE, 0x90, },
> =20
> -	for (key =3D topstar_keymap; key->code; key++)
> -		if (code =3D=3D key->keycode)
> -			return key;
> +	/*
> +	 * 'G key' generate two event codes, convert to only
> +	 * one event/key code for now, consider replacing by
> +	 * a switch (3G switch - SW_3G?)
> +	 */
> +	{ KE_KEY, 0x96, { KEY_F14 } },
> +	{ KE_KEY, 0x97, { KEY_F14 } },
> =20
> -	return NULL;
> -}
> +	{ KE_END, 0 }
> +};
> =20
>  static void acpi_topstar_notify(struct acpi_device *device, u32 even=
t)
>  {
> -	struct tps_key_entry *key;
>  	static bool dup_evnt[2];
>  	bool *dup;
>  	struct topstar_hkey *hkey =3D acpi_driver_data(device);
> @@ -85,27 +71,8 @@ static void acpi_topstar_notify(struct acpi_device=
 *device, u32 event)
>  		*dup =3D true;
>  	}
> =20
> -	/*
> -	 * 'G key' generate two event codes, convert to only
> -	 * one event/key code for now (3G switch?)
> -	 */
> -	if (event =3D=3D 0x97)
> -		event =3D 0x96;
> -
> -	key =3D tps_get_key_by_scancode(event);
> -	if (key) {
> -		input_report_key(hkey->inputdev, key->keycode, 1);
> -		input_sync(hkey->inputdev);
> -		input_report_key(hkey->inputdev, key->keycode, 0);
> -		input_sync(hkey->inputdev);
> -		return;
> -	}
> -
> -	/* Known non hotkey events don't handled or that we don't care yet =
*/
> -	if (event =3D=3D 0x8e || event =3D=3D 0x8f || event =3D=3D 0x90)
> -		return;
> -
> -	pr_info("unknown event =3D 0x%02x\n", event);
> +	if (!sparse_keymap_report_event(hkey->inputdev, event, 1, true))
> +		pr_info("unknown event =3D 0x%02x\n", event);
>  }
> =20
>  static int acpi_topstar_fncx_switch(struct acpi_device *device, bool=
 state)
> @@ -126,63 +93,41 @@ static int acpi_topstar_fncx_switch(struct acpi_=
device *device, bool state)
>  	return 0;
>  }
> =20
> -static int topstar_getkeycode(struct input_dev *dev, int scancode, i=
nt *keycode)
> -{
> -	struct tps_key_entry *key =3D tps_get_key_by_scancode(scancode);
> -
> -	if (!key)
> -		return -EINVAL;
> -
> -	*keycode =3D key->keycode;
> -	return 0;
> -}
> -
> -static int topstar_setkeycode(struct input_dev *dev, int scancode, i=
nt keycode)
> -{
> -	struct tps_key_entry *key;
> -	int old_keycode;
> -
> -	if (keycode < 0 || keycode > KEY_MAX)
> -		return -EINVAL;
> -
> -	key =3D tps_get_key_by_scancode(scancode);
> -
> -	if (!key)
> -		return -EINVAL;
> -
> -	old_keycode =3D key->keycode;
> -	key->keycode =3D keycode;
> -	set_bit(keycode, dev->keybit);
> -	if (!tps_get_key_by_keycode(old_keycode))
> -		clear_bit(old_keycode, dev->keybit);
> -	return 0;
> -}
> -
>  static int acpi_topstar_init_hkey(struct topstar_hkey *hkey)
>  {
> -	struct tps_key_entry *key;
> +	struct input_dev *input;
> +	int error;
> =20
> -	hkey->inputdev =3D input_allocate_device();
> -	if (!hkey->inputdev) {
> +	input =3D input_allocate_device();
> +	if (!input) {
>  		pr_err("Unable to allocate input device\n");
> -		return -ENODEV;
> +		return -ENOMEM;
>  	}
> -	hkey->inputdev->name =3D "Topstar Laptop extra buttons";
> -	hkey->inputdev->phys =3D "topstar/input0";
> -	hkey->inputdev->id.bustype =3D BUS_HOST;
> -	hkey->inputdev->getkeycode =3D topstar_getkeycode;
> -	hkey->inputdev->setkeycode =3D topstar_setkeycode;
> -	for (key =3D topstar_keymap; key->code; key++) {
> -		set_bit(EV_KEY, hkey->inputdev->evbit);
> -		set_bit(key->keycode, hkey->inputdev->keybit);
> +
> +	input->name =3D "Topstar Laptop extra buttons";
> +	input->phys =3D "topstar/input0";
> +	input->id.bustype =3D BUS_HOST;
> +
> +	error =3D sparse_keymap_setup(input, topstar_keymap, NULL);
> +	if (error) {
> +		pr_err("Unable to setup input device keymap\n");
> +		goto err_free_dev;
>  	}
> -	if (input_register_device(hkey->inputdev)) {
> +
> +	error =3D input_register_device(input);
> +	if (error) {
>  		pr_err("Unable to register input device\n");
> -		input_free_device(hkey->inputdev);
> -		return -ENODEV;
> +		goto err_free_keymap;
>  	}
> =20
> +	hkey->inputdev =3D input;
>  	return 0;
> +
> + err_free_keymap:
> +	sparse_keymap_free(input);
> + err_free_dev:
> +	input_free_device(input);
> +	return error;
>  }
> =20
>  static int acpi_topstar_add(struct acpi_device *device)
> @@ -216,6 +161,7 @@ static int acpi_topstar_remove(struct acpi_device=
 *device, int type)
> =20
>  	acpi_topstar_fncx_switch(device, false);
> =20
> +	sparse_keymap_free(tps_hkey->inputdev);
>  	input_unregister_device(tps_hkey->inputdev);
>  	kfree(tps_hkey);
> =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
[]'s
Herton
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
