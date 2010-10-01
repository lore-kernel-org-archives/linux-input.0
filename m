From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Add acer wmi hotkey events support
Date: Fri, 1 Oct 2010 10:46:37 -0700
Message-ID: <20101001174637.GB16141@core.coreip.homeip.net>
References: <4CA6A90C02000023000212D2@novprvlin0050.provo.novell.com>
 <20101001174422.GA16141@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61892 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab0JARqo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Oct 2010 13:46:44 -0400
Content-Disposition: inline
In-Reply-To: <20101001174422.GA16141@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: corentin.chary@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Fri, Oct 01, 2010 at 10:44:22AM -0700, Dmitry Torokhov wrote:
> On Fri, Oct 01, 2010 at 11:37:48AM -0600, Joey Lee wrote:
> > Hi Corentin,=20
> >=20
> > =E6=96=BC =E4=BA=94=EF=BC=8C2010-10-01 =E6=96=BC 16:03 +0200=EF=BC=8C=
Corentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> > > On Fri, Oct 1, 2010 at 3:51 PM, Lee, Chun-Yi <joeyli.kernel@gmail=
=2Ecom> wrote:
> > > > Add acer wmi hotkey event support. Install a wmi notify handler=
 to
> > > > transfer wmi event key to key code, then send out keycode throu=
gh acer
> > > > wmi input device to userland.
> > > >
> > > > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> > >=20
> > > Hi Lee,
> > > You'll probably want to take a look at the sparse keymap library.=
 Using
> > > it would remove a lot of code from this patch.
> > > Thanks
> > >=20
> >=20
> > Thank's for your suggestion, I just goolge it:
> >  http://www.spinics.net/lists/linux-input/msg10336.html
> >=20
> > And, you are right, it's a very good framework for keymap handler.
> > I will modify patch to use sparse keymap library.
> >=20
> > I believe it already available in newest kernel.
> > Does it already in 2.6.32 kernel? Because I also need backport thos=
e 2
> > patches to 2.6.32.x kernel.
> >=20
>=20
> Unfortunately it is in 2.6.33 onward.
>=20

=2E.. but you shold be able to add the module to your distibution, it i=
s
pretty much self-contained. If you do so there were a couple of fixes i=
n
later kernels you might want to grab as well.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
