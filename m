From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] lib: int_sqrt: add int64_sqrt routine
Date: Mon, 23 Jun 2014 11:52:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1406231150000.22151@pmeerw.net>
References: <1403516581-12560-1-git-send-email-21cnbao@gmail.com> <1403516581-12560-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:44162 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbaFWJxB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 05:53:01 -0400
In-Reply-To: <1403516581-12560-2-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, akpm@linux-foundation.org, linux-input@vger.kernel.org, workgroup.linux@csr.com, Yibo Cai <yibo.cai@csr.com>, Barry Song <Baohua.Song@csr.com>

> Get square root of a 64-bit digit on 32bit platforms. CSR SiRFSoC
> touchscreen driver needs it.

maybe the code could be #MACRO()'d to avoid duplication

see comment below

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
>  extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
> diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
> index 1ef4cc3..2aa9fcc 100644
> --- a/lib/int_sqrt.c
> +++ b/lib/int_sqrt.c
> @@ -36,3 +36,30 @@ unsigned long int_sqrt(unsigned long x)
>  	return y;
>  }
>  EXPORT_SYMBOL(int_sqrt);
> +
> +/*
> + * Square root of a 64-bit digit.
> + * Same as int_sqrt on 64-bit platforms where "long" equals "long long"
> + */
> +unsigned long long int64_sqrt(unsigned long long x)
> +{
> +	unsigned long long m = 0, y = 0, b = 0;

initialization for b, m not needed

the original int_sqrt() code correctly skips initialization

> +
> +	if (x <= 1)
> +		return x;
> +
> +	m = 1ULL << (BITS_PER_LONG_LONG - 2);
> +	while (m != 0) {
> +		b = y + m;
> +		y >>= 1;
> +
> +		if (x >= b) {
> +			x -= b;
> +			y += m;
> +		}
> +		m >>= 2;
> +	}
> +
> +	return y;
> +}
> +EXPORT_SYMBOL(int64_sqrt);
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
