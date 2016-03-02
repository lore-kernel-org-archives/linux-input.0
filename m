From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 15:56:41 +0000
Message-ID: <CA+V1Lzqnu6bBPG6StMHgJRW0VyUtutoPh5gh6gd3batz0cS8Zw@mail.gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
	<56D568C7.20203@gmail.com>
	<CA+V1LzpzJ1P3E_Rm4bRRegV0+ZMLs9befCXmA7PTSEn8umQsBw@mail.gmail.com>
	<56D61E05.3060407@gmail.com>
	<CA+V1Lzr09-GU8yS9RHU=qO=200DiCTCXEqc3zP0953uLOWaoKQ@mail.gmail.com>
	<56D6E5A0.9080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35820 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051AbcCBP4n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 10:56:43 -0500
Received: by mail-qk0-f182.google.com with SMTP id o6so84189385qkc.2
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 07:56:42 -0800 (PST)
In-Reply-To: <56D6E5A0.9080509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

"However, you got an ACPI name (CHPN0001), which leads me to conclude that some
interaction was going on."

Hi, Gregor.
Unfortunately it is not so :(
In previous reply, version 0.0.2 - I have changed i2c dev name to icn8528.
I have added the module to the /lib/modules/KVER, with right depmod and booted.
The output is only - registering i2c drv: bus: 'i2c': add driver icn8528.

And again only manual! echo icn8528 0x48 >/sys/bus/devices/i2c-4/newdevice
is called probe_ts funct but output shows bad news:

Mar 02 15:45:06 archiso kernel: i2c i2c-4: new_device: Instantiated
device icn8528 at 0x48
Mar 02 15:45:06 archiso kernel: bus: 'i2c': add driver icn8528
Mar 02 15:45:06 archiso kernel: bus: 'i2c': driver_probe_device:
matched device 4-0048 with driver icn8528
Mar 02 15:45:06 archiso kernel: bus: 'i2c': really_probe: probing
driver icn8528 with device 4-0048
Mar 02 15:45:06 archiso kernel: icn8528 4-0048: no default pinctrl state
Mar 02 15:45:06 archiso kernel: devices_kset: Moving 4-0048 to end of list
Mar 02 15:45:06 archiso kernel: Hello from probe_ts_probe
Mar 02 15:45:06 archiso kernel: icn8528 4-0048: probe info:
gsl_ts_probe: got a device named icn8528 at address 0x48, IRQ 0, flags
0x0
Mar 02 15:45:06 archiso kernel: icn8528 4-0048: gsl_ts_probe: missing
IRQ configuration
Mar 02 15:45:06 archiso kernel: icn8528: probe of 4-0048 rejects match -19.

Parameters it takes just from my manual creating of i2cdev through sysfs.

Kind regards,
                      Serge Kolotylo.

On Wed, Mar 2, 2016 at 1:07 PM, Gregor Riepl <onitake@gmail.com> wrote:
>> echo icn8528 0x48 > /sys/bus/i2c/devices/i2c-4/newdevice
>> After this kernel automatically loads myicn_ts_acpi.ko module.
>>
>> ...
>>
>> gsl_ts_probe: got a device named icn8528 at address 0x48, IRQ 0, flags
>> 0x0
>> Mar 02 12:07:31 archiso kernel: icn8528 4-0048: gsl_ts_probe: missing
>> IRQ configuration
>> Mar 02 12:07:31 archiso kernel: icn8528: probe of 4-0048 rejects match -19
>>
>> So, based on main line output: archiso kernel: CHPN0001 4-0048: probe
>> info: gsl_ts_probe: got a device named CHPN0001 at address 0x48, IRQ
>> 0, flags 0x0
>>
>> It looks that via ACPI no info is provided? No IRQ, no flags?
>
> Umm... Ok, this seems a bit weird. Normally, you wouldn't create devices from
> user space, as the kernel should automatically instantiate them when parsing
> the DSDT or DT.
>
> However, you got an ACPI name (CHPN0001), which leads me to conclude that some
> interaction was going on.
>
> Ok, now about the interrupt. The DSDT you posted previously contained this:
>
> Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
>                         {
>                             0x00000044,
>                         }
>
> So the irq field should have been set. I don't really understand why this
> wasn't the case, sorry.
>
> I recommend you try to load the module without creating a device from user
> space first. Either install the module and reboot or load the module manually.
>
