From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/8] mfd: stpmic1: add stpmic1 driver
Date: Fri, 26 Oct 2018 08:17:44 +0100
Message-ID: <20181026071744.GH4870@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-3-git-send-email-p.paillet@st.com>
 <20181025112156.GB4870@dell>
 <CA+M3ks6s=mhLr0Hzcym_vmPVKjsuk8AFnQQe0qj-doVaXo9VcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+M3ks6s=mhLr0Hzcym_vmPVKjsuk8AFnQQe0qj-doVaXo9VcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: pascal paillet <p.paillet@st.com>, dmitry.torokhov@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, eballetbo@gmail.com
List-Id: linux-input@vger.kernel.org

On Thu, 25 Oct 2018, Benjamin Gaignard wrote:

> Le jeu. 25 oct. 2018 à 13:21, Lee Jones <lee.jones@linaro.org> a écrit :
> >
> > On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:
> >
> > > From: pascal paillet <p.paillet@st.com>
> > >
> > > stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> > > regulators , 3 switches, a watchdog and an input for a power on key.
> >
> > Same comments as for the DT binding patch.
> >
> > > Signed-off-by: pascal paillet <p.paillet@st.com>
> > > ---
> > > changes in v4:
> > > * rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE
> > >
> > >  drivers/mfd/Kconfig         |  13 ++
> > >  drivers/mfd/Makefile        |   1 +
> > >  drivers/mfd/stpmic1.c       | 401 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++
> > >  4 files changed, 627 insertions(+)
> > >  create mode 100644 drivers/mfd/stpmic1.c
> > >  create mode 100644 include/linux/mfd/stpmic1.h

[...]

> > > +static const struct regmap_irq stpmic1_irqs[] = {
> > > +     [IT_PONKEY_F]           = { .mask = 0x01 },
> > > +     [IT_PONKEY_R]           = { .mask = 0x02 },
> > > +     [IT_WAKEUP_F]           = { .mask = 0x04 },
> > > +     [IT_WAKEUP_R]           = { .mask = 0x08 },
> > > +     [IT_VBUS_OTG_F]         = { .mask = 0x10 },
> > > +     [IT_VBUS_OTG_R]         = { .mask = 0x20 },
> > > +     [IT_SWOUT_F]            = { .mask = 0x40 },
> > > +     [IT_SWOUT_R]            = { .mask = 0x80 },
> > > +
> > > +     [IT_CURLIM_BUCK1]       = { .reg_offset = 1, .mask = 0x01 },
> > > +     [IT_CURLIM_BUCK2]       = { .reg_offset = 1, .mask = 0x02 },
> > > +     [IT_CURLIM_BUCK3]       = { .reg_offset = 1, .mask = 0x04 },
> > > +     [IT_CURLIM_BUCK4]       = { .reg_offset = 1, .mask = 0x08 },
> > > +     [IT_OCP_OTG]            = { .reg_offset = 1, .mask = 0x10 },
> > > +     [IT_OCP_SWOUT]          = { .reg_offset = 1, .mask = 0x20 },
> > > +     [IT_OCP_BOOST]          = { .reg_offset = 1, .mask = 0x40 },
> > > +     [IT_OVP_BOOST]          = { .reg_offset = 1, .mask = 0x80 },
> > > +
> > > +     [IT_CURLIM_LDO1]        = { .reg_offset = 2, .mask = 0x01 },
> > > +     [IT_CURLIM_LDO2]        = { .reg_offset = 2, .mask = 0x02 },
> > > +     [IT_CURLIM_LDO3]        = { .reg_offset = 2, .mask = 0x04 },
> > > +     [IT_CURLIM_LDO4]        = { .reg_offset = 2, .mask = 0x08 },
> > > +     [IT_CURLIM_LDO5]        = { .reg_offset = 2, .mask = 0x10 },
> > > +     [IT_CURLIM_LDO6]        = { .reg_offset = 2, .mask = 0x20 },
> > > +     [IT_SHORT_SWOTG]        = { .reg_offset = 2, .mask = 0x40 },
> > > +     [IT_SHORT_SWOUT]        = { .reg_offset = 2, .mask = 0x80 },
> > > +
> > > +     [IT_TWARN_F]            = { .reg_offset = 3, .mask = 0x01 },
> > > +     [IT_TWARN_R]            = { .reg_offset = 3, .mask = 0x02 },
> > > +     [IT_VINLOW_F]           = { .reg_offset = 3, .mask = 0x04 },
> > > +     [IT_VINLOW_R]           = { .reg_offset = 3, .mask = 0x08 },
> > > +     [IT_SWIN_F]             = { .reg_offset = 3, .mask = 0x40 },
> > > +     [IT_SWIN_R]             = { .reg_offset = 3, .mask = 0x80 },
> > > +};
> >
> > There should be a MACRO for doing this.
> >
> > If there isn't, you should author one and put it in the Regmap header.

> I don't understand why you want to put this MACRO in regmap header.

REGMAP_IRQ_REG()

> Offsets and masks are custom from this hardware block.
> How can this become generic enough to be put in regmap ?

When replying to only a small section of driver/review like this,
would you mind trimming any unrelated quoting (as I have now done),
please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
