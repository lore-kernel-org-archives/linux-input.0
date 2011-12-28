From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple key matrixes
Date: Wed, 28 Dec 2011 15:37:37 -0800
Message-ID: <CAOesGMjpN8yqOmTvXfcNqVpMTwf90wct5tOBNErR1F9rtHAXRg@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
	<4EFBA698.6080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EFBA698.6080601-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 28, 2011 at 3:30 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Olof,
>
> On 12/28/2011 04:52 PM, Olof Johansson wrote:
>> From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> This adds a basic device tree binding for simple key matrix data.
>>
>> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>> ---
>>
>> Based on email exchange this morning, this is a first cut at a share=
d
>> definition and helper function to parse and fill in the keymap data.
>>
>> Instead of doing the direct parsing into the final keymap format, I
>> chose to fill in the pdata-equivalent since that is how the OF pdata
>> fillers work right now if code is to be kept common with the legacy
>> platform_device probe interface.
>>
>> This is a prerequisite for a revised version of the tegra-kbc device
>> tree support that I will repost separately once this interface is st=
able.
>>
>>
>> -Olof
>>
>> =A0.../devicetree/bindings/input/matrix-keymap.txt =A0 =A0| =A0 35 +=
+++++++++++
>> =A0include/linux/input/matrix_keypad.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 55 ++++++++++++++++++++
>> =A02 files changed, 90 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/input/matrix=
-keymap.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.t=
xt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> new file mode 100644
>> index 0000000..894f786
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> @@ -0,0 +1,35 @@
>> +For matrix keyboards there are two kinds of layout bindings using
>> +linux key codes.
>> +
>> +Required properties:
>> +- compatible: "matrix-keyboard-controller"
>
> Seems like this is not really needed. You've already matched the node
> before you call matrix_keyboard_of_fill_keymap.

The view I had when adding a compatible field was that the controllers
that use this binding essentially inherits and extends it, so having
this as a common compatible seems like the right thing to do. It also
gives an easy reference ('see binding for
"matrix-keyboard-controller"' from the other binding, etc).

>> +
>> +For simple keyboards with just a few buttons, you can specify each =
key
>> +as a subnode of the keyboard controller, with the following
>> +properties:
>> +
>> +- keypad,row: the row number to which the key is connected.
>> +- keypad,column: the column number to which the key is connected.
>> +- linux,code: the key-code to be reported when the key is pressed
>> + =A0and released.
>> +
>> +Example:
>> +
>> + =A0 =A0 key_1 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <3>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 linux,code =3D <2>;
>> + =A0 =A0 };
>> +
>> +
>> +For a more complex keyboard, such as a full laptop, a more compact
>> +binding can be used instead, with the following property directly i=
n
>> +the keyboard controller node:
>> +
>> +- linux,keymap: an array of 3-cell entries containing the equivalen=
t
>> + =A0of the three separate properties above: row, column and linux
>> + =A0key-code.
>> +
>> +Example:
>> + =A0 =A0 linux,keymap =3D < 0 3 2
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 4 5 >;
>> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/inp=
ut/matrix_keypad.h
>> index fe7c4b9..ff13cd3 100644
>> --- a/include/linux/input/matrix_keypad.h
>> +++ b/include/linux/input/matrix_keypad.h
>> @@ -3,6 +3,7 @@
>>
>> =A0#include <linux/types.h>
>> =A0#include <linux/input.h>
>> +#include <linux/of.h>
>>
>> =A0#define MATRIX_MAX_ROWS =A0 =A0 =A0 =A0 =A0 =A0 =A032
>> =A0#define MATRIX_MAX_COLS =A0 =A0 =A0 =A0 =A0 =A0 =A032
>> @@ -106,4 +107,58 @@ matrix_keypad_build_keymap(const struct matrix_=
keymap_data *keymap_data,
>> =A0 =A0 =A0 __clear_bit(KEY_RESERVED, keybit);
>> =A0}
>>
>> +#ifdef CONFIG_OF
>> +static inline struct matrix_keymap_data *
>> +matrix_keyboard_of_fill_keymap(struct device_node *np)
>> +{
>
> Seems a bit large to inline.

It's pushing the limits for it, yes. Dmitry, should I start a shared C
file for this? If so, where? drivers/input/keyboard/keymap.c?

>> + =A0 =A0 struct matrix_keymap_data *kd;
>> + =A0 =A0 struct device_node *knp;
>> + =A0 =A0 int proplen =3D 0, i;
>> + =A0 =A0 u32 *keymap, row, col, key_code;
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
>> +
>> + =A0 =A0 for_each_child_of_node(np, knp)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kd->keymap_size++;
>> +
>> + =A0 =A0 keymap =3D kzalloc(kd->keymap_size * sizeof(u32), GFP_KERN=
EL);
>> + =A0 =A0 if (!keymap) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(kd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>
> Looks like memory leaks would be very likely. Is the caller expected =
to
> free these? If so, a matching free function should be provided. Perha=
ps
> trying to keep platform_data compatibility is not the best approach i=
f
> it would simplify this.

Yes, caller is expected to free. Dmitry doesn't like devm_alloc so I
guess having a free function could be a decent idea (I had it
open-coded in the driver that uses this, will switch that over too).


-Olof
