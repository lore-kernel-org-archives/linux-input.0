From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Thu, 29 Dec 2011 14:26:17 -0800
Message-ID: <CAOesGMhKjUVJATiD2MQv1OVOWi72Vn6RCtJe=i14JasVV=RLew@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
	<1325184146-3527-1-git-send-email-olof@lixom.net>
	<20111229220515.GA17621@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111229220515.GA17621-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On Thu, Dec 29, 2011 at 2:05 PM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Olof,
>
> On Thu, Dec 29, 2011 at 10:42:26AM -0800, Olof Johansson wrote:
>> This adds a simple device tree binding for simple key matrix data.
>>
>> Changes since v1:
>> =A0* Removed samsung-style binding support
>> =A0* Added linux,fn-keymap and linux,fn-key optional properties
>>
>
> This looks very reasonable to me, a few comments though.
>
>> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>> ---
>> =A0.../devicetree/bindings/input/matrix-keymap.txt =A0 =A0| =A0 25 +=
+++++
>> =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A01 +
>> =A0drivers/input/keyboard/keymap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 78 ++++++++++++++++++++
>> =A0include/linux/input/matrix_keypad.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 34 +++++----
>> =A04 files changed, 123 insertions(+), 15 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/input/matrix=
-keymap.txt
>> =A0create mode 100644 drivers/input/keyboard/keymap.c
>>
>> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.t=
xt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> new file mode 100644
>> index 0000000..480ca46
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> @@ -0,0 +1,25 @@
>> +For matrix keyboards there are two kinds of layout bindings using
>> +linux key codes.
>> +
>> +Required properties:
>> +- compatible: "matrix-keyboard-controller"
>> +- linux,keymap: an array of 3-cell entries containing the equivalen=
t
>> + =A0of the three separate properties above: row, column and linux
>> + =A0key-code.
>> +
>> +Optional properties:
>> +- linux,fn-keymap: A separate array of 3-cell entries similar to
>> + =A0linux,keymap but only to be used when the function key modifier=
 is
>> + =A0active. This is used for keyboards that have a software-based m=
odifier
>> + =A0key for 'Fn' but that need to describe the custom layout that s=
hould
>> + =A0be used when said modifier key is active.
>> +
>> +- linux,fn-key: a 2-cell entry containing the < row column > of the
>> + =A0function modifier key used to switch to the above linux,fn-keym=
ap
>> + =A0layout.
>> +
>> +Example:
>> + =A0 =A0 linux,keymap =3D < 0 3 2
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 4 5 >;
>> + =A0 =A0 linux,fn-key =3D < 2 1 >;
>> + =A0 =A0 linux,fn-keymap =3D < 0 3 1 >;
>> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboar=
d/Makefile
>> index df7061f..83e6eed 100644
>> --- a/drivers/input/keyboard/Makefile
>> +++ b/drivers/input/keyboard/Makefile
>> @@ -4,6 +4,7 @@
>>
>> =A0# Each configuration option enables a list of files.
>>
>> +obj-$(CONFIG_INPUT_KEYBOARD) =A0 =A0 =A0 =A0 +=3D keymap.o
>
> I do not think we should restrict it keyboard devices only; there cou=
ld
> be users in input/misc as well, so I'd rather have it as
> drivers/input/matrix-keymap.c
>
> I'd start with just matrix_keyboard_of_build_keymap() there and moved
> matrix_keypad_build_keymap() as a follow-up patch as drivers using it
> should 'select' it.

Hmm. It could be argued that any driver that provides a keyboard
complex enough to need this binding should be under
drivers/input/keyboard (possibly provided MFD-style by the misc
device). But sure, I'll move it and add a slient Kconfig for it. :)

>> =A0obj-$(CONFIG_KEYBOARD_ADP5520) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D a=
dp5520-keys.o
>> =A0obj-$(CONFIG_KEYBOARD_ADP5588) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D a=
dp5588-keys.o
>> =A0obj-$(CONFIG_KEYBOARD_ADP5589) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D a=
dp5589-keys.o
>> diff --git a/drivers/input/keyboard/keymap.c b/drivers/input/keyboar=
d/keymap.c
>> new file mode 100644
>> index 0000000..80d1074
>> --- /dev/null
>> +++ b/drivers/input/keyboard/keymap.c
>> @@ -0,0 +1,78 @@
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/input.h>
>> +#include <linux/of.h>
>> +#include <linux/input/matrix_keypad.h>
>> +#include <linux/export.h>
>> +#include <linux/gfp.h>
>> +#include <linux/slab.h>
>> +
>> +void matrix_keypad_build_keymap(const struct matrix_keymap_data *ke=
ymap_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned i=
nt row_shift,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned s=
hort *keymap, unsigned long *keybit)
>> +{
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < keymap_data->keymap_size; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int key =3D keymap_data->keymap[i=
];
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int row =3D KEY_ROW(key);
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int col =3D KEY_COL(key);
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned short code =3D KEY_VAL(key);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 keymap[MATRIX_SCAN_CODE(row, col, row_shif=
t)] =3D code;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(code, keybit);
>> + =A0 =A0 }
>> + =A0 =A0 __clear_bit(KEY_RESERVED, keybit);
>> +}
>> +EXPORT_SYMBOL_GPL(matrix_keypad_build_keymap);
>> +
>> +#ifdef CONFIG_OF
>> +struct matrix_keymap_data *
>
> Instead of allocating keymap data why don't we populate keymap and
> keybits directly, like matrix_keypad_build_keymap() does?

The reason I did it this way is the way the drivers are written for
device tree: They use a helper that fills in the platform data, and
then use the same probe flow as for the platform device. If I was to
fill in the keymap/keybits here, then we would have separate code
flows for the two ways to enter the driver probe.

>> +matrix_keyboard_of_fill_keymap(struct device_node *np)
>> +{
>> + =A0 =A0 struct matrix_keymap_data *kd;
>> + =A0 =A0 struct device_node *knp;
>> + =A0 =A0 int proplen =3D 0, i;
>> + =A0 =A0 u32 *keymap, row, col, key_code;
>
> Let's fail safely if np is NULL.

Sure.

>> + =A0 =A0 const __be32 *prop =3D of_get_property(np, "linux,keymap",=
 &proplen);
>> +
>> + =A0 =A0 if (!of_device_is_compatible(np, "matrix-keyboard-controll=
er"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> +
>> + =A0 =A0 kd =3D kmalloc(sizeof(*kd), GFP_KERNEL);
>> + =A0 =A0 if (!kd)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 kd->keymap_size =3D proplen / 3;
>
> Validate that proplen % 3 =3D=3D 0?

See discussion on other subthread: I think we want to switch to a
compacter format anyway and just use one cell per key. But if not,
yeah this check is useful for that case.

>> +
>> + =A0 =A0 keymap =3D kzalloc(kd->keymap_size * sizeof(u32), GFP_KERN=
EL);
>> + =A0 =A0 if (!keymap) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(kd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 kd->keymap =3D keymap;
>> +
>> + =A0 =A0 for (i =3D 0; i < kd->keymap_size; i++){
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* property format is < row column keycode=
 > */
>> + =A0 =A0 =A0 =A0 =A0 =A0 row =3D be32_to_cpup(prop++);
>> + =A0 =A0 =A0 =A0 =A0 =A0 col =3D be32_to_cpup(prop++);
>> + =A0 =A0 =A0 =A0 =A0 =A0 key_code =3D be32_to_cpup(prop++);
>> + =A0 =A0 =A0 =A0 =A0 =A0 *keymap++ =3D KEY(row, col, key_code);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* FIXME: Need to add handling of the linux,fn-keymap prop=
erty here */
>> +
>> + =A0 =A0 return kd;
>> +}
>> +EXPORT_SYMBOL_GPL(matrix_keyboard_of_fill_keymap);
>> +
>> +void matrix_keyboard_of_free_keymap(const struct matrix_keymap_data=
 *kd)
>> +{
>> + =A0 =A0 if (!kd)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 if (kd->keymap)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(kd->keymap);
>
> If we decide to keep allocating kd then checking kd->keymap before
> freeing is not necessary.

Good point, fixing.


-Olof
