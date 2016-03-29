From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to setup Touchscreen IRQ mode?
Date: Tue, 29 Mar 2016 12:52:06 +0000
Message-ID: <CA+V1LzpnmEB=N-3tF2zY1vA0QvE_j7q+P_d4OmTS+-OzKcuVog@mail.gmail.com>
References: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
	<56EF459E.8000808@gmail.com>
	<CA+V1Lzph-W2eXhp22_jjObeu-ywzO===9EYWkKccuGuvdJDYRg@mail.gmail.com>
	<20160329095244.GI2099@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f65.google.com ([209.85.192.65]:36176 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcC2MwH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 08:52:07 -0400
Received: by mail-qg0-f65.google.com with SMTP id n34so1410036qge.3
        for <linux-input@vger.kernel.org>; Tue, 29 Mar 2016 05:52:07 -0700 (PDT)
In-Reply-To: <20160329095244.GI2099@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Gregor Riepl <onitake@gmail.com>, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

Hi Mika!
Glad to see you here!
1st - have finished yesterday protorype of polling mode kernel space
driver - it works - all parameters i2c-bus, i2c addr, registers, gpios
just setuped manually! not sure that gpio pin I guessed (393 - this
one is really used on my Chuwi Vi8 Z3735 with Silead 1680 TS, but we
are discovering Chuwi Vi10 Z3736 with Chipone icn8528 TS) with
enumerating all untill screen is blank off/on has influence to
anything.

Regarding i2c-hid - it even does not load i2c-hid module! moreover
loading it = nothing changes!
Also it will be cool if you in this case explain or reference what is
the difference in code between using i2c-hid and ordinary ACPI i2c TS.
below is skeleton for ACPI i2c TS driver, that did not provide nothing
(irq, i2c addr, gpios)!

regarding ACPI and IRQ: The story is the same as it was for Teclast -
there is nothing automatically detected via i2c, I have described it
here with providing ACPI skeleton:
https://www.spinics.net/lists/linux-i2c/msg23467.html

Some summary extractions:

========================================================
According kernel Documentation I have created such skeleton:


#define DEVICE_NAME  "testme"

static const struct acpi_device_id icn_ts_acpi_match[] = {
    { "CHPN0001", 0 },
    { "PNP05C0", 0 },
    { },
};
MODULE_DEVICE_TABLE(acpi, icn_ts_acpi_match);


static int ts_probe(struct i2c_client *client, const struct i2c_device_id *id){
    printk("Hello from %s",__func__);

    printk(&client->dev, "%s: got a device named %s at address 0x%x,
IRQ %d, flags 0x%x\n", __func__, client->name, client->addr,
client->irq, client->flags);

return 0;
}

static struct i2c_driver icn_ts_driver = {
    .probe = ts_probe,
    .remove = ts_remove,
    .id_table = ts_i2c_id,
    .driver = {
        .name = DEVICE_NAME,
        .owner = THIS_MODULE,
        .acpi_match_table = ACPI_PTR(icn_ts_acpi_match),

    },
};

static const struct i2c_device_id ts_i2c_id[] = {
    { DEVICE_NAME, 0 },
    { }
};
MODULE_DEVICE_TABLE(i2c, gsl_ts_i2c_id);


module_i2c_driver(icn_ts_driver);

===============================================


As result - nothing until I create i2c device with the name testme. I
am using user space way from kernel doc: echo testme 0x30 >
/sys/bus/i2c/devices/i2c-3/new_device.

ONLY AFTER this (Creating i2c device) I receive output from .probe function.
And as result I do NOT receive NOTHING ACPI related because i2c device
was created manually and all information is taken from my manual
created dev (bus address and bus number), no irq - nothing while DSDT
HAS THIS INFO!




Exploring sysfs shows:

ls -l /sys/bus/acpi/devices/CHPN0001:00
lrwxrwxrwx 1 root root 0 Mar 15 22:08
/sys/bus/acpi/devices/CHPN0001:00 ->
../../../devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:03/CHPN0001:00
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/status
0

status is 0 - what does this mean? It is detected via ACPI but not present?
What does "LNXSYBUS:00/80860F41:03"  means?  Does it mean i2c-3, 0x41
?  80860F41:03 == ?

also inside its subfolders I do not see nothing useful:

cat /sys/bus/acpi/devices/CHPN0001:00/adr
0x00000000
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/hid
CHPN0001
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/modalias
acpi:CHPN0001:PNP0C50:
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/path
\_SB_.I2C4.TCS5
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/uevent
MODALIAS=acpi:CHPN0001:PNP0C50:
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/runtime_usage
0
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/control
auto
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/runtime_enabled
disabled

So the question is the same - how to obtain via acpi in mentioned
above code i2cbus, bus addr and irq for this touch?

Thanks in advance,
Kind regards,
                        Serge Kolotylo.

On Tue, Mar 29, 2016 at 9:52 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Sun, Mar 27, 2016 at 12:05:27AM +0000, sergk sergk2mail wrote:
>> Hi Mika, Benjamin, Antonio.
>> Kindly would like to invite all of you to this thread because it is
>> very closely to http://www.spinics.net/lists/linux-input/msg35935.html
>>  : About Goodix-TS on Bay Trail, and ACPI and interrupts
>> Let me briefly summarize:
>> 1) I have wrote driver that loads FW into the TS chip (icn8228), I am
>> able to get polling mode, primary task at the moment is - to setup IRQ
>> mode.
>> 2) No ACPI, but at the moment I do not take care because just taken
>> and guessed all info and passed it hardcoded in my prototype of the
>> chipone driver. - later I will back to ACPI moment or if it is not
>> possible to setup IRQ in 1) without 2 - priorities will be changed.
>>
>> DSDT for chipone icn8528 on Chuwi Vi10 (Baytrail Z3736F) is
>> here:http://www.spinics.net/lists/linux-i2c/msg23520.html
>
> It claims to be I2C-HID compatible device so I think it should just use
> i2c-hid.c which should handle setting up interrupt automatically. Not
> sure about loading the firmware but I suppose it is the job of the
> higher level HID driver who knows the details.
>
>> Please assists with in setuping IRQ mode for TS driver, possible IRQ
>> is gpio based.
>> What I have obtained from Android:  SB_GPO1 : gpio base 102 - > this
>> means that gpio controller is used!
>> Looking for corresponding gpiochip inside Linux 4.2.2 kernel: I have
>> discovered suitable (the same amount of ngpio) this one: chip382,
>> label: INT33FC:01.
>> Also guessing (enumerating all)  gpios via userspace kernel interface
>> I have discovered that gpios: 393 and 391,392 - blank off/on
>> touchscreen by setting /sys/class/gpio39X/value to 0/1.
>>
>> Here is my draft debug code of the driver prototype for Chipone
>> icn8528 and irq NOT setuped at the moment :(.
>> I think it should be gpio based, in Android it is so:  cat /proc/interrupts
>>
>> 389  29 3 0 0  VLV-GPIO-gpio icn85xx_ts.
>>
>> Inside my code irq setuping:
>> IRQ begin:
>> https://gitlab.com/SergK/icn8528/blob/master/myicn.c#L1393
>>
>> icn85xx_request_irq
>> https://gitlab.com/SergK/icn8528/blob/master/myicn.c#L993
>
> In order to use GPIO as interrupt you need to first request and
> configure it like:
>
>         struct gpio_desc *desc;
>         int irq;
>
>         desc = gpiod_get(dev, NULL, GPIOD_IN);
>         irq = gpiod_to_irq(desc);
>
>         request_irq(irq, ...);
>
> But in you case, looking at the DSDT there is one Interrupt() resource
> below the TCS5 device. That should be handled automatically by the I2C
> core and filled in client->irq.
