From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 1/2] lib: int_sqrt: add int64_sqrt routine
Date: Tue, 24 Jun 2014 15:43:01 +0200
Message-ID: <CADbOyBQzqFa9P71mLfWLjxtd5Fmm3+6GieVkxfQJA+9=+AnNAA@mail.gmail.com>
References: <1403516581-12560-1-git-send-email-21cnbao@gmail.com>
	<1403516581-12560-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:61681 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbaFXNnD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 09:43:03 -0400
Received: by mail-ve0-f175.google.com with SMTP id jx11so330064veb.6
        for <linux-input@vger.kernel.org>; Tue, 24 Jun 2014 06:43:02 -0700 (PDT)
In-Reply-To: <1403516581-12560-2-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, akpm@linux-foundation.org, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, workgroup.linux@csr.com, Yibo Cai <yibo.cai@csr.com>, Barry Song <Baohua.Song@csr.com>

On Mon, Jun 23, 2014 at 11:43 AM, Barry Song <21cnbao@gmail.com> wrote:
> From: Yibo Cai <yibo.cai@csr.com>
>
> Get square root of a 64-bit digit on 32bit platforms. CSR SiRFSoC
> touchscreen driver needs it.
>
> Signed-off-by: Yibo Cai <yibo.cai@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  include/linux/kernel.h |  1 +
>  lib/int_sqrt.c         | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 4c52907..6e63081 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -418,6 +418,7 @@ struct pid;
>  extern struct pid *session_of_pgrp(struct pid *pgrp);
>
>  unsigned long int_sqrt(unsigned long);
> +unsigned long long int64_sqrt(unsigned long long);
>
>  extern void bust_spinlocks(int yes);
>  extern int oops_in_progress;           /* If set, an oops, panic(), BUG() or die() is in progress */
> diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
> index 1ef4cc3..2aa9fcc 100644
> --- a/lib/int_sqrt.c
> +++ b/lib/int_sqrt.c
> @@ -36,3 +36,30 @@ unsigned long int_sqrt(unsigned long x)
>         return y;
>  }
>  EXPORT_SYMBOL(int_sqrt);
> +
> +/*
> + * Square root of a 64-bit digit.
> + * Same as int_sqrt on 64-bit platforms where "long" equals "long long"
> + */
> +unsigned long long int64_sqrt(unsigned long long x)
> +{
> +       unsigned long long m = 0, y = 0, b = 0;
> +
> +       if (x <= 1)
> +               return x;
> +
> +       m = 1ULL << (BITS_PER_LONG_LONG - 2);
> +       while (m != 0) {
> +               b = y + m;
> +               y >>= 1;
> +
> +               if (x >= b) {
> +                       x -= b;
> +                       y += m;
> +               }
> +               m >>= 2;
> +       }
> +
> +       return y;
> +}
> +EXPORT_SYMBOL(int64_sqrt);
>

Maybe it's a stupid question (I'm new to kernel programming),
but why don't you use a for-loop instead of a while-loop?
(apart from following the already-existing code of int_sqrt.c)

E.g.:
    for (m = 1ULL << (BITS_PER_LONG_LONG - 2); m != 0; m >>= 2) {
        b = y + m;
        y >>= 1;

        if (x >= b) {
            x -= b;
            y += m;
        }
    }

Instead of:
    m = 1ULL << (BITS_PER_LONG_LONG - 2);
    while (m != 0) {
        b = y + m;
        y >>= 1;

        if (x >= b) {
            x -= b;
            y += m;
        }
        m >>= 2;
    }

Thanks,
Elias
