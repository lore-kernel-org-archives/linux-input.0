From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 15:03:15 +0200
Message-ID: <4C56C213.2010605@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se> <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se> <4C56BE30.2070807@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:52502 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202Ab0HBNEk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Aug 2010 09:04:40 -0400
In-Reply-To: <4C56BE30.2070807@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 08/02/2010 02:46 PM, =C9ric Piel wrote:

[...]

>>
>> We can do better in the sense that since the device cannot comply wi=
th MT-A, we
>> can do as close as possible to MT-B with less cpu usage. But frankly=
, the best
>> solution at this stage seems to be to drop MT handling altogether, s=
ince there
>> does not seem to be any plan to use it.
> Ah, this alternative solution is a bit boring ;-) In addition it's no=
t
> compatible with my own master plan to eventually have the "pinch to
> zoom" and "rotate to rotate" gestures work on my laptop, like in Wind=
ows ;-)


Since rotational symmetry is what prevents us from implementing proper =
MT
support, it is not likely going to work anyways.

> So, let's agree on just the two patches I'm going to send to support
> "better than nothing" MT-protocol for now. When, later, someone has
> better ideas, he can send patches to improve MT-protocol
> support/compliance. Fine?


No. I think it is fair to say we tried to make it work properly, but th=
e (known)
information about the device is simply not enough. As long as MT does n=
ot work
properly, there is no point in adding it at all - in particular not an =
elaborate
solution. I can see that zoom would work even with a poor MT implementa=
tion, but
that is not what the MT protocol is about. Maybe one day someone will f=
ind the
missing information somewhere in the packets.

=46or your usecase, perhaps one should add ABS_ZOOM etcetera instead, a=
nd patch up
synaptics to use those values.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
