From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] elantech: Fix detection of touchpads where the
 revision matches a known rate
Date: Tue, 2 Jun 2015 10:41:37 -0700
Message-ID: <20150602174137.GA11297@dtor-ws>
References: <1433237617-12495-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35622 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260AbbFBRlm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jun 2015 13:41:42 -0400
Content-Disposition: inline
In-Reply-To: <1433237617-12495-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Ulrik de Bie <ulrik.debie-os@e2big.org>, linux-input@vger.kernel.org, stable@vger.kernel.org

On Tue, Jun 02, 2015 at 11:33:37AM +0200, Hans de Goede wrote:
> Make the check to skip the rate check more lax, so that it applies
> to all hw_version 4 models.
>=20
> This fixes the touchpad not being detected properly on Asus PU551LA
> laptops.
>=20
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: David Zafra G=F3mez <dezeta@klo.es>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
> Changes in v2:
> -Update the comment above the check to match the new code
> ---
>  drivers/input/mouse/elantech.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 79363b6..f181d73 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1376,10 +1376,11 @@ static bool elantech_is_signature_valid(const=
 unsigned char *param)
>  		return true;
> =20
>  	/*
> -	 * Some models have a revision higher then 20. Meaning param[2] may
> -	 * be 10 or 20, skip the rates check for these.
> +	 * Some hw_version >=3D 4 models have a revision higher then 20. Me=
aning
> +	 * that param[2] may be 10 or 20, skip the rates check for these.
>  	 */
> -	if (param[0] =3D=3D 0x46 && (param[1] & 0xef) =3D=3D 0x0f && param[=
2] < 40)
> +	if ((param[0] & 0x0f) >=3D 0x06 && (param[1] & 0xaf) =3D=3D 0x0f &&
> +	    param[2] < 40)
>  		return true;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(rates); i++)
> --=20
> 2.4.2
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
