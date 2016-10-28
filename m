From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Fri, 28 Oct 2016 17:45:20 +0200
Message-ID: <1960434.J8MW3Y2VCi@wuerfel>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com> <5347568.3SpFZiqxSr@wuerfel> <CABeXuvra9faVw1z_0Bjwp5znO5y+6y0fSJ29AuBWt2A-cRLtrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABeXuvra9faVw1z_0Bjwp5znO5y+6y0fSJ29AuBWt2A-cRLtrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>
List-Id: linux-input@vger.kernel.org

On Friday, October 28, 2016 8:19:46 AM CEST Deepa Dinamani wrote:
> On Fri, Oct 28, 2016 at 5:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday, October 17, 2016 8:27:32 PM CEST Deepa Dinamani wrote:
> >> @@ -55,24 +60,24 @@ struct ff_effect_compat {
> >>
> >>  static inline size_t input_event_size(void)
> >>  {
> >> -       return (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) ?
> >> -               sizeof(struct input_event_compat) : sizeof(struct input_event);
> >> +       return in_compat_syscall() ? sizeof(struct raw_input_event_compat) :
> >> +                                    sizeof(struct raw_input_event);
> >>  }
> >
> > I think the COMPAT_USE_64BIT_TIME check has to stay here,
> > it's needed for x32 mode on x86-64.
> 
> There is no time_t anymore in the raw_input_event structure.
> The struct uses __kernel_ulong_t type.
> This should take care of x32 support.

I don't think it does.

> From this cover letter:
> https://www.spinics.net/lists/linux-arch/msg16356.html
> 
> I see that that the __kernel types were introduced to address the ABI
> issues for x32.

This is a variation of the problem we are trying to solve for
the other architectures in your patch set:

On x32, the kernel uses produces a structure with the 64-bit
layout, using __u64 tv_sec, to match the current user space
that has 64-bit __kernel_ulong_t and 64-bit time_t, but
in_compat_syscall() also returns 'true' here, as this is
mostly a 32-bit ABI (time_t being one of the exceptions).

	ARnd
