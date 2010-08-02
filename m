From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 14:29:07 +0200
Message-ID: <4C56BA13.3030104@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se> <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:35020 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969Ab0HBM3y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Aug 2010 08:29:54 -0400
In-Reply-To: <4C56B686.60606@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 08/02/2010 02:13 PM, =C9ric Piel wrote:

> Op 02-08-10 13:46, Henrik Rydberg schreef:
>> On 08/02/2010 01:33 PM, =C9ric Piel wrote:
> :
>>>> The implemented part could also be done in userspace. Going half-w=
ay just to
>>>> circumvent buggy behavior in synaptics is really not a good idea.
>>> No, we've been going from protocol 0.5 (report max/min coordinates)=
 to
>>> protocol A.5 (report finger positions, often with correct track ID)=
=2E My
>>> argument is that it's not because we are half-way to B, by chance, =
that
>>> we should go up to it. We do just the minimum to respect the minimu=
m
>>> protocol. Once the driver respects that protocol, all the fancy stu=
ff
>>> has to stay in userspace. There is already mtdev (I'm sure I don't =
have
>>> to tell you ;-) ), I don't see the point of doing some copy-pasting=
=2E
>>
>>
>> Without this patch, the driver reports two points, the lower-left an=
d
>> upper-right of a rectangle. With this patch, the driver reports two =
points,
>> which is either equal to the two actual fingers, or, after resting t=
he fingers
>> horizontally, two random opposite corners of a rectangle.
> Yes, exactly.
>=20
>> Doing userspace tracking without the patch results in properly follo=
wing the
>> lower-left and upper-right corners of a triangle. Doing userspace tr=
acking with
>> the patch results in properly following two random opposite corners =
of a rectangle.
> Yes, with "random opposite" being "quite often the actual corners whe=
re
> the fingers are".


Right. It is not very compelling for someone actually trying to use the=
 MT
points to anything useful.

>> Without this patch, synaptics shows jerky behavior. With this patch,=
 synaptics
>> works a bit better.
> No. This patch, doing the tracking, doesn't change at all the behavio=
ur
> with synaptics.
>=20
> Synaptics already detects the transitions between singletap/doubletap=
,
> and avoid cursor jumps. So tracking the finger doesn't help. The only
> patch that ever helped was the one in the subject of this email:
> reporting the double touch in ST-protocol as the middle of the two
> touches. That helps a lot when you do scrolling with one finger fixed
> and one finger moving (because without it half of the time nothing
> happens). If your gesture is to move both fingers at the same time, i=
t
> has always worked fine.


So "this patch" got intermingled. The part that you describe is the par=
t that I
was referring to.

> The tracking patch improves cursor jumps for other userspace apps whi=
ch
> do not detect singletap/doubletap transitions... but in practice I do=
n't
> know any other app that read the touchpad events! So that's not a big
> improvement ;-)


Right.

>> The above tells me that the MT situation did not improve much, and t=
hat the
>> major improvement is to paper over the synaptics problem.
> For me it has changed because my argument was "with two finger we rep=
ort
> crap anyway, so let's report the average". With the tracking, we
> actually (often) report the real position of the fingers, so this
> argument is not valid anymore. Now we can happily say we conform to t=
he
> official protocols: ST (which apparently requires to always reports a=
n
> actual position), and MT-A.


It does not comply with MT-A as long as two semi-random corners of a re=
ctangle
are reported.

>> The argument to go forward implementing protocol B is that the curre=
nt patch
>> actually does proper two-finger tracking to the extent that it is po=
ssible.
>> Since mtdev cannot improve the fact that this device does not follow=
ing fingers
>> but corners, it makes sense to treat this device specially, and impl=
ement the
>> extra lines in the kernel to make it as good as it can be. Alternati=
vely, one
>> can give up the idea of using MT in this driver altogether, and just=
 implement
>> the mean position ABS_X/Y, old-style.
> Do you think that if we implement full tracking in kernel, we can do
> _better_ than the small tracking + mtdev? I don't think so (but, hey,
> I've been tinkering with multitouch for something like 20h in my life=
,
> so I might have missed something ;-) ). If you have in mind a better
> performing algorithm, then let me know, and I'll happily implement it=
 in
> kernel :-)


We can do better in the sense that since the device cannot comply with =
MT-A, we
can do as close as possible to MT-B with less cpu usage. But frankly, t=
he best
solution at this stage seems to be to drop MT handling altogether, sinc=
e there
does not seem to be any plan to use it.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
