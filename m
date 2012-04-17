From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/8] ohci-nxp: Driver cleanup
Date: Tue, 17 Apr 2012 20:36:14 +0000
Message-ID: <201204172036.15663.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
	<1334682507-15055-2-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1334682507-15055-2-git-send-email-stigge@antcom.de>
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

On Tuesday 17 April 2012, Roland Stigge wrote:
>Cleanup for ohci-nxp.c:
>
>* Cleanup of resource handling (mem and irq), use devm_request_and_ioremap()
>* Fixed controller initialization (bits)
>* Use DMA_BIT_MASK()
>* Don't remove __devinit
>* Removed obsolete gpio.h include
>* More consistent bit access symbols
>* Removed unused extern declaration ocpi_enable()
>* Added error handling on i2c_get_adapter()
>* Better USB host and device differentiation, since on LPC32xx, the same
>  controller can be used as USB device controller
>* Whitespace cleanup
>
>Signed-off-by: Roland Stigge <stigge@antcom.de>

Looks almost good, I just found one more bug that you introduce:

> +
> +       hcd->regs = devm_request_and_ioremap(&pdev->dev, res);
> +       if (!hcd->regs) {
> +               err("Failed to devm_request_and_ioremap");
>                 ret =  -ENOMEM;
>                 goto out4;
>         }
> -       hcd->regs = (void __iomem *)pdev->resource[0].start;
> +       hcd->rsrc_start = (u64)(u32)hcd->regs;
> +       hcd->rsrc_len = resource_size(res);

This is wrong in multiple ways:

* rsrc_start is a physical address, not an __iomem token.
* you cannot cast a pointer to u32 in general, only to unsigned long.

The fact that you need an ugly type cast like above could have told
you that you are doing something wrong here. I guess it should
be

	hcd->rsrc_start = res->start;

	Arnd
