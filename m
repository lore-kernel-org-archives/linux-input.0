From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Enable WM97xx touchscreen sub-drivers by default
Date: Thu, 24 Jul 2008 13:00:05 -0400
Message-ID: <20080724170005.GA7081@anvil.corenet.prv>
References: <1216905308-4723-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1216906867-5058-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080724065756.55954c35@infradead.org> <20080724142650.GA5234@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:14610 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYGXRAJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jul 2008 13:00:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1259800ywe.1
        for <linux-input@vger.kernel.org>; Thu, 24 Jul 2008 10:00:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080724142650.GA5234@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 24, 2008 at 03:26:51PM +0100, Mark Brown wrote:
> On Thu, Jul 24, 2008 at 06:57:56AM -0700, Arjan van de Ven wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > 
> > > Currently the support for each WM97xx touchscreen model is compiled
> > > out by default, meaning that the default configuration when the
> 
> > this isn't normally how things are done; Linux is on a "off unless
> > selected or unless it breaks booting" policy nowadays...
> 
> These options only be visible if the user has chosen to build the WM97xx
> touchscreen driver which does the default thing already.  Within the
> context of the driver these options are of the broken boot variety since
> without at least one of them being enabled the driver will do nothing
> except waste resources.
> 
> I really don't think it's sensible for the default configuration of the
> driver to produce something totally non-functional.
> 
> > (and distributions don't follow "default" anyway, so don't worry about
> > that part)
> 
> This change is a direct result of Ubuntu enabling the driver with all
> the controllers compiled out.  This seems like a completely reasonable
> thing for them to do - nothing in Kconfig suggests that it is mandatory
> to enable at least one of the options and the existing default and help
> text both suggest that it should be turned off.

I agree with Mark - since the core driver is disabled by default we
don't burden users who do not want it. However enabling the main
option should produce working driver and people who want to save space
in their custom kernels can disable unneeded sub-options.

Will apply.

-- 
Dmitry
