From: Terry Lambert <tlambert@chromium.org>
Subject: Re: [PATCH] Driver for Primax keyboards violating USB HID spec
Date: Thu, 13 Oct 2011 17:11:20 -0700
Message-ID: <CAA_E9NHi4mS+J5VrxS915S3TD-157D=hMG7b-PMT2c1RYvnwVQ@mail.gmail.com>
References: <1318548517-5289-1-git-send-email-tlambert@chromium.org>
	<alpine.LNX.2.00.1110140134200.14768@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:37192 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab1JNALW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 20:11:22 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p9E0BMqt000968
	for <linux-input@vger.kernel.org>; Thu, 13 Oct 2011 17:11:22 -0700
Received: from pzk34 (pzk34.prod.google.com [10.243.19.162])
	by wpaz1.hot.corp.google.com with ESMTP id p9E0BK1A000528
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 13 Oct 2011 17:11:21 -0700
Received: by pzk34 with SMTP id 34so5605636pzk.2
        for <linux-input@vger.kernel.org>; Thu, 13 Oct 2011 17:11:20 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1110140134200.14768@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri; thanks for looking so promptly!

The routine right now just caches the hi->input for later look up
during the raw input report, which I suppose could be done inline on
each report with a couple function calls.

The reasoning was that there's some =A0hardware that's going to fall
into this class that needs some key remapping done. =A0Maybe this
hardware, too, depending on what is decided about the num lock not
being on by default for a newly plugged keyboard (this specific
keyboard has no num lock key).

I don't have one of the folding keyboards people are complaining about
not being able to use for Android tablets on hand, or the unhappy Dell
Inspiron laptop, both of which use the controller  =A0That's to explain
why the remapping code and the product ID for them are missing from
this patch.

If it would make things easier, I could inline the input lookup and
just ditch the routine altogether, until I or someone else gets their
hands on the other hardware.

Thanks,
-- Terry

On Thu, Oct 13, 2011 at 4:35 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>
> On Thu, 13 Oct 2011, Terry Lambert wrote:
>
> > Primax keyboards with the issue this driver addresses report modifi=
er
> > keys as in band key events instead of as out of band modifier bits,
> > resulting in the modifier keys generating key up events immediately
> > before the keys they are intended to modify. =A0This driver rewrite=
s
> > the raw report data from such keyboards into USB HID 1.11 compliant
> > report data. =A0It only matches the USB vendor and product IDs for =
the
> > keyboard it has been tested on. Since there are several keyboards,
> > notably a number of laptops and folding USB keyboards known to have
> > similar unresolved problem reports, the list is expected to grow.
> >
> > Signed-off-by: Terry Lambert <tlambert@chromium.org>
>
> Terry,
>
> thanks for the patch.
>
> [ ... snip ... ]
> > +static int px_input_mapping(struct hid_device *hid, struct hid_inp=
ut *hi,
> > + =A0 =A0 struct hid_field *field, struct hid_usage *usage,
> > + =A0 =A0 unsigned long **bit, int *max)
> > +{
> > + =A0 =A0 struct px_device *px =3D hid_get_drvdata(hid);
> > +
> > + =A0 =A0 px->input_primax =3D hi->input;
> > +
> > + =A0 =A0 /* Remap keys, if necesssary, here */
> > +
> > + =A0 =A0 return 0;
> > +}
>
> I fail to see the point of this routine ... ?
>
> Otherwise, the patch seems fine.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
