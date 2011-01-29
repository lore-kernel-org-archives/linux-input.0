From: Robin Theunis <robint91@gmail.com>
Subject: Re: USB HID plug and play, hardware developer frustration
Date: Sat, 29 Jan 2011 10:15:40 +0100
Message-ID: <AANLkTimq1JY5MNx3-CL=gfGreA5=VLtSfrg81TzftZd2@mail.gmail.com>
References: <AANLkTinytMpW8-7eEDg1O+vUP=C6-MHc8H8yssRbbxUc@mail.gmail.com>
	<20110129083638.GD26915@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20110129083638.GD26915@core.coreip.homeip.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Devs, Dmitry

Oh, there is some support for digitizers. That will help me a lot!
Some thing else. When releasing my product how do I "ship" my driver?
Or do I need to hope that it will be included in the kernel?

Thanks

Robin

2011/1/29 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Ho Robin,
>
> On Sat, Jan 29, 2011 at 09:15:11AM +0100, Robin Theunis wrote:
>> Hi Devs,
>>
>> Currently I am design a USB product, and in that process I also look
>> if almost every OS supports my device.
>> The device is just only a HID digitizer or touch tablet thingy. It
>> reports it self also as HID device. This is to have it
>> work PLUG and PLAY. But I gotten a cold shower when trying this on my
>> linux pcs. It doesn't work!
>> I did some investigation and found that the linux (kernel) only
>> support mouses and keyboard, all the other usage pages
>> that are included in the USB HID specs aren't implemented.
>> http://www.usb.org/developers/devclass_docs/Hut1_11.pdf
>>
>> Is there a reason why they aren't implemented? especially the
>> digitizer thingies because of all the new tablets?
>
> Linux HID driver does have code to handle digitizers, please take a look
> at drivers/hid/hid-input.c::hidinput_configure_usage().
>
>> Is it difficult
>> to make a driver to support my device?
>
> It should not be. You might need to tweak usage mappings a bit by the
> way of writing small HID sub-driver. Look for examples in
> drivers/hid/hid-<vendor>.c
>
> If you need additional help I'd recommend asking on
> linux-input@vger.kernel.org
>
>> I have seen that there are a
>> lot of wacom drivers, I think doing all the same thing.
>>
>
> Wacoms are quite different since they are not HID devices but handler by
> a completely separate driver.
>
> Thanks.
>
> --
> Dmitry
>
