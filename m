From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
Date: Tue, 8 Mar 2016 11:09:26 +0100
Message-ID: <56DEA4D6.10008@suse.de>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47908 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbcCHKJ3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2016 05:09:29 -0500
In-Reply-To: <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-rockchip <linux-rockchip@lists.infradead.org>, LAKML <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Julien Chauveau <chauveau.julien@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am 08.03.2016 um 09:54 schrieb Geert Uytterhoeven:
> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F=C3=A4rber <afaerber@suse.de=
> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices=
=2E
>>
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>> ---
>>  Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b=
/Documentation/devicetree/bindings/input/gpio-keys.txt
>> index 21641236c095..1552a11f6786 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> @@ -34,8 +34,6 @@ Example nodes:
>>
>>         gpio_keys {

While at it, I was told the preferred node naming would be dashes, not
underscores. The deeper we dig, the more we find.

>>                         compatible =3D "gpio-keys";
>> -                       #address-cells =3D <1>;
>> -                       #size-cells =3D <0>;
>>                         autorepeat;

Also a white line here may be optically more pleasant.

>>                         button@21 {
>=20
> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1c=
dd":
> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
>=20
> Warning (unit_address_vs_reg): Node /keyboard/button@21 has a unit
> name, but no reg property

My v2 GeekBox patch did have *-cells and a reg property, but Julien
asked I drop that: https://patchwork.kernel.org/patch/8246481/

Are you suggesting we should add a reg property here and drop this patc=
h
or go with this patch but follow up to not use @21?

>=20
>>                                 label =3D "GPIO Key UP";

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
