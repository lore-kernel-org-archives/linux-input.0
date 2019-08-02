From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] HID: usbhid: Use GFP_KERNEL instead of GFP_ATOMIC when
 applicable
Date: Fri, 2 Aug 2019 09:51:25 +0200
Message-ID: <36fe1980-9b92-084d-f9db-fac07e624076@wanadoo.fr>
References: <20190801074759.32738-1-christophe.jaillet@wanadoo.fr>
 <5D42B98B.40900@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5D42B98B.40900@bfs.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wharms@bfs.de
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi, (and sorry if you receive this email twice. I've used a web mail 
which sends HTML by default and it was rejected by ML)

Le 01/08/2019 à 12:06, walter harms a écrit :
> 
> 
> Am 01.08.2019 09:47, schrieb Christophe JAILLET:
>> There is no need to use GFP_ATOMIC when calling 'usb_alloc_coherent()'
>> here. These calls are done from probe functions and using GFP_KERNEL should
>> be safe.
>> The memory itself is used within some interrupts, but it is not a
>> problem, once it has been allocated.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/hid/usbhid/usbkbd.c   | 4 ++--
>>   drivers/hid/usbhid/usbmouse.c | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
>> index d5b7a696a68c..63e8ef8beb45 100644
>> --- a/drivers/hid/usbhid/usbkbd.c
>> +++ b/drivers/hid/usbhid/usbkbd.c
>> @@ -239,11 +239,11 @@ static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
>>   		return -1;
>>   	if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
>>   		return -1;
>> -	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma)))
>> +	if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_KERNEL, &kbd->new_dma)))
>>   		return -1;
>>   	if (!(kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
>>   		return -1;
>> -	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_ATOMIC, &kbd->leds_dma)))
>> +	if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_KERNEL, &kbd->leds_dma)))
>>   		return -1;
>>   
> 
> the kernel style is usually:
>   kbd->new = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &kbd->new_dma);
>   if (!kbd->new)
> 	return -1;
> 

Searching with coccinelle with:
*   x = usb_alloc_coherent(..., <+... GFP_KERNEL ...+>, ...);
finds 67 files,

whereas:
*   x = usb_alloc_coherent(..., <+... GFP_ATOMIC ...+>, ...);
only finds 11 files.

> 
> in usbmouse.c this is done, any reason for the change here ?
> 

No real reason in fact, just to be consistent with surrounding code.

Unless some allocations are done within a spin_lock/spin_unlock, using 
both GFP_KERNEL and GFP_ATOMIC in the same function looks spurious to me.
Either there is a bug (GFP_KERNEL should be GFP_ATOMIC), or a useless 
constraint is given to the memory allocator.

CJ

> re,
>   wh
> 
>>   	return 0;
>> diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
>> index 073127e65ac1..c89332017d5d 100644
>> --- a/drivers/hid/usbhid/usbmouse.c
>> +++ b/drivers/hid/usbhid/usbmouse.c
>> @@ -130,7 +130,7 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
>>   	if (!mouse || !input_dev)
>>   		goto fail1;
>>   
>> -	mouse->data = usb_alloc_coherent(dev, 8, GFP_ATOMIC, &mouse->data_dma);
>> +	mouse->data = usb_alloc_coherent(dev, 8, GFP_KERNEL, &mouse->data_dma);
>>   	if (!mouse->data)
>>   		goto fail1;
>>   
> 
