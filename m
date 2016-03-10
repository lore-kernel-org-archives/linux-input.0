From: Julien Chauveau <chauveau.julien@gmail.com>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys example
Date: Fri, 11 Mar 2016 00:08:49 +0100
Message-ID: <7E647096-6B3B-4015-BB0F-7B4087206180@gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de> <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com> <525564DD-D0D3-4DEB-9306-3A23288FD83F@gmail.com> <56DEA67E.8090704@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34481 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbcCJXIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 18:08:54 -0500
In-Reply-To: <56DEA67E.8090704@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-rockchip <linux-rockchip@lists.infradead.org>, LAKML <linux-arm-kernel@lists.infradead.org>, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


> Le 8 mars 2016 =C3=A0 11:16, Andreas F=C3=A4rber <afaerber@suse.de> a=
 =C3=A9crit :
>=20
> Am 08.03.2016 um 10:41 schrieb Julien Chauveau:
>> Le 8 mars 2016 =C3=A0 09:54, Geert Uytterhoeven <geert@linux-m68k.or=
g> a =C3=A9crit :
>>> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F=C3=A4rber <afaerber@suse.=
de> wrote:
>>>> Drop #address-cells and #size-cells, which are not required by the
>>>> gpio-keys binding documentation, as button sub-nodes are not devic=
es.
>>>>=20
>>>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>>>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>>>> ---
>>>> Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>>>> 1 file changed, 2 deletions(-)
>>>>=20
>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt=
 b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> index 21641236c095..1552a11f6786 100644
>>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> @@ -34,8 +34,6 @@ Example nodes:
>>>>=20
>>>>       gpio_keys {
>>>>                       compatible =3D "gpio-keys";
>>>> -                       #address-cells =3D <1>;
>>>> -                       #size-cells =3D <0>;
>>>>                       autorepeat;
>>>>                       button@21 {
>>>=20
>>> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b=
1cdd":
>>> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
>>>=20
>>> Warning (unit_address_vs_reg): Node /keyboard/button@21 has a unit
>>> name, but no reg property
>>>=20
>>=20
>> Hi Andreas,
>> This means you can also drop the unit-address (the @21 part) for the=
 button.
>> What about using a more relevant name like "key_up" instead of "butt=
on"?
>=20
> Or in my case power-key or power-button. Or would just power suffice?

=46or the example nodes of the documentation, according to the labels y=
ou=E2=80=99ll probably want to use "up" and "down" (or "key-up" and "ke=
y-down", or "up-key" and "down-key").

=46or the Geekbox, I think "power" is meaningful enough.

>=20
> The Landingship baseboard does have four more buttons not yet enabled=
,
> so I do need some way to distinguish nodes.

The labels on the board are key1, key2, key3 and key4. Maybe you can us=
e that?


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
