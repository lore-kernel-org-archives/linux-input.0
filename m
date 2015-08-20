From: Yuasa Yoichi <yuasa@linux-mips.org>
Subject: Re: [PATCH v5] input: Add ROHM BU21023/24 Dual touch support
 resistive touchscreens
Date: Thu, 20 Aug 2015 16:35:47 +0900
Message-ID: <CACBHAeyxxV9Eq6YNEB3i=JiiaHqYhPRxJeVQ4_d0RzXeP+fAhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33532 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbbHTHfs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 03:35:48 -0400
Received: by obbhe7 with SMTP id he7so25431697obb.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 00:35:48 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoichi Yuasa <yuasa@linux-mips.org>, linux-input@vger.kernel.org

Hi Dmitry,

I updated the driver according to your comments.
Do you have any comments?

Thanks,

Yoichi

2015-08-07 18:06 GMT+09:00 Yoichi Yuasa <yuasa@linux-mips.org>:
> v5 Changes:
> - contact count variables move to array
> - remove unneeded u16 casts in #define
> - remove module parameters
> - handle "no fingers" as same as others
> - move devm_request_thread_irq() from open() to probe()
> - move "power off" from remove() to close()
>
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
