From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v9] input: keyboard: Add keys driver for the LPC32xx SoC
Date: Wed, 11 Jul 2012 09:49:04 +0200
Message-ID: <4FFD2FF0.8030000@antcom.de>
References: <1341948910-6530-1-git-send-email-stigge@antcom.de>
 <20120710205507.GA377@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120710205507.GA377-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: srinivas.bakki-3arQi8VN3Tc@public.gmane.org, aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/10/2012 10:55 PM, Dmitry Torokhov wrote:
> Hi Roland,
> 
> On Tue, Jul 10, 2012 at 09:35:10PM +0200, Roland Stigge wrote:
>> This patch adds a driver for the key scan interface of the LPC32xx SoC
>>
> 
> Could of more things that I had in my patch but forgot to specifically
> call out:
> 
>> +
>> +	/* Configure the key scanner */
>> +	clk_prepare_enable(kscandat->clk);
> 
> This may fail so we should handle errors.
> 
>> +	writel(kscandat->deb_clks, LPC32XX_KS_DEB(kscandat->kscan_base));
>> +	writel(kscandat->scan_delay, LPC32XX_KS_SCAN_CTL(kscandat->kscan_base));
>> +	writel(LPC32XX_KSCAN_FTST_USE32K_CLK,
>> +	       LPC32XX_KS_FAST_TST(kscandat->kscan_base));
>> +	writel(kscandat->matrix_sz,
>> +	       LPC32XX_KS_MATRIX_DIM(kscandat->kscan_base));
>> +	writel(1, LPC32XX_KS_IRQ(kscandat->kscan_base));
>> +	clk_disable_unprepare(kscandat->clk);
>> +
>> +	error = request_irq(irq, lpc32xx_kscan_irq, 0, pdev->name, kscandat);
> 
> ...
> 
>> +
>> +	free_irq(platform_get_irq(pdev, 0), pdev);
> 
> You are requesting IRQ with kscandat as an argument but freeing it with
> 'pdev' which will fail.
> 
>> +
>> +	if (kscandat->input->users) {
>> +		/* Enable clock and clear IRQ */
>> +		clk_prepare_enable(kscandat->clk);
> 
> Need to handle errors here as well.
> 
> Since I am partial to my rearrangement (basically I started preferring
> err_<action> style of error labels as they more explanatory than out2 or
> fail3 style of labels), could you try this version of my patch (on top
> of your v9 one). Third time is a charm maybe? :)

Yes, works fine!

Thanks!

Acked-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
