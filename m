From: Alan Cox <alan@linux.intel.com>
Subject: Re: Staging: mrst_touchscreen: clean up input side
Date: Thu, 8 Jul 2010 23:46:51 +0100
Message-ID: <20100708234651.6acc82a6@linux.intel.com>
References: <20100630173137.9776.52847.stgit@localhost.localdomain>
	<20100708204459.GA13526@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5215 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758836Ab0GHXPg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jul 2010 19:15:36 -0400
In-Reply-To: <20100708204459.GA13526@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-input@vger.kernel.org

On Thu, 8 Jul 2010 13:44:59 -0700
Greg KH <greg@kroah.com> wrote:

> On Wed, Jun 30, 2010 at 06:31:58PM +0100, Alan Cox wrote:
> > 
> > Still staging stuff but knocked out some of the problems.
> > 
> > 
> > Fix most of the stuff that Dmitry pointed out. This leaves the
> > mutex in IRQ and misuse of SPI to sort out.
> > 
> > Also fix the build bits so it actually builds in staging - whoops.
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> What tree did you make this against?  I can't seem to apply it to
> mine, wierd.

I'll sync up with a current -next and sort that out - not sure why it
wouldn't apply.

