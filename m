From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] Input: Add EVIOC mechanism for MT slots
Date: Fri, 3 Feb 2012 08:27:25 +0100
Message-ID: <20120203072725.GA6914@polaris.bitmath.org>
References: <1328036403-2827-1-git-send-email-rydberg@euromail.se>
 <4F2B24AC.1020408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F2B24AC.1020408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Chase,

> > +#define INPUT_MT_REQUEST(num_slots)					\
> > +	{								\
> > +		__u32 code;						\
> > +		__s32 values[num_slots];				\
> 
> I think this assumes a userspace C compiler that can handle variable
> length arrays. This would require only compiling in C source code at the
> C99 standard or later. It looks like C++ doesn't even allow variable
> length arrays, though gcc handles it. According to:
> 
> http://www.cplusplus.com/forum/beginner/1601/
> 
> it looks like Borland c++ compilers may not be able to compile this :(.

This is resolved on the preprocessor level, so C99 or not does not
enter the problem. Compile-time constant, as you can see in the code
example in the patch summary.

Thanks,
Henrik
