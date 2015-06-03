From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] Input: Elantech- add new icbody type
Date: Wed, 3 Jun 2015 19:59:08 +0200
Message-ID: <20150603175908.GA22351@lantern>
References: <013b01d09dd7$03856e30$0a904a90$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:54660 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbbFCR7Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jun 2015 13:59:16 -0400
Content-Disposition: inline
In-Reply-To: <013b01d09dd7$03856e30$0a904a90$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5rSq5LiA56u5?= <sam.hung@emc.com.tw>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 'duson' <dusonlin@emc.com.tw>

Dear Sam,

Do you also have fw_version and caps that can be entered in the Laptop-=
model
table ? The highest number there is currently 8 ..

Thanks,
Kind regards,
Ulrik
On Wed, Jun 03, 2015 at 04:26:33PM +0800, =E6=B4=AA=E4=B8=80=E7=AB=B9  =
wrote:
>=20
>=20
> add new icbody type for the h/w connect with elantech driver.
>=20
> Signed-off-by: Sam <sam.hung@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 79363b6..af40c59 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1555,6 +1555,7 @@ static int elantech_set_properties(struct
> elantech_data *etd)
>  		case 9:
>  		case 10:
>  		case 13:
> +		case 14:
>  			etd->hw_version =3D 4;
>  			break;
>  		default:
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
