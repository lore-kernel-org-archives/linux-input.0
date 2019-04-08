From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/6] MIPS: SGI-IP27: remove setup of RTC platform device
Date: Mon, 08 Apr 2019 10:05:28 -0700 (PDT)
Message-ID: <20190408.100528.608078178525055072.davem@davemloft.net>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
        <20190408142100.27618-3-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408142100.27618-3-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: tbogendoerfer@suse.de
Cc: ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Date: Mon,  8 Apr 2019 16:20:54 +0200

> RTC platform device will be setup by new IOC3 MFD driver, therefore
> remove it from IP27 platform code.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

You cannot break the driver like this.

Your patch series must be fully bisectable, which means that after
this patch is applied things still must continue working properly.
