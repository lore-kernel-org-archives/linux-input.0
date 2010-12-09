From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/8] input: gpio_keys_polled fixes
Date: Wed, 8 Dec 2010 16:06:00 -0800
Message-ID: <20101209000600.GF15294@core.coreip.homeip.net>
References: <4CF541ED.80905@openwrt.org>
 <1291142663-1011-1-git-send-email-juhosg@openwrt.org>
 <AANLkTi=fYLTEkws+R+9PFtrgUzujQrOuN2PQcGoG7X=v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33984 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0LIAGL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 19:06:11 -0500
Received: by ywl5 with SMTP id 5so1057006ywl.19
        for <linux-input@vger.kernel.org>; Wed, 08 Dec 2010 16:06:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=fYLTEkws+R+9PFtrgUzujQrOuN2PQcGoG7X=v@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Gabor Juhos <juhosg@openwrt.org>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

On Tue, Nov 30, 2010 at 05:16:15PM -0500, Ben Gardiner wrote:
> Hi Gabor,
>=20
> On Tue, Nov 30, 2010 at 1:44 PM, Gabor Juhos <juhosg@openwrt.org> wro=
te:
> > This set contains my latest fixes on top of Dmitry's changes.
> >
> > Gabor Juhos (8):
> > =A0input: gpio_keys_polled: add MODULE_ALIAS
>=20
> > =A0input: gpio_keys_polled: return -EINVAL if wakeup specified
> > =A0input: gpio_keys_polled: avoid possible division by zero
> Good idea to return -EINVAL in those cases.
>=20
> > =A0input: gpio_keys_polled: use DIV_ROUND_UP to compute the thresho=
ld value
> That's what I was looking for, thank you for fixing that up.
>=20
> > =A0input: gpio_keys_polled: precompute threshold value in the probe=
 routine
> Even better.
>=20
> > =A0input: gpio_keys_polled: use tabs instead of spaces for indentat=
ion
> > =A0input: gpio_keys_polled: remove a local variable
> > =A0input: gpio_keys_polled: fix Kconfig help text
> I missed that remaining gpio-buttons reference, thanks for catching t=
hat.
>=20
> > =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 +-
> > =A0drivers/input/keyboard/gpio_keys_polled.c | =A0 30 +++++++++++++=
++-------------
> > =A02 files changed, 18 insertions(+), 16 deletions(-)
>=20
> I have tested this series with the "da850-evm: add gpio-{keys,leds}
> for UI and BB expanders" on top of your "[PATCH 09/18] input:  add
> input driver for polled GPIO buttons" patch, my "[PATCH WIP 0/6]
> suggested changes to gpio_buttons driver" series and Dmitry's "Input:
> gpio-buttons - misc changes"  patch.

Ok, so driver is in mainline now and you should have no problems with
merging your platform code in .38 merge window.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
