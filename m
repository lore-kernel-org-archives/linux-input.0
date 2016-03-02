From: Gregor Riepl <onitake@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 14:07:44 +0100
Message-ID: <56D6E5A0.9080509@gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
 <56D568C7.20203@gmail.com>
 <CA+V1LzpzJ1P3E_Rm4bRRegV0+ZMLs9befCXmA7PTSEn8umQsBw@mail.gmail.com>
 <56D61E05.3060407@gmail.com>
 <CA+V1Lzr09-GU8yS9RHU=qO=200DiCTCXEqc3zP0953uLOWaoKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35307 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbcCBNHq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 08:07:46 -0500
Received: by mail-wm0-f42.google.com with SMTP id l68so84333435wml.0
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 05:07:46 -0800 (PST)
In-Reply-To: <CA+V1Lzr09-GU8yS9RHU=qO=200DiCTCXEqc3zP0953uLOWaoKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>, linux-input@vger.kernel.org

> echo icn8528 0x48 > /sys/bus/i2c/devices/i2c-4/newdevice
> After this kernel automatically loads myicn_ts_acpi.ko module.
> 
> ...
>
> gsl_ts_probe: got a device named icn8528 at address 0x48, IRQ 0, flags
> 0x0
> Mar 02 12:07:31 archiso kernel: icn8528 4-0048: gsl_ts_probe: missing
> IRQ configuration
> Mar 02 12:07:31 archiso kernel: icn8528: probe of 4-0048 rejects match -19
> 
> So, based on main line output: archiso kernel: CHPN0001 4-0048: probe
> info: gsl_ts_probe: got a device named CHPN0001 at address 0x48, IRQ
> 0, flags 0x0
> 
> It looks that via ACPI no info is provided? No IRQ, no flags?

Umm... Ok, this seems a bit weird. Normally, you wouldn't create devices from
user space, as the kernel should automatically instantiate them when parsing
the DSDT or DT.

However, you got an ACPI name (CHPN0001), which leads me to conclude that some
interaction was going on.

Ok, now about the interrupt. The DSDT you posted previously contained this:

Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                        {
                            0x00000044,
                        }

So the irq field should have been set. I don't really understand why this
wasn't the case, sorry.

I recommend you try to load the module without creating a device from user
space first. Either install the module and reboot or load the module manually.

