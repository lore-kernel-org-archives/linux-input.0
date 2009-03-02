From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Mon, 2 Mar 2009 15:43:08 +0100
Message-ID: <20090302144308.GB11072@buzzloop.caiaq.de>
References: <20090227064314.GB32470@buzzloop.caiaq.de> <1235757652-16514-1-git-send-email-daniel@caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349198@mi8nycmail19.Mi8.com> <20090227183449.GD8855@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349253@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:53540 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbZCBOnN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 09:43:13 -0500
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901349253@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Feb 27, 2009 at 03:15:23PM -0500, hartleys wrote:
> Not sure if it matters but you can add my Tested-by if you like.
> 
> Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> >> I have a minor patch to it that allows the platform init to
> >> configure the absolute/relative axis to report the encoder on.
> >> If you would like to see it I can put together a patch.
> >
> > Yes, and probably just post it as follow-up as soon as this one
> > has been commited. I'm new to this list, so I don't know who
> > can/will/wants to do this?
> 
> Dmitry Torokhov is listed as the maintainer of the input drivers.  I
> think he needs to Ack the driver in order for it to be accepted and then
> committed to the kernel.

Dmitry, are you willing to take this patch? Just wanted to make sure
it's not getting lost :)

Daniel

