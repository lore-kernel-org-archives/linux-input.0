From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Wed, 22 Jun 2011 14:43:08 -0700
Message-ID: <20110622214307.GB978@core.coreip.homeip.net>
References: <20110620094815.341d1cff@archvile>
 <20110620084511.GB23113@core.coreip.homeip.net>
 <20110621114631.GC25032@sirena.org.uk>
 <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com>
 <20110621172744.GB26592@opensource.wolfsonmicro.com>
 <20110621204804.GC3731@core.coreip.homeip.net>
 <20110621230242.GA8791@opensource.wolfsonmicro.com>
 <20110622070052.GA16561@core.coreip.homeip.net>
 <20110622113835.GC18726@opensource.wolfsonmicro.com>
 <BANLkTinB+utdPeL+mGJQApXAydDyLEK7Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47434 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758899Ab1FVVnQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2011 17:43:16 -0400
Received: by pwj7 with SMTP id 7so859966pwj.19
        for <linux-input@vger.kernel.org>; Wed, 22 Jun 2011 14:43:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinB+utdPeL+mGJQApXAydDyLEK7Kg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>, David Jander <david.jander@protonic.nl>

On Wed, Jun 22, 2011 at 08:58:45AM -0600, Grant Likely wrote:
> On Wed, Jun 22, 2011 at 5:38 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, Jun 22, 2011 at 12:00:52AM -0700, Dmitry Torokhov wrote:
> >> On Wed, Jun 22, 2011 at 12:02:42AM +0100, Mark Brown wrote:
> >> > On Tue, Jun 21, 2011 at 01:48:05PM -0700, Dmitry Torokhov wrote:
> >
> >> > > Can the initcall stuff be kept out of mainline? I'd expect
> >
> >> > The init order stuff is in mainline already, you're far too late=
 to the
> >> > party here.
> >
> >> For some drivers it might be already in mainline, it does not matt=
er
> >> that we should continue adding more.
> >
> > It's not just a few drivers, there's entire subsystems that are doi=
ng
> > this.
> >
> >> > Keeping things in board trees is exactly the sort of thing we wa=
nt to
> >> > avoid people doing. =A0That just means people do all sorts of st=
uff that
> >> > wouldn't be acceptable upstream, either out of ignorance or thro=
ugh
> >> > knowing that only their systems have to work with what they're d=
oing,
> >> > and just don't bother working upstream at all half the time maki=
ng life
> >> > miserable for pretty much everyone.
> >
> >> So you are saying that we should accept such crap directly into
> >> mainline?
> >
> > Pretty much, yes. =A0In code terms it's not really invasive and it =
doesn't
> > have any real impact on other systems so it's the sort of thing we =
can
> > carry without too much pain. =A0Pragmatically it's not unreasonable=
=2E
>=20
> +1
>=20

OK, you wore me out. I'll apply the initcall change...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
