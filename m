From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Sat, 31 Jan 2015 15:39:48 -0500
Message-ID: <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
References: <54CCEE3D.9040306@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:40817 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbbAaUjt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 15:39:49 -0500
Received: by mail-qg0-f48.google.com with SMTP id z60so42787953qgd.7
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2015 12:39:48 -0800 (PST)
In-Reply-To: <54CCEE3D.9040306@m-labs.hk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastien Bourdeauducq <sb@m-labs.hk>
Cc: linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

On Sat, Jan 31, 2015 at 10:01 AM, Sebastien Bourdeauducq <sb@m-labs.hk> wrote:
> Hi,
>
> among the many problems that the Baytrail-based Thinkpad Tablet 10 has under
> Linux, the built-in Wacom digitizer does not work. I get the following
> messages in the kernel log (with i2c_hid.debug=1):
>
> [  593.224249] i2c_hid i2c-WCOM0008:00: Fetching the HID descriptor
> [  593.224259] i2c_hid i2c-WCOM0008:00: __i2c_hid_command: cmd=01 00
> [  593.243080] i2c_hid i2c-WCOM0008:00: HID Descriptor: 1e 00 00 01 ee 00 02
> 00 03 00 0a 00 00 00 00 00 04 00 05 00 6a 05 14 01 02 03 00 00 00 00
> [  593.243110] i2c_hid i2c-WCOM0008:00: Could not register for WCOM0008:00
> interrupt, irq = -1, ret = -22

That means that your tablet is the first one we (maybe only I) see
that uses a GPIO as an interrupt :)

Mika sent a patch recently which should solve your problem.
Can you give a try to the following patch?
https://patchwork.kernel.org/patch/5709961/

> [  593.253422] i2c_hid: probe of i2c-WCOM0008:00 failed with error -22
>
> What should I look at?
>

So if you can test the above patch, that would help. If it does not
work, we will need to check the DSDT of your tablet.

Cheers,
Benjamin
