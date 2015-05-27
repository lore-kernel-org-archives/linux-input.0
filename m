From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/9] mfd: max77693: Store I2C device type as enum and
 add default unknown
Date: Wed, 27 May 2015 13:15:36 +0100
Message-ID: <20150527121536.GK11677@x1>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
 <1432446213-4886-3-git-send-email-k.kozlowski.k@gmail.com>
 <20150527102334.GD11677@x1>
 <CAJKOXPchv7hqcsE5pDB-_PJknfTqLYUOdNbP=6ExUD_gdRoa3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPchv7hqcsE5pDB-_PJknfTqLYUOdNbP=6ExUD_gdRoa3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 27 May 2015, Krzysztof Koz=C5=82owski wrote:

> 2015-05-27 19:23 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> > On Sun, 24 May 2015, Krzysztof Kozlowski wrote:
> >
> >> Store the device type (obtained from i2c_device_id) as an enum and=
 add a
> >> default type of unknown to distinguish from case when this is not =
set
> >> at all.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> >> ---
> >>  include/linux/mfd/max77693-private.h | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > Applied, thanks.
>=20
> Thanks.
>=20
> I was thinking about merging everything through one tree because of
> the dependency (successive patches depend on previous) but I don't
> mind choosing different strategy. However if you picked this one mayb=
e
> you can also apply the patch 1/9:
> mfd/extcon: max77693: Remove unused extern declarations and max77693_=
dev members
>=20
> It already got ack from Chanwoo.
>=20
> Other patches depend on these so either everything will go through
> your tree or you will prepare an immutable branch for e.g. Mark (as
> everything is around regulator drivers).
>=20
> Anyway I need some input from Mark about the patches 4, 5 and 9. Rest
> of them already have his ack.

I'm happy to do that.  Just let me know when you have all the Acks you
need and I'll apply them all at once.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
