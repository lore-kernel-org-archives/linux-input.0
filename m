From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 01/18] mfd: add new driver for Sharp LoCoMo
Date: Thu, 28 May 2015 12:58:23 +0100
Message-ID: <20150528115823.GQ11677@x1>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
 <1432554113-26280-2-git-send-email-dbaryshkov@gmail.com>
 <20150527102756.GH11677@x1>
 <CALT56yO5Eu4Bk+_4sn2WgURh9YTsym9inWkvJftKUi_aLy5XXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALT56yO5Eu4Bk+_4sn2WgURh9YTsym9inWkvJftKUi_aLy5XXw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-input@vger.kernel.org

On Wed, 27 May 2015, Dmitry Eremin-Solenikov wrote:

> 2015-05-27 13:27 GMT+03:00 Lee Jones <lee.jones@linaro.org>:
> > On Mon, 25 May 2015, Dmitry Eremin-Solenikov wrote:
> >
> >> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does h=
as
> >> several design issues (special bus instead of platform bus, doesn'=
t use
> >> mfd-core, etc).
> >>
> >> Implement 'core' parts of locomo support as an mfd driver.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >
> > These things are much easier to re-review if you keep a change-log
> > here.
> >
> >>  drivers/mfd/Kconfig        |  10 ++
> >>  drivers/mfd/Makefile       |   1 +
> >>  drivers/mfd/locomo.c       | 336 ++++++++++++++++++++++++++++++++=
+++++++++++++
> >>  include/linux/mfd/locomo.h | 169 +++++++++++++++++++++++
> >>  4 files changed, 516 insertions(+)
> >>  create mode 100644 drivers/mfd/locomo.c
> >>  create mode 100644 include/linux/mfd/locomo.h
> >
> > Looks good now though:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> > How do you plan for this to be merged?
>=20
> I'd like for this to be merged either through mfd tree or through the
> arm-soc (or rmk's ARM) tree.
> Some of the respective maintainers already gave their blessing for
> this patchset to be merged
> not through their subsystem trees.

I can take it through MFD.  Once you have all the required Acks,
resubmit the set with them all applied with a note in the cover-letter
to that affect and I'll apply.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
