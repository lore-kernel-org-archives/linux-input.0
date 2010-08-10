From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 1/1] mouse: add qci touchpad driver
Date: Tue, 10 Aug 2010 16:20:14 -0700
Message-ID: <20100810232014.GB21240@huya.qualcomm.com>
References: <1281126776-20014-1-git-send-email-nleeder@codeaurora.org>
 <4C5D3926.6050307@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:46154 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab0HJXUQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Aug 2010 19:20:16 -0400
Content-Disposition: inline
In-Reply-To: <4C5D3926.6050307@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Neil Leeder <nleeder@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>

On Sat, Aug 07, 2010 at 04:14:54PM +0530, Trilok Soni wrote:

> > +
> > +/*
> > + * Driver communicates over i2c to nuvoTon WPCE775x Embedded Controller,
> > + * which has touchpad attached through PS/2 interface.
> > + */
> 
> Why this driver is not developed through MFD architecture then? nuvoTon chip
> looks like multi-function chip, isn't it?

It is, in the sense that it does multiple things.  But, for this
particular device, it makes the keyboard available as an i2c device.
I don't see any particular reason to tie that to other functionality
that the chip provides.

David
