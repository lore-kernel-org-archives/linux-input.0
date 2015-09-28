From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Input: serio - fix blocking of parport
Date: Mon, 28 Sep 2015 19:11:59 +0530
Message-ID: <20150928134126.GA4536@sudip-pc>
References: <1443273801-8822-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150928001808.GA17818@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33865 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbbI1NmP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 09:42:15 -0400
Content-Disposition: inline
In-Reply-To: <20150928001808.GA17818@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Sep 27, 2015 at 05:18:08PM -0700, Dmitry Torokhov wrote:
> On Sat, Sep 26, 2015 at 06:53:21PM +0530, Sudip Mukherjee wrote:
> > If parkbd_allocate_serio() fails to allocate memory we are releasing the
> > parport but we missed unregistering the device. As a result this device
> > with exclusive access to that parport remains registered. And no other
> > device will be able to use that parport even though this driver has
> > failed to load.
> > 
> > Cc: <stable@vger.kernel.org> # 2.6.32+
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> 
> Applied, but I dropped stable annotation - since noone complained about
> this and the issue is in error path that is unlikely anyway, I do not
> think we need to bother stable guys with it.
Ok. Thanks.
BTW, I have two more patches waiting for your review.
1) Input: cyapa: remove variable overwriting
2) Input: omap-keypad: fix memory leak

Did you get a chance to have a look at them?

regards
sudip
