From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/3] mfd: max8997: handle IRQs using regmap
Date: Thu, 13 Mar 2014 08:00:00 +0000
Message-ID: <20140313080000.GA8740@lee--X1>
References: <1394631466-6429-1-git-send-email-r.baldyga@samsung.com>
 <1394631466-6429-3-git-send-email-r.baldyga@samsung.com>
 <532111FA.2010706@samsung.com>
 <53216272.7050304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53216272.7050304@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, sameo@linux.intel.com, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

Guys, when replying please cut out all of the unnecessary text. Paging
down though unmodified/unreviewed code is tiresome.

> >> This patch modifies mfd driver to use regmap for handling interrup=
ts.
> >> It allows to simplify irq handling process. This modifications nee=
ded
> >> to make small changes in function drivers, which use interrupts.
> >>
> >> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> >> ---
> >>  drivers/extcon/extcon-max8997.c     |   35 ++--
> >>  drivers/mfd/Kconfig                 |    2 +-
> >>  drivers/mfd/Makefile                |    2 +-
> >>  drivers/mfd/max8997-irq.c           |  373 ----------------------=
-------------
> >>  drivers/mfd/max8997.c               |  113 ++++++++++-
> >>  drivers/rtc/rtc-max8997.c           |    2 +-
> >>  include/linux/mfd/max8997-private.h |   65 +++++-
> >>  7 files changed, 183 insertions(+), 409 deletions(-)
> >>  delete mode 100644 drivers/mfd/max8997-irq.c
> >>
> >> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extc=
on-max8997.c
> >> index f258c08..15fc5c0 100644
> >> --- a/drivers/extcon/extcon-max8997.c
> >> +++ b/drivers/extcon/extcon-max8997.c
> >> @@ -46,15 +46,15 @@ struct max8997_muic_irq {
> >>  };
> >> =20
> >>  static struct max8997_muic_irq muic_irqs[] =3D {
> >> -	{ MAX8997_MUICIRQ_ADCError,	"muic-ADCERROR" },
> >> -	{ MAX8997_MUICIRQ_ADCLow,	"muic-ADCLOW" },
> >> -	{ MAX8997_MUICIRQ_ADC,		"muic-ADC" },
> >> -	{ MAX8997_MUICIRQ_VBVolt,	"muic-VBVOLT" },
> >> -	{ MAX8997_MUICIRQ_DBChg,	"muic-DBCHG" },
> >> -	{ MAX8997_MUICIRQ_DCDTmr,	"muic-DCDTMR" },
> >> -	{ MAX8997_MUICIRQ_ChgDetRun,	"muic-CHGDETRUN" },
> >> -	{ MAX8997_MUICIRQ_ChgTyp,	"muic-CHGTYP" },
> >> -	{ MAX8997_MUICIRQ_OVP,		"muic-OVP" },
> >> +	{ MAX8997_MUICIRQ_ADCERROR,	"MUIC-ADCERROR" },
> >> +	{ MAX8997_MUICIRQ_ADCLOW,	"MUIC-ADCLOW" },
> >> +	{ MAX8997_MUICIRQ_ADC,		"MUIC-ADC" },
> >> +	{ MAX8997_MUICIRQ_VBVOLT,	"MUIC-VBVOLT" },
> >> +	{ MAX8997_MUICIRQ_DBCHG,	"MUIC-DBCHG" },
> >> +	{ MAX8997_MUICIRQ_DCDTMR,	"MUIC-DCDTMR" },
> >> +	{ MAX8997_MUICIRQ_CHGDETRUN,	"MUIC-CHGDETRUN" },
> >> +	{ MAX8997_MUICIRQ_CHGTYP,	"MUIC-CHGTYP" },
> >> +	{ MAX8997_MUICIRQ_OVP,		"MUIC-OVP" },
> >>  };
> >=20
> >=20
> > Why did you modify interrput name? Did you have some reason?
> > I think this modification don't need it.
>=20
> I did it to have one naming convention in max8997-private.h file. Any
> other interrupt names uses upper case, but MUIC iqr's from some reaso=
n
> uses CamelCase. I think it's much better to have consistent style in
> entire file.

I agree with the modification. CamelCase #defines/enums are hard to
read and look awful.

<snip>

> >> +enum max8997_irq_muic {
> >>  	MAX8997_MUICIRQ_ADC,
> >> +	MAX8997_MUICIRQ_ADCLOW,
> >> +	MAX8997_MUICIRQ_ADCERROR,
> >> =20
> >> -	MAX8997_MUICIRQ_VBVolt,
> >> -	MAX8997_MUICIRQ_DBChg,
> >> -	MAX8997_MUICIRQ_DCDTmr,
> >> -	MAX8997_MUICIRQ_ChgDetRun,
> >> -	MAX8997_MUICIRQ_ChgTyp,
> >> +	MAX8997_MUICIRQ_CHGTYP,
> >> +	MAX8997_MUICIRQ_CHGDETRUN,
> >> +	MAX8997_MUICIRQ_DCDTMR,
> >> +	MAX8997_MUICIRQ_DBCHG,
> >> +	MAX8997_MUICIRQ_VBVOLT,
> >=20
> > ditto.
> > I don't understand why do you modify interrnut name/macro.

=2E.. because the old ones are ugly and hard to read.

> >>  	MAX8997_MUICIRQ_OVP,
> >> =20
> >> -	MAX8997_IRQ_NR,
> >> +	MAX8997_MUCIRQ_NR,
> >=20
> > ditto.
>=20
> Here I have splitted enum into few enums, each for single interrupt
> source, to make it easier to use with regmap irq handling. So I chang=
ed
> MAX8997_IRQ_NR name to MAX8997_MUCIRQ_NR because now it's not number =
of
> all interrupts but number of interrupts coming form MUIC.

The new name is more inline with the remaining enums, thus is better.

<snip>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
