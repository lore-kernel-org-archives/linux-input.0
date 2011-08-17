From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - correct x, y value range for v2
 hardware
Date: Tue, 16 Aug 2011 23:43:36 -0700
Message-ID: <20110817064336.GA29361@core.coreip.homeip.net>
References: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw>
 <87hb5hligi.fsf@emc.com.tw>
 <4E4AE637.1090000@tudelft.nl>
 <87aab86d3v.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62033 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab1HQGno (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 02:43:44 -0400
Received: by iye16 with SMTP id 16so1316904iye.1
        for <linux-input@vger.kernel.org>; Tue, 16 Aug 2011 23:43:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87aab86d3v.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>

Hi JJ,

On Wed, Aug 17, 2011 at 09:28:04AM +0800, JJ Ding wrote:
> Hi =C9ric,
>=20
> Thanks for the reply.
>=20
> On Tue, 16 Aug 2011 23:50:47 +0200, =C9ric Piel <E.A.B.Piel@tudelft.n=
l> wrote:
> > On 16-08-11 13:11, JJ Ding wrote:
> > > Hi Dmitry,
> > >
> > > What do you think about this patch?
> > > This is really a simple correction, I am wondering if it's OK to =
push
> > > this to 3.1?
> > Hi JJ Ding,
> > The merge window of 3.1 is already closed, so only patches which fi=
x=20
> > bugs are accepted. Is there any hardware already available for whic=
h=20
> > this patch solves a bug? That would be a great incentive to push it
> > > :-)
> As far as I know, this doesn't fix a bug. I just want to make sure th=
e
> driver and what the firmware sends are consistent.

As =C9ric mentioned, simply extending range to 12 bits is dangerous
because we might cause overflows. Blindly increasing ETP_YMAX_V2 is not
a good idea either as userspace would expect much larger device and
reports would only cover fraction of its surface. We need to separate
ETP_YMAX_V2 as absolute maximum from reported coordinates range, like i=
t
is done in synaptics driver.

>=20
> Thank you for telling me this. I will try this again with newer hardw=
are
> support patches, aiming for 3.2 inclusion.

Yes, if hardware currently supported by mainline version of the driver
is not affected it is better to queue the patch[es] for 3.2. BTW, that
means that you should not wait till 3.2 merge window opens as we'll nee=
d
time to review the patches and get them into my 'next' branch.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
