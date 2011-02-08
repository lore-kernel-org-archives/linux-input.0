From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/input/touchscreen/ads7846.c:959: error: 'GPIOF_DIR_IN'
 undeclared
Date: Tue, 8 Feb 2011 13:10:36 -0800
Message-ID: <20110208211035.GC16527@core.coreip.homeip.net>
References: <AANLkTim2706Negrvd-ektbNMLwucM9M0icphb_uFY_9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim2706Negrvd-ektbNMLwucM9M0icphb_uFY_9D@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sourav Poddar <sourav.poddar@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Linux-Next <linux-next@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 08, 2011 at 09:03:27PM +0100, Geert Uytterhoeven wrote:
> linux-next/m68k-allmodconfig/m68k:
> http://kisskb.ellerman.id.au/kisskb/buildresult/3899710/
> 
> drivers/input/touchscreen/ads7846.c:959: error: 'GPIOF_DIR_IN'
> undeclared (first use in this function)
> drivers/input/touchscreen/ads7846.c:959: error: (Each undeclared
> identifier is reported only once
> drivers/input/touchscreen/ads7846.c:959: error: for each function it
> appears in.)
> make[4]: *** [drivers/input/touchscreen/ads7846.o] Error 1
> 
> As of commit e9b6e245c727767e6d64cb3dd47a0c6982aa5d23
> ("Input: ads7846 - use gpio_request_one to configure pendown_gpio"), this
> driver should depend on GENERIC_GPIO?
> Else <linux/gpio.h> doesn't include <asm/gpio.h>, and we never see the
> definition of GPIOF_DIR_IN.

Crap, sorry about that, I'll fix it up tonight.

-- 
Dmitry
