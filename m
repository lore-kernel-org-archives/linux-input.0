From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: ad7879 - Convert I2C to dev_pm_ops
Date: Wed, 5 Jan 2011 22:41:46 +0000
Message-ID: <20110105224145.GA5476@opensource.wolfsonmicro.com>
References: <1294254095-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110105221432.GA6086@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37269 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751338Ab1AEWl3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Jan 2011 17:41:29 -0500
Content-Disposition: inline
In-Reply-To: <20110105221432.GA6086@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Wed, Jan 05, 2011 at 02:14:32PM -0800, Dmitry Torokhov wrote:

> I do not think you tested it with !CONFIG_PM since &NULL is not valid
> expression (& requires an lvalue for operand).

Oh, fail.  I knew there was a reason why dev_pm_ops stuff caused hassle.
But then I do have to wonder who exactly builds without PM enabled these
days.  

> Please change to guard .pm = &ad7879_i2c_pm with #ifdef.

Meh, I guess.  Though that ends up being annoying in general as some of
the PM functions (things like poweroff) are active even without PM
enabled, it always feels clearer to just have the struct there all the
time and carry on with the standard NULLs for functions.
