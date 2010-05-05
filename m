From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT
 messages
Date: Wed, 5 May 2010 11:25:42 -0700
Message-ID: <20100505182541.GG7337@core.coreip.homeip.net>
References: <4BE1629E.50901@tudelft.nl>
 <20100505163832.GA7337@core.coreip.homeip.net>
 <4BE1A591.3020201@tudelft.nl>
 <20100505180528.GI6075@perldition.org>
 <4BE1B4BA.3050209@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55742 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757371Ab0EESZ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 14:25:56 -0400
Received: by wyb35 with SMTP id 35so572518wyb.19
        for <linux-input@vger.kernel.org>; Wed, 05 May 2010 11:25:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE1B4BA.3050209@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Florian Ragwitz <rafl@debian.org>, =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, May 05, 2010 at 08:11:06PM +0200, Henrik Rydberg wrote:
> Florian Ragwitz wrote:
> > On Wed, May 05, 2010 at 07:06:25PM +0200, =C9ric Piel wrote:
> >> Op 05-05-10 18:38, Dmitry Torokhov schreef:
> >>> Where is the proprietary driver BTW? Do we even care? I'd probabl=
y get
> >>> rid of HAT abuse if our standard tools provide good user experien=
ce.
> >> Actually I had never heard of a proprietary driver before reading =
the
> >> code ;-) Maybe Florian knows?
> >=20
> > No, unfortunately he doesn't.
> >=20
> > I've only ever heard of it through the comment in the current drive=
r.
> > I've tried to find them, but failed.
> >=20
> > git blames Arjan Opmeer <arjan@opmeer.net> for the comment, but he =
seems
> > a little unresponsive these days.
> >=20
> >=20
>=20
> Speaking of proprietary drivers (sorry for going OT here), I am curio=
us about
> the development around synaptics. Has anyone seen any attempt to add =
MT events
> for their new touchpads?
>=20

Unfortunately they are not willing/able/ready to disclose their MT
protocol so unless someone spends time and reverse-engineer it - not at
this moment.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
