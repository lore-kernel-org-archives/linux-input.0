From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] new driver for SGI volume buttons
Date: Thu, 17 Jul 2008 14:27:47 -0400
Message-ID: <20080717142640.ZZRA012@mailhub.coreip.homeip.net>
References: <20080715110436.7E8F2C312F@solo.franken.de> <20080717120337.ZZRA012@mailhub.coreip.homeip.net> <20080717173835.GB10376@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:9830 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759291AbYGQS1v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jul 2008 14:27:51 -0400
Received: by qw-out-2122.google.com with SMTP id 3so27339qwe.37
        for <linux-input@vger.kernel.org>; Thu, 17 Jul 2008 11:27:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080717173835.GB10376@alpha.franken.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-input@vger.kernel.org

On Thu, Jul 17, 2008 at 07:38:35PM +0200, Thomas Bogendoerfer wrote:
> On Thu, Jul 17, 2008 at 12:05:11PM -0400, Dmitry Torokhov wrote:
> > On Tue, Jul 15, 2008 at 01:04:36PM +0200, Thomas Bogendoerfer wrote:
> > > This driver adds support for the volume buttons on the front of every
> > > SGI Indy and O2 workstation.
> > 
> > Looks very nice. Do you think we could pass a pointer to
> > button_status() in device's platform data and get rid of ifdefs
> > altogether?
> 
> it's doable, but would need an extra header file for declaring
> a struct for passing the button_status() function pointer. If
> you think that's worth it, I'll implement it.
> 

I think it is OK as is for now. If we ever want to add yet another
button flavor then I would request this change.

Thanks.

-- 
Dmitry
