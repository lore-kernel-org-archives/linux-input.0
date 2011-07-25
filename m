From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 08:21:06 -0700
Message-ID: <20110725152106.GB23356@suse.de>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
 <20110725083048.GD22937@core.coreip.homeip.net>
 <4E2D33E3.9090408@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60573 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab1GYPWu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 11:22:50 -0400
Content-Disposition: inline
In-Reply-To: <4E2D33E3.9090408@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On Mon, Jul 25, 2011 at 05:14:11PM +0800, Wanlong Gao wrote:
> On 07/25/2011 04:30 PM, Dmitry Torokhov wrote:
> >On Wed, Jul 20, 2011 at 11:34:28PM +0800, Wanlong Gao wrote:
> >>It's better to set the device's driver data to NULL
> >>when remove it.
> >>
> >
> >I'd rather have platform devices core clean up this pointer, then we
> >could stop caring about it in all drivers...
> But the platform devices core just call the method of each own.
> And don't care about the details like pdata, etc.
> 
> Meanwhile, I think the platform core need not care about these details.
> 
> and Greg, what do you think about this?

I don't understand what you are asking me.
