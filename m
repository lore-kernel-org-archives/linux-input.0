From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ads7846 touchscreen: fix pressure
Date: Wed, 25 Nov 2009 18:10:40 -0800
Message-ID: <20091126021040.GA23079@core.coreip.homeip.net>
References: <20091120182238.GA1344@ucw.cz> <20091120182528.GB16447@core.coreip.homeip.net> <20091120185058.GA1472@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:40110 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZKZCKk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 21:10:40 -0500
Content-Disposition: inline
In-Reply-To: <20091120185058.GA1472@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, Nov 20, 2009 at 07:50:58PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > On Zaurus, pressure is reported inverted -- the lighter the pressure,
> > > the bigger numerical value. This should fix it.
> > > 
> > 
> > Thanks. Didn't you also have a bigger cleanup patch for ads7846?
> 
> Yes, I did, but I wanted to avoid risk for collision. So pick one...
> 

Thanks. I ended up picking both...

-- 
Dmitry
