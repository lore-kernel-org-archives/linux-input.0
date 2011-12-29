From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple key matrixes
Date: Wed, 28 Dec 2011 22:34:22 -0800
Message-ID: <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Simon Glass (sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org)" <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 28, 2011 at 10:16 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> w=
rote:
> Olof Johansson wrote at Wednesday, December 28, 2011 3:53 PM:
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
> ...
>> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.t=
xt
> ...
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
>
> Why allow two completely different bindings? Is there some deficiency
> to the compact binding that means it isn't suitable for all cases?

The main reason is that the samsung keyboard driver already implements
the more verbose one, and allowing that binding to coexist while also
providing a more compact one seems like the right thing to do.

> The binding proposed by Simon Glass for U-Boot was just a matrix
> of keycodes, with any unused locations containing zero, e.g. see:
>
> http://patchwork.ozlabs.org/patch/129825/
>
> ... which is yet another option. We obviously don't want U-Boot and t=
he
> kernel to expect different DT content either.

The row/column format is closer to how the hardware is actually
behaving, and it's trivial to remap that to the kind of
two-dimensional array like Simon provides (it's already done in the
input layer). It also has the benefit of not using up space for
undefined keys.

Since there is no concept of modifier keys in hardware (they are just
keypress events), the translation table should be in the u-boot
implementation instead of in the binding.

There is already precedence to using the linux key code format instead
of character encodings in keyboard maps, and the reasoning behind it
is quite sane: Since it's a userspace-exported interface it is a
stable one. If we went with the array that Simon proposed, there will
need to be a transition layer in the kernel device tree parser to
remap everything back, with very little to no benefit when it comes to
the usability of the binding, as far as I can tell.

It is also a little unclear to me whether that binding should be
localized or not, which would add another level of headaches when it
comes to reverse-mapping the character array back to linux key
bindings, since then you would also need to provide one remapping
table per locale supported.


-Olof
