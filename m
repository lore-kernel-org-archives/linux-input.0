From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/1] Input: don't modify the id of ioctl-provided ff
 effect on upload failure
Date: Sat, 29 Mar 2014 12:12:36 -0700
Message-ID: <20140329191236.GC10710@core.coreip.homeip.net>
References: <1396095396-23551-1-git-send-email-elias.vds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49229 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaC2TMk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Mar 2014 15:12:40 -0400
Content-Disposition: inline
In-Reply-To: <1396095396-23551-1-git-send-email-elias.vds@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, Michal =?iso-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Mar 29, 2014 at 01:16:36PM +0100, Elias Vanderstuyft wrote:
> If a new (id =3D=3D -1) ff effect was uploaded from userspace,
> ff-core.c::input_ff_upload() will have assigned
> a positive number to the new effect id.
> Currently, evdev.c::evdev_do_ioctl() will save this new id to userspa=
ce,
> regardless of whether the upload succeeded or not.
>=20
> On upload failure, this can be confusing because the dev->ff->effects=
[] array
> will not contain an element at the index of that new effect id.
>=20
> This patch fixes this by leaving the id unchanged after upload fails.
>=20
> Note: Unfortunately applications should still expect changed effect i=
d for
> quite some time.
>=20
> This has been discussed on:
> http://www.mail-archive.com/linux-input@vger.kernel.org/msg08513.html
> ("ff-core effect id handling in case of a failed effect upload")
>=20
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Elias Vanderstuyft <elias.vds@gmail.com>
> Cc: Anssi Hannula <anssi.hannula@iki.fi>
> Cc: Michal Mal=FD <madcatxster@devoid-pointer.net>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Applied, thank you, and sorry for the delay.

> ---
>  v2:
>   Only added one line to the commit message to say
>   what this patch actually does,
>   instead of only stating the reason why it's submitted.
>=20
>  drivers/input/evdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index a06e125..ce953d8 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -954,11 +954,13 @@ static long evdev_do_ioctl(struct file *file, u=
nsigned int cmd,
>  			return -EFAULT;
> =20
>  		error =3D input_ff_upload(dev, &effect, file);
> +		if (error)
> +			return error;
> =20
>  		if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
>  			return -EFAULT;
> =20
> -		return error;
> +		return 0;
>  	}
> =20
>  	/* Multi-number variable-length handlers */
> --=20
> 1.8.3.1
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
