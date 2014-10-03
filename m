From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] input: alps: Reset mouse before identifying it
Date: Fri, 03 Oct 2014 11:47:59 +0200
Message-ID: <542E70CF.40205@redhat.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com> <1412329392-5580-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbaJCJsI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Oct 2014 05:48:08 -0400
In-Reply-To: <1412329392-5580-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Thanks for working on this!

On 10/03/2014 11:43 AM, Pali Roh=C3=A1r wrote:
> On some systems after starting computer function alps_identify() does=
 not detect
> dual ALPS touchpad+trackstick device correctly and detect only touchp=
ad.
>=20
> Resetting ALPS device before identifiying it fixing this problem and =
both parts
> touchpad and trackstick are detected.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Looks good and seems sensible:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/input/mouse/alps.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 35a49bf..1bd5aa1 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2403,6 +2403,8 @@ int alps_detect(struct psmouse *psmouse, bool s=
et_properties)
>  {
>  	struct alps_data dummy;
> =20
> +	psmouse_reset(psmouse);
> +
>  	if (alps_identify(psmouse, &dummy) < 0)
>  		return -1;
> =20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
