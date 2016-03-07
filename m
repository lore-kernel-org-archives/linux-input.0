From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] MAINTAINERS: Add devicetree bindings to Input Drivers section
Date: Mon, 07 Mar 2016 19:54:16 +0100
Message-ID: <2964268.geAV7fb7cP@diego>
References: <1457374694-4764-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:57260 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826AbcCGSyT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2016 13:54:19 -0500
In-Reply-To: <1457374694-4764-1-git-send-email-afaerber@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>

Am Montag, 7. M=E4rz 2016, 19:18:13 schrieb Andreas F=E4rber:
> To avoid changes to input bindings not reaching linux-input reviewers
> add an appropriate file pattern to the MAINTAINERS entry.
>=20
> Reported-by: Heiko St=FCbner <heiko@sntech.de>
> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>

not sure if it is needed, but looks good to me, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e9d47e10f59..b01a56dd7fb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5633,6 +5633,7 @@ F:	drivers/input/
>  F:	include/linux/input.h
>  F:	include/uapi/linux/input.h
>  F:	include/linux/input/
> +F:	Documentation/devicetree/bindings/input/
>=20
>  INPUT MULTITOUCH (MT) PROTOCOL
>  M:	Henrik Rydberg <rydberg@bitmath.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
