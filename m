From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <l.majewski@majess.pl>
Subject: Re: [Regulator] Request for clarification - GPIO controlled
 regulator, USB VBUS,
Date: Tue, 3 Oct 2017 22:25:23 +0200
Message-ID: <5343f07a-e22f-dce9-0cb2-a67723345511@majess.pl>
References: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
 <CAKdAkRSB4wAx1CnaQKFq2jdvmk15NisWegYbS1iHqMOgvothKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:46228 "EHLO
        1.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdJCUZa (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Oct 2017 16:25:30 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id EE2381341C4
        for <linux-input@vger.kernel.org>; Tue,  3 Oct 2017 22:25:28 +0200 (CEST)
In-Reply-To: <CAKdAkRSB4wAx1CnaQKFq2jdvmk15NisWegYbS1iHqMOgvothKg@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

Hi Dmitry,

> Hi Łukasz,
> 
> On Tue, Oct 3, 2017 at 9:58 AM, Łukasz Majewski <l.majewski@majess.pl> wrote:
>> Dear All,
>>
>> Maybe somebody could shed some light to following issue:
>>
>> On my setup I do have USB connected touchscreen powered from VBUS.
>>
>> The VBUS power is controlled by a GPIO pin, which in turn is governed by
>> regulator API:
>>
>>          reg_usbh1_vbus: usb-h1-vbus {
>>                  compatible = "regulator-fixed";
>>                  gpio = <&gpio3 31 GPIO_ACTIVE_LOW>;
>>                  pinctrl-names = "default";
>>                  pinctrl-0 = <&pinctrl_usbh1_vbus>;
>>                  regulator-name = "usb_h1_vbus";
>>                  regulator-min-microvolt = <5000000>;
>>                  regulator-max-microvolt = <5000000>;
>>                  regulator-settling-time-us = <100000>;
>>          };
>>
>>
>> This regulator is then passed to USB controller:
>>
>> &usbh1 {
>>          vbus-supply = <&reg_usbh1_vbus>;
>>
>> }
>>
>> The regulator API starts VBUS -> USB host get info about the VBUS present
>> and starts enumeration of the USB device.
>>
>>
>> I would like to ask if there is any recommended way to remove VBUS power and
>> have a way to force from user space the touchscreen (re-)enumeration?
>>
>> As fair as I know the Regulator API is RO on purpose, so I cannot toggle
>> vbus from there.
>>
>> I could use hacks presented here (the userspace-regulator API):
>> https://patchwork.ozlabs.org/patch/374912/
>> https://lkml.org/lkml/2014/7/30/357
>>
>> but for some reason they did not find the way to the upstream. Also it seems
>> like such approach is for testing, not for production system.
>>
>>
>> I could write a "dummy" regulator driver, which would export control API to
>> /dev/sys/proc.
>> Something like:
>> http://elixir.free-electrons.com/linux/latest/source/drivers/usb/phy/phy-fsl-usb.c
>>
>> (but with opposite way).
>>
>> or ./drivers/input/misc/regulator-haptic.c
>>
>>
>> I've also tried the "usb" power control tricks;
>>
>> echo "0" > /sys/bus/usb/devices/usb1/power/autosuspend_delay_ms
>> echo "auto" > /sys/bus/usb/devices/usb1/power/control
>>
>> But without any effect (probably because of above dependencies).
>>
>>
>>
>> Have I overlooked something? Maybe there is any other mainline code, which I
>> could reuse?
>>
>>
>> My goal is to reuse as much as possible from ML and avoid developing any new
>> code :-)
>>
> 
> Please start from the beginning: it is not quite clear why you want
> the touchscreen to be re-enumerated.

The above setup generally works.

However, from time to time I do encounter some HID multi-touch driver 
initialization errors, which render the touchscreen unusable - e.g:

usb 1-1: input irq status -75 received
usb 1-1: reset low-speed USB device number 2 using ci_hdrc
expected 16 bytes, got -1

or

hid-generic 0003:19E2:2533.0002: unknown main item tag 0x0
hid-generic 0003:19E2:2533.0002: unknown main item tag 0x0
hid-generic 0003:19E2:2533.0002: unbalanced collection at end of report 
description
hid-generic: probe of 0003:19E2:2533.0002 failed with error -22


I've added 100 ms settle time for the VBUS regulator, but I'm not sure 
if it will fix this issue (I'm going to inspect VBUS voltage with 
oscilloscope).

Since I do have above errors, I thought that it would be feasible to 
have a "mean" to re-set VBUS voltage and force enumeration of the device.

I'm quite curious how USB connected touchscreens are controlled with 
USB's VBUS not accessible from user-space out of the box?

> 
> Thanks.
> 


-- 
Best regards.

Łukasz Majewski
