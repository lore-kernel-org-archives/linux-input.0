From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: I want to add support for the Logitech G710+ keyboard
Date: Fri, 19 Apr 2013 09:51:04 +0200
Message-ID: <CAN+gG=H9iTckyWGqiAheTObWfSbuK3QJ-VXHajzwR8cTva3_qA@mail.gmail.com>
References: <CAK0ehjG+Lkp__cw-251Hk-1sa_ZLFa9DD93Rmp0NJE-bzUsrVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:56035 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab3DSHvH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Apr 2013 03:51:07 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so3250262lab.26
        for <linux-input@vger.kernel.org>; Fri, 19 Apr 2013 00:51:04 -0700 (PDT)
In-Reply-To: <CAK0ehjG+Lkp__cw-251Hk-1sa_ZLFa9DD93Rmp0NJE-bzUsrVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: K900 <k0009000@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Fri, Apr 19, 2013 at 6:34 AM, K900 <k0009000@gmail.com> wrote:
> Hi,
> So I have this keyboard, and it mostly works, but some Logitech
> specific features (programmable keys, etc) don't. I've been playing
> around with it, and I've figured out pretty much everything
> (interrupts and some GetFeature/SetFeature requests for things like
> backlight levels). I have some proof of concept Python+PyUSB code at
> https://github.com/K900/g710 , but I'm getting confused when it comes
> to implementing that in the kernel. Is there something like a 'HID
> drivers for dummies' guide? Sorry for the noobish questions.

Hi Ilya,

I had a very quick look at your code, but I'm missing one important
part to fully understand your device:
you don't give the report descriptors of your device [1].
If you give them, then it will be easier to know which part are
required to be handled in a special way, and which won't.
#> cat /sys/kernel/debug/hid/0003\:046D\:C24D.*/rdesc

Anyway, I don't think there is a 'HID drivers for dummies'. There are
few books on kernel hacking, but not for HID to my knowledge.

The easier way is to have a look at some simple HID drivers and use
them as a skeleton:
- hid-icade -> general handling of a hid device with .event() remapping
- hid-zydacron -> simple + report fixup
- hid-appleir (sunmitted recently) -> simple when using .raw_event()

Also, you may need to integrate your driver in hid-lg.c (which is a
little bigger than the previous three).

Cheers,
Benjamin


[1] http://www.usb.org/developers/devclass_docs/HID1_11.pdf
