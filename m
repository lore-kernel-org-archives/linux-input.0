From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Elantech- add new icbody type
Date: Thu, 4 Jun 2015 22:31:15 -0700
Message-ID: <20150605053115.GA29704@dtor-ws>
References: <013b01d09dd7$03856e30$0a904a90$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36279 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbbFEFbT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 01:31:19 -0400
Received: by ieclw1 with SMTP id lw1so51062597iec.3
        for <linux-input@vger.kernel.org>; Thu, 04 Jun 2015 22:31:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <013b01d09dd7$03856e30$0a904a90$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5rSq5LiA56u5?= <sam.hung@emc.com.tw>
Cc: linux-input@vger.kernel.org, 'duson' <dusonlin@emc.com.tw>

On Wed, Jun 03, 2015 at 04:26:33PM +0800, =E6=B4=AA=E4=B8=80=E7=AB=B9  =
wrote:
>=20
> add new icbody type for the h/w connect with elantech driver.
>=20
> Signed-off-by: Sam <sam.hung@emc.com.tw>

Applied, thank you.

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

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
