From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Tue, 14 May 2019 14:39:25 +0200
Message-ID: <87mujpky6a.fsf@haabendal.dk>
References: <20190409154610.6735-1-tbogendoerfer@suse.de>
        <20190409154610.6735-3-tbogendoerfer@suse.de>
        <20190508102313.GG3995@dell>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409154610.6735-3-tbogendoerfer@suse.de> (Thomas Bogendoerfers's message of "Tue, 9 Apr 2019 17:46:06 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Lee Jones <lee.jones@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 09 Apr 2019, Thomas Bogendoerfer wrote:
> 
> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
> index 358e66b81926..21fe722ebcd8 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
>  
>  [ ... ]
>  
> -	err = pci_request_regions(pdev, "ioc3");

Why are you dropping the call to pci_request_regions()?  Shouldn't you
do something similar in the new mfd driver?

When you are use the the BAR 0 resource as mem_base argument to
mfd_add_devices() later on, it will be split into child resources for
the child devices, but they will not be related to the IORESOURCE_MEM
root tree (iomem_resource) anymore.  I don't think that is how it is
supposed to be done, as it will allow random other drivers to request
the exact same memory area.

How/where is the memory resources inserted in the root IORESOURCE_MEM
resource (iomem_resource)?  Or is it allowed to use resources without
inserting it into the root tree?

> +	SET_NETDEV_DEV(dev, &pdev->dev);
> +	ip = netdev_priv(dev);
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ip->regs = ioremap(r->start, resource_size(r));
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	ip->ssram = ioremap(r->start, resource_size(r));

Maybe use devm_platform_ioremap_resource() instead, which handles both
platform_get_resource() and ioremap() in one call..

/Esben
