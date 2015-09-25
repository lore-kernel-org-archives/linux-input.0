From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] input: fix data race __ps2_command
Date: Fri, 25 Sep 2015 13:38:11 +0200
Message-ID: <20150925113811.GG27119@pali>
References: <1441634675-114118-1-git-send-email-dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34766 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbbIYLiO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2015 07:38:14 -0400
Content-Disposition: inline
In-Reply-To: <1441634675-114118-1-git-send-email-dvyukov@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, andreyknvl@google.com, kcc@google.com, glider@google.com, ktsan@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>

On Monday 07 September 2015 16:04:35 Dmitry Vyukov wrote:
> The data race happens on ps2dev->cmdcnt and ps2dev->cmdbuf contents.
> __ps2_command reads that data concurrently with the interrupt handler=
=2E
> As the result, for example, if a response arrives just after the
> timeout, __ps2_command can copy out garbage from ps2dev->cmdbuf
> but then see that ps2dev->cmdcnt is 0 and return success.
>=20
> Stop the interrupt handler with serio_pause_rx() before
> reading the results.
>=20
> The data race was found with KernelThreadSanitizer (KTSAN).
>=20
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  drivers/input/serio/libps2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps=
2.c
> index 7551699..8f93336 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -234,17 +234,19 @@ int __ps2_command(struct ps2dev *ps2dev, unsign=
ed char *param, int command)
>  				   !(ps2dev->flags & PS2_FLAG_CMD), timeout);
>  	}
> =20
> +	serio_pause_rx(ps2dev->serio);
>  	if (param)
>  		for (i =3D 0; i < receive; i++)
>  			param[i] =3D ps2dev->cmdbuf[(receive - 1) - i];
> =20
>  	if (ps2dev->cmdcnt && (command !=3D PS2_CMD_RESET_BAT || ps2dev->cm=
dcnt !=3D 1))
> -		goto out;
> -
> +		goto out_paused;
>  	rc =3D 0;
> +	goto out_paused;
> =20
>   out:
>  	serio_pause_rx(ps2dev->serio);
> +out_paused:
>  	ps2dev->flags =3D 0;
>  	serio_continue_rx(ps2dev->serio);
> =20

Hi! Was this patch queued? Or is there any problem with it? Because I
did not see any response for more weeks on any mailing list.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
