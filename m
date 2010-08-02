From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 13:12:30 +0200
Message-ID: <4C56A81E.3040703@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se> <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:33755 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab0HBLMd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Aug 2010 07:12:33 -0400
In-Reply-To: <4C5697C4.1020801@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 02-08-10 12:02, Henrik Rydberg schreef:
> On 08/02/2010 10:17 AM, =C9ric Piel wrote:
>=20
>> Op 01-08-10 15:57, Henrik Rydberg schreef:
>>> On 08/01/2010 01:28 PM, =C9ric Piel wrote:
>> :
>>>> I still think that for the very specific use case of scrolling whe=
n
>>>> pressing one finger and moving up and dow the other one, reporting=
 the
>>>> average works better than the first finger. However, I guess this =
can be
>>>> considered just as a drawback of the ST protocol, and fixed in use=
rspace
>>>> by using the MT protocol.
>>>>
>>>> What do you think? Does it look fine to you? Below is the code.
>>>
>>>
>>> I might have lost track of what problem needs to be solved. The cur=
rent patch
>>> seems to implement tracking, but still does not solve the individua=
l MT finger
>>> problem. And, it uses the same definition of ABS_X/Y as before. I w=
as also under
>>> the impression that synaptics needs fixing, anyways. All of this ta=
ken together
>>> sadly suggests that this patch could just as well be reverted to th=
e original
>>> one. Or? Alternatively, one could switch to the type B protocol, si=
nce no
>>> further tracking improvement is possible in userspace. The implemen=
tation is
>>> tidy and simple enough, I think.
>> Yes, you're right, the patch I've sent was still with the "average o=
f
>> the 2 fingers", but I'm now willing to drop it. With the tracking, a=
t
>> least we can keep sending info about a real finger and avoid jumps a=
t
>> the transition 1->2, so reporting the first finger might have advant=
ages
>> over reporting the average :-) The improvement for the test case can
>> just go to userspace.
>>
>> The tracking is still not so clever, so it's definitly not adapted t=
o a
>> type B MT protocol (think transition 2->1).
>=20
>=20
> You need to add the tracking id and a couple of lines, but i do not s=
ee why the
> 2->1 transition would be treated any differently. The one-finger coor=
dinate
> would be close to either position[0] or position[1], which would dete=
rmine the
> tracking id to keep. Every time you add a finger you add a new tracki=
ng id. What
> is your planned support for three fingers?
Yes, yes, it's probably fairly easy to do some kind of tracking. But I
think that as long as the hardware does not provide such a thing, it's
better to do the minimum in kernel space, just enough to be meaningful,
and leave the rest to userspace.

Concerning 3 fingers (and more), the hardware reports only one set of
coordinates, the lower ones. So in this case, tracking is definitely no=
t
possible.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
