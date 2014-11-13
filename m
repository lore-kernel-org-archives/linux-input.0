From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] Input: gpio_keys - add device tree support for interrupt only keys
Date: Thu, 13 Nov 2014 12:05:26 +0100
Message-ID: <1587930.UcHkd3vGmk@wuerfel>
References: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com> <1763965.yCxTDubTPH@wuerfel> <54648EF6.10402@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <54648EF6.10402@nvidia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 13 November 2014 16:29:02 Laxman Dewangan wrote:
> On Thursday 13 November 2014 04:17 PM, Arnd Bergmann wrote:
> > I notice that Laxman Dewangan initially added the feature as part of
> > (I assume) work on Tegra, but these days Tegra is DT-only so it can't
> > actually get used for that any more.
> >
> > If we have a real usecase, I think we can still take your patch, but
> > my impression at the moment is that it may be better to instead
> > remove the feature entirely by reverting d8ee4a1c9052 ("Input:
> > gpio_keys - add support for interrupt only keys").
> >
> > Regarding your initial use case of testing interrupt polarity, would
> > you have been able to do the same thing by looking at the interrupt
> > count in /proc/interrupts?
> >
> 
> Yes, I posted patch for interrupt key on context on key connected to 
> PMIC-Onkey.
> On PMIC, there is onkey pin input which generates interrupt only when it 
> toggles. So if we have key (power key on our platforms) connected to 
> this pin then we will only get interrupt from PMIC.
> Instead of implementing full interrupt key driver, I added this support 
> on existing gpio keys.

So is this code still in place, and do you think it's worthwhile to
have a DT binding for it?

Could the PMIC register a gpio controller instead?

	Arnd
