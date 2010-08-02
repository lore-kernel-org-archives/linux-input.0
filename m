From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 16:12:55 +0200
Message-ID: <4C56D267.3000600@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl> <4C554058.6080203@euromail.se> <4C555A44.5050505@tudelft.nl> <4C557D3A.3050501@euromail.se> <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se> <4C56BE30.2070807@tudelft.nl> <4C56C213.2010605@euromail.se> <4C56C6DF.2040106@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:59350 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753381Ab0HBONM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Aug 2010 10:13:12 -0400
In-Reply-To: <4C56C6DF.2040106@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 08/02/2010 03:23 PM, =C9ric Piel wrote:

[...]

>> For your usecase, perhaps one should add ABS_ZOOM etcetera instead, =
and patch up

>> synaptics to use those values.
> Detecting the pinch gesture in-kernel? In addition to me not knowing =
how
> to do gesture recognition, I doubt Dmitry would ever accept such a
> patch, and Peter Hutterer would probably not enjoy a lot either the
> patch for synaptics.
>=20
> That's why I like the idea of reporting MT events as well as we can (=
the
> user will know that on his device some gestures are limited), and  th=
e
> rest of the stack can stay completely standard.


Using my offering of a different solution as an argument _for_ your sol=
ution is
incorrect. It is clear that you want zoom to work, and rotate to almost=
 work. I
disagree with the notion of implementing a fairly complex but still inc=
omplete
MT solution to that end alone. I am sure there is a third alternative h=
ere.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
