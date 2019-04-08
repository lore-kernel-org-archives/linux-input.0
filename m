From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH 2/6] MIPS: SGI-IP27: remove setup of RTC platform device
Date: Mon, 8 Apr 2019 20:58:35 +0200
Message-ID: <20190408205835.9b6f29b17d8ccb17c70d712d@suse.de>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
        <20190408142100.27618-3-tbogendoerfer@suse.de>
        <20190408.100528.608078178525055072.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408.100528.608078178525055072.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 08 Apr 2019 10:05:28 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Date: Mon,  8 Apr 2019 16:20:54 +0200
> 
> > RTC platform device will be setup by new IOC3 MFD driver, therefore
> > remove it from IP27 platform code.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> 
> You cannot break the driver like this.
> 
> Your patch series must be fully bisectable, which means that after
> this patch is applied things still must continue working properly.

sorry didn't realize your are talking about RTC. I'll check, if there
is a chance to move after the MFD driver addition.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
