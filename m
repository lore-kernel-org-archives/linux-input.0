From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Mon, 28 Sep 2009 10:02:22 -0700
Message-ID: <20090928170222.GC21455@core.coreip.homeip.net>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com> <20090925040127.GA416@core.coreip.homeip.net> <4ABCD179.9010007@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:23386 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZI1RCZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2009 13:02:25 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1529588fge.1
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2009 10:02:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ABCD179.9010007@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Fri, Sep 25, 2009 at 08:19:37AM -0600, Miguel Aguilar wrote:
> Dmitry Torokhov wrote:
>>
>>> +
>>> +	davinci_ks = kzalloc(sizeof(struct davinci_ks) +
>>> +		sizeof(unsigned short) * pdata->keymapsize, GFP_KERNEL);
>>> +	if(!davinci_ks) {
>>> +		dev_dbg(dev, "could not allocate memory for private data\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	if (!pdata->keymap) {
>>> +		dev_dbg(dev, "no keymap from pdata\n");
>>
>> You are leaking davinci_ks here. Maybe you should check pdata->keymap
>> first.
> [MA] Do you mean check pdata->keymap before davinci_ks allocation?

Yes.

>>> +
>>> +	ret = input_register_device(davinci_ks->input);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "unable to register DaVinci keyscan device\n");
>>> +		goto fail4;
>>> +	}
>>> +
>>> +	ret = request_irq(davinci_ks->irq, davinci_ks_interrupt, IRQF_DISABLED,
>>> +                         "davinci_keyscan", davinci_ks);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "unable to register DaVinci keyscan Interrupt\n");
>>> +		goto fail5;
>>> +	}
>>
>> FWIW you may request IRQ before registering the device - as soon as it
>> is alloctaed it can survive events going through it.
> [MA] Ok. request_irq before input_register_device.
>>

You don't have to change it, it was more of FYI item because sometimes
registering IRQ first simplifies error unwinding.

-- 
Dmitry
