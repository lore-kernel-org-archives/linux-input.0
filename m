From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm97xx - use EBUSY instead of EINVAL
Date: Wed, 3 Jun 2009 07:19:14 -0700
Message-ID: <20090603141913.GA21197@dtor-d630.eng.vmware.com>
References: <4A260DEB.2040306@samsung.com> <20090603100120.GA31919@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:64525 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbZFCOTT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 10:19:19 -0400
Received: by rv-out-0506.google.com with SMTP id f9so5948rvb.1
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2009 07:19:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090603100120.GA31919@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Wed, Jun 03, 2009 at 11:01:21AM +0100, Mark Brown wrote:
> On Wed, Jun 03, 2009 at 02:45:15PM +0900, Joonyoung Shim wrote:
> > If request_irq() fails, we have to return -EBUSY instead of -EINVAL.
> 
> Could you provide a bit more explanation for this one, please?  -EBUSY
> seems to give entirely the wrong impression to applications since in the
> systems where this driver will be deployed a failure to acquire the IRQ
> is most likely to be due to incorrect platform data and it is highly
> unlikely to resolve itself.

The "most correct" thing would be to propagate the value returned by
request_irq() I think but since nobidy actually uses result of
wm97xx_init_pen_irq() I just would not bother at all.

-- 
Dmitry
