From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - add support for reporting x/y
	resolution
Date: Thu, 7 May 2009 20:03:46 -0700
Message-ID: <20090508030345.GD30616@dtor-d630.eng.vmware.com>
References: <1241460369.29685.6.camel@hp> <1241461145.29685.13.camel@hp> <20090507164859.GB6450@dtor-d630.eng.vmware.com> <ad348feb0905071159i68138a6cyef0d98410fc752cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:49702 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764002AbZEHDD6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 23:03:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so912112rvb.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 20:03:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ad348feb0905071159i68138a6cyef0d98410fc752cb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tero Saarni <tero.saarni@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, May 07, 2009 at 09:59:36PM +0300, Tero Saarni wrote:
> On Thu, May 7, 2009 at 19:49, Dmitry Torokhov <dmitry.torokhov@gmail.=
com> wrote:
> >> +#define ABS_RESX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x26
> >> +#define ABS_RESY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x27
> >
> > This data is not part of dynamic state of the device but rather
> > describes it's physical characteristics and as such should not be
> > transmitted as input events. We should consider extending input_abs=
info
> > and making this data available via EVIOCGABS ioctl but we need to b=
e
> > careful with keeping compatibility with existing clients.
>=20
> Thanks for your reply!
>=20
> What kind of extension do you mean?
>=20
> Making it available via EVIOCGABS ioctl was my intention too but
> extending by adding new ABS_nnn was the only obvious way I came up
> with.  All the other similar uses of input_absinfo seem to describe
> static limits of dynamic parameters (like max and min y coordinates)
> so I agree that resolution is not a perfect fit into the group,  For
> resolution I never need to call input_report_abs().
>=20

Well, we could add '__u32 resolution;' field to struct input_absinfo bu=
t
we need to be really careful not to break applications using old
(smaller) structures with newer kernels.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
