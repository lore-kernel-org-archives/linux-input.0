From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: rotary_encoder cleanup
Date: Mon, 29 Jun 2009 19:32:11 -0700
Message-ID: <20090630023211.GC10652@dtor-d630.eng.vmware.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:55006 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbZF3CcM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 22:32:12 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1390435rvb.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 19:32:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090623162126.GL29236@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, linux-input@vger.kernel.org

On Tue, Jun 23, 2009 at 06:21:26PM +0200, Daniel Mack wrote:
> On Sat, Jun 20, 2009 at 06:15:51PM -0400, H Hartley Sweeten wrote:
> > There is no need to carry the two irq numbers in the allocated memory.
> > They are only needed for the free_irq() calls during the remove.  Since
> > the driver is already carrying the platform_data we can just call
> > gpio_to_irq() to get the irq number.
> > 
> > Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> Acked-by: Daniel Mack <daniel@caiaq.de>
> 

Do we know how many encoders we need to have in the system to start
seeing the benefits (given that all these conversions increase text
size)?

-- 
Dmitry
