From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 13/14] HID: picolcd_core: validate output report
 details
Date: Wed, 4 Sep 2013 12:04:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041203200.3684@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282222460.22181@pobox.suse.cz> <20130831140415.7837c1c9@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48154 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934486Ab3IDKEg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 06:04:36 -0400
In-Reply-To: <20130831140415.7837c1c9@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>

On Sat, 31 Aug 2013, Bruno Pr=E9mont wrote:

> Hi Kees, Jiri,
>=20
> On Wed, 28 August 2013 Jiri Kosina <jkosina@suse.cz> wrote:
> > From: Kees Cook <keescook@chromium.org>
> >=20
> > A HID device could send a malicious output report that would cause =
the
> > picolcd HID driver to trigger a NULL dereference during attr file w=
riting.
> >=20
> > CVE-2013-2899
> >=20
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Cc: stable@kernel.org
> > ---
> >  drivers/hid/hid-picolcd_core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picol=
cd_core.c
> > index b48092d..72bba1e 100644
> > --- a/drivers/hid/hid-picolcd_core.c
> > +++ b/drivers/hid/hid-picolcd_core.c
> > @@ -290,7 +290,7 @@ static ssize_t picolcd_operation_mode_store(str=
uct device *dev,
> >  		buf +=3D 10;
> >  		cnt -=3D 10;
> >  	}
> > -	if (!report)
> > +	if (!report || report->maxfield < 1)
>=20
> Please do
>   +     if (!report || report->maxfield !=3D 1)
>=20
> That way we are consistent with whole picolcd driver and a device
> deciding to change its HID-ABI will be properly detected.
>=20
> With that adjustment, Acked-by/Reviewed-by me

Applied with that adjustment. Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
