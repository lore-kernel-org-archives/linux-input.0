From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
Date: Tue, 8 Mar 2016 11:16:30 +0100
Message-ID: <56DEA67E.8090704@suse.de>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
 <525564DD-D0D3-4DEB-9306-3A23288FD83F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48840 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbcCHKQd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2016 05:16:33 -0500
In-Reply-To: <525564DD-D0D3-4DEB-9306-3A23288FD83F@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julien Chauveau <chauveau.julien@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-rockchip <linux-rockchip@lists.infradead.org>, LAKML <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am 08.03.2016 um 10:41 schrieb Julien Chauveau:
> Le 8 mars 2016 =C3=A0 09:54, Geert Uytterhoeven <geert@linux-m68k.org=
> a =C3=A9crit :
>> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F=C3=A4rber <afaerber@suse.d=
e> wrote:
>>> Drop #address-cells and #size-cells, which are not required by the
>>> gpio-keys binding documentation, as button sub-nodes are not device=
s.
>>>
>>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>>> ---
>>> Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>>> 1 file changed, 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt =
b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> index 21641236c095..1552a11f6786 100644
>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> @@ -34,8 +34,6 @@ Example nodes:
>>>
>>>        gpio_keys {
>>>                        compatible =3D "gpio-keys";
>>> -                       #address-cells =3D <1>;
>>> -                       #size-cells =3D <0>;
>>>                        autorepeat;
>>>                        button@21 {
>>
>> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1=
cdd":
>> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
>>
>> Warning (unit_address_vs_reg): Node /keyboard/button@21 has a unit
>> name, but no reg property
>>
>=20
> Hi Andreas,
> This means you can also drop the unit-address (the @21 part) for the =
button.
> What about using a more relevant name like "key_up" instead of "butto=
n"?

Or in my case power-key or power-button. Or would just power suffice?

The Landingship baseboard does have four more buttons not yet enabled,
so I do need some way to distinguish nodes.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton; HRB 21284 (AG=
 N=C3=BCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
