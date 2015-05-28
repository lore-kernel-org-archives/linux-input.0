From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] elantech: Fix detection of touchpads where the revision
 matches a known rate
Date: Thu, 28 May 2015 20:19:48 +0200
Message-ID: <20150528181947.GA2572@lantern>
References: <1432804171-3878-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:43167 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826AbbE1Sn5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 14:43:57 -0400
Content-Disposition: inline
In-Reply-To: <1432804171-3878-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org

Hi Hans,
On Thu, May 28, 2015 at 11:09:31AM +0200, Hans de Goede wrote:
>=20
> Make the check to skip the rate check more lax, so that it applies
> to all hw_version 4 models.
>=20
> This fixes the touchpad not being detected properly on Asus PU551LA
> laptops.
>=20
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: David Zafra G=F3mez <dezeta@klo.es>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/elantech.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 79363b6..e605303 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1379,7 +1379,8 @@ static bool elantech_is_signature_valid(const u=
nsigned char *param)
>  	 * Some models have a revision higher then 20. Meaning param[2] may
>  	 * be 10 or 20, skip the rates check for these.
>  	 */
Would it not be best to also update the comment here ? That it will ski=
p rate
check in that case for all hw version 4+ when revision is higher than .=
=2E

> -	if (param[0] =3D=3D 0x46 && (param[1] & 0xef) =3D=3D 0x0f && param[=
2] < 40)
> +	if ((param[0] & 0x0f) >=3D 0x06 && (param[1] & 0xaf) =3D=3D 0x0f &&
> +	    param[2] < 40)
>  		return true;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(rates); i++)
> --=20
> 2.4.1
>=20

Kind regards,
Ulrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
