From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] hid: picolcd: testing the wrong variable
Date: Fri, 6 Aug 2010 14:54:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008061453470.29919@pobox.suse.cz>
References: <20100806062848.GL9031@bicker> <20100806100804.4b920829@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45775 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755984Ab0HFMyY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Aug 2010 08:54:24 -0400
In-Reply-To: <20100806100804.4b920829@pluto.restena.lu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dan Carpenter <error27@gmail.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 6 Aug 2010, Bruno Pr=E9mont wrote:

> Thanks for spotting!
>=20
> But while fixing this one also fix the ordering (which was never
> reached due to this wrong check) a few lines later.
>=20
> Patch (combined) at the end.
>=20
> Thanks,
> Bruno
>=20
>=20
> On Fri, 6 Aug 2010 08:28:49 Dan Carpenter <error27@gmail.com> wrote:
> > "ref_cnt" is a point to the reference count and it's non-null.  We =
really
> > want to test the reference count itself.
> >=20
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> >=20
> > diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> > index 346f0e3..c0bdeba 100644
> > --- a/drivers/hid/hid-picolcd.c
> > +++ b/drivers/hid/hid-picolcd.c
> > @@ -547,7 +547,7 @@ static void picolcd_fb_destroy(struct fb_info *=
info)
> >  	ref_cnt--;
> >  	mutex_lock(&info->lock);
> >  	(*ref_cnt)--;
> > -	may_release =3D !ref_cnt;
> > +	may_release =3D !*ref_cnt;
> >  	mutex_unlock(&info->lock);
> >  	if (may_release) {
> >  		framebuffer_release(info);
>=20
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -547,11 +547,11 @@ static void picolcd_fb_destroy(struct fb
>  	ref_cnt--;
>  	mutex_lock(&info->lock);
>  	(*ref_cnt)--;
> -	may_release =3D !ref_cnt;
> +	may_release =3D !*ref_cnt;
>  	mutex_unlock(&info->lock);
>  	if (may_release) {
> -		framebuffer_release(info);
>  		vfree((u8 *)info->fix.smem_start);
> +		framebuffer_release(info);
>  	}
>  }

I have applied the patch fixing the ordering, along with adding

	Signed-off-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>

to it. Please shoud if that is not proper.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
