From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 19:01:36 +0000
Message-ID: <CA+V1LzqQ=s9kahPW8c0Xw-SZCc0PYb8cGXf0q6Ps9Kq24HJw3A@mail.gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
	<56D568C7.20203@gmail.com>
	<CA+V1LzohZr1ryibyS+YQ75D8-txQaiYU5qo2CNWTKS2kwn53dg@mail.gmail.com>
	<CA+V1Lzp8pEtiwH-EWJiDCu=oFpXO9N2SEM5UbSqi5-mxgwsiTg@mail.gmail.com>
	<20160302175232.GC4318@dtor-ws>
	<CA+V1LzoiheCTZRv9xS=f_aTLkb27vw0aha=otYy=eiwOPB52+Q@mail.gmail.com>
	<56D73003.2060606@gmail.com>
	<CA+V1Lzr4pOJs1VG3V1MzAR4bEr1gjoJKfU9hAzVxpLwNErMv4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35762 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbcCBTBh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 14:01:37 -0500
Received: by mail-qk0-f169.google.com with SMTP id o6so86526565qkc.2
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 11:01:37 -0800 (PST)
In-Reply-To: <CA+V1Lzr4pOJs1VG3V1MzAR4bEr1gjoJKfU9hAzVxpLwNErMv4Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Sorry, have forgotten to mentione that after this i2cdetect -r 4
detects nothing on i2c-4 0x48.
Kind regards,
                        Serge Kolotylo.

On Wed, Mar 2, 2016 at 7:00 PM, sergk sergk2mail <sergk.admin@gmail.com> wrote:
> Hi Gregor,
>
> Actually if you look for the code of atmel_mxt_ts - all actions are in probe.
> Also simple experimental like:
> echo maxtouch 0x48 > /sys/bus/i2c/i2c-4/new_device
> you got the same as in my case with modified your driver:
>
> Mar 02 18:51:39 archiso kernel: device: '4-0048': device_add
> Mar 02 18:51:39 archiso kernel: bus: 'i2c': add device 4-0048
> Mar 02 18:51:39 archiso kernel: PM: Adding info for i2c:4-0048
> Mar 02 18:51:39 archiso kernel: i2c i2c-4: new_device: Instantiated
> device maxtouch at 0x48
> Mar 02 18:51:39 archiso kernel: bus: 'i2c': add driver atmel_mxt_ts
> Mar 02 18:51:39 archiso kernel: bus: 'i2c': driver_probe_device:
> matched device 4-0048 with driver atmel_mxt_ts
> Mar 02 18:51:39 archiso kernel: bus: 'i2c': really_probe: probing
> driver atmel_mxt_ts with device 4-0048
> Mar 02 18:51:39 archiso kernel: atmel_mxt_ts 4-0048: no default pinctrl state
> Mar 02 18:51:39 archiso kernel: devices_kset: Moving 4-0048 to end of list
> Mar 02 18:51:39 archiso kernel: atmel_mxt_ts 4-0048: No platform data specified
> Mar 02 18:51:39 archiso kernel: atmel_mxt_ts: probe of 4-0048 faile
>
> Regards,
>                  Serge Kolotylo.
>
> PS: it will be really good if here will be someone who is fluent in
> Chinese and could directly read spec for Chipone and translate it to
> us.
