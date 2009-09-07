From: Harald Welte <laforge@gnumonks.org>
Subject: Fragmentation of Samsung SoC code (was INPUT][KEYBOARD] Add new
	keypad driver for s3c series SoCs)
Date: Mon, 7 Sep 2009 17:02:02 +0900
Message-ID: <20090907080202.GW3962@prithivi.gnumonks.org>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com> <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com> <20090907062658.GS3962@prithivi.gnumonks.org> <9c9fda240909062359s1629f7a4p65717ad07dcc22ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:46130 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbZIGIJ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 04:09:58 -0400
Content-Disposition: inline
In-Reply-To: <9c9fda240909062359s1629f7a4p65717ad07dcc22ca@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: =?utf-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?utf-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAL0UzL+yCvOyEseyghOyekA==?= <ki0351.kim@samsung.com>, =?utf-8?B?6rmA6rWt7KeEL0FQ6rCc67Cc7YyAL0U1L+yCvOyEseyghOyekA==?= <kgene.kim@samsung.com>

Hi Kyungmin,

On Mon, Sep 07, 2009 at 03:59:41PM +0900, Kyungmin Park wrote:
> > System LSI's kernel tree is on git.kernel.org and updated every nig=
ht, so you
> > (or other interested parties) can stay up-to-date with what is happ=
ening. =A0If
> > you base your work on top of System LSI's tree, you would always fo=
llow their
> > work. =A0System LSI's tree is what is scheduled to be submitted to =
mainline.
>=20
> Even though it's working at Samsung SoCs. but it's not mean it fits
> the mainline kernel.  It's based on SMDK board and focused on SMDK.
>
> I mean it's not generic. Some codes are hard-coded and don't call
> proper frameworks APIs. especially clocks

Yes, I agree wity you.  Some customers of those SoCs who use Linux also=
 agree :)

This is why the System LSI team needs your input based on your experien=
ce!

They will merge your patches if you send them!  They will learn as much=
 from
you, as they are from me when I provide feedback.

> >> I will post the our works.
> >
> > I'm not sure if two different Samsung departments posting competing=
 drivers to
> > the mainline mailing lists will really help. =A0You need to define =
which group
> > will be the 'master' inside Samsung (the logical choice would be Sy=
stem LSI).
>=20
> It's simple. give a choice to customers if there are two versions. yo=
u
> think it's some duplicated works it's better to others.

Don't you think it is weird to see two different Samsung groups duplica=
ting
each others work, creating fragmentation and confusion?  Each driver wi=
ll have
its own bugs and or problems, and right now neither your driver nor Sys=
tem
LSI's driver is in mainline.

So rather than continue to try to compete with each other, you need to =
work
together.  If you think your code is superior, why not submit your code=
 as
patches to System LSI, or even ask System LSI if you can either

1) get commit access to system lsi's git tree=20
or
2) send pull requests to system LSI and ask them to pull from your tree=
=2E

Everyone has limited resources.  System LSI, your team, anyone in the
community.

The point is that everyone needs to work together.  There needs to be a=
 clear
definition of the process, i.e. who will work on what, based on which t=
ree.
Hwo will submit what mainline, and who will maintain which driver after=
 it has
been merged in mainline..

The fragmentation between many different trees with each their own set =
of
drivers (let's say so far: Ben dooks / mainline, your code, System LSI'=
s code)
is creating a complexity and maintenance nightmare that nobody can deal=
 with
in the long term.

I understand that System LSI was probably the root cause of this proble=
m
due to their lack of understanding of this process.  But this has chang=
ed
now.

It is not "they" vs. "you" vs. "us", it is all of us together.  There i=
s too
much work to be done.  There is 6400,6410,6440,6430,6442,c100,c110 and =
more
products lining up in the future.  Many drivers spanning various subsys=
tems.
Only if the resources are put together this task can be finished in any
reasonable amount of time.

The Linux-aware customer wants to grab one tree (preferrably mainline)
that has all the drivers/features for all SoCs.  He doesn't want to loo=
k
at 5 different trees, test them, select what he wants and then manually=
 go
merging bits and pieces from each of them.

> I don't hope just push their codes to mainline with these discussion.

Sorry, I don't understand what you're saying here.

System LSI is pushing their code for mainline, one patch at a time, lik=
e
we are seeing with this keypad driver right now.  This will generate fe=
edback
by the community (including you).  System LSI then incorporates that fe=
edback
and re-submit an updated version of the driver - just like any other pe=
rson
who submits code to Linux mainline.

Regards,
--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks=
=2Eorg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch=
=2E A6)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
