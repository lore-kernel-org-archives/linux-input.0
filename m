From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Sat, 7 Mar 2009 18:06:33 +0100
Message-ID: <20090307170632.GA31096@buzzloop.caiaq.de>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <1236074367-23172-1-git-send-email-daniel@caiaq.de> <20090304084851.GB7394@dtor-d630.eng.vmware.com> <20090304095053.GA6098@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349B98@mi8nycmail19.Mi8.com> <20090304172054.GD12183@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:52874 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbZCGRGj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2009 12:06:39 -0500
Content-Disposition: inline
In-Reply-To: <20090304172054.GD12183@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Wed, Mar 04, 2009 at 06:20:54PM +0100, Daniel Mack wrote:
> > 2) I have a patch to the driver that allows the axis to be a REL_* type.
> > I will post this patch for review after the driver is committed.
> 
> Cool, that might be a good alternative for users.
> 
> > 3) Are both 'inverted_*' flags really needed?  It appears that the end
> > effect of these just reverses the logical direction of the encoder.
> > 
> > 	inverted_a	inverted_b	result
> > 	0		0		normal encoder
> > 	0		1		backwards encoder
> > 	1		0		backwards encoder
> > 	1		1		normal encoder

The driver has now been commited to input.git/next, so you could send a
patch with your ideas on top of it if you like and find some time :)

Daniel

