From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/9] mfd: max77693: Store I2C device type as enum and
 add default unknown
Date: Wed, 27 May 2015 13:24:18 +0100
Message-ID: <20150527122418.GM11677@x1>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
 <1432446213-4886-3-git-send-email-k.kozlowski.k@gmail.com>
 <20150527102334.GD11677@x1>
 <CAJKOXPchv7hqcsE5pDB-_PJknfTqLYUOdNbP=6ExUD_gdRoa3w@mail.gmail.com>
 <20150527121536.GK11677@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34089 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbE0MYY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 08:24:24 -0400
Received: by wicmc15 with SMTP id mc15so92016621wic.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2015 05:24:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150527121536.GK11677@x1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 27 May 2015, Lee Jones wrote:

> On Wed, 27 May 2015, Krzysztof Koz=C5=82owski wrote:
>=20
> > 2015-05-27 19:23 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> > > On Sun, 24 May 2015, Krzysztof Kozlowski wrote:
> > >
> > >> Store the device type (obtained from i2c_device_id) as an enum a=
nd add a
> > >> default type of unknown to distinguish from case when this is no=
t set
> > >> at all.
> > >>
> > >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> > >> ---
> > >>  include/linux/mfd/max77693-private.h | 11 ++++++-----
> > >>  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > > Applied, thanks.
> >=20
> > Thanks.
> >=20
> > I was thinking about merging everything through one tree because of
> > the dependency (successive patches depend on previous) but I don't
> > mind choosing different strategy. However if you picked this one ma=
ybe
> > you can also apply the patch 1/9:
> > mfd/extcon: max77693: Remove unused extern declarations and max7769=
3_dev members
> >=20
> > It already got ack from Chanwoo.
> >=20
> > Other patches depend on these so either everything will go through
> > your tree or you will prepare an immutable branch for e.g. Mark (as
> > everything is around regulator drivers).
> >=20
> > Anyway I need some input from Mark about the patches 4, 5 and 9. Re=
st
> > of them already have his ack.
>=20
> I'm happy to do that.  Just let me know when you have all the Acks yo=
u
> need and I'll apply them all at once.

In fact, it's probably better to withdraw this patch too, then apply
it with all the others.

Patch unapplied (but you can add my Ack).

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
