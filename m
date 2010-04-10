From: Andy Walls <awalls@md.metrocast.net>
Subject: Re: [RFC3] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Sat, 10 Apr 2010 07:56:19 -0400
Message-ID: <1270900579.3034.25.camel@palomino.walls.org>
References: <20100408113910.GA17104@hardeman.nu>
	 <1270812351.3764.66.camel@palomino.walls.org>
	 <s2o9e4733911004090531we8ff39b4r570e32fdafa04204@mail.gmail.com>
	 <4BBF3309.6020909@infradead.org>  <20100410064801.GA2667@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100410064801.GA2667@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Jon Smirl <jonsmirl@gmail.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2010-04-10 at 08:48 +0200, David H=C3=A4rdeman wrote:
> On Fri, Apr 09, 2010 at 11:00:41AM -0300, Mauro Carvalho Chehab wrote=
:
> > struct {
> > 	unsigned mark : 1;
> > 	unsigned duration :31;
> > }
> >=20
> > There's no memory spend at all: it will use just one unsigned int a=
nd it is
> > clearly indicated what's mark and what's duration.
>=20
> If all three of you agree on this approch, I'll write a patch to conv=
ert=20
> ir-core to use it instead.

I'm OK with it.

I haven't been paying close attention,so I must ask: What will the unit=
s
of duration be?

a. If we use nanoseconds the max duration is 2.147 seconds.

If passing pulse measurments out to LIRC, there are cases where irrecor=
d
and lircd want the duration of the long silence between the
transmissions from the remote. Do any remotes have silence periods
longer than 2.1 seconds?

b. If we use microseconds, the max duration is 214.7 seconds or 3.6
minutes.  That's too high to be useful.

c.  Something in between, like 1/8 (or 1/2, 1/4, or 1/10) of a
microsecond?  1/8 gives a max duration of 26.8 seconds and a little
extra precision.

Regards,
Andy
