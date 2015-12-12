From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sunxi LRADC-keys: allwinner,sun4i-a10-lradc-keys
 binding: typo fix
Date: Sat, 12 Dec 2015 14:25:46 -0800
Message-ID: <20151212222546.GB40689@dtor-ws>
References: <1449931675-5775-1-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33743 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbLLWZt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2015 17:25:49 -0500
Received: by pfnn128 with SMTP id n128so84672250pfn.0
        for <linux-input@vger.kernel.org>; Sat, 12 Dec 2015 14:25:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449931675-5775-1-git-send-email-merker@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

On Sat, Dec 12, 2015 at 03:47:55PM +0100, Karsten Merker wrote:
> Trivial typo fix ("mut" -> "must") in the sunxi LRADC-keys binding
> documentation.
>=20
> Signed-off-by: Karsten Merker <merker@debian.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> This patch was originally part of a sunxi board dts patch series
> (whereby I stumbled over the typo in the binding docs), but the =20
> sunxi maintainers indicated that it should go through the input
> tree, so here we go ;-).

Applied, thank you.

>=20
> Regards,
> Karsten
>=20
>  Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys=
=2Etxt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> index b9c32f6..4357e49 100644
> --- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> +++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> @@ -12,7 +12,7 @@ Each key is represented as a sub-node of "allwinner=
,sun4i-a10-lradc-keys":
>  Required subnode-properties:
>  	- label: Descriptive name of the key.
>  	- linux,code: Keycode to emit.
> -	- channel: Channel this key is attached to, mut be 0 or 1.
> +	- channel: Channel this key is attached to, must be 0 or 1.
>  	- voltage: Voltage in =B5V at lradc input when this key is pressed.
> =20
>  Example:
> --=20
> 2.1.4
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
