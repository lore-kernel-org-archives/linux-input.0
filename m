From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx
	data
Date: Thu, 16 Jul 2009 08:15:29 +0100
Message-ID: <20090716071529.GA28840@n2100.arm.linux.org.uk>
References: <200907151106.47917.david-b@pacbell.net> <20090715093313.GA2897@mail.gnudd.com> <20090715193326.GA13306@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40628 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbZGPHPw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 03:15:52 -0400
Content-Disposition: inline
In-Reply-To: <20090715193326.GA13306@mail.gnudd.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Rubini <rubini-list@gnudd.com>
Cc: david-b@pacbell.net, linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Jul 15, 2009 at 09:33:26PM +0200, Alessandro Rubini wrote:
> >> The issue was discussed with Russell King on linux-arm-kernel.
> > 
> > Gee, but not with the author of that driver or the maintainer of
> > the SPI framework.   Who could have pointed out instantly where
> > the true bug resides.
> 
> So, where is it? I don't get it I'm sorry.

Clearly David has no knowledge of DMA cache line handing and has not
read the DMA API document.  I really suggest that you ignore him until
he gets a fucking clue.
