From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: elantech touchpad issues
Date: Tue, 13 Sep 2011 09:27:24 +0800
Message-ID: <877h5d44g3.fsf@emc.com.tw>
References: <4E6633E5.6080108@t-online.de> <87sjo7oef3.fsf@emc.com.tw> <4E6906B9.1080205@t-online.de> <4E6DC5F6.7090008@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:5586 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab1IMBYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Sep 2011 21:24:55 -0400
In-Reply-To: <4E6DC5F6.7090008@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>, Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>
Cc: linux-input@vger.kernel.org, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>

Hi =C3=89ric, Richard,

On Mon, 12 Sep 2011 10:42:30 +0200, =C3=89ric Piel <E.A.B.Piel@tudelft.=
nl> wrote:
> Op 08-09-11 20:17, Richard Sch=C3=BCtz schreef:
> > Am 08.09.2011 06:18, schrieb JJ Ding:
> >
> > Yeah, this fixes the annoying issue with multiple fingers.
> >
> > Now only the problem with the wrong axis ranges is remaining.
> >
>=20
> I've tried with my version of the hardware (a old v2) and it doesn't=20
> seem to have the problem you describe.
>=20
> Basically your problem is that the driver reports ranges as 0-1152 an=
d=20
> 0-576, but in reality, when you move your finger, the coordinates sta=
y=20
> in the ranges 0-819, 171-576. So in practice the cursor moves as=20
> expected but the borders to allow the scrolling don't work. Is that r=
ight?
>=20
> I wonder if it's normal that the device has a range even smaller than=
=20
> what it reports, and whether something can be done. JJ Ding?

I asked our firmware team and windows team, the v2 hardware is such a
wild beast. ;-) It has many variants WRT x, y ranges (due to different
scanning methods the hardware is using.) I am preparing a patch that
will hopefully fix this issue for all the v2 variants.

jj

> Cheers,
> =C3=89ric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
