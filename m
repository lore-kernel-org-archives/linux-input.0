From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 12:02:44 +0200
Message-ID: <4C5697C4.1020801@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se> <4C567F27.7070900@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:44808 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751142Ab0HBKC5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Aug 2010 06:02:57 -0400
In-Reply-To: <4C567F27.7070900@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 08/02/2010 10:17 AM, =C9ric Piel wrote:

> Op 01-08-10 15:57, Henrik Rydberg schreef:
>> On 08/01/2010 01:28 PM, =C9ric Piel wrote:
> :
>>> I still think that for the very specific use case of scrolling when
>>> pressing one finger and moving up and dow the other one, reporting =
the
>>> average works better than the first finger. However, I guess this c=
an be
>>> considered just as a drawback of the ST protocol, and fixed in user=
space
>>> by using the MT protocol.
>>>
>>> What do you think? Does it look fine to you? Below is the code.
>>
>>
>> I might have lost track of what problem needs to be solved. The curr=
ent patch
>> seems to implement tracking, but still does not solve the individual=
 MT finger
>> problem. And, it uses the same definition of ABS_X/Y as before. I wa=
s also under
>> the impression that synaptics needs fixing, anyways. All of this tak=
en together
>> sadly suggests that this patch could just as well be reverted to the=
 original
>> one. Or? Alternatively, one could switch to the type B protocol, sin=
ce no
>> further tracking improvement is possible in userspace. The implement=
ation is
>> tidy and simple enough, I think.
> Yes, you're right, the patch I've sent was still with the "average of
> the 2 fingers", but I'm now willing to drop it. With the tracking, at
> least we can keep sending info about a real finger and avoid jumps at
> the transition 1->2, so reporting the first finger might have advanta=
ges
> over reporting the average :-) The improvement for the test case can
> just go to userspace.
>=20
> The tracking is still not so clever, so it's definitly not adapted to=
 a
> type B MT protocol (think transition 2->1).


You need to add the tracking id and a couple of lines, but i do not see=
 why the
2->1 transition would be treated any differently. The one-finger coordi=
nate
would be close to either position[0] or position[1], which would determ=
ine the
tracking id to keep. Every time you add a finger you add a new tracking=
 id. What
is your planned support for three fingers?

Henrik

> Dmitry, if that's ok with you, you can drop this patch 7/7, and I'll
> send you two new patches to add MT support and finger tracking?
>=20
> Eric


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
