From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx data
Date: Thu, 16 Jul 2009 01:35:51 -0700
Message-ID: <200907160135.51307.david-b@pacbell.net>
References: <200907160051.04506.david-b@pacbell.net> <20090715193326.GA13306@mail.gnudd.com> <20090716081527.GA29374@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.gq1.yahoo.com ([67.195.14.95]:30078 "HELO
	smtp110.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753098AbZGPIfw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 04:35:52 -0400
In-Reply-To: <20090716081527.GA29374@mail.gnudd.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Rubini <rubini-list@gnudd.com>
Cc: linux-input@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk

On Thursday 16 July 2009, Alessandro Rubini wrote:
> > Note that this issue is unrelated to full duplex DMA support.
> 
> Yes, that's right. But full duplex is not involved here, it's
> just 2 or 3 rounds of "one byte tx then two bytes rx".

Then your patch description was *seriously* misleading:

> > > Since the SPI master might use DMA, tx and rx buffers must live on
> > > different cache lines. ...

I'll have another look at that patch to see if it could make
sense after I discard the description.

- dave
