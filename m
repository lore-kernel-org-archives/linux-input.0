From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] HID: picoLCD: Remove use of deprecated function
Date: Thu, 6 Sep 2012 22:12:52 +0200
Message-ID: <20120906221252.1402ba50@neptune.home>
References: <1346942780-8091-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:47488 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759792Ab2IFUNn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 16:13:43 -0400
In-Reply-To: <1346942780-8091-1-git-send-email-emilgoode@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Emil Goode <emilgoode@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Tejun Heo <tj@kernel.org>

On Thu, 06 September 2012 Emil Goode <emilgoode@gmail.com> wrote:
> The flush_delayed_work_sync function is deprecated,
> we can instead call flush_delayed_work directly.
>=20
> Sparse is giving a warning:
> drivers/hid/hid-picolcd_fb.c:611:2: warning:
> 	=E2=80=98flush_delayed_work_sync=E2=80=99 is deprecated
> 	(declared at include/linux/workqueue.h:454)
> 	[-Wdeprecated-declarations]
>=20
> Signed-off-by: Emil Goode <emilgoode@gmail.com>

Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

This matches a patch by Tejun a few weeks ago which was partially
skipped in -next due to merge conflict with code split in picoLCD.

See http://comments.gmane.org/gmane.linux.kernel.next/23740

=46or the sake of proper bisectability, this should go in after
Tejun's workqueue changes (if needed at all depending on how merge
happens during pull by Linus).

Bruno

> ---
>  drivers/hid/hid-picolcd_fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_f=
b.c
> index 0008a51..eb00357 100644
> --- a/drivers/hid/hid-picolcd_fb.c
> +++ b/drivers/hid/hid-picolcd_fb.c
> @@ -608,7 +608,7 @@ void picolcd_exit_framebuffer(struct picolcd_data=
 *data)
>  	/* make sure there is no running update - thus that fbdata->picolcd
>  	 * once obtained under lock is guaranteed not to get free() under
>  	 * the feet of the deferred work */
> -	flush_delayed_work_sync(&info->deferred_work);
> +	flush_delayed_work(&info->deferred_work);
> =20
>  	data->fb_info =3D NULL;
>  	unregister_framebuffer(info);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
