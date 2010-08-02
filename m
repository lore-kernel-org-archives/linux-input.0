From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 02 Aug 2010 19:15:23 +0200
Message-ID: <4C56FD2B.8040703@euromail.se>
References: <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se> <4C56BE30.2070807@tudelft.nl> <4C56C213.2010605@euromail.se> <20100802163913.GB3276@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:52734 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330Ab0HBRP1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Aug 2010 13:15:27 -0400
In-Reply-To: <20100802163913.GB3276@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 08/02/2010 06:39 PM, Dmitry Torokhov wrote:
> On Mon, Aug 02, 2010 at 03:03:15PM +0200, Henrik Rydberg wrote:
>> On 08/02/2010 02:46 PM, =C9ric Piel wrote:
>>
>> [...]
>>
>>>>
>>>> We can do better in the sense that since the device cannot comply =
with MT-A, we
>>>> can do as close as possible to MT-B with less cpu usage. But frank=
ly, the best
>>>> solution at this stage seems to be to drop MT handling altogether,=
 since there
>>>> does not seem to be any plan to use it.
>>> Ah, this alternative solution is a bit boring ;-) In addition it's =
not
>>> compatible with my own master plan to eventually have the "pinch to
>>> zoom" and "rotate to rotate" gestures work on my laptop, like in Wi=
ndows ;-)
>>
>>
>> Since rotational symmetry is what prevents us from implementing prop=
er MT
>> support, it is not likely going to work anyways.
>>
>=20
> Not work at all or not work as good as with other devices? "Not as go=
od"
> is still OK, hardware is different and we have to make the best of it=
=2E
> The same elantech does not export pressure (at lest the version in
> mainline does not) and thus users are unable to adjust sensitivity.
> Still the device is useable with Synaptics X.

This whole thread started off as a question how the ABS_X/Y should be r=
eported
in the presence of two fingers. Given that the elantech driver can repo=
rt _some_
point via ABS_X/Y, and the number of fingers, the device should be usab=
le with
Synaptics X. If there is a problem with a jumping cursor, I have a feel=
ing this
is a bug that should be fixed in Synaptics X. As far as I can tell, the=
 MT
events are not needed for this case.

>>> So, let's agree on just the two patches I'm going to send to suppor=
t
>>> "better than nothing" MT-protocol for now. When, later, someone has
>>> better ideas, he can send patches to improve MT-protocol
>>> support/compliance. Fine?
>>
>>
>> No. I think it is fair to say we tried to make it work properly, but=
 the (known)
>> information about the device is simply not enough. As long as MT doe=
s not work
>> properly, there is no point in adding it at all - in particular not =
an elaborate
>> solution. I can see that zoom would work even with a poor MT impleme=
ntation, but
>> that is not what the MT protocol is about. Maybe one day someone wil=
l find the
>> missing information somewhere in the packets.
>>
>> For your usecase, perhaps one should add ABS_ZOOM etcetera instead, =
and patch up
>> synaptics to use those values.
>=20
> No, I do not believe that this is the direcion we should be taking. I=
'd
> prefer we export as much information as we can for MT to be useful. A=
nd
> if we discover some missing pieces in proocol (or future firmware
> revisioons will be smarter) we can improve MT support.
>=20

That is fine per se, I was simply looking for other options. The questi=
on then
is how much MT support is needed. For existing applications (read Synap=
tics X),
there should be no need for MT, so we should be able to wait with that =
part
until the firmware gets smarter. If the idea is to use something like t=
he
Multitouch X Driver to enable zoom and rotate, this is where I am hesit=
ant,
given the current capabilities of the device.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
