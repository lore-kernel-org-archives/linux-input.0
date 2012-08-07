From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Tue, 7 Aug 2012 18:01:30 +0100
Message-ID: <20120807170129.GA3759@gmail.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
 <20120806153750.GI10524@gmail.com>
 <20120806160226.GF29272@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57029 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab2HGRBh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Aug 2012 13:01:37 -0400
Received: by eaac11 with SMTP id c11so1259307eaa.19
        for <linux-input@vger.kernel.org>; Tue, 07 Aug 2012 10:01:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120806160226.GF29272@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org

On Mon, Aug 06, 2012 at 05:02:26PM +0100, Mark Brown wrote:
> On Mon, Aug 06, 2012 at 04:37:52PM +0100, Lee Jones wrote:
> > On Mon, Aug 06, 2012 at 01:19:15AM -0700, Dmitry Torokhov wrote:
>=20
> > > > +	ponkey->irq_dbf =3D (np) ? ab8500_irq_get_virq(ab8500, irq_db=
f) : irq_dbf;
> > > > +	ponkey->irq_dbr =3D (np) ? ab8500_irq_get_virq(ab8500, irq_db=
r) : irq_dbr;
>=20
> > > Why this isn't done inside ab8500_irq_get_virq()?
>=20
> > There's no reason why it can't be.
>=20
> > My first version of the patch did just that in fact.
>=20
> > Would that be your preference?
>=20
> Restating my comment elsewhere...  why do we even need to do this in
> _get_virq() - I'd *really* expect this to be handled by the irq domai=
n
> code.

Okay, so I've just spent a small amount of time looking at this. I thin=
k
the best place for this would be in *_get_virq(), using the same logic =
that
selected a *_legacy or *_linear domain in the first place. The only thi=
ng=20
the domain can test for is the 'type' of domain and the requested IRQ. =
This
is where the issue lies. If a hwirq to virq conversion is requested, bu=
t a
virq is passed (which happens in the non-DT case) a WARN() is triggered
because the irq passed is bigger than first_irq + size. I think *_get_v=
irq()
should ensure that only a hwirq is passed to irq_create_mapping().

Let me know if you had other ideas.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
