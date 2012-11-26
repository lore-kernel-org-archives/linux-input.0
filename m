From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: gpio-keys: Disable hardware on suspend
Date: Mon, 26 Nov 2012 01:32:40 -0800
Message-ID: <20121126093240.GB13792@core.coreip.homeip.net>
References: <1353590617-11466-1-git-send-email-lee.jones@linaro.org>
 <20121125083229.GB21091@core.coreip.homeip.net>
 <20121126090503.GB12782@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43393 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab2KZJco (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 04:32:44 -0500
Content-Disposition: inline
In-Reply-To: <20121126090503.GB12782@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, Jonas Aaberg <jonas.aberg@stericsson.com>, linux-input@vger.kernel.org, Philippe Langlais <philippe.langlais@linaro.org>

On Mon, Nov 26, 2012 at 09:05:03AM +0000, Lee Jones wrote:
> > On Thu, Nov 22, 2012 at 01:23:36PM +0000, Lee Jones wrote:
> > > From: Jonas Aaberg <jonas.aberg@stericsson.com>
> > > 
> > > Disable hardware if active when suspending if the hw can not
> > > wake the system from suspend.
> > 
> > How about below instead (needs the other patch I have just sent out)?
> 
> Sorry Dmitry, I'm a little confused. What does this mean?

The modified version of the patch I have sent depends on the other patch
to gpio-keys that introduces gpio_keys_report_state() that I believe you
have been CCed.

Thanks.

-- 
Dmitry
