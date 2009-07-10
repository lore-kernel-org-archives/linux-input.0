From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input: Add keypad support for w90p910 evb
Date: Fri, 10 Jul 2009 10:39:36 +0800
Message-ID: <4A56A9E8.2000703@gmail.com>
References: <4A546443.9030907@gmail.com>	 <5d5443650907080332t4156cabdu267d28c6c486f372@mail.gmail.com>	 <4A55901B.6070805@gmail.com> <5d5443650907082347i40f5f39bn63e2683046155eb@mail.gmail.com> <4A55B8E0.6020909@gmail.com> <BD79186B4FD85F4B8E60E381CAEE190901A68B96@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:29513 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZGJCjs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 22:39:48 -0400
Received: by rv-out-0506.google.com with SMTP id f6so140491rvb.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2009 19:39:47 -0700 (PDT)
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901A68B96@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Dear Hartley,

Thanks for your good ideas, before resubmitting the updated patch,I have to need your help.

H Hartley Sweeten:
> On Thursday, July 09, 2009 2:31 AM, Wan ZongShun wrote:
>> Dear sirs,
>>
>> According to Trilok's suggestion, I fixed up my driver and
>> resubmitted it.
>>
>> patch text:
>>
>> Add w90p910 keypad driver for w90p910 evalution board
>> based on w90p910,there is a 4X4 keypad on my board.
>>
>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>>
>> ---
> +
> +#define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
> +#define keypad_writel(off, v)	__raw_writel((v), keypad->mmio_base + (off))
> +

Do you mean that using the following function instead of that above macro?


static inline unsigned long keypad_readl(unsigned int off, struct w90p910_keypad *keypad)
{
	return __raw_readl(keypad->mmio_base + (off));
}

> You might want to make these two macro's inline functions instead.
> 
> Depending on having the local variable 'keypad' is prone to breakage.
> See Documentation/CodingStyle, Chapter 12.
> 
> +	input_dev->name = pdev->name;
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->open = w90p910_keypad_open;
> +	input_dev->close = w90p910_keypad_close;
> +	input_dev->dev.parent = &pdev->dev;
> 
> If you add the following the keymap can be changed from userspace:
> 
> 	input_dev->keycode = keypad->matrix_keycodes;
> 	input_dev->keycodesize = sizeof(keypad->matrix_keycodes[0]);
> 	input_dev->keycodemax = ARRAY_SIZE(keypad->matrix_keycodes);

It is a good idea.

> Regards,
> Hartley
> 

