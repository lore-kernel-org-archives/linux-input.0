From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ad7879 - Convert I2C to dev_pm_ops
Date: Wed, 5 Jan 2011 16:09:34 -0800
Message-ID: <20110106000934.GA6677@core.coreip.homeip.net>
References: <1294254095-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110105221432.GA6086@core.coreip.homeip.net>
 <20110105224145.GA5476@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44929 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1AFAJn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 19:09:43 -0500
Received: by pxi15 with SMTP id 15so2835011pxi.19
        for <linux-input@vger.kernel.org>; Wed, 05 Jan 2011 16:09:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110105224145.GA5476@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Wed, Jan 05, 2011 at 10:41:46PM +0000, Mark Brown wrote:
> On Wed, Jan 05, 2011 at 02:14:32PM -0800, Dmitry Torokhov wrote:
> 
> > I do not think you tested it with !CONFIG_PM since &NULL is not valid
> > expression (& requires an lvalue for operand).
> 
> Oh, fail.  I knew there was a reason why dev_pm_ops stuff caused hassle.
> But then I do have to wonder who exactly builds without PM enabled these
> days.  

Well, I kind of agree. Maybe someone should start looking into removing
CONFIG_PM, we are in 2011 now...


> 
> > Please change to guard .pm = &ad7879_i2c_pm with #ifdef.
> 
> Meh, I guess.  Though that ends up being annoying in general as some of
> the PM functions (things like poweroff) are active even without PM
> enabled,

Most of the drivers do not need special handlers for poweroff though...
I actually do not much liek the "simple" initializator as it usually
does way more than needed.

> it always feels clearer to just have the struct there all the
> time and carry on with the standard NULLs for functions.

Thanks.

-- 
Dmitry
