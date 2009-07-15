From: Alessandro Rubini <rubini-list@gnudd.com>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx
	data
Date: Wed, 15 Jul 2009 21:33:26 +0200
Message-ID: <20090715193326.GA13306@mail.gnudd.com>
References: <200907151106.47917.david-b@pacbell.net>
	<20090715093313.GA2897@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:63016 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093AbZGOTdr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 15:33:47 -0400
Content-Disposition: inline
In-Reply-To: <200907151106.47917.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: david-b@pacbell.net
Cc: linux-input@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk

>> Since the SPI master might use DMA, tx and rx buffers must live on
>> different cache lines.
> 
> Not true.  Full duplex tranfsers using a single buffer are
> explicitly allowed.

Ok, thanks.

> If that spi_master driver mis-handles this, it's a bug in that
> driver.

Well, the driver receives one spi message made of 4 or 6 transfers.
It does one at a time, shouldn't it?  If the transfer description is
intermixed with the data buffer, we fetch a line from ram with
not-yet-filled input buffers. So I get invalid data from the analog
inputs -- usually zero, as the structure is kzalloced.

>> The issue was discussed with Russell King on linux-arm-kernel.
> 
> Gee, but not with the author of that driver or the maintainer of
> the SPI framework.   Who could have pointed out instantly where
> the true bug resides.

So, where is it? I don't get it I'm sorry.

ps: yes, it's a revB silicon.

/alessandro
