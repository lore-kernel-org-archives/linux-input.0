From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: question on releasing keys
Date: Thu, 1 Jul 2010 09:11:01 -0700
Message-ID: <20100701161101.GC4152@core.coreip.homeip.net>
References: <201004281053.52598.oneukum@suse.de>
 <201004280942.25746.dmitry.torokhov@gmail.com>
 <201005061533.49845.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35137 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0GAQLH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jul 2010 12:11:07 -0400
Received: by pwi5 with SMTP id 5so221798pwi.19
        for <linux-input@vger.kernel.org>; Thu, 01 Jul 2010 09:11:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201005061533.49845.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org

On Thu, May 06, 2010 at 03:33:49PM +0200, Oliver Neukum wrote:
> Am Mittwoch, 28. April 2010 18:42:24 schrieb Dmitry Torokhov:
> > Hi Oliver,
> > 
> > On Wednesday 28 April 2010 01:53:52 am Oliver Neukum wrote:
> > > Hi,
> > > 
> > > I am seeing a generic problem with buttons on devices released during S3.
> > > The input layer then assumes that the button is still pressed. It would be
> > > best for drivers to either verify that a button is still held or
> > > alternatively, to release all buttons upon resumption. Is there a generic
> > > way to do that?
> > >
> > 
> > I think input core should force release of all keys when device is
> > being suspended, I guess we need to change input.c::input_dev_reset().
> 
> Something like this?
> 
> 	Regards
> 		Oliver
> 
> From 96c19e9e0c6164655600e764a9b5c3a6f132723d Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Thu, 6 May 2010 15:30:28 +0200
> Subject: [PATCH] input: release pressed keys during resume()
> 
> As the kernel has no way to know whether a key was released
> while the system was asleep, keys need to be reported released
> as the system is resumed, lest autorepeat set in.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

Applied, thanks Oliver.

-- 
Dmitry
