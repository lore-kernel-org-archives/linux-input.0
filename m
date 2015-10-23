From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] hp_sdc: convert struct timeval to ktime_t
Date: Fri, 23 Oct 2015 14:34:52 +0200
Message-ID: <3865085.z48HxzEQ2F@wuerfel>
References: <3901659.bcGNtuE6xV@wuerfel> <4634704.Sh0UHGgRyQ@wuerfel> <6193EA0A-49EB-44FC-950A-F126B855E724@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6193EA0A-49EB-44FC-950A-F126B855E724@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pingbo Wen <pingbo.wen@linaro.org>
Cc: y2038@lists.linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Friday 23 October 2015 20:19:46 Pingbo Wen wrote:
>=20
> > Also, we don't normally have enumerated lists in a changelog, just =
use
> > normal text. The best changelogs typically have three paragraphs:
> >=20
> > The first paragraph describes what the driver currently does. For r=
eally
> > obvious cases, this can be combined with the second paragraph.
> >=20
> > The second paragraph explains why that is bad. This is where you ca=
n
> > mention the monotonic time vs real time issue and say whether we
> > just want the timeval removed to fix the kernel in general or wheth=
er
> > this particular driver is broken.
> >=20
> > The third paragraph explains what the patch does to resolve the iss=
ue
> > described in the second one. This is also where you can list other
> > approaches that would have solved the problem, and why you picked o=
n
> > over the others.
>=20
> Do we really need this in ChangeLog? Commit msg already states this. =
I think
> the purpose of ChangeLog is let people know the main difference of tw=
o
> version patch at a glance, and the =E2=80=98what=E2=80=99 and =E2=80=98=
why=E2=80=99 should be placed in
> commit msg.
>=20

I was using the terms changelog and commit message interchangeably, sor=
ry
for being unclear. I meant the part above the --- line. The revision
history you have below the --- line looks good here.

	Arnd
