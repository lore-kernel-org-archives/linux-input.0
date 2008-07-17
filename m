From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH] new driver for SGI volume buttons
Date: Thu, 17 Jul 2008 19:38:35 +0200
Message-ID: <20080717173835.GB10376@alpha.franken.de>
References: <20080715110436.7E8F2C312F@solo.franken.de> <20080717120337.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:41237 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbYGQRin (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jul 2008 13:38:43 -0400
Content-Disposition: inline
In-Reply-To: <20080717120337.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Jul 17, 2008 at 12:05:11PM -0400, Dmitry Torokhov wrote:
> On Tue, Jul 15, 2008 at 01:04:36PM +0200, Thomas Bogendoerfer wrote:
> > This driver adds support for the volume buttons on the front of every
> > SGI Indy and O2 workstation.
> 
> Looks very nice. Do you think we could pass a pointer to
> button_status() in device's platform data and get rid of ifdefs
> altogether?

it's doable, but would need an extra header file for declaring
a struct for passing the button_status() function pointer. If
you think that's worth it, I'll implement it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
