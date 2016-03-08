From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys example
Date: Tue, 8 Mar 2016 09:54:50 +0100
Message-ID: <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35052 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbcCHIyv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 03:54:51 -0500
In-Reply-To: <1457375055-5544-1-git-send-email-afaerber@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Julien Chauveau <chauveau.julien@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Mar 7, 2016 at 7:24 PM, Andreas F=C3=A4rber <afaerber@suse.de> =
wrote:
> Drop #address-cells and #size-cells, which are not required by the
> gpio-keys binding documentation, as button sub-nodes are not devices.
>
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/=
Documentation/devicetree/bindings/input/gpio-keys.txt
> index 21641236c095..1552a11f6786 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -34,8 +34,6 @@ Example nodes:
>
>         gpio_keys {
>                         compatible =3D "gpio-keys";
> -                       #address-cells =3D <1>;
> -                       #size-cells =3D <0>;
>                         autorepeat;
>                         button@21 {

=46YI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1c=
dd":
(http://www.spinics.net/lists/devicetree/msg117206.html) applied:

Warning (unit_address_vs_reg): Node /keyboard/button@21 has a unit
name, but no reg property

>                                 label =3D "GPIO Key UP";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
