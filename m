From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: How to setup Touchscreen IRQ mode?
Date: Mon, 21 Mar 2016 00:43:32 +0000
Message-ID: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33826 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcCUAnd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Mar 2016 20:43:33 -0400
Received: by mail-qg0-f44.google.com with SMTP id w104so144516963qge.1
        for <linux-input@vger.kernel.org>; Sun, 20 Mar 2016 17:43:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi Gurus of linux-input!
Please help with setuping IRQ mode for touchscreen.
It is declared http://linux-sunxi.org/Touchscreen#General_information
the following:
 "In Interrupt mode every time an event on the touchscreen occurs the
INT pin triggers and notifies the CPU. the cpu then read the new event
from the touchscreen"

Could someone please explain the logic (details) howto process IRQ for
touchscreen.

Input info: have initialized successfully TS and loaded its firmware,
standard registers output correct data!
in ACPI irq is 0x44. i2cbus 3, address is 0x30.

Do not know wakeup pin, actually TS available without any gpios for
loading firmware and reading from it.

What was done by myself:

I have registered irq in such way:
//handler

static irqreturn_t icn85xx_ts_interrupt(int irq, void *dev_id){
    struct icn85xx_ts_data *icn85xx_ts = dev_id;

    printk("==========------icn85xx_ts TS Interrupt-----===========\n");
return 0;
}

err = request_irq(icn85xx_ts->irq, icn85xx_ts_interrupt,
IRQ_TYPE_EDGE_FALLING, "icn85xx_ts", icn85xx_ts);
    if (err < 0){
        icn85xx_error("icn85xx_ts_probe: request irq failed\n");
        return err;
    }


As result have received this: (looks like no any occurrences of my
handler for irq 0x44  = dec: 68)

 cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
  68:          0          0          0          0  BYT-GPIO   60  icn85xx_ts


Questions:

1) Does this correct IRQ settings for TS? If not - what is procedure?
What I have missed? H

2) What does mean BYT-GPIO 60 in cat /proc/interrupts?
I could not obtain gpio 60 via gpio_request(60, "TS_INT");

3) how it could be in code example setuping irq with gpio for touch?
Is this so:

 a) obtain gpio
 b) setup gpio to in direction
 c) request irg

4) How to find out gpio for setuping irq having decoded ACPI
DSDT,working Android and Windows with this touch.

Kind regards,
                Serge Kolotylo.
