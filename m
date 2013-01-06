From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Sun, 6 Jan 2013 16:30:28 +0530
Message-ID: <50E9594C.4040506@nvidia.com>
References: <1357371910-3164-1-git-send-email-ldewangan@nvidia.com> <1357371910-3164-3-git-send-email-ldewangan@nvidia.com> <20130105080658.GA1315@core.coreip.homeip.net> <50E80C9A.7040404@nvidia.com> <20130105231858.GD6475@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130105231858.GD6475-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sunday 06 January 2013 04:48 AM, Dmitry Torokhov wrote:
> On Sat, Jan 05, 2013 at 04:50:58PM +0530, Laxman Dewangan wrote:
>> HI Dmitry,
>> Thanks for quick review.
>>
>> I will take care of your comment in next version. Some have my answer.
>>
>>
>> On Saturday 05 January 2013 01:36 PM, Dmitry Torokhov wrote:
>>> Hi Laxman,
>>>
>>> On Sat, Jan 05, 2013 at 01:15:08PM +0530, Laxman Dewangan wrote:
>>>> Use devm_* for memory, clock, input device allocation. This reduces
>>>> code for freeing these resources.
>>>>   	err = tegra_kbd_setup_keymap(kbc);
>>>> -	if (err) {
>>>> +	if (err < 0) {
>>> Why is this change? As far as I can see tegra_kbd_setup_keymap() never
>>> returns positive values.
>> Ok, mostly errors are in negative and hence this change, I will
>> revert it and will keep original.
>>
>>>>   		dev_err(&pdev->dev, "failed to setup keymap\n");
>>>> -		goto err_put_clk;
>>>> +		return err;
>>>>   	}
>>>>   	__set_bit(EV_REP, input_dev->evbit);
>>>> @@ -790,15 +784,15 @@ static int tegra_kbc_probe(struct platform_device *pdev)
>>>>   	err = request_irq(kbc->irq, tegra_kbc_isr,
>>>>   			  IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
>>>> -	if (err) {
>>>> +	if (err < 0) {
>>> Neither request_irq(). BTW, why not devm_request_irq?
>> I understand from Mark B on different patches that using
>> devm_request_irq() can create race condition when removing device.
>> Interrupt can occur when device resource release is in process and
>> so it can cause isr call which can use the freed pointer.
>> devm_request_irq() should be avoided.
> devm_request_irq() has a potential of creating a race condition, but it
> depents on the driver. In this particular case tegra driver ensures that
> interrupts are inhibited when input device is unregistered by providing
> tegra_kbc_close() method, so in this particular case it is safe to
> use devm_request_irq().
>
> Also, when using managed input devices, the unregistering and final
> freeing is a 2-step process, so even in absence of close() method, if
> initialization sequence was:
>
> 	devm_input_allocate_device()
> 	...
> 	devm_request_irq()
> 	...
> 	input_unregister_device()
>
> then order of freeing resources (behind the scenes) will be
>
> 	devm_input_device_unregister();
> 	/* input device is still present in memory and can
> 	 * handle input_event() calls.
> 	 */
> 	free_irq();
> 	devm_input_device_release();
>
> So using managed request_irq() _together_ with managed input devices is
> OK.

Thanks for detail explanation. I will modify and sent the new version of 
patch.
