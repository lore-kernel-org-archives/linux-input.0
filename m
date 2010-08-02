From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 10:17:43 +0200
Message-ID: <4C567F27.7070900@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:46077 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab0HBIRp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Aug 2010 04:17:45 -0400
In-Reply-To: <4C557D3A.3050501@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 01-08-10 15:57, Henrik Rydberg schreef:
> On 08/01/2010 01:28 PM, =C9ric Piel wrote:
:
>> I still think that for the very specific use case of scrolling when
>> pressing one finger and moving up and dow the other one, reporting t=
he
>> average works better than the first finger. However, I guess this ca=
n be
>> considered just as a drawback of the ST protocol, and fixed in users=
pace
>> by using the MT protocol.
>>
>> What do you think? Does it look fine to you? Below is the code.
>=20
>=20
> I might have lost track of what problem needs to be solved. The curre=
nt patch
> seems to implement tracking, but still does not solve the individual =
MT finger
> problem. And, it uses the same definition of ABS_X/Y as before. I was=
 also under
> the impression that synaptics needs fixing, anyways. All of this take=
n together
> sadly suggests that this patch could just as well be reverted to the =
original
> one. Or? Alternatively, one could switch to the type B protocol, sinc=
e no
> further tracking improvement is possible in userspace. The implementa=
tion is
> tidy and simple enough, I think.
Yes, you're right, the patch I've sent was still with the "average of
the 2 fingers", but I'm now willing to drop it. With the tracking, at
least we can keep sending info about a real finger and avoid jumps at
the transition 1->2, so reporting the first finger might have advantage=
s
over reporting the average :-) The improvement for the test case can
just go to userspace.

The tracking is still not so clever, so it's definitly not adapted to a
type B MT protocol (think transition 2->1).

Dmitry, if that's ok with you, you can drop this patch 7/7, and I'll
send you two new patches to add MT support and finger tracking?

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
