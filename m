From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: picolcd: sanity check report size in raw_event()
 callback
Date: Wed, 27 Aug 2014 10:25:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408271025040.2992@pobox.suse.cz>
References: <alpine.LNX.2.00.1408270911130.2992@pobox.suse.cz> <alpine.LNX.2.00.1408270912310.2992@pobox.suse.cz> <20140827101311.098f3fd1@pluto>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58705 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbaH0IZv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2014 04:25:51 -0400
In-Reply-To: <20140827101311.098f3fd1@pluto>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 27 Aug 2014, Bruno Pr=C3=A9mont wrote:

> > The report passed to us from transport driver could potentially be=20
> > arbitrarily large, therefore we better sanity-check it so that raw_=
data=20
> > that we hold in picolcd_pending structure are always kept within pr=
oper=20
> > bounds.
> >=20
> > Cc: stable@vger.kernel.org
> > Reported-by: Steven Vittitoe <scvitti@google.com>
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>=20
> Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Thanks.

> > ---
> >  drivers/hid/hid-picolcd_core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picol=
cd_core.c
> > index acbb0210..020df3c 100644
> > --- a/drivers/hid/hid-picolcd_core.c
> > +++ b/drivers/hid/hid-picolcd_core.c
> > @@ -350,6 +350,12 @@ static int picolcd_raw_event(struct hid_device=
 *hdev,
> >  	if (!data)
> >  		return 1;
> > =20
> > +	if (size > 64) {
> > +		hid_warn(hdev, "invalid size value (%d) for picolcd raw event\n"=
,
> > +				size);
>=20
> Is it worth adding report->id to this hid_warn()?
>=20
> A valid device is not expected to ever send >64 bytes reports but in
> case a firmware update would do so it would help to know for which
> report it was.

It definitely wouldn't hurt. Pull request with the original patch is no=
w=20
on its way to Linus though, so let's do this as a followup patch on top=
=20
once this is merged.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
