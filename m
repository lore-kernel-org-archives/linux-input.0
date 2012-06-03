From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: wacom: Remove code duplication
Date: Sun, 3 Jun 2012 16:45:52 -0500
Message-ID: <CAGzDe_YGJPbJncEpKJvUg-H1AYYk2w=hoggdPRJ-X+RPMw8nfw@mail.gmail.com>
References: <1338568741-28365-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61533 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754701Ab2FCVpx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 3 Jun 2012 17:45:53 -0400
Received: by lahd3 with SMTP id d3so2575118lah.19
        for <linux-input@vger.kernel.org>; Sun, 03 Jun 2012 14:45:52 -0700 (PDT)
In-Reply-To: <1338568741-28365-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Jun 1, 2012 at 11:39 AM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> Replaces code to calculate Intuos5 physical dimensions with a call
> to an existing function that performs the same task.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 =A05 +----
> =A01 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index b3a8bd3..50a804d 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -1144,10 +1144,7 @@ static int wacom_probe(struct usb_interface *i=
ntf, const struct usb_device_id *i
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->device_type =
=3D BTN_TOOL_FINGER;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D W=
ACOM_PKGLEN_BBTOUCH3;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (featur=
es->x_max * 100) / features->x_resolution;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (featur=
es->y_max * 100) / features->y_resolution;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_set_phy_from_res(=
features);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D 40=
96;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D 40=
96;
> --
> 1.7.10.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
