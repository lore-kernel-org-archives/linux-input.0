From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 20:11:06 +0200
Message-ID: <4BE1B4BA.3050209@euromail.se>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1A591.3020201@tudelft.nl> <20100505180528.GI6075@perldition.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:54417 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756136Ab0EESLx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 May 2010 14:11:53 -0400
In-Reply-To: <20100505180528.GI6075@perldition.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Ragwitz <rafl@debian.org>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

=46lorian Ragwitz wrote:
> On Wed, May 05, 2010 at 07:06:25PM +0200, =C9ric Piel wrote:
>> Op 05-05-10 18:38, Dmitry Torokhov schreef:
>>> Where is the proprietary driver BTW? Do we even care? I'd probably =
get
>>> rid of HAT abuse if our standard tools provide good user experience=
=2E
>> Actually I had never heard of a proprietary driver before reading th=
e
>> code ;-) Maybe Florian knows?
>=20
> No, unfortunately he doesn't.
>=20
> I've only ever heard of it through the comment in the current driver.
> I've tried to find them, but failed.
>=20
> git blames Arjan Opmeer <arjan@opmeer.net> for the comment, but he se=
ems
> a little unresponsive these days.
>=20
>=20

Speaking of proprietary drivers (sorry for going OT here), I am curious=
 about
the development around synaptics. Has anyone seen any attempt to add MT=
 events
for their new touchpads?

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
