From: Yuasa Yoichi <yuasa@linux-mips.org>
Subject: Re: [PATCH v3 0/2] Add ROHM BU21023/24 Dual touch support resistive touchscreens
Date: Fri, 3 Oct 2014 14:16:53 +0900
Message-ID: <CACBHAewRkZz35D1+s=S+JTsOqrDgwgzS_amB0MJtVQq8-aL4QA@mail.gmail.com>
References: <20140925001647.dd48571a3c0ceda5c25ab669@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:38225 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbaJCFQx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Oct 2014 01:16:53 -0400
Received: by mail-oi0-f47.google.com with SMTP id a141so300618oig.34
        for <linux-input@vger.kernel.org>; Thu, 02 Oct 2014 22:16:53 -0700 (PDT)
In-Reply-To: <20140925001647.dd48571a3c0ceda5c25ab669@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yoichi Yuasa <yuasa@linux-mips.org>, linux-input@vger.kernel.org

Hi Dmitry,

Do you have any comments?
If you have a comment, I will fix it before next merge.

Thanks,

Yoichi

2014-09-25 0:16 GMT+09:00 Yoichi Yuasa <yuasa@linux-mips.org>:
> Hi Dmitry,
>
> I updated the driver according to your comments.
> Do you have any comments?
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
> - firmware load and device initialization are shifted at opening the device
> - add error handling for IO operations
>
> Yoichi Yuasa (2):
>   input: Add ROHM BU21023/24 Dual touch support resistive touchscreens
>   input: bu21023_ts: Add calibration function
>
>  drivers/input/touchscreen/Kconfig        |   11 +
>  drivers/input/touchscreen/Makefile       |    1 +
>  drivers/input/touchscreen/rohm_bu21023.c |  930 ++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/rohm_bu21023.h |  258 +++++++++
>  4 files changed, 1200 insertions(+)
>  create mode 100644 drivers/input/touchscreen/rohm_bu21023.c
>  create mode 100644 drivers/input/touchscreen/rohm_bu21023.h
>
> --
> 1.7.9.5
>
