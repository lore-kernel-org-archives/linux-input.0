From: Julien Chauveau <chauveau.julien@gmail.com>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys example
Date: Tue, 8 Mar 2016 10:41:37 +0100
Message-ID: <525564DD-D0D3-4DEB-9306-3A23288FD83F@gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de> <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35687 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcCHJlm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 04:41:42 -0500
In-Reply-To: <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


> Le 8 mars 2016 =C3=A0 09:54, Geert Uytterhoeven <geert@linux-m68k.org=
> a =C3=A9crit :
>=20
> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F=C3=A4rber <afaerber@suse.de=
> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices=
=2E
>>=20
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>> ---
>> Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>> 1 file changed, 2 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b=
/Documentation/devicetree/bindings/input/gpio-keys.txt
>> index 21641236c095..1552a11f6786 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> @@ -34,8 +34,6 @@ Example nodes:
>>=20
>>        gpio_keys {
>>                        compatible =3D "gpio-keys";
>> -                       #address-cells =3D <1>;
>> -                       #size-cells =3D <0>;
>>                        autorepeat;
>>                        button@21 {
>=20
> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1c=
dd":
> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
>=20
> Warning (unit_address_vs_reg): Node /keyboard/button@21 has a unit
> name, but no reg property
>=20

Hi Andreas,
This means you can also drop the unit-address (the @21 part) for the bu=
tton.
What about using a more relevant name like "key_up" instead of "button"=
?

Julien--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
