From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] mrst_touchscreen: clean up input side
Date: Wed, 30 Jun 2010 12:46:27 -0700
Message-ID: <20100630194626.GA12366@core.coreip.homeip.net>
References: <20100630173137.9776.52847.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44066 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab0F3Tqe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 15:46:34 -0400
Received: by pxi14 with SMTP id 14so43076pxi.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 12:46:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100630173137.9776.52847.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: greg@kroah.com, linux-input@vger.kernel.org

On Wed, Jun 30, 2010 at 06:31:58PM +0100, Alan Cox wrote:
> 
> Still staging stuff but knocked out some of the problems.
> 
> 
> Fix most of the stuff that Dmitry pointed out. This leaves the mutex in IRQ
> and misuse of SPI to sort out.
> 

Looks better, thanks for making the changes. I wonder if switching to
threaded IRQ willnot fix all this ugliness in pendetect implementation.

>  static int mrstouch_remove(struct spi_device *spi)

__devexit

>  {
> -	mrstouch_debug("%s", __func__);
>  	free_irq(mrstouchdevp->irq, mrstouchdevp);
> -	input_unregister_device(mrstouchdevp->input);
> -	input_free_device(mrstouchdevp->input);
>  	if (mrstouchdevp->pendet_thrd)
>  		kthread_stop(mrstouchdevp->pendet_thrd);
> +	input_unregister_device(mrstouchdevp->input);
>  	kfree(mrstouchdevp);
>  	return 0;
>  }
> @@ -830,8 +776,6 @@ static struct spi_driver mrstouch_driver = {
>  		.owner  = THIS_MODULE,
>  	},
>  	.probe          = mrstouch_probe,
> -	.suspend        = mrstouch_suspend,
> -	.resume         = mrstouch_resume,
>  	.remove         = mrstouch_remove,

__devexot_p()

>  };
>  
> @@ -839,11 +783,10 @@ static int __init mrstouch_module_init(void)
>  {
>  	int err;
>  
> -	mrstouch_debug("%s", __func__);
>  	err = spi_register_driver(&mrstouch_driver);
>  	if (err) {
> -		mrstouch_debug("%s(%d)", "SPI PENDET failed", err);
> -		return -1;
> +		printk(KERN_ERR "%s(%d)", "SPI PENDET failed", err);
> +		return err;;


Extra semicolon... But I'd just do:

	return spi_register_driver(&mrstouch_driver);

>  	}
>  
>  	return 0;
> @@ -851,7 +794,6 @@ static int __init mrstouch_module_init(void)
>  
>  static void __exit mrstouch_module_exit(void)
>  {
> -	mrstouch_debug("%s", __func__);
>  	spi_unregister_driver(&mrstouch_driver);
>  	return;

Zap this return please.

Thanks.

-- 
Dmitry
