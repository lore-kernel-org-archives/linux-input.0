From: AZO <typesylph@gmail.com>
Subject: Re: [PATCH] drivers: input: joystick: Add PSX (Play Station 1/2) pad
 with SPI driver.
Date: Wed, 26 Apr 2017 08:07:32 +0900
Message-ID: <CAE35y5v9fq8gv2Mm+xDYUHraJGwpb7hppN_=ju6EA3eDzJ04QQ@mail.gmail.com>
References: <20170425074159.8533-1-typesylph@gmail.com> <201704260607.2xZFs7pU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36411 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1433395AbdDYXHe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 19:07:34 -0400
In-Reply-To: <201704260607.2xZFs7pU%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Mr. Torokhov

>> make[4]: *** No rule to make target 'drivers/input/joystick/rpisense-js.c', needed by 'drivers/input/joystick/rpisense-js.o'.

Sorry to my mistake.
I sended 2nd patch is,
between Generic kernel source and Raspberry Pi's kernel source.

I sended 3rd patch is for Generic kernel source.
Try build this.

I'm sorry.

Regard.


2017-04-26 7:24 GMT+09:00 kbuild test robot <lkp@intel.com>:
> Hi AZO,
>
> [auto build test ERROR on input/next]
> [also build test ERROR on v4.11-rc8 next-20170424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/AZO/drivers-input-joystick-Add-PSX-Play-Station-1-2-pad-with-SPI-driver/20170425-182329
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>>> make[4]: *** No rule to make target 'drivers/input/joystick/rpisense-js.c', needed by 'drivers/input/joystick/rpisense-js.o'.
>    make[4]: Target '__build' not remade because of errors.
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
