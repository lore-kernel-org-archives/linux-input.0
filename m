From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for HTC Shift Touchscreen
Date: Tue, 20 May 2008 09:54:16 -0400
Message-ID: <20080520094647.ZZRA012@mailhub.coreip.homeip.net>
References: <482ED31E.2000009@eslack.org> <483198F8.3000201@eslack.org> <20080519112104.ZZRA012@mailhub.coreip.homeip.net> <4832087C.6060009@eslack.org> <20080520014937.GA23247@anvil.corenet.prv> <4832AFCA.30701@eslack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:28166 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765911AbYETNyV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2008 09:54:21 -0400
Received: by py-out-1112.google.com with SMTP id u52so2427610pyb.10
        for <linux-input@vger.kernel.org>; Tue, 20 May 2008 06:54:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4832AFCA.30701@eslack.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pau Oliva Fora <pau@eslack.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, May 20, 2008 at 01:02:34PM +0200, Pau Oliva Fora wrote:
> Dmitry Torokhov wrote:
>> On Tue, May 20, 2008 at 01:08:44AM +0200, Pau Oliva Fora wrote:
>>> +
>>> +static int htcpen_open(struct input_dev *dev)
>>> +{
>>> +	outb_p(DEVICE_ENABLE, HTCPEN_PORT_INIT);
>>> +	return 0;
>>> +}
>>> +
>>> +static void htcpen_close(struct input_dev *dev)
>>> +{
>>> +	free_irq(HTCPEN_IRQ, dev);
>>> +}
>>> +
>>
>> No, this will not work.. next time you open the device you won't have
>> IRQ anymore. You need the opposite of outb_p(DEVICE_ENABLE,
>> HTCPEN_PORT_INIT); here.
>>
>
> It is actually working; it also works after suspend/resume without any
> issues.
>

You need to close the device. Making evdev a module and unloading it
should do the trick (you don't use tsdev, do you?).

> I currently do not know a safe way of disabling the device, as HTC did
> not offer any specifications or datasheet when I requested, so everything
> in the driver has been reverse engineered.
>
> Let me know if you think it's ok to leave it as is, otherwise I'll try
> to find the proper way to disable the device (it should not be much
> different than the way of enabling it).

If you can't find the way to disable device then you need to revert to
the old way, with enabling it in _probe() and freein irq in _remove(),
you just need to make sure that you free_irq() first and then call
input_unregister_device().

Also, like Andrey said, we might consider using DMI table so we dont
poke IO ports on random boxes. Oh, and one more thing, you need to
reserve the IO ports your driver is using with request_region.

-- 
Dmitry
