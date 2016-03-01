From: Gregor Riepl <onitake@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Tue, 1 Mar 2016 23:56:05 +0100
Message-ID: <56D61E05.3060407@gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
 <56D568C7.20203@gmail.com>
 <CA+V1LzpzJ1P3E_Rm4bRRegV0+ZMLs9befCXmA7PTSEn8umQsBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33545 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbcCAW4I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2016 17:56:08 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so56636040wml.0
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2016 14:56:07 -0800 (PST)
In-Reply-To: <CA+V1LzpzJ1P3E_Rm4bRRegV0+ZMLs9befCXmA7PTSEn8umQsBw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: linux-input@vger.kernel.org

> So, my questions are:
> 
> 1) Am I right when I am registering i2c client  mentioned in .probe
> function should be called immediately ?

Please clarify: Are you trying to configure any i2c stuff from user space? You
shouldn't do that, as the kernel will take care of everything.

The probing procedure works like this, I believe:
- Module has an ACPI HID or OF/DT matching table
- Kernel finds an entry in the DSDT or DT
- Kernel loads module with corresponding entry (if not loaded)
or
- Module is loaded manually
- Kernel calls probe() with the preconfigured device structure
- probe() fetches i2c, gpio and irq information from device structure
- probe() configures gpio, irq handler, internal stuff and input devices
- probe() starts up the device
- probe() returns

If your probe routine isn't called, there may be a mismatch, or someone
claimed the device already. Try a reboot, perhaps.

> 2) how to ensure and output all info that was taken from ACPI, as
> minimum i2cbus number and address,
>     irq

You shouldn't have to worry about that.

This line should print all the interesting information:
>     dev_warn(&client->dev, "%s: got a device named %s at address 0x%x,
> IRQ %d, flags 0x%x\n", __func__, client->name, client->addr,
> client->irq, client->flags);
If it doesn't something may have gone wrong.

> 3) how to ensure that gpios are taken? from where was taken name
> "power" for gpio?  Why exactly the name "power" ?    Looks also like I
> need one more gpio that is "reset".

"power" is a name I gave to the wakeup pin. The DSDT does not contain named
GPIOs, and AFAIK direct use of unnamed GPIOs is deprecated.

> 4) How will be created i2c-dev ? is this should be done by kernel
> automatically? I mean there is no any direct creation of device on
> predefined i2c-bus at predefined address.

Yes, the kernel will take care of that whenever it finds a matching device.


