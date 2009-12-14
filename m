From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input_ gpio_keys: scan gpio state at probe time
Date: Sun, 13 Dec 2009 20:31:17 -0800
Message-ID: <20091214043117.GC16760@core.coreip.homeip.net>
References: <1259146416-6713-1-git-send-email-daniel@caiaq.de> <20091126034612.GA23244@core.coreip.homeip.net> <20091214031054.GX28375@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:60913 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093AbZLNEjc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 23:39:32 -0500
Received: by pzk1 with SMTP id 1so2008531pzk.33
        for <linux-input@vger.kernel.org>; Sun, 13 Dec 2009 20:39:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091214031054.GX28375@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org, Jani Nikula <ext-jani.1.nikula@nokia.com>, Mike Rapoport <mike@compulab.co.il>

On Mon, Dec 14, 2009 at 11:10:55AM +0800, Daniel Mack wrote:
> On Wed, Nov 25, 2009 at 07:46:13PM -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 25, 2009 at 11:53:36AM +0100, Daniel Mack wrote:
> > > gpio_keys.c registers interrupts at both edges of all given gpio lines
> > > and updates the input device when they change. However, the driver fails
> > > to check the current line state at probe time.
> > > 
> > 
> > Should not matter for keys really, but is important for swicthes. I
> > guess we need to also do this at resume. Does the following still work?
> 
> Sorry for the long delay on this. I could finally test this patch and it
> works fine, key states are reported correctly after resume.
> 

Thanks Daniel.

-- 
Dmitry
