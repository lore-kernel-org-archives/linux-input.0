From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 0/4] mfd/regulator/clk/input: bd71837: ROHM BD71837
 PMIC driver
Date: Tue, 3 Jul 2018 08:02:00 +0100
Message-ID: <20180703070200.GC20176@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180621103400.GB6076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621103400.GB6076@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Thu, 21 Jun 2018, Matti Vaittinen wrote:

> On Tue, Jun 19, 2018 at 01:55:31PM +0300, Matti Vaittinen wrote:
> > Patch series adding support for ROHM BD71837 PMIC.
> > 
> What is the preferred way when I send updated patches:
> 
> 1. always resend _all_ unapplied patches even if there is no changes to
>    some of them. (patch-vN mail thread contains _all_ unapplied patches)
> 2. only resend changed patches (patch-vN mail thread contains only
>    patches that were changed from patch-vN-1)
> 
> I have currently used approach 1 - so that no patches would be
> accidentally forgotten - but downside is that people need to check if
> they have already reviewed some of the patches. I'd rather not caused
> any extra work. What is the most convenient way for you guys?

Option 1 is preferred.

Just ensure you apply any tags you have collected so reviewers can see
which patches are pending a review.  It's also a good idea to keep a
succinct change log between the "--" marker and the diff stat where
you can state "v4: No change" or the like.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
