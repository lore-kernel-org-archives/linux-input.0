From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Sat, 18 Jun 2011 03:17:06 -0700
Message-ID: <20110618101706.GB2401@core.coreip.homeip.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl>
 <20110616192732.GJ3795@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59026 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab1FRKRV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2011 06:17:21 -0400
Received: by pzk9 with SMTP id 9so2379366pzk.19
        for <linux-input@vger.kernel.org>; Sat, 18 Jun 2011 03:17:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110616192732.GJ3795@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Thu, Jun 16, 2011 at 01:27:32PM -0600, Grant Likely wrote:
> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> > Use a threaded interrupt handler in order to permit the handler to use
> > a GPIO driver that causes things like I2C transactions being done inside
> > the handler context.
> > Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
> > all needed GPIO drivers have been loaded if the drivers are built into the
> > kernel.
> 
> ...which is a horrid hack, but until device dependencies can be
> described, it isn't one that can be solved easily.
> 

I really do not want to apply this... Currently the order of
initialization does not matter since nothing actually happens until
corresponding device appears on the bus. Does the OF code creates
devices before all resources are ready?

Thanks.

-- 
Dmitry
