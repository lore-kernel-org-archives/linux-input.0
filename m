From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Thu, 24 Sep 2009 09:21:53 -0700
Message-ID: <20090924162152.GA26484@core.coreip.homeip.net>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <20090923034643.GB1458@core.coreip.homeip.net> <4ABB896C.4010205@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:61175 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbZIXQV6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 12:21:58 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1906421fge.1
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2009 09:22:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ABB896C.4010205@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Thu, Sep 24, 2009 at 08:59:56AM -0600, Miguel Aguilar wrote:
> Dmitry,
>
> I addressed your comments but I still have a couple of questions.

Thank you for making the adjustments.

>
> [MA] This is the current irq function:
> static irqreturn_t davinci_ks_interrupt(int irq, void *dev_id)
> {
> 	struct davinci_ks *davinci_ks = dev_id;
> 	struct device *dev = &davinci_ks->input->dev;
> 	unsigned short *keymap = davinci_ks->keymap;
> 	u32 prev_status, new_status, changed, position;
> 	bool release;
> 	int keycode = KEY_UNKNOWN;
> 	int ret = IRQ_NONE;
>
> 	/* Disable interrupt */
> 	davinci_ks_write(davinci_ks, 0x0, DAVINCI_KEYSCAN_INTENA);
>
> 	/* Reading previous and new status of the key scan */
> 	prev_status = davinci_ks_read(davinci_ks, DAVINCI_KEYSCAN_PREVSTATE);
> 	new_status = davinci_ks_read(davinci_ks, DAVINCI_KEYSCAN_CURRENTST);
>
> 	changed = prev_status ^ new_status;
> 	position = ffs(changed) - 1;
>
> 	if (changed) {
> 		keycode = keymap[position];
> 		release = (new_status >> position) & 0x1;
> 		dev_dbg(dev, "davinci_keyscan: key %d %s\n",
> 		    keycode, release ? "released" : "pressed");
>
> 		input_report_key(davinci_ks->input, keycode, !release);
> 		input_sync(davinci_ks->input);
>
> 		/* Clearing interrupt */
> 		davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL,
> 				    DAVINCI_KEYSCAN_INTCLR);
>
> 		ret = IRQ_HANDLED;
> 	}
>
> 	/* Enable interrupts */
> 	davinci_ks_write(davinci_ks, 0x1, DAVINCI_KEYSCAN_INTENA);
>
> 	return ret;

I'd just return IRQ_HANDLED unconditionally and I think you should go
through all bits in changed to ensure that you don't lose key presses
(unless controller never ever reports more than 1 key pressed).

> }
>
>

>
>>> +static int __init davinci_kp_init(void)
>>> +{
>>> +	return platform_driver_probe(&davinci_kp_driver, davinci_kp_probe);
>>> +}
>>> +module_init(davinci_kp_init);
> [MA] Should I use platform_driver_probe?
>

I don't see why not - you are still saving memory due to discarding
davinci_kp_probe. And if driver core is changed so that unbind is a NOP
for drivers registered with platform_driver_probe I will gladly accept a
follow-up patch to change __devexit to __exit for even more savings.


>>> +static void __exit davinci_kp_exit(void)
>>> +{
>>> +	platform_driver_unregister(&davinci_kp_driver);
>>> +}
>>> +module_exit(davinci_kp_exit);
> [MA] Is the module exit function __exit or __devexit
>

Module ext routines are always __exit (and inits are __init).

Thanks.

-- 
Dmitry
