From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to setup Touchscreen IRQ mode?
Date: Sun, 27 Mar 2016 00:05:27 +0000
Message-ID: <CA+V1Lzph-W2eXhp22_jjObeu-ywzO===9EYWkKccuGuvdJDYRg@mail.gmail.com>
References: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
	<56EF459E.8000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33472 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbcC0AF2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Mar 2016 20:05:28 -0400
Received: by mail-qg0-f44.google.com with SMTP id j35so84699199qge.0
        for <linux-input@vger.kernel.org>; Sat, 26 Mar 2016 17:05:27 -0700 (PDT)
In-Reply-To: <56EF459E.8000808@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org

Hi Mika, Benjamin, Antonio.
Kindly would like to invite all of you to this thread because it is
very closely to http://www.spinics.net/lists/linux-input/msg35935.html
 : About Goodix-TS on Bay Trail, and ACPI and interrupts
Let me briefly summarize:
1) I have wrote driver that loads FW into the TS chip (icn8228), I am
able to get polling mode, primary task at the moment is - to setup IRQ
mode.
2) No ACPI, but at the moment I do not take care because just taken
and guessed all info and passed it hardcoded in my prototype of the
chipone driver. - later I will back to ACPI moment or if it is not
possible to setup IRQ in 1) without 2 - priorities will be changed.

DSDT for chipone icn8528 on Chuwi Vi10 (Baytrail Z3736F) is
here:http://www.spinics.net/lists/linux-i2c/msg23520.html

Please assists with in setuping IRQ mode for TS driver, possible IRQ
is gpio based.
What I have obtained from Android:  SB_GPO1 : gpio base 102 - > this
means that gpio controller is used!
Looking for corresponding gpiochip inside Linux 4.2.2 kernel: I have
discovered suitable (the same amount of ngpio) this one: chip382,
label: INT33FC:01.
Also guessing (enumerating all)  gpios via userspace kernel interface
I have discovered that gpios: 393 and 391,392 - blank off/on
touchscreen by setting /sys/class/gpio39X/value to 0/1.

Here is my draft debug code of the driver prototype for Chipone
icn8528 and irq NOT setuped at the moment :(.
I think it should be gpio based, in Android it is so:  cat /proc/interrupts

389  29 3 0 0  VLV-GPIO-gpio icn85xx_ts.

Inside my code irq setuping:
IRQ begin:
https://gitlab.com/SergK/icn8528/blob/master/myicn.c#L1393

icn85xx_request_irq
https://gitlab.com/SergK/icn8528/blob/master/myicn.c#L993


Thanks in advance for your help!

Regards,
                 Serge Kolotylo.

On Mon, Mar 21, 2016 at 12:51 AM, Gregor Riepl <onitake@gmail.com> wrote:
>> err = request_irq(icn85xx_ts->irq, icn85xx_ts_interrupt,
>> IRQ_TYPE_EDGE_FALLING, "icn85xx_ts", icn85xx_ts);
>>     if (err < 0){
>>         icn85xx_error("icn85xx_ts_probe: request irq failed\n");
>>         return err;
>>     }
>>
>> 1) Does this correct IRQ settings for TS? If not - what is procedure?
>> What I have missed? H
>
> I recommend using devm_request_threaded_irq instead.
> The devm_* functions take care of deallocation automatically, and a threaded
> IRQ handler is much better for slow operations like I2C access IMHO.
>
