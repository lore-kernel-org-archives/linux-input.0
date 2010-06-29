From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] input: error handling bug in lm8323_probe()
Date: Tue, 29 Jun 2010 00:07:01 -0700
Message-ID: <20100629070701.GB19712@core.coreip.homeip.net>
References: <20100610075431.GK5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64131 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab0F2HHK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 03:07:10 -0400
Content-Disposition: inline
In-Reply-To: <20100610075431.GK5483@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Richard Purdie <rpurdie@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Jun 10, 2010 at 09:54:31AM +0200, Dan Carpenter wrote:
> We reuse the "i" variable later on so if we goto fail3 or fail4 then "i"
> will be set to the wrong thing and cause a crash.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 

Applied to next, thanks Dan.

-- 
Dmitry
