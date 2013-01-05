From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Sat, 5 Jan 2013 15:18:58 -0800
Message-ID: <20130105231858.GD6475@core.coreip.homeip.net>
References: <1357371910-3164-1-git-send-email-ldewangan@nvidia.com>
 <1357371910-3164-3-git-send-email-ldewangan@nvidia.com>
 <20130105080658.GA1315@core.coreip.homeip.net>
 <50E80C9A.7040404@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50E80C9A.7040404@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 05, 2013 at 04:50:58PM +0530, Laxman Dewangan wrote:
> HI Dmitry,
> Thanks for quick review.
> 
> I will take care of your comment in next version. Some have my answer.
> 
> 
> On Saturday 05 January 2013 01:36 PM, Dmitry Torokhov wrote:
> >Hi Laxman,
> >
> >On Sat, Jan 05, 2013 at 01:15:08PM +0530, Laxman Dewangan wrote:
> >>Use devm_* for memory, clock, input device allocation. This reduces
> >>code for freeing these resources.
> 
> >>  	err = tegra_kbd_setup_keymap(kbc);
> >>-	if (err) {
> >>+	if (err < 0) {
> >Why is this change? As far as I can see tegra_kbd_setup_keymap() never
> >returns positive values.
> 
> Ok, mostly errors are in negative and hence this change, I will
> revert it and will keep original.
> 
> >
> >>  		dev_err(&pdev->dev, "failed to setup keymap\n");
> >>-		goto err_put_clk;
> >>+		return err;
> >>  	}
> >>  	__set_bit(EV_REP, input_dev->evbit);
> >>@@ -790,15 +784,15 @@ static int tegra_kbc_probe(struct platform_device *pdev)
> >>  	err = request_irq(kbc->irq, tegra_kbc_isr,
> >>  			  IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
> >>-	if (err) {
> >>+	if (err < 0) {
> >Neither request_irq(). BTW, why not devm_request_irq?
> 
> I understand from Mark B on different patches that using
> devm_request_irq() can create race condition when removing device.
> Interrupt can occur when device resource release is in process and
> so it can cause isr call which can use the freed pointer.
> devm_request_irq() should be avoided.

devm_request_irq() has a potential of creating a race condition, but it
depents on the driver. In this particular case tegra driver ensures that
interrupts are inhibited when input device is unregistered by providing
tegra_kbc_close() method, so in this particular case it is safe to
use devm_request_irq().

Also, when using managed input devices, the unregistering and final
freeing is a 2-step process, so even in absence of close() method, if
initialization sequence was:

	devm_input_allocate_device()
	...
	devm_request_irq()
	...
	input_unregister_device()

then order of freeing resources (behind the scenes) will be

	devm_input_device_unregister();
	/* input device is still present in memory and can
	 * handle input_event() calls.
	 */
	free_irq();
	devm_input_device_release();

So using managed request_irq() _together_ with managed input devices is
OK.

Thanks.

-- 
Dmitry
