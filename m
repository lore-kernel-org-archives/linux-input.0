From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Sat, 29 Oct 2016 00:01:14 +0200
Message-ID: <1563780.JF7NgVgytb@wuerfel>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com> <3544660.FKrMrRAIUC@wuerfel> <CAKdAkRRXyz=uao_XdDVpG=BDsy+GA=bzkEKJabbs3Cd7ZG1mZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49400 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbcJ1WBT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 18:01:19 -0400
In-Reply-To: <CAKdAkRRXyz=uao_XdDVpG=BDsy+GA=bzkEKJabbs3Cd7ZG1mZA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>

On Friday, October 28, 2016 2:56:10 PM CEST Dmitry Torokhov wrote:
> On Fri, Oct 28, 2016 at 2:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday, October 28, 2016 2:39:35 PM CEST Deepa Dinamani wrote:
> >> >> >> @@ -55,24 +60,24 @@ struct ff_effect_compat {
> >> >> >>
> >> >> >>  static inline size_t input_event_size(void)
> >> >> >>  {
> >> >> >> -       return (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) ?
> >> >> >> -               sizeof(struct input_event_compat) : sizeof(struct input_event);
> >> >> >> +       return in_compat_syscall() ? sizeof(struct raw_input_event_compat) :
> >> >> >> +                                    sizeof(struct raw_input_event);
> >> >> >>  }
> >> >> >
> >> >> > I think the COMPAT_USE_64BIT_TIME check has to stay here,
> >> >> > it's needed for x32 mode on x86-64.
> >> >>
> >
> > We have to distinguish four cases on x86:
> >
> > - native 32-bit, input_event with 32-bit time_t
> > - compat 32-bit, input_event_compat with 32-bit time_t
> > - native 64-bit, input_event with 64-bit time_t
> > - compat x32, input_event with 64-bit time_t
> >
> > The first three can happen on other architectures too,
> > the last one is x86 specific. There are probably other ways
> > to express the condition above, but I can't think of one
> > that is better than the one we have today.
> 
> Can we detect if given task is compat x32, like we do for compat
> 64/32? Or entire userspace has to be x32?

Yes, this works fine per task, with the definition of COMPAT_USE_64BIT_TIME
that is hardcoded to zero everywhere except on x86 where it is

#define COMPAT_USE_64BIT_TIME \
        (!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))

This is unrelated to the patch in question, the existing code
is correct as long as we don't change the logic and just
replace input_event with raw_input_event (or __kernel_input_event
or whichever you prefer).

	Arnd
