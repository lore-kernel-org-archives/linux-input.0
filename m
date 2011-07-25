From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 11:19:16 -0700
Message-ID: <20110725181916.GB6876@core.coreip.homeip.net>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
 <20110725152106.GB23356@suse.de>
 <1311608069.3262.8.camel@Allen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41782 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab1GYSTW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 14:19:22 -0400
Received: by yia27 with SMTP id 27so2403837yia.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 11:19:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311608069.3262.8.camel@Allen>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <wanlong.gao@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-input@vger.kernel.org

On Mon, Jul 25, 2011 at 11:34:29PM +0800, Wanlong Gao wrote:
> > > On 07/25/2011 04:30 PM, Dmitry Torokhov wrote:
> 
> > I'd rather have platform devices core clean up this pointer, then we
> > could stop caring about it in all drivers...
> > 
> 
> then I said:
> 
> > But the platform devices core just call the method of each own.
> > And don't care about the details like pdata, etc.
> > 
> > Meanwhile, I think the platform core need not care about these
> > details.
> > 
> > and Greg, what do you think about this?
> > 
> this is the thread, Greg, understand now?
> 
> For short, it's all about the platform driver data. Since many drivers
> set the platform driver data to NULL when it is removed, then Dmitry
> think it should be done in the platform driver core instead.

Right, like i2c bus we could just have platform core clean up platform
drvdata pointer after calling ->remove() and also if ->probe() errors
out.

Then individual drivers do not have to care about cleaning up this
pointer.

Thanks.

-- 
Dmitry
