From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 14:46:40 +0200
Message-ID: <4C56BE30.2070807@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se> <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:53488 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab0HBMqm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Aug 2010 08:46:42 -0400
In-Reply-To: <4C56BA13.3030104@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 02-08-10 14:29, Henrik Rydberg schreef:
> On 08/02/2010 02:13 PM, =C9ric Piel wrote:
:
>>> The above tells me that the MT situation did not improve much, and =
that the
>>> major improvement is to paper over the synaptics problem.
>> For me it has changed because my argument was "with two finger we re=
port
>> crap anyway, so let's report the average". With the tracking, we
>> actually (often) report the real position of the fingers, so this
>> argument is not valid anymore. Now we can happily say we conform to =
the
>> official protocols: ST (which apparently requires to always reports =
an
>> actual position), and MT-A.
>=20
>=20
> It does not comply with MT-A as long as two semi-random corners of a =
rectangle
> are reported.
=46air enough. Without the tracking patch it complied with MT-A 50% of =
the
time, with it it's 75% of the time... I guess it's still not called
"complying" ;-)


>>> The argument to go forward implementing protocol B is that the curr=
ent patch
>>> actually does proper two-finger tracking to the extent that it is p=
ossible.
>>> Since mtdev cannot improve the fact that this device does not follo=
wing fingers
>>> but corners, it makes sense to treat this device specially, and imp=
lement the
>>> extra lines in the kernel to make it as good as it can be. Alternat=
ively, one
>>> can give up the idea of using MT in this driver altogether, and jus=
t implement
>>> the mean position ABS_X/Y, old-style.
>> Do you think that if we implement full tracking in kernel, we can do
>> _better_ than the small tracking + mtdev? I don't think so (but, hey=
,
>> I've been tinkering with multitouch for something like 20h in my lif=
e,
>> so I might have missed something ;-) ). If you have in mind a better
>> performing algorithm, then let me know, and I'll happily implement i=
t in
>> kernel :-)
>=20
>=20
> We can do better in the sense that since the device cannot comply wit=
h MT-A, we
> can do as close as possible to MT-B with less cpu usage. But frankly,=
 the best
> solution at this stage seems to be to drop MT handling altogether, si=
nce there
> does not seem to be any plan to use it.
Ah, this alternative solution is a bit boring ;-) In addition it's not
compatible with my own master plan to eventually have the "pinch to
zoom" and "rotate to rotate" gestures work on my laptop, like in Window=
s ;-)

So, let's agree on just the two patches I'm going to send to support
"better than nothing" MT-protocol for now. When, later, someone has
better ideas, he can send patches to improve MT-protocol
support/compliance. Fine?

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
