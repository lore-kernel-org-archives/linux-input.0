From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v5 12/17] net: sgi: ioc3-eth: use dma-direct for dma
 allocations
Date: Mon, 19 Aug 2019 17:07:35 -0700
Message-ID: <20190819170735.13884ec9@cakuba.netronome.com>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
        <20190819163144.3478-13-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819163144.3478-13-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 19 Aug 2019 18:31:35 +0200, Thomas Bogendoerfer wrote:
> @@ -1386,18 +1427,24 @@ static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		unsigned long b2 = (data | 0x3fffUL) + 1UL;
>  		unsigned long s1 = b2 - data;
>  		unsigned long s2 = data + len - b2;
> +		dma_addr_t d;
>  
>  		desc->cmd    = cpu_to_be32(len | ETXD_INTWHENDONE |
>  					   ETXD_B1V | ETXD_B2V | w0);
>  		desc->bufcnt = cpu_to_be32((s1 << ETXD_B1CNT_SHIFT) |
>  					   (s2 << ETXD_B2CNT_SHIFT));
> -		desc->p1     = cpu_to_be64(ioc3_map(skb->data, 1));
> -		desc->p2     = cpu_to_be64(ioc3_map((void *)b2, 1));
> +		d = dma_map_single(ip->dma_dev, skb->data, s1, DMA_TO_DEVICE);

You'll need to check the DMA address with dma_mapping_error(dev, addr),
otherwise static checkers will get upset.

> +		desc->p1     = cpu_to_be64(ioc3_map(d, PCI64_ATTR_PREF));
> +		d = dma_map_single(ip->dma_dev, (void *)b2, s1, DMA_TO_DEVICE);
> +		desc->p2     = cpu_to_be64(ioc3_map(d, PCI64_ATTR_PREF));
