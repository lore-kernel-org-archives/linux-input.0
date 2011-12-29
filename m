From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple key matrixes
Date: Wed, 28 Dec 2011 23:06:02 -0800
Message-ID: <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
	<CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39013 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1L2HGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Dec 2011 02:06:03 -0500
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, "Simon Glass (sjg@chromium.org)" <sjg@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rakesh Iyer <riyer@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

On Wed, Dec 28, 2011 at 11:01 PM, Stephen Warren <swarren@nvidia.com> w=
rote:
> Olof Johansson wrote at Wednesday, December 28, 2011 11:34 PM:
>> On Wed, Dec 28, 2011 at 10:16 PM, Stephen Warren <swarren@nvidia.com=
> wrote:
>> > Olof Johansson wrote at Wednesday, December 28, 2011 3:53 PM:
>> >> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> >>
>> >> This adds a basic device tree binding for simple key matrix data.
>> >>
>> >> Signed-off-by: Olof Johansson <olof@lixom.net>
>> >> ---
>> >>
>> >> Based on email exchange this morning, this is a first cut at a sh=
ared
>> >> definition and helper function to parse and fill in the keymap da=
ta.
>> >>
>> >> Instead of doing the direct parsing into the final keymap format,=
 I
>> >> chose to fill in the pdata-equivalent since that is how the OF pd=
ata
>> >> fillers work right now if code is to be kept common with the lega=
cy
>> >> platform_device probe interface.
>> >>
>> >> This is a prerequisite for a revised version of the tegra-kbc dev=
ice
>> >> tree support that I will repost separately once this interface is=
 stable.
>> > ...
>> >> diff --git a/Documentation/devicetree/bindings/input/matrix-keyma=
p.txt
>> > ...
>> >> +For simple keyboards with just a few buttons, you can specify ea=
ch key
>> >> +as a subnode of the keyboard controller, with the following
>> >> +properties:
>> >> +
>> >> +- keypad,row: the row number to which the key is connected.
>> >> +- keypad,column: the column number to which the key is connected=
=2E
>> >> +- linux,code: the key-code to be reported when the key is presse=
d
>> >> + =A0and released.
>> >> +
>> >> +Example:
>> >> +
>> >> + =A0 =A0 key_1 {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <3>;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 linux,code =3D <2>;
>> >> + =A0 =A0 };
>> >> +
>> >> +
>> >> +For a more complex keyboard, such as a full laptop, a more compa=
ct
>> >> +binding can be used instead, with the following property directl=
y in
>> >> +the keyboard controller node:
>> >> +
>> >> +- linux,keymap: an array of 3-cell entries containing the equiva=
lent
>> >> + =A0of the three separate properties above: row, column and linu=
x
>> >> + =A0key-code.
>> >
>> > Why allow two completely different bindings? Is there some deficie=
ncy
>> > to the compact binding that means it isn't suitable for all cases?
>>
>> The main reason is that the samsung keyboard driver already implemen=
ts
>> the more verbose one, and allowing that binding to coexist while als=
o
>> providing a more compact one seems like the right thing to do.
>
> Can we deprecate the Samsung format, and only allow it for that Samsu=
ng
> device (and allow both there), and require a single format for any ot=
her
> keyboard?

I'm definitely ok with that. Thomas, Grant, Rob? The code in question
is queued for 3.3, so it hasn't been out in a real release yet.

Adding Kukjin as well since it's getting merged through his tree.

> The issue here is that U-Boot wants to stay small, and having to allo=
w
> two alternative methods to specify a keyboard is going to bloat the c=
ode;
> I expect some pushback adding DT support for just one binding by the =
time
> they see all the DT parsing code that's needed to do it all right.

The bloat is pretty minimal, since the parsing is simple. But yeah, I
see your point.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
