From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Thu, 09 Dec 2010 14:03:36 -0800
Message-ID: <1291932216.18827.16.camel@c-dwalke-linux.qualcomm.com>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
	 <4D00800E.7050004@codeaurora.org>
	 <1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
	 <AANLkTi=3LHHNJUh35AUkq--KtRCnRaBHx8Ky2bhxxzE4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:34128 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0LIWDu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 17:03:50 -0500
In-Reply-To: <AANLkTi=3LHHNJUh35AUkq--KtRCnRaBHx8Ky2bhxxzE4@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2010-12-09 at 14:01 -0800, Arve Hj=C3=B8nnev=C3=A5g wrote:
> On Thu, Dec 9, 2010 at 9:45 AM, Daniel Walker <dwalker@codeaurora.org=
> wrote:
> > On Thu, 2010-12-09 at 12:36 +0530, Trilok Soni wrote:
> >
> >> > +static char *keycaps =3D "--qwerty";
> >> > +#undef MODULE_PARAM_PREFIX
> >> > +#define MODULE_PARAM_PREFIX "board_trout."
> >> > +module_param_named(keycaps, keycaps, charp, 0);
> >>
> >> I would like to know what is the use of this param?
> >
> > No idea .. It was part of Google's implementation ..
> >
>=20
> You removed the code that uses it. If you look at the original file
> you can see how it is used:
> http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Darch/a=
rm/mach-msm/board-trout-keypad.c;hb=3Drefs/heads/android-msm-2.6.35
> It is set by the bootloader according to the hardware version.
>=20
> You can also see that the "/* userspace needs to know about these
> changes as well */" comments refer to the code that changes the name
> of the input device.
>=20
> I don't think this change will work correctly with our existing
> user-space code though since you are now reporting the power-key,
> camera-key and slide-switch from a separate input device.

Yeah, I did remove those parts.. I'm not sure where to put that stuff i=
n
this new implementation. I can try to find an appropriate place , unles=
s
you have some suggestions ?

Daniel


--=20

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
