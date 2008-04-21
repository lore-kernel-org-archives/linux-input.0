From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] gpio-keys debouncing support
Date: Mon, 21 Apr 2008 11:55:16 -0400
Message-ID: <20080421155516.GD6884@anvil.corenet.prv>
References: <20080319221323.GA2710@doriath.ww600.siemens.net> <20080421144019.GA6516@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:48707 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761876AbYDUPzY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 11:55:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so558679nfb.21
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 08:55:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080421144019.GA6516@doriath.ww600.siemens.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Apr 21, 2008 at 06:40:19PM +0400, Dmitry Baryshkov wrote:
> Hi,
> 
> What about this patch? I still got no comments.
> 

I thought I CCed you form slightly different thread. I don't think that
this should be a separate Kconfig option, we shoudl make it permanent
in the driver. I also wonder if it would be better to allocate debounce
data once for all buttons instead of nickel-and-dime-ing memory
allocator with tiny requests. Timer shoudl be moved into debounce data
too BTW.

Thanks.

-- 
Dmitry
