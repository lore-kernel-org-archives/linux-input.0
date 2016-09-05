From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: PROBLEM: i2c_hid: probe of i2c-ELAN0732:00 failed with error -61
Date: Mon, 5 Sep 2016 12:19:05 +0200
Message-ID: <CAN+gG=EiFgVKdwc0J-UBDtAg2SkGqJQB9--CL7BL8ZDn7dXD7g@mail.gmail.com>
References: <CABgo8p4OPGzbezWde_s2p467YGtFSemFqxfUY9J6B-3GH4+1iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34266 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbcIEKTH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Sep 2016 06:19:07 -0400
Received: by mail-ua0-f182.google.com with SMTP id u68so3435795uau.1
        for <linux-input@vger.kernel.org>; Mon, 05 Sep 2016 03:19:07 -0700 (PDT)
In-Reply-To: <CABgo8p4OPGzbezWde_s2p467YGtFSemFqxfUY9J6B-3GH4+1iQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin Johnstone <johnstone.colin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hi Colin,

On Sat, Sep 3, 2016 at 8:33 PM, Colin Johnstone
<johnstone.colin@gmail.com> wrote:
> [1.] One line summary of the problem: Touchscreen does not work, dmesg
> shows errors "i2c_hid i2c-ELAN0732:00: failed to reset device",
> "i2c_hid i2c-ELAN0732:00: can't add hid device: -61", and "i2c_hid:
> probe of i2c-ELAN0732:00 failed with error -61" occur during boot.

-61 is -ENODATA, which is raised when we timed-out when waiting for
the interrupt line.

To confirm this, please provide a dmesg from the boot with
i2c_hid.debug=1 appended to the kernel command line.

>
> [2.] Full description of the problem/report: This is on an HP Eny x360
> M6-AR004DX laptop with 7th-generation AMD FX CPU. The touchscreen is
> not recognized at all; it appears the screen is using GPIO interrupts
> as I have to build with AMD GPIO support to receive these errors,
> otherwise I see a "failed to get GPIO interrupt" error.
>

So this is more likely either a failure of us retrieving the GPIO, or
a misconfiguration of those. I'd be interested if you could share the
output of acpidump (as root) as well.

Cheers,
Benjamin
