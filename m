From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Thu, 28 Jul 2016 21:33:30 +0200
Message-ID: <20160728193330.GA11657@amd>
References: <20160717184209.GA30119@amd>
 <20160717185134.GA20462@deathstar>
 <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly>
 <20160721063234.GA14200@amd>
 <20160725145620.GY29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48955 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbcG1Tdd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 15:33:33 -0400
Content-Disposition: inline
In-Reply-To: <20160725145620.GY29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com

Hi!

On Mon 2016-07-25 16:56:20, Pali Roh=E1r wrote:
> On Thursday 21 July 2016 08:32:34 Pavel Machek wrote:
> > Ok.. so out of the box, touchscreen is "upside down" and miscalibra=
ted
> > on n900. So I need to run
> >=20
> > xinput --set-prop --type=3Dfloat 8 115  1.10 0.00 -0.05  0.00 1.18 =
-0.10 0.00 0.00 1.00
> > xinput --set-prop --type=3Dint 8 249 0 1
>=20
> What these commands do? Or how they change driver behavior?

> As Dmitry wrote, it is possible to move at list "upside down" switch =
to
> kernel/DTS? I think that every N900 touchscreen acts "upside down" by
> default...

I don't think that's enough. Its upside down + slightly shifted. If
you have time you can try, but...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
