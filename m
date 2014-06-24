From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 1/2] lib: int_sqrt: add int64_sqrt routine
Date: Tue, 24 Jun 2014 08:15:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1406240810260.31856@pmeerw.net>
References: <1403516581-12560-1-git-send-email-21cnbao@gmail.com> <1403516581-12560-2-git-send-email-21cnbao@gmail.com>,<alpine.DEB.2.01.1406231150000.22151@pmeerw.net> <A94419613C6B3B46A0D9E05B960561730BF59488@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58331 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbaFXGP5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 02:15:57 -0400
In-Reply-To: <A94419613C6B3B46A0D9E05B960561730BF59488@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yibo Cai <Yibo.Cai@csr.com>
Cc: Barry Song <21cnbao@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "dtor@mail.ru" <dtor@mail.ru>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Barry Song <Barry.Song@csr.com>

Hello,

> > maybe the code could be #MACRO()'d to avoid duplication
> 
> Do you mean to define int64_sqrt() directly as int_sqrt() on a 64 bit 
> platform where sizeof(long) == sizeof(long long)?

something along the lines of

#define INT_SQRT(name, type) \
   type name(type x) \ 
      type m, y = 0, b; \
...

INT_SQRT(int_sqrt, unsigned long);
INT_SQRT(int64_sqrt, unsigned long long);

not sure if it is worth it

regards, p.

> ________________________________________
> From: Peter Meerwald [pmeerw@pmeerw.net]
> Sent: Monday, June 23, 2014 5:52 PM
> To: Barry Song
> Cc: dmitry.torokhov@gmail.com; dtor@mail.ru; akpm@linux-foundation.org; linux-input@vger.kernel.org; DL-SHA-WorkGroupLinux; Yibo Cai; Barry Song
> Subject: Re: [PATCH 1/2] lib: int_sqrt: add int64_sqrt routine
> 
> > Get square root of a 64-bit digit on 32bit platforms. CSR SiRFSoC
> > touchscreen driver needs it.
> 
> maybe the code could be #MACRO()'d to avoid duplication
> 
> see comment below
> 
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 4c52907..6e63081 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -418,6 +418,7 @@ struct pid;
> >  extern struct pid *session_of_pgrp(struct pid *pgrp);
> >
> >  unsigned long int_sqrt(unsigned long);
> > +unsigned long long int64_sqrt(unsigned long long);
> >
> >  extern void bust_spinlocks(int yes);
> >  extern int oops_in_progress;         /* If set, an oops, panic(), BUG() or die() is in progress */
> > diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
> > index 1ef4cc3..2aa9fcc 100644
> > --- a/lib/int_sqrt.c
> > +++ b/lib/int_sqrt.c
> > @@ -36,3 +36,30 @@ unsigned long int_sqrt(unsigned long x)
> >       return y;
> >  }
> >  EXPORT_SYMBOL(int_sqrt);
> > +
> > +/*
> > + * Square root of a 64-bit digit.
> > + * Same as int_sqrt on 64-bit platforms where "long" equals "long long"
> > + */
> > +unsigned long long int64_sqrt(unsigned long long x)
> > +{
> > +     unsigned long long m = 0, y = 0, b = 0;
> 
> initialization for b, m not needed
> 
> the original int_sqrt() code correctly skips initialization
> 
> > +
> > +     if (x <= 1)
> > +             return x;
> > +
> > +     m = 1ULL << (BITS_PER_LONG_LONG - 2);
> > +     while (m != 0) {
> > +             b = y + m;
> > +             y >>= 1;
> > +
> > +             if (x >= b) {
> > +                     x -= b;
> > +                     y += m;
> > +             }
> > +             m >>= 2;
> > +     }
> > +
> > +     return y;
> > +}
> > +EXPORT_SYMBOL(int64_sqrt);
> >
> 
> --
> 
> Peter Meerwald
> +43-664-2444418 (mobile)
> 
> 
>  To report this email as spam click https://www.mailcontrol.com/sr/MZbqvYs5QwJvpeaetUwhCQ== .
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
> New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
