From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] thinkpad-acpi: Improve hardware volume controls
Date: Thu, 12 May 2011 13:42:14 -0700
Message-ID: <20110512204213.GA8776@core.coreip.homeip.net>
References: <bf402af225e7005f052a8ccf92962efa48cbe703.1304979290.git.luto@mit.edu>
 <20110512134827.GA26159@srcf.ucam.org>
 <BANLkTimmrM4HMATSbsYzz6kh=e9hrfAZmg@mail.gmail.com>
 <20110512143912.GA28141@srcf.ucam.org>
 <BANLkTikX7mMu2me6+O1e-Ub=Cbzerd=J3Q@mail.gmail.com>
 <20110512153921.GB8293@core.coreip.homeip.net>
 <BANLkTinzOn1mMQ9BntEfBrQ+n=WC9=Ewrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTinzOn1mMQ9BntEfBrQ+n=WC9=Ewrg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, May 12, 2011 at 03:33:54PM -0400, Andrew Lutomirski wrote:
> On Thu, May 12, 2011 at 11:39 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Andrew,
> >
> > On Thu, May 12, 2011 at 10:50:54AM -0400, Andrew Lutomirski wrote:
> >>
> >> I do, however, have a question for the input people. =A0Dmitry: Le=
novo
> >> makes laptops which are kind enough to tell us that the volume cha=
nged
> >> by sending a keystroke over the atkbd-based keyboard. =A0(wtf!) =A0=
I've
> >> modified the thinkpad-acpi driver to register an input handler to
> >> catch those events coming from the keyboard and send them to ALSA
> >> where they belong. =A0But if there's a keyboard grab, it won't wor=
k.
> >> Would you accept a patch to the input layer to allow filters (or m=
aybe
> >> just filters that specifically request it) to run even if there's =
a
> >> grab?
> >
> > There is a filter on i8042 level that was introduced specifically f=
or
> > cases when events not having any relation to the input are routed v=
ia
> > KBC interface. It looks like this is the one you want to use. See
> > include/linux/i8042.h::i8042_install_filter(). It allows for such e=
vents
> > to completely bypass input layer.
> >
> > Hope this helps.
>=20
> Sort of.
>=20
> dell-laptop and msi-laptop are content to take some action on the key=
s
> they see but still leave the keys in the input stream, so their job i=
s
> a bit easier.
>=20
> I need to swallow one kind of extended key, detect and not swallow tw=
o
> others, and ignore all the ones that are normal keys.  But that means
> that I don't know whether I should filter out 0xe0 until it's too
> late.
>=20
> So either I'd need a function to feed an event back into i8042 or I
> need to filter a little farther downstream when the keys are resolved
> into keycodes (or scancodes -- I'm not really up on the terminology).

You can use serio_interrupt() to inject additional bytes into serio dat=
a
stream.

Thanks.

--=20
Dmitry
