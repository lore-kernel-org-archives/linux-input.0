From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 2 Aug 2010 09:26:25 -0700
Message-ID: <20100802162625.GA3276@core.coreip.homeip.net>
References: <4C533DC3.9070001@euromail.se>
 <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com>
 <4C54ABFE.8050106@tudelft.nl>
 <4C554058.6080203@euromail.se>
 <4C555A44.5050505@tudelft.nl>
 <4C557D3A.3050501@euromail.se>
 <4C567F27.7070900@tudelft.nl>
 <4C5697C4.1020801@euromail.se>
 <4C56A81E.3040703@tudelft.nl>
 <4C56AA67.8000902@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54487 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0HBQ0e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Aug 2010 12:26:34 -0400
Received: by iwn7 with SMTP id 7so4263650iwn.19
        for <linux-input@vger.kernel.org>; Mon, 02 Aug 2010 09:26:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C56AA67.8000902@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On Mon, Aug 02, 2010 at 01:22:15PM +0200, Henrik Rydberg wrote:
> On 08/02/2010 01:12 PM, =C9ric Piel wrote:
>=20
> > Op 02-08-10 12:02, Henrik Rydberg schreef:
> >> On 08/02/2010 10:17 AM, =C9ric Piel wrote:
> >>
> >>> Op 01-08-10 15:57, Henrik Rydberg schreef:
> >>>> On 08/01/2010 01:28 PM, =C9ric Piel wrote:
> >>> :
> >>>>> I still think that for the very specific use case of scrolling =
when
> >>>>> pressing one finger and moving up and dow the other one, report=
ing the
> >>>>> average works better than the first finger. However, I guess th=
is can be
> >>>>> considered just as a drawback of the ST protocol, and fixed in =
userspace
> >>>>> by using the MT protocol.
> >>>>>
> >>>>> What do you think? Does it look fine to you? Below is the code.
> >>>>
> >>>>
> >>>> I might have lost track of what problem needs to be solved. The =
current patch
> >>>> seems to implement tracking, but still does not solve the indivi=
dual MT finger
> >>>> problem. And, it uses the same definition of ABS_X/Y as before. =
I was also under
> >>>> the impression that synaptics needs fixing, anyways. All of this=
 taken together
> >>>> sadly suggests that this patch could just as well be reverted to=
 the original
> >>>> one. Or? Alternatively, one could switch to the type B protocol,=
 since no
> >>>> further tracking improvement is possible in userspace. The imple=
mentation is
> >>>> tidy and simple enough, I think.
> >>> Yes, you're right, the patch I've sent was still with the "averag=
e of
> >>> the 2 fingers", but I'm now willing to drop it. With the tracking=
, at
> >>> least we can keep sending info about a real finger and avoid jump=
s at
> >>> the transition 1->2, so reporting the first finger might have adv=
antages
> >>> over reporting the average :-) The improvement for the test case =
can
> >>> just go to userspace.
> >>>
> >>> The tracking is still not so clever, so it's definitly not adapte=
d to a
> >>> type B MT protocol (think transition 2->1).
> >>
> >>
> >> You need to add the tracking id and a couple of lines, but i do no=
t see why the
> >> 2->1 transition would be treated any differently. The one-finger c=
oordinate
> >> would be close to either position[0] or position[1], which would d=
etermine the
> >> tracking id to keep. Every time you add a finger you add a new tra=
cking id. What
> >> is your planned support for three fingers?
> > Yes, yes, it's probably fairly easy to do some kind of tracking. Bu=
t I
> > think that as long as the hardware does not provide such a thing, i=
t's
> > better to do the minimum in kernel space, just enough to be meaning=
ful,
> > and leave the rest to userspace.
>=20
>=20
> The implemented part could also be done in userspace. Going half-way =
just to
> circumvent buggy behavior in synaptics is really not a good idea.
>=20

What synaptics you are talking about here? Userspace driver or the
in-kernel synaptics support? If the latter, then the device is not trul=
y
multitouch device (latest versions of the hardware/firmware aside) as i=
t
is capable of reportiong only one set of coordinates (X/Y) in addition
to number of fingers on the surface.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
