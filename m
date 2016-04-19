From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
Date: Tue, 19 Apr 2016 17:13:49 -0500
Message-ID: <20160419221349.GA25916@rob-hp-laptop>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42619 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbcDSWNz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2016 18:13:55 -0400
Content-Disposition: inline
In-Reply-To: <1458129209-15449-1-git-send-email-afaerber@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-input@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Julien Chauveau <chauveau.julien@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

On Wed, Mar 16, 2016 at 12:53:29PM +0100, Andreas F=E4rber wrote:
> Drop #address-cells and #size-cells, which are not required by the
> gpio-keys binding documentation, as button sub-nodes are not devices.
>=20
> Rename sub-nodes to avoid new dtc unit address warnings when copied.
>=20
> While at it, adopt the dashes convention for the node name.
>=20
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Cc: Julien Chauveau <chauveau.julien@gmail.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>

Applied, thanks.

Rob

> ---
>  v1 -> v2:
>  * Changed node name from underscore to dash
>  * Inserted white lines
>  * Renamed sub-nodes (Geert, Julien)
> =20
>  Documentation/devicetree/bindings/input/gpio-keys.txt | 10 +++++----=
-
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/=
Documentation/devicetree/bindings/input/gpio-keys.txt
> index 21641236c095..a94940481e55 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -32,17 +32,17 @@ Optional subnode-properties:
> =20
>  Example nodes:
> =20
> -	gpio_keys {
> +	gpio-keys {
>  			compatible =3D "gpio-keys";
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
>  			autorepeat;
> -			button@21 {
> +
> +			up {
>  				label =3D "GPIO Key UP";
>  				linux,code =3D <103>;
>  				gpios =3D <&gpio1 0 1>;
>  			};
> -			button@22 {
> +
> +			down {
>  				label =3D "GPIO Key DOWN";
>  				linux,code =3D <108>;
>  				interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;
> --=20
> 2.6.2
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
