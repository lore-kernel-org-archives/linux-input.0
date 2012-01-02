From: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Mon, 2 Jan 2012 10:39:04 -0800
Message-ID: <CAPnjgZ1ngJrqB5FgOZDmc-H9KBE0-W75rqTHEPX4D+q0FjYumg@mail.gmail.com>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
	<1325484557-27695-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325484557-27695-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, U-Boot Mailing List <u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Olof,

On Sun, Jan 1, 2012 at 10:09 PM, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
> This adds a simple device tree binding for simple key matrix data and
> a helper to fill in the platform data.
>
> The implementation is in a shared file outside if drivers/input/keybo=
ard
> since some drivers in drivers/input/misc might be making use of it
> as well.
>
> Changes since v2:
> =A0* Removed reference to "legacy" format with a subnode per key
> =A0* Changed to a packed format with one cell per key instead of 3.
> =A0* Moved new OF helper to separate file
> =A0* Misc fixups based on comments
>
> Changes since v1:
> =A0* Removed samsung-style binding support
> =A0* Added linux,fn-keymap and linux,fn-key optional properties
>
> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> ---
> =A0.../devicetree/bindings/input/matrix-keymap.txt =A0 =A0| =A0 27 ++=
++++
> =A0drivers/input/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A04 +
> =A0drivers/input/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 +
> =A0drivers/input/of_keymap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 87 ++++++++++++++++++++
> =A0include/linux/input/matrix_keypad.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 19 ++++
> =A06 files changed, 139 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/input/matrix-=
keymap.txt
> =A0create mode 100644 drivers/input/of_keymap.c
>
> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.tx=
t b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> new file mode 100644
> index 0000000..1db8e12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> @@ -0,0 +1,27 @@
> +A simple common binding for matrix-connected key boards. Currently t=
argeted at
> +defining the keys in the scope of linux key codes since that is a st=
able and
> +standardized interface at this time.
> +
> +Required properties:
> +- compatible: "matrix-keyboard-controller"
> +- linux,keymap: an array of packed 1-cell entries containing the equ=
ivalent
> + =A0of row, column and linux key-code. The 32-bit big endian cell is=
 packed
> + =A0as:
> + =A0 =A0 =A0 row << 24 | column << 16 | key-code

This looks much better than the Samsung binding and the original 3-cell=
 one.

U-Boot Tegra (keyboard patch series) currently uses a 16x8 matrix, and
uses a single byte (the ASCII character) for a total of 128 bytes per
keymap. Since U-Boot does not have (or apparently want) the concept of
key codes or the added code and intermediate data this requires, the
binding presented here will not suit U-Boot so far.

These rows and columns embedded in the cell make it more of a pain to
write the fdt description. If you just set up the cells in (column,
row) order and set the matrix size (rows, columns) then you end up
with 128 entries on Tegra. If you use uint16 then this could be 256
bytes instead of 512. The binding you present for Tegra would be 109 *
4 =3D 436 bytes. However I take your point that Fn maps are much more
sparse, so overall this is likely to be similar (512 bytes for either
method once Fn mappings are taken into account).

But going back to U-Boot, it does not have the intermediate table that
you malloc and decant into, it does not understand key codes so
doesn't know what to do when Shift is pressed, doesn't understand
languages, etc. In order to use these Linux bindings in U-Boot we
would need to add new input layer, extra decode code and intermediate
tables. I can almost hear the NAKs already (bear in mind fdt only went
into U-Boot in the December release and people are more sensitive to
code size / performance there than in Linux). I did ask about this on
this list a few weeks ago but no response yet.

We could perhaps add an alternative direct ASCII binding like this
example (which would have to be in a separate node):

                /* Use a packed binding which doesn't include
row,column numbers in each cell */
                packed-binding;
                matrix-columns =3D <8>;
                matrix-rows =3D <16>;
                ascii-binding;  /* ASCII characters instead of keycodes=
 */
		u-boot,keymap  =3D /size/ 8 <00  00  'w' 's' 'a' 'z' 00  DE
				    00  00  00  00  00  00  00  00
				    00  00  00  00  00  00  00  00
				    '5' '4' 'r' 'e' 'f' 'd' 'x' 00
				    '7' '6' 't' 'h' 'g' 'v' 'c' ' '
				    '9' '8' 'u' 'y' 'j' 'n' 'b' 5C
				    '-' '0' 'o' 'i' 'l' 'k' ',' 'm'
				    00  '=3D' ']' 0D  00  00  00  00
				    00  00  00  00  DF  DF  00  00
				    00  00  00  00  00  DC  00  DD
				    00  00  00  00  00  00  00  00
				    '[' 'p' 27  ';' '/' '.' 00  00
				    00  00  08  '3' '2' 1E  00  00
				    00  7F  00  00  00  1D  1F  1C
				    00  00  00  'q' 00  00  '1' 00
				    1B  '`' 00  09  00  00  00  00>;
		u-boot,keymap-DF =3D /size/ 8 <00  00  'W' 'S' 'A' 'Z' 00  00
				    00  00  00  00  00  00  00  00
				    00  00  00  00  00  00  00  00
=2E..

The DC-DF codes codes denote Shift, Fn and Ctrl keys which would need
a separate keymap - although we could probably calculate the Ctrl one.

=46rom a point of view of efficiency, drivers can simply keep a pointer
to the appropriate property and read out the codes based on
(row,column) position.

If we have something like this, then in order for the keyboard to work
in U-Boot, vendors would need to create a completely separate ASCII
mapping. Yes I agree this is a bit of a pain, but the above map is
fairly easy to type in, and quite compact.

Given the push-back on the U-Boot list from Linux people about my
bindings, I would like to work out the U-Boot side in this thread if
possible, since it seems to be dependent on what Linux does. But I
hope what is created is efficient enough not to bloat U-Boot or
require an new input layer to be added just to use fdt.

Regards,
Simon

> +
> +Optional properties:
> +- linux,fn-keymap: A separate array of packed 1-cell entries similar=
 to
> + =A0linux,keymap but only to be used when the function key modifier =
is
> + =A0active. This is used for keyboards that have a software-based mo=
difier
> + =A0key for 'Fn' but that need to describe the custom layout that sh=
ould
> + =A0be used when said modifier key is active.
> +
> +- linux,fn-key: a 2-cell entry containing the < row column > of the
> + =A0function modifier key used to switch to the above linux,fn-keyma=
p
> + =A0layout.
> +
> +Example:
> + =A0 =A0 =A0 linux,keymap =3D < 0x00030012
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0102003a >;
> + =A0 =A0 =A0 linux,fn-key =3D < 2 1 >;
> + =A0 =A0 =A0 linux,fn-keymap =3D < 0x0002004a >;

[snip]

Regards,
Simon
