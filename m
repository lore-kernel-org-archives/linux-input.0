From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 06/10] drivers/input/serio/i8042: Use pr_<level>,
 pr_fmt. Fix dbg and __FILE__ use
Date: Tue, 26 Oct 2010 17:46:56 -0700
Message-ID: <1288140416.4145.76.camel@Joe-Laptop>
References: <cover.1288059486.git.joe@perches.com>
	 <20101026155028.GA13097@core.coreip.homeip.net>
	 <1288135531.4145.59.camel@Joe-Laptop>
	 <201010261740.13566.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:3615 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757459Ab0J0Aq5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Oct 2010 20:46:57 -0400
In-Reply-To: <201010261740.13566.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2010-10-26 at 17:40 -0700, Dmitry Torokhov wrote:
> > Mind if I move the time to the front like this?
> > +#define dbg(format, arg...)                                            \
> > +do {									\
> > +	if (i8042_debug)						\
> > +		printk(KERN_DEBUG KBUILD_MODNAME ": [%d]" format),	\
> > +                      (int)(jiffies - i8042_start_time), ##arg);	\
> > +} while (0)
> Another option would be to leave '\n' in dbg() and leave most of the
> callers as is.

That's really error prone though.

