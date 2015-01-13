From: Yuasa Yoichi <yuasa@linux-mips.org>
Subject: Re: [PATCH v4] input: Add ROHM BU21023/24 Dual touch support
 resistive touchscreens
Date: Wed, 14 Jan 2015 00:59:10 +0900
Message-ID: <CACBHAexySaKa3NhW06H-EAy7nvsnprpOa6YH22AOwD6aMABk8g@mail.gmail.com>
References: <20141205181739.3f3da16b1573c891cf49ba68@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36683 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbAMP7K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2015 10:59:10 -0500
Received: by mail-oi0-f42.google.com with SMTP id g201so2941068oib.1
        for <linux-input@vger.kernel.org>; Tue, 13 Jan 2015 07:59:10 -0800 (PST)
In-Reply-To: <20141205181739.3f3da16b1573c891cf49ba68@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoichi Yuasa <yuasa@linux-mips.org>, linux-input@vger.kernel.org

Hi Dmitry,

I updated the driver according to your comments.
Do you have any comments?

Thanks,

Yoichi

2014-12-05 18:17 GMT+09:00 Yoichi Yuasa <yuasa@linux-mips.org>:
> v4 Changes:
> - remove inline
> - master_xfer checks in probe()
> - rewrite rohm_i2c_burst_read()
> - rohm_i2c_burst_read() transfer error returns -EIO
> - remove unused module parameters
> - fix prev_touch_report update
> - pass NULL to hard_irq
> - per-device parameters use sysfs
> - fix errno
> - header file is taken in .c
>
> v3 Changes:
> - fix multi touch slots initialization
> - fix set_bit BTN_TOUCH
> - remove input_unregister_device()
> - switch to __set_bit()
>
> v2 Changes:
> - remove polling mode
> - switch to threaded interrupt
> - switch to managed resources
> - use MT-B protocol with input_mt_assign_slots
> - provide ST emulation
> - firmware load and device initialization are shifted at opening the
>   device
> - add error handling for IO operations
>
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  drivers/input/touchscreen/Kconfig        |   11 +
>  drivers/input/touchscreen/Makefile       |    1 +
>  drivers/input/touchscreen/rohm_bu21023.c | 1257 ++++++++++++++++++++++++++++++
>  3 files changed, 1269 insertions(+)
>  create mode 100644 drivers/input/touchscreen/rohm_bu21023.c
>
