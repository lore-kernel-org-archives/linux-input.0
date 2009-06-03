From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm97xx - use EBUSY instead of EINVAL
Date: Wed, 3 Jun 2009 07:48:57 -0700
Message-ID: <200906030748.58010.dmitry.torokhov@gmail.com>
References: <4A260DEB.2040306@samsung.com> <20090603141913.GA21197@dtor-d630.eng.vmware.com> <20090603144024.GJ11507@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:6859 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbZFCOtB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 10:49:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so14701rvb.1
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2009 07:49:03 -0700 (PDT)
In-Reply-To: <20090603144024.GJ11507@sirena.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Wednesday 03 June 2009 07:40:24 Mark Brown wrote:
> On Wed, Jun 03, 2009 at 07:19:14AM -0700, Dmitry Torokhov wrote:
> > The "most correct" thing would be to propagate the value returned by
> > request_irq() I think but since nobidy actually uses result of
> > wm97xx_init_pen_irq() I just would not bother at all.
>
> Yeah, I was looking at that - the driver can run in polling mode so it's
> fine as-is.  I could change the code to return void, I suppose.

Yes, I think that would be the best.

-- 
Dmitry
