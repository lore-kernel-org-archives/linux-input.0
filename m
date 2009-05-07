From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - add support for reporting x/y
	resolution
Date: Thu, 7 May 2009 09:49:00 -0700
Message-ID: <20090507164859.GB6450@dtor-d630.eng.vmware.com>
References: <1241460369.29685.6.camel@hp> <1241461145.29685.13.camel@hp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:61663 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbZEGQtH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 12:49:07 -0400
Received: by rv-out-0506.google.com with SMTP id f9so685985rvb.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 09:49:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1241461145.29685.13.camel@hp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tero Saarni <tero.saarni@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Tero,

On Mon, May 04, 2009 at 09:19:05PM +0300, Tero Saarni wrote:
> Synaptics uses anisotropic coordinate system.  On wide touchpads
> vertical coordinate resolution can be twice as high as horizontal
> leading to unequal sensitivity.  Make x and y coordinate resolution
> available so that differences can be compensated.
> 

Thank you for the patch.

> +#define ABS_RESX                0x26
> +#define ABS_RESY                0x27

This data is not part of dynamic state of the device but rather
describes it's physical characteristics and as such should not be
transmitted as input events. We should consider extending input_absinfo
and making this data available via EVIOCGABS ioctl but we need to be
careful with keeping compatibility with existing clients.

-- 
Dmitry
