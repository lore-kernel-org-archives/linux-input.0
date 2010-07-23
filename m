From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/6] *	Register platform interface
Date: Fri, 23 Jul 2010 09:07:16 -0700
Message-ID: <20100723160716.GA21546@core.coreip.homeip.net>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
 <20100723135219.19151.98855.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58547 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008Ab0GWQHW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 12:07:22 -0400
Received: by pzk26 with SMTP id 26so133183pzk.19
        for <linux-input@vger.kernel.org>; Fri, 23 Jul 2010 09:07:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100723135219.19151.98855.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: greg@kroah.com, linux-input@vger.kernel.org

Hi Alan,

On Fri, Jul 23, 2010 at 02:52:21PM +0100, Alan Cox wrote:
> -static struct spi_driver mrstouch_driver = {
> +static struct platform_driver mrstouch_driver = {
>  	.driver = {
>  		.name   = "pmic_touch",
> -		.bus    = &spi_bus_type,
>  		.owner  = THIS_MODULE,
>  	},
>  	.probe          = mrstouch_probe,
> @@ -725,13 +722,13 @@ static struct spi_driver mrstouch_driver = {
>  
>  static int __init mrstouch_init(void)
>  {
> -	return spi_register_driver(&mrstouch_driver);
> +	return platform_driver_register(&mrstouch_driver);
>  }
>  module_init(mrstouch_init);
>  
>  static void __exit mrstouch_exit(void)
>  {
> -	spi_unregister_driver(&mrstouch_driver);
> +	platform_driver_unregister(&mrstouch_driver);
>  }
>  module_exit(mrstouch_exit);
>  

I am confused here... Are you having a separate SPI driver create a
platform device and then you have mrstouch to bind to this intermediate
platform device? Are you doing that so you can introduce I2C interface
later? If so I think I prefer how adxl34x and ad7879 drivers are
structured - they are split into core and interface parts but do not
require extra devices/drivers (see in my 'next' brnach).

Thanks.

-- 
Dmitry
