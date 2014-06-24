From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] lib: int_sqrt: add int64_sqrt routine
Date: Tue, 24 Jun 2014 13:25:04 -0700
Message-ID: <20140624132504.221cba6760b0d16849456bfd@linux-foundation.org>
References: <1403516581-12560-1-git-send-email-21cnbao@gmail.com>
	<1403516581-12560-2-git-send-email-21cnbao@gmail.com>
	<alpine.DEB.2.01.1406231150000.22151@pmeerw.net>
	<A94419613C6B3B46A0D9E05B960561730BF59488@SHAASIEXM01.ASIA.ROOT.PRI>
	<alpine.DEB.2.01.1406240810260.31856@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36510 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaFXUZG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 16:25:06 -0400
In-Reply-To: <alpine.DEB.2.01.1406240810260.31856@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Yibo Cai <Yibo.Cai@csr.com>, Barry Song <21cnbao@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "dtor@mail.ru" <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Barry Song <Barry.Song@csr.com>

On Tue, 24 Jun 2014 08:15:55 +0200 (CEST) Peter Meerwald <pmeerw@pmeerw.net> wrote:

> > > maybe the code could be #MACRO()'d to avoid duplication
> > 
> > Do you mean to define int64_sqrt() directly as int_sqrt() on a 64 bit 
> > platform where sizeof(long) == sizeof(long long)?
> 
> something along the lines of
> 
> #define INT_SQRT(name, type) \
>    type name(type x) \ 
>       type m, y = 0, b; \
> ...
> 
> INT_SQRT(int_sqrt, unsigned long);
> INT_SQRT(int64_sqrt, unsigned long long);
> 
> not sure if it is worth it

We have made smaller optimisations in the past ;)

But not a macro, please:

#ifdef CONFIG_64BIT
static inline unsigned long long int64_sqrt(unsigned long long x)
{
	return int_sqrt(x);
}
#else
unsigned long long int64_sqrt(unsigned long long x);
#endif


