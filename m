From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Warning: evdev changes - no auto-grabs anymore
Date: Fri, 15 Aug 2008 11:26:29 +0300
Message-ID: <20080815082629.GB16680@sci.fi>
References: <20080814044337.GA11632@emu>
	<1218725645.907.27.camel@thor.sulgenrain.local>
	<1218736209.4467.11.camel@localhost.localdomain>
	<20080815002458.GA16836@emu> <20080815065159.GA16680@sci.fi>
	<20080815080247.GA17613@fooishbar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20080815080247.GA17613@fooishbar.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Daniel Stone <daniel@fooishbar.org>, Peter Hutterer <peter.hutterer@who-t.net>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>, xorg@lists.freedesktop.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 15, 2008 at 11:02:48AM +0300, Daniel Stone wrote:
> On Fri, Aug 15, 2008 at 09:51:59AM +0300, Ville Syrj=E4l=E4 wrote:
> > On Fri, Aug 15, 2008 at 09:54:58AM +0930, Peter Hutterer wrote:
> > > On Thu, Aug 14, 2008 at 01:50:09PM -0400, Adam Jackson wrote:
> > > > This is, in fact, one of the main reasons I put SIOCGRAB there in t=
he
> > > > first place; you need to keep the keyboard's event stream out of th=
e tty
> > > > layer entirely, not just out of reach of the kbd driver.  At the ti=
me
> > > > the argument was also that you wanted to keep them out of reach of
> > > > normal users so you couldn't snoop passwords, but now that there's a
> > > > ConsoleKit I think that's less true.
> > > > =

> > > > Mac mouse emulation we could probably just blacklist away from the =
evdev
> > > > driver.  rfkill is... harder?  Does it get its own event device or =
not?
> > > > I'd think it would have to get one kill device per wireless device.
> > > =

> > > The issue is not grabbing the mouse emulation device, it's grabbing t=
he
> > > keyboard that generates those keys events that should result in a but=
ton click
> > > on a different device. So we'd need something in the kernel I guess.
> > =

> > I was pondering about the same issue wrt. DirectFB. I wonder if
> > KDSETMODE/KD_GRAPHICS could be extended to take care of this or
> > would it break some existing applications.
> =

> Yeah, I was thinking about that, but that would mean we have issues
> under older kernels. I think the best was what I was proposing, which
> would be EVIOCSERIOUSLYDONTSENDANYCONSOLEINPUTWEWILLDEALWITHIT().

Yeah that would be better since support for it could be detected runtime
so the driver could do the right thing when running with a recent kernel,
and it could just fall back to the normal grab with old kernels.

Let's cc the linux-input list...

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
