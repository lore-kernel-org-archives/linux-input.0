From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 3/8] ARM: LPC32xx: clock.c update
Date: Wed, 18 Apr 2012 00:09:05 +0300
Message-ID: <20120417210905.GJ6498@mwanda>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
	<1334682507-15055-4-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1334682507-15055-4-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Roland Stigge <stigge@antcom.de>
Cc: devel@driverdev.osuosl.org, srinivas.bakki@nxp.com, linux-usb@vger.kernel.org, broonie@opensource.wolfsonmicro.com, gregkh@linuxfoundation.org, thierry.reding@avionic-design.de, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, marek.vasut@gmail.com, arm@kernel.org, linux-input@vger.kernel.org, axel.lin@gmail.com, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 17, 2012 at 07:08:22PM +0200, Roland Stigge wrote:
> Besides switching to the default macro CLKDEV_INIT() for clock registration,
> this patch actually updates the clock registrations of pl08xdmac.
> 

When there is a cleanup and a new feature added in the same patch,
it makes it hard to read...  :/  So when we update pl08xdmac:

-       CLKDEV_INIT(NULL, "clk_dmac", &clk_dma),
+       CLKDEV_INIT("pl08xdmac", NULL, &clk_dma),

What does that actually do?  Is it a bug fix?

regards,
dan carpenter
