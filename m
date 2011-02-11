From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/4] input - wacom: Support 2FGT in MT format
Date: Fri, 11 Feb 2011 23:05:19 +0100
Message-ID: <20110211220518.GB7375@polaris.bitmath.org>
References: <1297387983-13761-1-git-send-email-pinglinux@gmail.com>
 <20110211202010.GB2287@polaris.bitmath.org>
 <AANLkTimBPBDCBzw0fbDpLf8F7N_zG+ceKJAC9Li15g5P@mail.gmail.com>
 <20110211204742.GD2287@polaris.bitmath.org>
 <AANLkTinmUVW+cK1PJnCxiLSv1DiMQC-KkkeoAHVyckZe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:50664 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757392Ab1BKWEs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 17:04:48 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinmUVW+cK1PJnCxiLSv1DiMQC-KkkeoAHVyckZe@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

> >> The above statement is to avoid going through the input_mt_slot an=
d
> >> input_mt_report_slot_state routines without posting any meaningful
> >> events. I guess it could be considered as a performance enhancemen=
t?
> >
> > It won't be posting events unless something changed.
>=20
> But it still go through the  input_mt_slot and
> input_mt_report_slot_state routines, which is unnecessary. If we know
> up front there is no events posting, what benefit do we get to go
> through the routines?

Clarity. :-)

> >> Which case makes you nervous? I'll take care of it ;).
> >
> > Well, removing the logic above would suffice. :-)
>=20
> Yeah, I see one benefit here ;). I can remove that if others see the =
same issue.

Thanks.

> >> No, =A0wacom_tpc_mt_touch can set touch_down to false too. When to=
uch is
> >> false, touch_down will be false. This happens when pen in prox or =
when
> >> both fingers are up.
> >
> > Now, that is what cannot happen, because of the max() function.
>=20
> This time is real. How about this one?
>=20
>=20
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 39c289d..3cdafb9 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -699,7 +699,10 @@ static int wacom_tpc_mt_touch(struct wacom_wac *=
wacom)
>                 }
>=20
>                 /* keep touch bit to send proper touch up event */
> -               wacom->shared->touch_down =3D max(touch,
> wacom->shared->touch_down);
> +               if (i =3D=3D 1)
> +                       wacom->shared->touch_down =3D max(touch,
> wacom->shared->touch_down);
> +               else
> +                       wacom->shared->touch_down =3D touch;
>         }
>=20
>         input_mt_report_pointer_emulation(input, true);

Well... it might help to return to what the main goal is here. If the
purpose is to fix userspace, maybe it should actually be done in
userspace instead.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
