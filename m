From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 13:33:38 +0200
Message-ID: <4C56AD12.1080106@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se> <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:49774 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab0HBLdl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Aug 2010 07:33:41 -0400
In-Reply-To: <4C56AA67.8000902@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 02-08-10 13:22, Henrik Rydberg schreef:
> On 08/02/2010 01:12 PM, =C9ric Piel wrote:
:
>>> You need to add the tracking id and a couple of lines, but i do not=
 see why the
>>> 2->1 transition would be treated any differently. The one-finger co=
ordinate
>>> would be close to either position[0] or position[1], which would de=
termine the
>>> tracking id to keep. Every time you add a finger you add a new trac=
king id. What
>>> is your planned support for three fingers?
>> Yes, yes, it's probably fairly easy to do some kind of tracking. But=
 I
>> think that as long as the hardware does not provide such a thing, it=
's
>> better to do the minimum in kernel space, just enough to be meaningf=
ul,
>> and leave the rest to userspace.
>=20
>=20
> The implemented part could also be done in userspace. Going half-way =
just to
> circumvent buggy behavior in synaptics is really not a good idea.
No, we've been going from protocol 0.5 (report max/min coordinates) to
protocol A.5 (report finger positions, often with correct track ID). My
argument is that it's not because we are half-way to B, by chance, that
we should go up to it. We do just the minimum to respect the minimum
protocol. Once the driver respects that protocol, all the fancy stuff
has to stay in userspace. There is already mtdev (I'm sure I don't have
to tell you ;-) ), I don't see the point of doing some copy-pasting.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
