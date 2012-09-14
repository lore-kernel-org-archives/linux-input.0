From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v1 4/7] DA9055 GPIO driver
Date: Fri, 14 Sep 2012 17:38:54 +0100
Message-ID: <20120914163854.GG4684@opensource.wolfsonmicro.com>
References: <1347629416.18587.15.camel@dhruva>
 <CACRpkdYQutaM2aHyJOmtYZtZ8w6c-pQ4xm5adUAia1UH-SM88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60402 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827Ab2INQi5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 12:38:57 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYQutaM2aHyJOmtYZtZ8w6c-pQ4xm5adUAia1UH-SM88Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ashish Jangam <ashish.jangam@kpitcummins.com>, Grant Likely <grant.likely@secretlab.ca>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>

On Fri, Sep 14, 2012 at 04:13:57PM +0200, Linus Walleij wrote:

> But the parent driver is using regmap, sand you seem not to use the
> struct da9055
> for anything else than passing reads/writes, so isn't it simpler to just pass
> the struct regmap * and use update_bits etc directly and remove a layer of
> indirection?

> I'm very uncertain but Mark will know the proper design pattern.

Either way is fine - usually the device specific functions end up being
static inlines in the header so the code is the same.  It really depends
if it's useful to have the full device pointer around for other things.
