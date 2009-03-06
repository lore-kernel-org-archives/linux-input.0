From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 03/22] input: AD7879 Touchscreen driver
Date: Fri, 6 Mar 2009 02:05:11 -0800
Message-ID: <20090306100510.GC24864@dtor-d630.eng.vmware.com>
References: <200903041958.n24Jws9R028400@imap1.linux-foundation.org> <8A42379416420646B9BFAC9682273B6D09407D59@limkexm3.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:17313 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZCFKFU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2009 05:05:20 -0500
Received: by yx-out-2324.google.com with SMTP id 8so231692yxm.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2009 02:05:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A42379416420646B9BFAC9682273B6D09407D59@limkexm3.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, cooloney@kernel.org, randy.dunlap@oracle.com

Hi Michael,

On Fri, Mar 06, 2009 at 09:48:17AM -0000, Hennerich, Michael wrote:
> 
> Hi Dmitry,
> 
> Is there a schedule when this and my other patch get merged mainline?
> 
> [patch 01/22] input/touchscreen driver: add support AD7877 touchscreen
> driver
> 
> Do you have any concerns or is there something that should be done
> differently?

I have some concerns with regard to locking in the driver. I had a
preliminary patch but I need to look at it again.

-- 
Dmitry
