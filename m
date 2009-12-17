From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input_ gpio_keys: scan gpio state at probe time
Date: Thu, 17 Dec 2009 09:05:49 +0800
Message-ID: <20091217010548.GA28375@buzzloop.caiaq.de>
References: <1259146416-6713-1-git-send-email-daniel@caiaq.de>
 <20091126034612.GA23244@core.coreip.homeip.net>
 <20091214031054.GX28375@buzzloop.caiaq.de>
 <20091214043117.GC16760@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:40852 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762460AbZLQBF7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 20:05:59 -0500
Content-Disposition: inline
In-Reply-To: <20091214043117.GC16760@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jani Nikula <ext-jani.1.nikula@nokia.com>, Mike Rapoport <mike@compulab.co.il>

On Sun, Dec 13, 2009 at 08:31:17PM -0800, Dmitry Torokhov wrote:
> On Mon, Dec 14, 2009 at 11:10:55AM +0800, Daniel Mack wrote:
> > On Wed, Nov 25, 2009 at 07:46:13PM -0800, Dmitry Torokhov wrote:
> > > On Wed, Nov 25, 2009 at 11:53:36AM +0100, Daniel Mack wrote:
> > > > gpio_keys.c registers interrupts at both edges of all given gpio lines
> > > > and updates the input device when they change. However, the driver fails
> > > > to check the current line state at probe time.
> > > > 
> > > 
> > > Should not matter for keys really, but is important for swicthes. I
> > > guess we need to also do this at resume. Does the following still work?
> > 
> > Sorry for the long delay on this. I could finally test this patch and it
> > works fine, key states are reported correctly after resume.
> > 
> 
> Thanks Daniel.

Will this still make it to 2.6.33?

Thanks,
Daniel
