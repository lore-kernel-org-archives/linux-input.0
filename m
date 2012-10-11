From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] Input: wm831x-ts - Convert to devm_kzalloc()
Date: Thu, 11 Oct 2012 17:33:24 +0900
Message-ID: <20121011083322.GG11726@opensource.wolfsonmicro.com>
References: <1349875236-5707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1349875236-5707-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121011073955.GA30395@core.coreip.homeip.net>
 <20121011080722.GE11726@opensource.wolfsonmicro.com>
 <20121011082749.GD32175@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57999 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753678Ab2JKIdc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 04:33:32 -0400
Content-Disposition: inline
In-Reply-To: <20121011082749.GD32175@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 11, 2012 at 01:27:49AM -0700, Dmitry Torokhov wrote:
> On Thu, Oct 11, 2012 at 05:07:24PM +0900, Mark Brown wrote:

> > 
> > What's the error pattern you're seeing?  I've not noticed much of an
> > issue here, but if there is one perhaps we can do something to make the
> > error more obvious or harder to introduce.

> 	devm_request_irq();

> The problem is that input device is freed but interrupts are still fully
> functional.

Ah, yes - that one I do spot all the time.  I agree that devm_request_irq()
is a menace, that error is far too easy to introduce and it always seems
more work to work out if it's safe than the benefit in the cases where
it can be used.

The other devm APIs are less problematic, though.
