From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils ?
Date: Tue, 25 Jan 2011 13:50:39 -0800
Message-ID: <20110125215039.GB20030@core.coreip.homeip.net>
References: <20110125045559.GB7850@core.coreip.homeip.net>
 <4D3E59CA.6070107@teksavvy.com>
 <4D3E5A91.30207@teksavvy.com>
 <20110125053117.GD7850@core.coreip.homeip.net>
 <4D3EB734.5090100@redhat.com>
 <20110125164803.GA19701@core.coreip.homeip.net>
 <AANLkTi=1Mh0JrYk5itvef7O7e7pR+YKos-w56W5q4B8B@mail.gmail.com>
 <20110125205453.GA19896@core.coreip.homeip.net>
 <20110125210153.GB19896@core.coreip.homeip.net>
 <AANLkTiknmVaOhvhTXC_5G3m-HDrTJCyqbjOPgnUEFZpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiknmVaOhvhTXC_5G3m-HDrTJCyqbjOPgnUEFZpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 26, 2011 at 07:20:07AM +1000, Linus Torvalds wrote:
> On Wed, Jan 26, 2011 at 7:01 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > BTW, another issue is that evdev's ioctl returns -EINVAL for unknow=
n
> > ioctls so applications would have hard time figuring out whether er=
ror
> > returned because of kernel being too old or because they are trying=
 to
> > retrieve/establish invalid mapping if they had to go only by the er=
ror
> > code.
>=20
> So that's just another evdev interface bug.

Huh? I do not have lot of options here as far as error codes go. Invali=
d
request, invalid data in request - all goes to EINVAL.

>=20
> > As far as I can see EINVAL is a proper error for unknown ioctls:
> >
> > [dtor@hammer work]$ man 2 ioctl | grep EINVAL
> > =A0 =A0 =A0 EINVAL Request or argp is not valid.
>=20
> Yeah, there's some confusion there.
>=20
> The "unknown ioctl" error code is (for traditional reasons) ENOTTY,
> but yes, the EINVAL thing admittedly has a lot of legacy use too.
>=20
> Inside the kernel, the preferred way to say "I don't recognize that
> ioctl number" is actually ENOIOCTLCMD.  That's exactly so that variou=
s
> nested ioctl handlers can then tell the difference between "I didn't
> recognize that ioctl" and "I understand what you asked me to do, but
> your arguments were crap".
>=20
> vfs_ioctl() will then turn ENOIOCTLCMD to EINVAL to return to user sp=
ace.

OK, so I can change evdev to employ ENOIOCTLCMD where needed, bit that
will not change older kernels where such distinction is needed (as neve=
r
kernels do support newer ioctl). And even if I could go back it would
not help since userspace still sees EINVAL only.

--=20
Dmitry
