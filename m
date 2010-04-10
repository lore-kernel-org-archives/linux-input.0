From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 4/4] Add RC6 support to ir-core
Date: Sun, 11 Apr 2010 00:23:19 +0200
Message-ID: <20100410222319.GA10473@hardeman.nu>
References: <20100408230246.14453.97377.stgit@localhost.localdomain>
 <20100408230440.14453.36936.stgit@localhost.localdomain>
 <1270861928.3038.153.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1270861928.3038.153.camel@palomino.walls.org>
Sender: linux-media-owner@vger.kernel.org
To: Andy Walls <awalls@radix.net>
Cc: mchehab@redhat.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 09, 2010 at 09:12:08PM -0400, Andy Walls wrote:
> On Fri, 2010-04-09 at 01:04 +0200, David H=E4rdeman wrote:
> > +again:
> > +	IR_dprintk(2, "RC6 decode started at state %i (%i units, %ius)\n"=
,
> > +		   data->state, u, TO_US(duration));
> > +
> > +	if (DURATION(u) =3D=3D 0 && data->state !=3D STATE_FINISHED)
> > +		return 0;
>=20
> Isn't there a better way to structure the logic to break up two adjac=
ent
> pulse units than with goto's out of the switch back up to here?
>=20
> A do {} while() loop would have been much clearer.

I just tried it, and I'm not convinced. The main problem is that you'll=
=20
end up with:

do {
	switch(b) {
	case c:
		if (x)
			break;
		else if (y)
			continue;
while(a);

Where the break statement will affect the switch() and the continue=20
statement will affect the do-while() loop which is kinda confusing.

Especially if you're so far down in the function body that the=20
do-while() and switch() statements aren't visible any more.


--=20
David H=E4rdeman
