From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/6] Staging: mrst_touchscreen: clean up input side
Date: Tue, 27 Jul 2010 11:18:31 -0700
Message-ID: <20100727181831.GA29281@kroah.com>
References: <20100723134852.19151.6999.stgit@localhost.localdomain> <20100723135151.19151.73344.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:49892 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299Ab0G0SaE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 14:30:04 -0400
Content-Disposition: inline
In-Reply-To: <20100723135151.19151.73344.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, Jul 23, 2010 at 02:51:52PM +0100, Alan Cox wrote:
> Fix most of the stuff that Dmitry pointed out. This leaves the mutex in IRQ
> and misuse of SPI to sort out.
> 
> Also fix the build bits so it actually builds in staging - whoops.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

This doesn't apply for some reason.  Care to resend all 6 of these so I
can apply them?

thanks,

greg k-h
