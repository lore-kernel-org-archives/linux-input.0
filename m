From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Wed, 8 Jul 2009 22:11:44 -0700
Message-ID: <20090709051143.GA14516@dtor-d630.eng.vmware.com>
References: <4A555B9E.8060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:50180 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbZGIFLt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 01:11:49 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1862510rvb.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 22:11:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A555B9E.8060508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

Hi Wan,

On Thu, Jul 09, 2009 at 10:53:18AM +0800, Wan ZongShun wrote:
> @@ -311,6 +309,9 @@ static int __devexit w90x900ts_remove(struct platform_device *pdev)
>  	del_timer_sync(&w90p910_ts->timer);
>  	iounmap(w90p910_ts->ts_reg);
>  
> +	clk_disable(w90p910_ts->clk);

This disable is unneeded since we already disable clock in close(). I
will fix locally and apply, there is no need to resubmit. I will also
fix pxa27 driver.

Thanks!

-- 
Dmitry
