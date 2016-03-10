From: Julien Chauveau <chauveau.julien@gmail.com>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys example
Date: Fri, 11 Mar 2016 00:08:56 +0100
Message-ID: <A62AD22E-ECB3-4DC7-8156-22BC84795412@gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de> <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com> <56DEA4D6.10008@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56DEA4D6.10008@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-rockchip <linux-rockchip@lists.infradead.org>, LAKML <linux-arm-kernel@lists.infradead.org>, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


> Le 8 mars 2016 =C3=A0 11:09, Andreas F=C3=A4rber <afaerber@suse.de> a=
 =C3=A9crit :
>=20
> Am 08.03.2016 um 09:54 schrieb Geert Uytterhoeven:
>> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F=C3=A4rber <afaerber@suse.d=
e> wrote:
>>> Drop #address-cells and #size-cells, which are not required by the
>>> gpio-keys binding documentation, as button sub-nodes are not device=
s.
>>>=20
>>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>>> ---
>>> Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>>> 1 file changed, 2 deletions(-)
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt =
b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> index 21641236c095..1552a11f6786 100644
>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> @@ -34,8 +34,6 @@ Example nodes:
>>>=20
>>>        gpio_keys {
>=20
> While at it, I was told the preferred node naming would be dashes, no=
t
> underscores. The deeper we dig, the more we find.

I agree, here we should use dashes, not underscores. So "gpio-keys" ins=
tead of "gpio_keys".

>=20
>>>                        compatible =3D "gpio-keys";
>>> -                       #address-cells =3D <1>;
>>> -                       #size-cells =3D <0>;
>>>                        autorepeat;
>=20
> Also a white line here may be optically more pleasant.

I agree.

>=20
>>>                        button@21 {
>>=20
>> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1=
cdd":
>> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
>>=20
>> Warning (unit_address_vs_reg): Node /keyboard/button@21 has a unit
>> name, but no reg property
>=20
> My v2 GeekBox patch did have *-cells and a reg property, but Julien
> asked I drop that: https://patchwork.kernel.org/patch/8246481/
>=20
> Are you suggesting we should add a reg property here and drop this pa=
tch
> or go with this patch but follow up to not use @21?

I may be wrong but I think that if the unit-address has no meaning and =
is not used, then it should be removed.

By the way, I think the warning message is wrong. It should be _address=
_ instead of name: "Node has a unit address, but no reg property".

Julien
