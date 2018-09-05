From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] Input: wm97xx: only unregister wm97xx_driver if it has
 been registered
Date: Wed, 5 Sep 2018 10:16:09 +0100
Message-ID: <20180905091609.GC1653@imbe.wolfsonmicro.main>
References: <20180904183505.10693-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180904183505.10693-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, patches@opensource.cirrus.com, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 04, 2018 at 07:35:05PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where IS_BUILTIN(CONFIG_AC97_BUS)) is not true, the
> wm97xx_driver driver is being unregistered even it has not been
> previously registered.  Fix this by only unregistering it if
> IS_BUILTIN(CONFIG_AC97_BUS)) is true.  This fixes the warning
> message:
> 
> [  834.111248] ------------[ cut here ]------------
> [  834.111248] Unexpected driver unregister!
> [  834.111319] WARNING: CPU: 2 PID: 11749 at drivers/base/driver.c:193 driver_unregister+0x3b/0x40
> [  834.111319] Modules linked in: wm97xx_ts(-) ....
> 
> ..and a stack trace.
> 
> To easily reproduce this, load and unload the module on a system where
> the hardware is not supported.
> 
> Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
