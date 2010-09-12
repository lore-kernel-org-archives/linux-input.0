From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/4] input: wacom - Add Bamboo Pen Support
Date: Sun, 12 Sep 2010 00:14:47 -0700
Message-ID: <20100912071447.GA11122@core.coreip.homeip.net>
References: <1284229838-2852-1-git-send-email-chris@cnpbagwell.com>
 <AANLkTinCoY=7sm4VjRk=bmO1cvEcwWqgVGKG4pCaFfJm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:53104 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab0ILHOx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Sep 2010 03:14:53 -0400
Received: by pxi10 with SMTP id 10so1671807pxi.19
        for <linux-input@vger.kernel.org>; Sun, 12 Sep 2010 00:14:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinCoY=7sm4VjRk=bmO1cvEcwWqgVGKG4pCaFfJm@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "chris@cnpbagwell.com" <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "pingc@wacom.com" <pingc@wacom.com>

On Sun, Sep 12, 2010 at 04:13:27AM +0200, Ping Cheng wrote:
> On Saturday, September 11, 2010, =A0<chris@cnpbagwell.com> wrote:
> > From: Chris Bagwell <chris@cnpbagwell.com>
> >
> > Addes Bamboo Pen and Pen&Touch support. =A0Builds on previous
> > commited support for Bamboo Touch.
> >
> > Only difference in this patch set is patch #3. =A0It makes suggeste=
d
> > change to logic for checking pen in-proximity and adds comment
> > to clarify why 2-bits are checked.
> >
> > Chris Bagwell (4):
> > =A0=A0input: wacom - Request tablet data for Bamboo Pens
> > =A0=A0input: wacom - move Bamboo Touch irq to own function
> > =A0=A0input: wacom - Add support for Bamboo Pen
> > =A0=A0input: wacom - disable Bamboo touchpad when pen is being used=
=2E
>=20
> Acked-by: Ping Cheng <pingc@wacom.com> for the whole series.
>=20

Applied all 4 to 'next', thanks Chris.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
