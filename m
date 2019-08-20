From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v5 11/17] net: sgi: ioc3-eth: no need to stop queue
 set_multicast_list
Date: Mon, 19 Aug 2019 17:04:53 -0700
Message-ID: <20190819170440.37ff18d4@cakuba.netronome.com>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
        <20190819163144.3478-12-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819163144.3478-12-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 19 Aug 2019 18:31:34 +0200, Thomas Bogendoerfer wrote:
> netif_stop_queue()/netif_wake_qeue() aren't needed for changing
> multicast filters. Use spinlocks instead for proper protection
> of private struct.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/sgi/ioc3-eth.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/s=
gi/ioc3-eth.c
> index d862f28887f9..7f85a3bfef14 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -1542,8 +1542,7 @@ static void ioc3_set_multicast_list(struct net_devi=
ce *dev)
>  	struct netdev_hw_addr *ha;
>  	u64 ehar =3D 0;
> =20
> -	netif_stop_queue(dev);				/* Lock out others. */
> -
> +	spin_lock_irq(&ip->ioc3_lock);

What does this lock protect? =F0=9F=A4=94 No question that stopping TX queu=
es
makes little sense, but this function is only called from
ndo_set_rx_mode(), so with rtnl_lock held.=20

I thought it may protect ip->emcr, but that one is accessed with no
locking from the ioc3_timer() -> ioc3_setup_duplex() path..

>  	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous.  */
>  		ip->emcr |=3D EMCR_PROMISC;
>  		writel(ip->emcr, &regs->emcr);
> @@ -1572,7 +1571,7 @@ static void ioc3_set_multicast_list(struct net_devi=
ce *dev)
>  		writel(ip->ehar_l, &regs->ehar_l);
>  	}
> =20
> -	netif_wake_queue(dev);			/* Let us get going again. */
> +	spin_unlock_irq(&ip->ioc3_lock);
>  }
> =20
>  module_pci_driver(ioc3_driver);
