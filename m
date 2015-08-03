From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Mon, 3 Aug 2015 14:26:48 +0200
Message-ID: <20150803122648.GE20682@pali>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150730165323.GC13165@dtor-ws>
 <20150731101525.GA7811@sudip-pc>
 <20150731165427.GB5613@dtor-ws>
 <20150731173426.GA23126@sudip-pc>
 <20150731203618.GA24494@kroah.com>
 <20150731204306.GM5613@dtor-ws>
 <20150801124348.GA10147@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150801124348.GA10147@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Saturday 01 August 2015 18:13:48 Sudip Mukherjee wrote:
> On Fri, Jul 31, 2015 at 01:43:06PM -0700, Dmitry Torokhov wrote:
> > On Fri, Jul 31, 2015 at 01:36:18PM -0700, Greg KH wrote:
> > > On Fri, Jul 31, 2015 at 11:04:26PM +0530, Sudip Mukherjee wrote:
> > > > On Fri, Jul 31, 2015 at 09:54:27AM -0700, Dmitry Torokhov wrote=
:
> > > > > On Fri, Jul 31, 2015 at 03:45:25PM +0530, Sudip Mukherjee wro=
te:
> > > > > > On Thu, Jul 30, 2015 at 09:53:23AM -0700, Dmitry Torokhov w=
rote:
> > > > > > > Hi Sudip,
> > > > > > Hi Dmitry,
> > > > > > >=20
> > > > > > > On Thu, Jul 30, 2015 at 07:36:34PM +0530, Sudip Mukherjee=
 wrote:
> <snip>
> > > > >=20
> > > > > No, unfortunately I do not.
> > > > >=20
> > > > > Since neither of us can test the change what is the benefit o=
f doing the
> > > > > conversion? What will be gained by doing it? Are there plans =
for parport
> > > > > subsystem to remove the old style initialization?
> > > > Yes, that is the plan. Well, if you are not comfortable with in=
troducing
> > > > attach and detach functions then this can be done in another wa=
y where
> > > > there will be very minimum change in the code. But I will prefe=
r to have
> > > > attach and detach then it can take advantage of the hotplug fea=
ture.
> > > > Adding Greg in To: list for his comments.
> > >=20
> > > Converting to the "new" api is the end goal here, no need to keep=
 the
> > > old one around anymore.
> >=20
> > OK, then I guess we can do the conversion right (dropping db9_base
> > module-global) and see if anyone screams at us.
> I am working on it now to remove db9_base. But in the detach callback=
 we
> will get struct parport * and from parport to get a pardevice we need=
 to
> get it from port->physport->devices. Since it is having PARPORT_FLAG_=
EXCL
> it is ok, but should we really depend on and work with the internal d=
ata
> structures of the parport rather than working with the exported api?
>=20
> regards
> sudip
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

Hey! I believe you are not going to break my Atari joystick connected t=
o
my desktop PC via special homemade reduction for parallel port... :-)
That Atari joystick uses db9.ko linux kernel driver and so any untested
changes to db9.c could break functionality!

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
