From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Fri, 27 Feb 2009 18:17:47 +0100
Message-ID: <20090227171747.GB9749@buzzloop.caiaq.de>
References: <1235671228-29552-1-git-send-email-daniel@caiaq.de> <1235673764-5540-1-git-send-email-daniel@caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901348F62@mi8nycmail19.Mi8.com> <20090227064314.GB32470@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349093@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:55158 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbZB0RRx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 12:17:53 -0500
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901349093@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Fri, Feb 27, 2009 at 12:13:10PM -0500, hartleys wrote:
> Cool.
> 
> I was able to compile and test your driver on an ep93xx based system
> with a Bourns ECW1J-B24-BC0024 rotary encoder connected to the EGPIO8
> and EGPIO9 pins.  But I had to make the following changes to your
> original patch.

Ok, I'm fine with your changes. Will post a new patch that includes
them.

Daniel

