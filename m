From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] input: wacom: Fix physical size calculation for 3rd-gen Bamboo
Date: Mon, 12 Mar 2012 22:25:47 -0500
Message-ID: <CAGzDe_aNMddbMCnK61c3J+3zTOtuM9EMkf5RhbfBs0oodnsNoA@mail.gmail.com>
References: <1331592784-6894-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59079 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758762Ab2CMDZs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 23:25:48 -0400
Received: by lahj13 with SMTP id j13so72626lah.19
        for <linux-input@vger.kernel.org>; Mon, 12 Mar 2012 20:25:47 -0700 (PDT)
In-Reply-To: <1331592784-6894-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linuxwacom-devel@lists.sourceforge.net

On Mon, Mar 12, 2012 at 5:53 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> This calculation determines the physical dimensions of the tablet,
> used later on in calculate_touch_res to obtain the touch sensor
> resolution.
>
> Instead of dividing the logical size by the resolution, the current
> code performs a multiplication. This doesn't pose a problem for the
> 3rd-gen Bamboo since the resolution and scale factor happen to be
> identical, but will produce an incorrect result for other cases.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index c9588ee..dc07821 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -184,9 +184,9 @@ static int wacom_parse_logical_collection(unsigne=
d char *report,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * data before its overwritten.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_phy =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (features->x_max * feat=
ures->x_resolution) / 100;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (features->x_max * 100)=
 / features->x_resolution;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (features->y_max * feat=
ures->y_resolution) / 100;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (features->y_max * 100)=
 / features->y_resolution;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&re=
port[10]);
> --
> 1.7.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
