From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [input:next 1370/1370] drivers/input/misc/rotary_encoder.c:439:34:
 error: 'rotary_encoder_of_match' undeclared here (not in a function)
Date: Fri, 16 Oct 2015 09:53:44 -0700
Message-ID: <CAKdAkRTgZStbsT_ZXyOo1kc8Pq1=z9CNZZ3nE2rN+EEgew_+Mg@mail.gmail.com>
References: <201510160923.PWF34hIg%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35882 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbbJPQxp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2015 12:53:45 -0400
Received: by obcqt19 with SMTP id qt19so17223736obc.3
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2015 09:53:44 -0700 (PDT)
In-Reply-To: <201510160923.PWF34hIg%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

On Thu, Oct 15, 2015 at 6:44 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> head:   8a1b30efbef4b339c3f4987c4937acc99aebf106
> commit: 8a1b30efbef4b339c3f4987c4937acc99aebf106 [1370/1370] Input: rotary-encoder - add support for quarter-period mode
> config: x86_64-randconfig-i0-201541 (attached as .config)
> reproduce:
>         git checkout 8a1b30efbef4b339c3f4987c4937acc99aebf106
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/asm-generic/gpio.h:7:0,
>                     from include/linux/gpio.h:51,
>                     from drivers/input/misc/rotary_encoder.c:23:
>>> drivers/input/misc/rotary_encoder.c:439:34: error: 'rotary_encoder_of_match' undeclared here (not in a function)
>       .of_match_table = of_match_ptr(rotary_encoder_of_match),
>                                      ^
>    include/linux/of.h:357:29: note: in definition of macro 'of_match_ptr'
>     #define of_match_ptr(_ptr) (_ptr)

Oops, I locally changed #ifdef to #ifndef and accidentally refreshed
the patch... I'll fix it up in a jiffy.

-- 
Dmitry
