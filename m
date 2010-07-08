From: Greg KH <greg@kroah.com>
Subject: Re: Staging: mrst_touchscreen: clean up input side
Date: Thu, 8 Jul 2010 13:44:59 -0700
Message-ID: <20100708204459.GA13526@kroah.com>
References: <20100630173137.9776.52847.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:56363 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757141Ab0GHU7Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jul 2010 16:59:24 -0400
Content-Disposition: inline
In-Reply-To: <20100630173137.9776.52847.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Wed, Jun 30, 2010 at 06:31:58PM +0100, Alan Cox wrote:
> 
> Still staging stuff but knocked out some of the problems.
> 
> 
> Fix most of the stuff that Dmitry pointed out. This leaves the mutex in IRQ
> and misuse of SPI to sort out.
> 
> Also fix the build bits so it actually builds in staging - whoops.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

What tree did you make this against?  I can't seem to apply it to mine,
wierd.

greg k-h
