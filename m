From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Warning: evdev changes - no auto-grabs anymore
Date: Fri, 15 Aug 2008 17:39:21 +0300
Message-ID: <20080815143921.GC16680@sci.fi>
References: <20080814044337.GA11632@emu> <1218725645.907.27.camel@thor.sulgenrain.local> <1218736209.4467.11.camel@localhost.localdomain> <20080815002458.GA16836@emu> <20080815065159.GA16680@sci.fi> <20080815080247.GA17613@fooishbar.org> <20080815082629.GB16680@sci.fi> <20080815100717.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:37252 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbYHOOjY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2008 10:39:24 -0400
Content-Disposition: inline
In-Reply-To: <20080815100717.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Stone <daniel@fooishbar.org>, Peter Hutterer <peter.hutterer@who-t.net>, Michel D?nzer <michel@tungstengraphics.com>, xorg@lists.freedesktop.org, linux-input@vger.kernel.org

On Fri, Aug 15, 2008 at 10:10:10AM -0400, Dmitry Torokhov wrote:
> On Fri, Aug 15, 2008 at 11:26:29AM +0300, Ville Syrj?l? wrote:
> > On Fri, Aug 15, 2008 at 11:02:48AM +0300, Daniel Stone wrote:
> > > On Fri, Aug 15, 2008 at 09:51:59AM +0300, Ville Syrj?l? wrote:
> > > > On Fri, Aug 15, 2008 at 09:54:58AM +0930, Peter Hutterer wrote:
> > > > > On Thu, Aug 14, 2008 at 01:50:09PM -0400, Adam Jackson wrote:
> > > > > > This is, in fact, one of the main reasons I put SIOCGRAB th=
ere in the
> > > > > > first place; you need to keep the keyboard's event stream o=
ut of the tty
> > > > > > layer entirely, not just out of reach of the kbd driver.  A=
t the time
> > > > > > the argument was also that you wanted to keep them out of r=
each of
> > > > > > normal users so you couldn't snoop passwords, but now that =
there's a
> > > > > > ConsoleKit I think that's less true.
> > > > > >=20
> > > > > > Mac mouse emulation we could probably just blacklist away f=
rom the evdev
> > > > > > driver.  rfkill is... harder?  Does it get its own event de=
vice or not?
> > > > > > I'd think it would have to get one kill device per wireless=
 device.
> > > > >=20
> > > > > The issue is not grabbing the mouse emulation device, it's gr=
abbing the
> > > > > keyboard that generates those keys events that should result =
in a button click
> > > > > on a different device. So we'd need something in the kernel I=
 guess.
> > > >=20
> > > > I was pondering about the same issue wrt. DirectFB. I wonder if
> > > > KDSETMODE/KD_GRAPHICS could be extended to take care of this or
> > > > would it break some existing applications.
> > >=20
> > > Yeah, I was thinking about that, but that would mean we have issu=
es
> > > under older kernels. I think the best was what I was proposing, w=
hich
> > > would be EVIOCSERIOUSLYDONTSENDANYCONSOLEINPUTWEWILLDEALWITHIT().
> >=20
> > Yeah that would be better since support for it could be detected ru=
ntime
> > so the driver could do the right thing when running with a recent k=
ernel,
> > and it could just fall back to the normal grab with old kernels.
> >=20
>=20
> If evdev support in X is maturing why does it even need using tty and
> mousedev multiplexors? If you just use evdev for all of your devices
> you would not have the problem of duplicate events coming from 2
> interfaces.

That's not the problem. The problem is that when using evdev without gr=
abs
any keyboardish input also goes to the console. For stuff like ctrl-c i=
t's
particularly nasty since it will result in the X server exiting.

This also affect DirectFB and it was the original reason why I added
EVIOCGRAB code to DirectFB's linux-input driver. Grabbing didn't cause
problems back then but now that the input subsystem is used by
rfkill/acpi/etc. functionalitys is lost when the devices are grabbed.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
