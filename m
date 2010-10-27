From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/10] drivers/input/serio/i8042: Use pr_<level>, pr_fmt. Fix dbg and __FILE__ use
Date: Tue, 26 Oct 2010 17:40:13 -0700
Message-ID: <201010261740.13566.dmitry.torokhov@gmail.com>
References: <cover.1288059486.git.joe@perches.com> <20101026155028.GA13097@core.coreip.homeip.net> <1288135531.4145.59.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45620 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391Ab0J0AkU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Oct 2010 20:40:20 -0400
In-Reply-To: <1288135531.4145.59.camel@Joe-Laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, October 26, 2010 04:25:31 pm Joe Perches wrote:
> On Tue, 2010-10-26 at 08:50 -0700, Dmitry Torokhov wrote:
> > Hi Joe,
> 
> Hi Dmitry.
> 
> > On Mon, Oct 25, 2010 at 07:44:24PM -0700, Joe Perches wrote:
> > > Standardized message logging prefixes.
> > > Removed \n from dbg macro, added \n to each dbg call site.
> > 
> > Did you test it? It looks for call like:
> > > +             dbg("%02x <- i8042 (flush, %s)\n",
> > > +                 data, str & I8042_STR_AUXDATA ? "aux" : "kbd");
> > 
> > the result will be:
> > printk(KERN_DEBUG "i8042: %02x <- i8042 (flush, %s)\n [%d]", ...)
> > which is not exactly what you want...
> 
> Right.  My mistake.
> I compile tested only and didn't notice the badly formed string.
> 
> Mind if I move the time to the front like this?
> 
> +#define dbg(format, arg...)                                            \
> +do {									\
> +	if (i8042_debug)						\
> +		printk(KERN_DEBUG KBUILD_MODNAME ": [%d]" format),	\
> +                      (int)(jiffies - i8042_start_time), ##arg);	\
> +} while (0)

Another option would be to leave '\n' in dbg() and leave most of the
callers as is.

Thanks.

-- 
Dmitry
