From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH v5 11/17] net: sgi: ioc3-eth: no need to stop queue
 set_multicast_list
Date: Wed, 21 Aug 2019 14:40:33 +0200
Message-ID: <20190821144033.2e206cb18b1dfd10377357c2@suse.de>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
        <20190819163144.3478-12-tbogendoerfer@suse.de>
        <20190819170440.37ff18d4@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190819170440.37ff18d4@cakuba.netronome.com>
Sender: netdev-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 19 Aug 2019 17:04:53 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Mon, 19 Aug 2019 18:31:34 +0200, Thomas Bogendoerfer wrote:
> > netif_stop_queue()/netif_wake_qeue() aren't needed for changing
> > multicast filters. Use spinlocks instead for proper protection
> > of private struct.
> > 
>
> I thought it may protect ip->emcr, but that one is accessed with no
> locking from the ioc3_timer() -> ioc3_setup_duplex() path..

it should protect ip->emcr ... I'll add spin_lock/unlock to setup_duplex and
respin the patch.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
