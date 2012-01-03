From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Tue, 3 Jan 2012 07:43:17 -0800
Message-ID: <20120103154317.GA27061@quad.lixom.net>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
 <1325484557-27695-1-git-send-email-olof@lixom.net>
 <CAPnjgZ1ngJrqB5FgOZDmc-H9KBE0-W75rqTHEPX4D+q0FjYumg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:60494 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753418Ab2ACPnY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jan 2012 10:43:24 -0500
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1ngJrqB5FgOZDmc-H9KBE0-W75rqTHEPX4D+q0FjYumg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, riyer@nvidia.com, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, thomas.abraham@linaro.org, swarren@nvidia.com, grant.likely@secretlab.ca, U-Boot Mailing List <u-boot@lists.denx.de>

Hi,

On Mon, Jan 02, 2012 at 10:39:04AM -0800, Simon Glass wrote:
> > diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.=
txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> > new file mode 100644
> > index 0000000..1db8e12
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
> > @@ -0,0 +1,27 @@
> > +A simple common binding for matrix-connected key boards. Currently=
 targeted at
> > +defining the keys in the scope of linux key codes since that is a =
stable and
> > +standardized interface at this time.
> > +
> > +Required properties:
> > +- compatible: "matrix-keyboard-controller"
> > +- linux,keymap: an array of packed 1-cell entries containing the e=
quivalent
> > + =A0of row, column and linux key-code. The 32-bit big endian cell =
is packed
> > + =A0as:
> > + =A0 =A0 =A0 row << 24 | column << 16 | key-code
>=20
> This looks much better than the Samsung binding and the original 3-ce=
ll one.
>=20
> U-Boot Tegra (keyboard patch series) currently uses a 16x8 matrix, an=
d
> uses a single byte (the ASCII character) for a total of 128 bytes per
> keymap. Since U-Boot does not have (or apparently want) the concept o=
f
> key codes or the added code and intermediate data this requires, the
> binding presented here will not suit U-Boot so far.
>
> These rows and columns embedded in the cell make it more of a pain to
> write the fdt description. If you just set up the cells in (column,
> row) order and set the matrix size (rows, columns) then you end up
> with 128 entries on Tegra. If you use uint16 then this could be 256
> bytes instead of 512. The binding you present for Tegra would be 109 =
*
> 4 =3D 436 bytes. However I take your point that Fn maps are much more
> sparse, so overall this is likely to be similar (512 bytes for either
> method once Fn mappings are taken into account).

Looking at the keymap you posted, you define 62 keys and 16 function
keys. So if that is all you care about on your particular keyboard,
that means that the layout with the 1-cell format is 248 bytes for the
base keymap, and 64 bytes for the fn-keymap. The benefit of using the
row/column/keycode format is that the table is only as large as the
number of keys you care about.

> But going back to U-Boot, it does not have the intermediate table tha=
t
> you malloc and decant into, it does not understand key codes so
> doesn't know what to do when Shift is pressed, doesn't understand
> languages, etc. In order to use these Linux bindings in U-Boot we
> would need to add new input layer, extra decode code and intermediate
> tables. I can almost hear the NAKs already (bear in mind fdt only wen=
t
> into U-Boot in the December release and people are more sensitive to
> code size / performance there than in Linux). I did ask about this on
> this list a few weeks ago but no response yet.
>=20
> We could perhaps add an alternative direct ASCII binding like this
> example (which would have to be in a separate node):

You keep saying "direct ASCII", but your map contains non-ASCII
characters. ASCII provides no way at all to specify things such as shif=
t,
or arrow keys, or other common new keys on keyboards. Instead you have =
had to
make up an ad-hoc custom map that contains your own special codes for t=
hese
keys.

=46or example, for arrow keys you seem to overload the FS/GS/RS/US. I'm=
 not
saying we expect to need to use those ascii codes, but it does seem arb=
itrary
to just grab them for arrow keys. So in essence you have come up with y=
our own
encoding of non-ASCII keys instead of reusing what is already available=
 through
the linux keycodes.

Also, for example with return, does it encode as CR, LF or CR+LF? Etc.

Doing a binding in pseudo-ASCII is just asking for extra complications,=
 in my
opinion. Over time that encoding is likely to swell to similar sizes an=
yway,
but still be incompatible.

>                 /* Use a packed binding which doesn't include
> row,column numbers in each cell */
>                 packed-binding;
>                 matrix-columns =3D <8>;
>                 matrix-rows =3D <16>;
>                 ascii-binding;  /* ASCII characters instead of keycod=
es */
> 		u-boot,keymap  =3D /size/ 8 <00  00  'w' 's' 'a' 'z' 00  DE
> 				    00  00  00  00  00  00  00  00
> 				    00  00  00  00  00  00  00  00
> 				    '5' '4' 'r' 'e' 'f' 'd' 'x' 00
> 				    '7' '6' 't' 'h' 'g' 'v' 'c' ' '
> 				    '9' '8' 'u' 'y' 'j' 'n' 'b' 5C
> 				    '-' '0' 'o' 'i' 'l' 'k' ',' 'm'
> 				    00  '=3D' ']' 0D  00  00  00  00
> 				    00  00  00  00  DF  DF  00  00
> 				    00  00  00  00  00  DC  00  DD
> 				    00  00  00  00  00  00  00  00
> 				    '[' 'p' 27  ';' '/' '.' 00  00
> 				    00  00  08  '3' '2' 1E  00  00
> 				    00  7F  00  00  00  1D  1F  1C
> 				    00  00  00  'q' 00  00  '1' 00
> 				    1B  '`' 00  09  00  00  00  00>;
> 		u-boot,keymap-DF =3D /size/ 8 <00  00  'W' 'S' 'A' 'Z' 00  00
> 				    00  00  00  00  00  00  00  00
> 				    00  00  00  00  00  00  00  00
> ...
>=20
> The DC-DF codes codes denote Shift, Fn and Ctrl keys which would need
> a separate keymap - although we could probably calculate the Ctrl one=
=2E

I had included the row/column property in my binding for KEY_FN, but in
hindsight it's probably just enough to decode that through the regular =
key
layout, since there will be an entry for it there.

> From a point of view of efficiency, drivers can simply keep a pointer
> to the appropriate property and read out the codes based on
> (row,column) position.
>
> If we have something like this, then in order for the keyboard to wor=
k
> in U-Boot, vendors would need to create a completely separate ASCII
> mapping. Yes I agree this is a bit of a pain, but the above map is
> fairly easy to type in, and quite compact.

It doesn't make sense to come up with a fresh, brand new binding that
requires anyone adding a new device to it to do extra work to do two
redunant descriptions of the same device. We should be able to find com=
mon
ground.

The KEY_* codes that are interesting all seem to be in the range of
0-83. In the u-boot case, that means the base KEY*-to-ascii table would
be 83 bytes.

That means that the memory consumption for your case above would be
4*62+4*16=3D312 bytes for the base+fn table, and then 3*83 =3D 249 byte=
s
for the KEY*-to-ASCII tables for regular/shift/ctrl, for a total of
561 bytes. I'm sure there will be a few special cases in the code just
like you have now for arrow keys, etc, but they don't have to be in the
83-byte table.

Sure, that is somewhat more than your 4*128 byte tables, but it is also
a much more flexible binding that is less likely to hit limitations dow=
n
the road.

> Given the push-back on the U-Boot list from Linux people about my
> bindings, I would like to work out the U-Boot side in this thread if
> possible, since it seems to be dependent on what Linux does. But I
> hope what is created is efficient enough not to bloat U-Boot or
> require an new input layer to be added just to use fdt.

I think it's a great idea to use a common binding, since there will jus=
t be
wasted effort for vendors to have to create two maps and keep them in s=
ync.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
