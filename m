From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS touchpad no longer recognizing 'taps' as mouseclick in
 3.3-rc3
Date: Sun, 12 Feb 2012 22:39:28 -0800
Message-ID: <20120213063928.GB10056@core.coreip.homeip.net>
References: <20120212164728.GA19629@kroah.com>
 <20120212201236.GA9389@core.coreip.homeip.net>
 <20120213022221.GF25382@kroah.com>
 <20120213051243.GA10056@core.coreip.homeip.net>
 <CAKanTDeJepAY9FjSBJuQ6sK6kaGJwGH1hm3_T5hEQY4GDVuPeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55125 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2BMGji (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 01:39:38 -0500
Received: by pbcun15 with SMTP id un15so4304884pbc.19
        for <linux-input@vger.kernel.org>; Sun, 12 Feb 2012 22:39:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKanTDeJepAY9FjSBJuQ6sK6kaGJwGH1hm3_T5hEQY4GDVuPeA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ajaxas <ajaxas@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org

On Mon, Feb 13, 2012 at 01:19:31PM +0700, ajaxas wrote:
> Hello
>=20
> On Mon, Feb 13, 2012 at 12:12 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sun, Feb 12, 2012 at 06:22:21PM -0800, Greg KH wrote:
> >> On Sun, Feb 12, 2012 at 12:12:36PM -0800, Dmitry Torokhov wrote:
> >> > Hi Greg,
> >> >
> >> > On Sun, Feb 12, 2012 at 08:47:28AM -0800, Greg KH wrote:
> >> > > Hi,
> >> > >
> >> > > This problem has been since 3.3-rc1, but I only now am getting=
 around to
> >> > > reporting it, sorry about that.
> >> > >
> >> > > In 3.3-rc3, my alps touchpad isn't recognizing a tap on the to=
uchpad as
> >> > > a mouse click. =A0Is there a new Kconfig option that I need to=
 enable?
> >> > >
> >> > > My /proc/bus/input/devices entry for this thing is:
> >> > > I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D7326
> >> > > N: Name=3D"AlpsPS/2 ALPS DualPoint TouchPad"
> >> > > P: Phys=3Disa0060/serio1/input0
> >> > > S: Sysfs=3D/devices/platform/i8042/serio1/input/input6
> >> > > U: Uniq=3D
> >> > > H: Handlers=3Dmouse1 event6
> >> > > B: PROP=3D8
> >> > > B: EV=3Db
> >> > > B: KEY=3De420 70000 0 0 0 0
> >> > > B: ABS=3D260800001000003
> >> > >
> >> > > Is there anything else you need me to report to help track thi=
s down?
> >> > >
> >> >
> >> > Please make sure you have xorg-x11-drv-synaptics installed and t=
hen
> >> > check if tap to click is enabled in your DE. I think Gnome for s=
ome
> >> > reason has it off my default.
> >>
> >> Is this a new thing for the 3.3 kernel? =A0I ask as 3.2 and older =
kernels
> >> work just fine this way. =A0I can do a 'git bisect' to track it do=
wn to a
> >> specific patch if that will help out.
> >
> > No, there is no need. I am pretty sure pre-3.3 your touchpad worked=
 in
> > PS/2 compatibility mode; in 3.3 we merged support for native multit=
ouch
> > protocol so your touchpad works in absolute mode, can support vario=
us
> > gestures (vertical/hrizontal scroll, user-selected sensitivity, etc=
=2E)
> > and is recognozed as a proper touchpad by the entire stack. For som=
e
> > reason though Gnome has disabled tap to click for touchpads by defa=
ult.
> > I do not remember what is the default for KDE.
> >
> > Hope this helps.
> >
> > --
> > Dmitry
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>=20
> Since I'm using the same ALPS touchpad as Greg, I might be of some he=
lp here.
>=20
> I don't know how to check whether my touchpad is in absoulte mode or
> not, but KDE system settings ->  input devices doesn't list any
> additional touchpads at all, only a mouse. Which affects both mouse
> and touchpad.

What mouse does it identify? Also, do you have kcm_touchpad module
installed?

[dtor@dtor-d630 ~]$ rpm -qa "kcm*touchpad*"
kcm_touchpad-0.3.1-6.fc15.x86_64
[dtor@dtor-d630 ~]$ locate kcm_touchpad.so
/usr/lib64/kde4/kcm_touchpad.so

>=20
> Could this be not a DE, but a xorg/driver problem afetr all?

It could but it most likely is as most distributions install and set up
synaptics X driver by default. I am not sure what DE Greg is using
though.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
