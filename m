From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input question: ambient light sensor button
Date: Tue, 19 Nov 2013 13:27:36 -0800
Message-ID: <20131119212736.GA25784@core.coreip.homeip.net>
References: <201309151553.34000@pali>
 <alpine.LNX.2.00.1311131146410.22940@pobox.suse.cz>
 <20131113162840.GB11657@core.coreip.homeip.net>
 <201311141302.33384@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201311141302.33384@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Nov 14, 2013 at 01:02:31PM +0100, Pali Roh=E1r wrote:
> On Wednesday 13 November 2013 17:28:40 Dmitry Torokhov wrote:
> > On Wed, Nov 13, 2013 at 11:47:18AM +0100, Jiri Kosina wrote:
> > > On Sun, 15 Sep 2013, Pali Roh=E1r wrote:
> > > > I do not know where to ask this question, but I think that
> > > > kernel developers could help me.
> > > >=20
> > > > I have notebook with one special button on keyboard which
> > > > is designed for turning ambient light sensor on and off.
> > > > By default pressing button do nothing (I can turn ambient
> > > > light sensor on/off via sysfs platform wmi module).
> > > > Button press is reported by kernel input device AT
> > > > Translated Set 2 keyboard and reports it as button
> > > > "touchpad off".
> > > >=20
> > > > Of course "touchpad off" is incorrect and I'd like to ask
> > > > which kernel key or button from
> > > > /usr/include/linux/input.h should be mapped for my
> > > > ambient light sensor button? Is there already some? And
> > > > what is strategy for allocating KEY_* and BTN_* numbers?
> > >=20
> > > This is maintained by Dmitry, so he's the one to answer
> > > this. I am adding him to CC.
> >=20
> > I guess we need patch adding
> >=20
> > 	#define KEY_ALS_TOGGLE	0x230
> >=20
> > Thanks.
>=20
> So there is no good key for als yet?

No, but if you send me a patch adding it I will gladly apply it.

Thanks.

--=20
Dmitry
